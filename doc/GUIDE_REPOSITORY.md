# Repository 패턴 가이드

## 개요
JSON 파일에서 문제 데이터를 로드하는 Repository 패턴 구현 문서입니다.

---

## 아키텍처

```
┌─────────────────────────────────────────────────────────┐
│                    Presentation Layer                    │
│              (HomeScreen, QuizScreen, etc.)             │
└────────────────────────┬────────────────────────────────┘
                         │ Provider
                         ▼
┌─────────────────────────────────────────────────────────┐
│                    Domain Layer                          │
│              ┌─────────────────────────┐                │
│              │  QuestionRepository     │ (Interface)    │
│              │  - getAllQuestionSets() │                │
│              │  - getQuestionSet()     │                │
│              └────────────┬────────────┘                │
└───────────────────────────┼─────────────────────────────┘
                            │ implements
                            ▼
┌─────────────────────────────────────────────────────────┐
│                      Data Layer                          │
│  ┌────────────────────────────────────────────────────┐ │
│  │            QuestionRepositoryImpl                   │ │
│  │  - 캐싱 로직                                        │ │
│  │  - 에러 처리                                        │ │
│  └───────────────────────┬────────────────────────────┘ │
│                          │                               │
│  ┌───────────────────────▼────────────────────────────┐ │
│  │          QuestionLocalDataSource                    │ │
│  │  - rootBundle.loadString()                         │ │
│  │  - JSON 파싱                                        │ │
│  └────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────┐
│                    Assets (JSON Files)                   │
│              assets/data/*.json                          │
└─────────────────────────────────────────────────────────┘
```

---

## 생성된 파일

### Domain Layer
| 파일 | 설명 |
|------|------|
| `lib/domain/repositories/question_repository.dart` | Repository 인터페이스 |

### Data Layer
| 파일 | 설명 |
|------|------|
| `lib/data/datasources/local/question_local_datasource.dart` | JSON 로딩 DataSource |
| `lib/data/repositories/question_repository_impl.dart` | Repository 구현체 |

### Providers
| 파일 | 설명 |
|------|------|
| `lib/providers/question_providers.dart` | Riverpod Providers |

### Assets
| 파일 | 설명 |
|------|------|
| `assets/data/constitutional_law_ch1.json` | 샘플 문제 데이터 (10문제) |

---

## JSON 파일 형식

```json
{
  "subject_info": {
    "subject_name": "헌법",
    "chapter_major": "제1편 헌법총론",
    "chapter_minor": "제1장 헌법의 의의",
    "source_reference": "2024 공무원 헌법 기출문제집",
    "version": "1.0.0"
  },
  "questions": [
    {
      "id": 1,
      "question": "헌법은 국가의 최고 규범이다.",
      "answer": "O",
      "explanation": "헌법은 국가의 기본법으로서...",
      "correction": null,
      "tags": ["헌법총론", "최고규범성"],
      "importance": 5
    }
  ]
}
```

---

## 새 문제 파일 추가 방법

### 1. JSON 파일 생성
`assets/data/` 폴더에 JSON 파일 추가

### 2. DataSource에 파일 등록
`lib/data/datasources/local/question_local_datasource.dart`:

```dart
static const List<String> _registeredFiles = [
  'constitutional_law_ch1.json',
  'new_file.json',  // 추가
];
```

### 3. 앱 재시작
Hot reload로는 assets 변경이 반영되지 않으므로 앱 재시작 필요

---

## Provider 사용법

### 모든 문제 세트 로드
```dart
final questionSetsAsync = ref.watch(allQuestionSetsProvider);

questionSetsAsync.when(
  data: (sets) => ...,
  loading: () => CircularProgressIndicator(),
  error: (e, st) => Text('Error: $e'),
);
```

### 특정 파일 로드
```dart
final questionSet = await ref.read(
  questionSetProvider('constitutional_law_ch1.json').future,
);
```

### 선택된 문제 세트 관리
```dart
// 선택
ref.read(selectedQuestionSetProvider.notifier).select(questionSet);

// 읽기
final selected = ref.watch(selectedQuestionSetProvider);

// 초기화
ref.read(selectedQuestionSetProvider.notifier).clear();
```

---

## 에러 처리

### QuestionDataException
```dart
try {
  final qs = await repository.getQuestionSet('file.json');
} on QuestionDataException catch (e) {
  print('Error: ${e.message}');
  print('Cause: ${e.cause}');
}
```

### 에러 종류
| 에러 | 원인 |
|------|------|
| `Failed to load question file` | 파일을 찾을 수 없음 |
| `Invalid JSON format` | JSON 파싱 실패 |

---

## 캐싱

Repository 구현체는 메모리 캐싱을 지원합니다:

```dart
final repository = ref.read(questionRepositoryProvider);

// 첫 호출: 파일에서 로드
final qs1 = await repository.getQuestionSet('file.json');

// 두 번째 호출: 캐시에서 반환
final qs2 = await repository.getQuestionSet('file.json');

// 캐시 초기화
(repository as QuestionRepositoryImpl).clearCache();
```

---

## 상태: ✅ 구현 완료

### 실행 전 필수 명령어
```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run -d chrome
```
