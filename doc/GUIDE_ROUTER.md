# go_router 설정 가이드

## 개요
이 문서는 O/X 문제 풀이 앱의 라우팅 설정을 설명합니다.

---

## 라우트 구조

```
/                    → HomeScreen (홈 화면)
├── /quiz            → QuizScreen (퀴즈 풀이)
└── /result          → ResultScreen (결과 확인)
```

---

## 생성된 파일 목록

### 1. 라우터 설정
| 파일 | 상태 | 설명 |
|------|------|------|
| `lib/router/route_paths.dart` | ✅ | 경로 상수 정의 |
| `lib/router/app_router.dart` | ✅ | GoRouter 설정 (Riverpod Provider) |

### 2. 화면 파일
| 파일 | 상태 | 설명 |
|------|------|------|
| `lib/presentation/home/view/home_screen.dart` | ✅ | 홈 화면 |
| `lib/presentation/quiz/view/quiz_screen.dart` | ✅ | 퀴즈 화면 |
| `lib/presentation/result/view/result_screen.dart` | ✅ | 결과 화면 |

### 3. 앱 진입점
| 파일 | 상태 | 설명 |
|------|------|------|
| `lib/app.dart` | ✅ | MaterialApp.router 설정 |
| `lib/main.dart` | ✅ | ProviderScope 래핑 |

---

## 라우트 파라미터

### /quiz
퀴즈 화면으로 이동 시 전달할 데이터:
- `questionSetId`: 문제 세트 식별자 (선택적)

### /result
결과 화면으로 이동 시 전달할 데이터:
- `correctCount`: 정답 개수
- `totalCount`: 전체 문제 수
- `wrongQuestionIds`: 오답 문제 ID 목록

---

## 사용 예시

### 화면 이동
```dart
// 홈에서 퀴즈로 이동
context.go('/quiz');

// 퀴즈에서 결과로 이동 (extra 데이터 전달)
context.go('/result', extra: QuizResult(...));

// 뒤로가기
context.pop();
```

### Provider에서 라우터 접근
```dart
final router = ref.watch(appRouterProvider);
router.go('/quiz');
```

---

## 구현 순서

1. `route_paths.dart` - 경로 상수 정의
2. 각 화면 기본 Scaffold 생성
3. `app_router.dart` - GoRouter 설정
4. `app.dart` - MaterialApp.router 연결
5. `main.dart` - ProviderScope 래핑

---

## 상태: ✅ 구현 완료

모든 라우터 설정이 완료되었습니다.

### 실행 전 필수 명령어
```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```
