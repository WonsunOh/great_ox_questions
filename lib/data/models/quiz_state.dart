import 'package:freezed_annotation/freezed_annotation.dart';

import 'question.dart';

part 'quiz_state.freezed.dart';

/// 사용자의 개별 답변 기록
@freezed
abstract class UserAnswer with _$UserAnswer {
  const factory UserAnswer({
    /// 문제 ID
    required int questionId,

    /// 사용자가 선택한 답변 (true = O, false = X)
    required bool selectedAnswer,

    /// 정답 여부
    required bool isCorrect,
  }) = _UserAnswer;
}

/// 퀴즈 진행 상태
enum QuizStatus {
  /// 초기 상태
  initial,

  /// 진행 중
  inProgress,

  /// 완료
  completed,
}

/// 퀴즈 전체 상태
@freezed
abstract class QuizState with _$QuizState {
  const QuizState._();

  const factory QuizState({
    /// 문제 목록
    @Default([]) List<Question> questions,

    /// 현재 문제 인덱스
    @Default(0) int currentIndex,

    /// 사용자 답변 기록
    @Default([]) List<UserAnswer> userAnswers,

    /// 퀴즈 상태
    @Default(QuizStatus.initial) QuizStatus status,

    /// 마지막 답변의 정답 여부 (피드백 표시용)
    bool? lastAnswerCorrect,

    /// 피드백 표시 중 여부
    @Default(false) bool showingFeedback,
  }) = _QuizState;

  /// 현재 문제
  Question? get currentQuestion =>
      questions.isNotEmpty && currentIndex < questions.length
          ? questions[currentIndex]
          : null;

  /// 전체 문제 수
  int get totalQuestions => questions.length;

  /// 정답 개수
  int get correctCount => userAnswers.where((a) => a.isCorrect).length;

  /// 오답 개수
  int get incorrectCount => userAnswers.where((a) => !a.isCorrect).length;

  /// 진행률 (0.0 ~ 1.0)
  double get progress =>
      totalQuestions > 0 ? currentIndex / totalQuestions : 0.0;

  /// 완료된 문제 수
  int get answeredCount => userAnswers.length;

  /// 마지막 문제인지 확인
  bool get isLastQuestion => currentIndex >= totalQuestions - 1;

  /// 오답 문제 목록
  List<Question> get incorrectQuestions {
    final incorrectIds =
        userAnswers.where((a) => !a.isCorrect).map((a) => a.questionId).toSet();
    return questions.where((q) => incorrectIds.contains(q.id)).toList();
  }

  /// 정답률 (퍼센트)
  double get correctRate =>
      answeredCount > 0 ? (correctCount / answeredCount) * 100 : 0.0;
}
