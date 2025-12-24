# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build Commands

```bash
# Install dependencies
flutter pub get

# Generate freezed/riverpod code (required after model changes)
dart run build_runner build --delete-conflicting-outputs

# Run on Chrome (web target)
flutter run -d chrome

# Run with specific port
flutter run -d chrome --web-port=8080
```

## Architecture

This is a Flutter O/X quiz web app using **MVVM + Repository Pattern**.

### Layer Structure

```
lib/
├── data/           # Data layer (implementations)
│   ├── models/         # Freezed data models
│   ├── datasources/    # JSON file loading
│   └── repositories/   # Repository implementations
├── domain/         # Domain layer (interfaces)
│   └── repositories/   # Repository interfaces
├── presentation/   # UI layer
│   └── {feature}/
│       ├── view/       # Screens (ConsumerWidget/ConsumerStatefulWidget)
│       └── viewmodel/  # Riverpod Notifiers
├── providers/      # Global Riverpod providers
└── router/         # go_router configuration
```

### Key Patterns

- **State Management**: `@Riverpod` annotation with `riverpod_generator`. Use `@Riverpod(keepAlive: true)` for state that must persist across navigation.
- **Data Models**: `@freezed` with `json_serializable` for immutable models with JSON support.
- **Navigation**: `go_router` configured via Riverpod provider in `app_router.dart`.

### Data Flow

1. `QuestionLocalDataSource` loads JSON from `assets/data/`
2. `QuestionRepositoryImpl` caches and provides data
3. Riverpod providers expose data to UI
4. `QuizViewModel` manages quiz state (questions, answers, progress)

## Adding New Question Files

1. Add JSON file to `assets/data/` following the schema in `constitutional_law_ch1.json`
2. Register filename in `QuestionLocalDataSource._registeredFiles` list
3. Hot restart required (assets changes don't hot reload)

## JSON Schema

```json
{
  "subject_info": {
    "subject_name": "과목명",
    "chapter_major": "대단원",
    "chapter_minor": "소단원",
    "source_reference": "출처",
    "version": "1.0.0"
  },
  "questions": [
    {
      "id": 1,
      "question": "문제 텍스트",
      "answer": "O" | "X",
      "explanation": "해설",
      "correction": "정정문 (X일 경우)",
      "tags": ["태그1", "태그2"],
      "importance": 1-5
    }
  ]
}
```
