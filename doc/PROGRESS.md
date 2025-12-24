# O/X 문제 풀이 웹앱 - 개발 진행사항

## 프로젝트 개요
- **프로젝트명**: great_ox_questions
- **목적**: 수험생을 위한 O/X 문제 풀이 웹앱
- **Flutter SDK**: ^3.9.0

---

## 기술 스택
| 구분 | 기술 |
|------|------|
| Framework | Flutter (Web) |
| Architecture | MVVM + Repository Pattern |
| State Management | flutter_riverpod + riverpod_generator |
| Data Modeling | freezed + json_serializable |
| Navigation | go_router |

---

## 진행 상태

### Phase 1: 프로젝트 초기 설정
| 작업 | 상태 | 비고 |
|------|------|------|
| Flutter 프로젝트 생성 | ✅ 완료 | |
| pubspec.yaml 의존성 추가 | ✅ 완료 | |
| 폴더 구조 설계 | ✅ 완료 | MVVM 패턴 적용 |
| 데이터 모델 작성 | ✅ 완료 | freezed 3.x 적용 |
| go_router 설정 | ✅ 완료 | Riverpod Provider 연동 |

### Phase 2: 핵심 기능 구현
| 작업 | 상태 | 비고 |
|------|------|------|
| 홈 화면 | ✅ 완료 | 문제 세트 목록, 학습 시작 |
| 퀴즈 화면 | ✅ 완료 | O/X 버튼, 피드백, 진행률 |
| 결과 화면 | ✅ 완료 | 통계, 오답노트, 다시풀기 |
| QuizViewModel | ✅ 완료 | Riverpod Notifier |
| Repository 패턴 | ✅ 완료 | JSON 파일 로딩 |
| 샘플 데이터 | ✅ 완료 | 10개 헌법 문제 |

### Phase 3: 추가 기능 (예정)
| 작업 | 상태 | 비고 |
|------|------|------|
| 로컬 저장소 | ⏳ 대기 | 학습 기록 저장 |
| 다크 모드 | ✅ 완료 | 시스템 설정 연동 |
| 반응형 레이아웃 | ⏳ 대기 | 웹/모바일 대응 |

---

## 완료된 작업 상세

### 1. 데이터 모델 (2024-12-25)

**생성된 파일:**
```
lib/data/models/
├── models.dart          # Barrel export
├── subject_info.dart    # 과목 정보 모델
├── question.dart        # O/X 문제 모델
├── question_set.dart    # 전체 JSON 구조 모델
└── quiz_state.dart      # 퀴즈 상태 모델
```

### 2. go_router 설정 (2024-12-25)

**라우트 구조:**
| 경로 | 화면 | 설명 |
|------|------|------|
| `/` | HomeScreen | 홈 (문제 세트 목록) |
| `/quiz` | QuizScreen | 퀴즈 풀이 |
| `/result` | ResultScreen | 결과 확인 |

### 3. Quiz ViewModel (2024-12-25)

**QuizViewModel 주요 기능:**
| 메서드 | 설명 |
|--------|------|
| `startQuiz()` | 퀴즈 시작 |
| `submitAnswer()` | O/X 답변 제출 |
| `nextQuestion()` | 다음 문제로 이동 |
| `restartQuiz()` | 전체 다시 풀기 |
| `retryIncorrectOnly()` | 오답만 다시 풀기 |

### 4. Repository 패턴 (2024-12-25)

**생성된 파일:**
```
lib/
├── domain/repositories/
│   └── question_repository.dart        # Repository 인터페이스
├── data/
│   ├── datasources/local/
│   │   └── question_local_datasource.dart  # JSON 로딩
│   └── repositories/
│       └── question_repository_impl.dart   # Repository 구현체
├── providers/
│   └── question_providers.dart          # Riverpod Providers
assets/data/
└── constitutional_law_ch1.json          # 샘플 문제 (10문제)
```

**Provider 목록:**
| Provider | 설명 |
|----------|------|
| `allQuestionSetsProvider` | 모든 문제 세트 로드 |
| `questionSetProvider(fileName)` | 특정 파일 로드 |
| `selectedQuestionSetProvider` | 선택된 문제 세트 |

---

## 폴더 구조 (현재)

```
lib/
├── main.dart                           # ✅ 앱 진입점
├── app.dart                            # ✅ MaterialApp.router
├── data/
│   ├── models/                         # ✅ Freezed 모델 (5개)
│   ├── datasources/local/              # ✅ JSON DataSource
│   └── repositories/                   # ✅ Repository 구현체
├── domain/
│   └── repositories/                   # ✅ Repository 인터페이스
├── presentation/
│   ├── home/view/                      # ✅ 홈 화면 (개선됨)
│   ├── quiz/
│   │   ├── view/                       # ✅ 퀴즈 화면
│   │   └── viewmodel/                  # ✅ QuizViewModel
│   └── result/view/                    # ✅ 결과 화면
├── providers/                          # ✅ Riverpod Providers
└── router/                             # ✅ go_router 설정

assets/
└── data/                               # ✅ JSON 문제 파일
```

---

## 새 문제 파일 추가 방법

1. `assets/data/` 폴더에 JSON 파일 추가
2. `question_local_datasource.dart`의 `_registeredFiles` 목록에 파일명 추가
3. 앱 재시작 (Hot reload로는 assets 변경 미반영)

---

## 코드 생성 명령어

```bash
# 패키지 설치
flutter pub get

# Freezed/Riverpod 코드 생성
dart run build_runner build --delete-conflicting-outputs

# 웹 실행
flutter run -d chrome
```

---

## 다음 작업 (예정)

1. **로컬 저장소** - SharedPreferences로 학습 기록 저장
2. **반응형 레이아웃** - 웹/태블릿/모바일 대응
3. **추가 문제 파일** - 다양한 과목 문제 추가
4. **성능 최적화** - 대용량 문제 처리

---

## 문서 목록
| 문서 | 설명 |
|------|------|
| `doc/PROGRESS.md` | 전체 진행사항 (현재 문서) |
| `doc/GUIDE_ROUTER.md` | go_router 설정 가이드 |
| `doc/GUIDE_VIEWMODEL.md` | ViewModel 구현 가이드 |
| `doc/GUIDE_REPOSITORY.md` | Repository 패턴 가이드 |

---

## 변경 이력
| 날짜 | 작업 내용 |
|------|----------|
| 2024-12-25 | 프로젝트 초기 설정, 데이터 모델 작성 |
| 2024-12-25 | go_router 설정, 기본 화면 Scaffold 구현 |
| 2024-12-25 | QuizViewModel 구현, 퀴즈/결과 화면 완성 |
| 2024-12-25 | Repository 패턴 구현, 홈 화면 개선 |
