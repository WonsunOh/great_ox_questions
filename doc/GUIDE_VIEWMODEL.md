# Quiz ViewModel 가이드

## 개요
퀴즈 상태 관리를 위한 MVVM 패턴의 ViewModel 구현 문서입니다.

---

## 아키텍처

```
┌─────────────────────────────────────────────────────────┐
│                      View Layer                          │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐      │
│  │ HomeScreen  │  │ QuizScreen  │  │ResultScreen │      │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘      │
│         │                │                │              │
└─────────┼────────────────┼────────────────┼──────────────┘
          │                │                │
          ▼                ▼                ▼
┌─────────────────────────────────────────────────────────┐
│                   ViewModel Layer                        │
│              ┌─────────────────────┐                     │
│              │   QuizViewModel     │                     │
│              │  (Riverpod Notifier)│                     │
│              └──────────┬──────────┘                     │
│                         │                                │
└─────────────────────────┼────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────┐
│                    Model Layer                           │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐   │
│  │  QuizState   │  │  Question    │  │  UserAnswer  │   │
│  │  (freezed)   │  │  (freezed)   │  │  (freezed)   │   │
│  └──────────────┘  └──────────────┘  └──────────────┘   │
└─────────────────────────────────────────────────────────┘
```

---

## 생성된 파일

### 모델
| 파일 | 상태 | 설명 |
|------|------|------|
| `lib/data/models/quiz_state.dart` | ✅ | 퀴즈 상태 모델 (freezed) |

### ViewModel
| 파일 | 상태 | 설명 |
|------|------|------|
| `lib/presentation/quiz/viewmodel/quiz_viewmodel.dart` | ✅ | 퀴즈 ViewModel |

### Provider
| 파일 | 상태 | 설명 |
|------|------|------|
| `lib/providers/sample_data_provider.dart` | ✅ | 샘플 문제 데이터 |

### View (업데이트)
| 파일 | 상태 | 설명 |
|------|------|------|
| `lib/presentation/quiz/view/quiz_screen.dart` | ✅ | ViewModel 연동 |
| `lib/presentation/result/view/result_screen.dart` | ✅ | ViewModel 연동 |

---

## QuizState 구조

```dart
@freezed
class QuizState {
  List<Question> questions;      // 문제 목록
  int currentIndex;              // 현재 문제 인덱스
  List<UserAnswer> userAnswers;  // 답변 기록
  QuizStatus status;             // 상태 (initial/inProgress/completed)
  bool? lastAnswerCorrect;       // 마지막 답변 정답 여부
  bool showingFeedback;          // 피드백 표시 중

  // Computed Properties
  Question? currentQuestion;     // 현재 문제
  int totalQuestions;            // 전체 문제 수
  int correctCount;              // 정답 개수
  int incorrectCount;            // 오답 개수
  double progress;               // 진행률 (0.0~1.0)
  double correctRate;            // 정답률 (%)
  List<Question> incorrectQuestions;  // 오답 문제 목록
}
```

---

## QuizViewModel 메서드

| 메서드 | 설명 |
|--------|------|
| `startQuiz(questions)` | 퀴즈 시작 |
| `submitAnswer(bool)` | O/X 답변 제출 |
| `nextQuestion()` | 다음 문제로 이동 |
| `restartQuiz()` | 전체 다시 풀기 |
| `retryIncorrectOnly()` | 오답만 다시 풀기 |
| `resetQuiz()` | 퀴즈 초기화 |
| `goToQuestion(index)` | 특정 문제로 이동 |

---

## 사용 예시

### View에서 ViewModel 사용

```dart
class QuizScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 상태 구독 (UI 자동 갱신)
    final quizState = ref.watch(quizViewModelProvider);

    // 메서드 호출용
    final viewModel = ref.read(quizViewModelProvider.notifier);

    return Column(
      children: [
        Text('문제 ${quizState.currentIndex + 1}'),
        ElevatedButton(
          onPressed: () => viewModel.submitAnswer(true),
          child: Text('O'),
        ),
      ],
    );
  }
}
```

### 상태 변화 리스닝

```dart
ref.listen(quizViewModelProvider, (prev, next) {
  if (next.status == QuizStatus.completed) {
    context.go('/result');
  }
});
```

---

## 퀴즈 플로우

```
1. HomeScreen
   └── "퀴즈 시작" 클릭
       └── QuizScreen으로 이동

2. QuizScreen
   ├── 문제 표시
   ├── O/X 버튼 클릭 → submitAnswer()
   ├── 정답/오답 피드백 표시
   ├── "다음 문제" 클릭 → nextQuestion()
   └── 마지막 문제 완료 시 → ResultScreen으로 이동

3. ResultScreen
   ├── 결과 요약 표시 (정답률, 통계)
   ├── 오답 노트 표시
   ├── "홈으로" → resetQuiz() + 홈 이동
   ├── "전체 다시 풀기" → restartQuiz() + 퀴즈 이동
   └── "오답만 다시 풀기" → retryIncorrectOnly() + 퀴즈 이동
```

---

## 주요 기능

### 1. 답변 피드백
- O/X 선택 시 즉시 정답/오답 표시
- 해설 및 정정 내용 표시
- "다음 문제" 버튼으로 진행

### 2. 진행 상황 표시
- AppBar에 현재 문제 번호 표시
- LinearProgressIndicator로 진행률 표시

### 3. 결과 화면
- 정답률 원형 그래프
- 전체/정답/오답 통계 카드
- 오답 노트 (확장 가능한 목록)

### 4. 다시 풀기 옵션
- 전체 다시 풀기
- 오답만 다시 풀기

---

## 상태: ✅ 구현 완료

### 실행 전 필수 명령어
```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```
