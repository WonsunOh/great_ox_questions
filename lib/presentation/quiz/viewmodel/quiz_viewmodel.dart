import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/models.dart';

part 'quiz_viewmodel.g.dart';

/// 퀴즈 ViewModel
///
/// 퀴즈 진행 상태를 관리하고 사용자 인터랙션을 처리합니다.
/// keepAlive: true로 설정하여 화면 전환 후에도 상태가 유지됩니다.
@Riverpod(keepAlive: true)
class QuizViewModel extends _$QuizViewModel {
  @override
  QuizState build() {
    return const QuizState();
  }

  /// 퀴즈 시작 - 문제 목록을 설정하고 퀴즈를 시작합니다.
  void startQuiz(List<Question> questions) {
    if (questions.isEmpty) return;

    state = QuizState(
      questions: questions,
      currentIndex: 0,
      userAnswers: [],
      status: QuizStatus.inProgress,
    );
  }

  /// 문제 목록만 설정 (샘플 데이터용)
  void setQuestions(List<Question> questions) {
    state = state.copyWith(
      questions: questions,
      status: questions.isNotEmpty ? QuizStatus.inProgress : QuizStatus.initial,
    );
  }

  /// 답변 제출
  ///
  /// [answeredO] - true면 O 선택, false면 X 선택
  void submitAnswer(bool answeredO) {
    final currentQuestion = state.currentQuestion;
    if (currentQuestion == null) return;
    if (state.status != QuizStatus.inProgress) return;

    // 정답 확인
    final isCorrect = currentQuestion.checkAnswer(answeredO);

    // 답변 기록 추가
    final userAnswer = UserAnswer(
      questionId: currentQuestion.id,
      selectedAnswer: answeredO,
      isCorrect: isCorrect,
    );

    state = state.copyWith(
      userAnswers: [...state.userAnswers, userAnswer],
      lastAnswerCorrect: isCorrect,
      showingFeedback: true,
    );
  }

  /// 다음 문제로 이동
  void nextQuestion() {
    if (state.isLastQuestion) {
      // 마지막 문제면 퀴즈 완료
      state = state.copyWith(
        status: QuizStatus.completed,
        showingFeedback: false,
      );
    } else {
      // 다음 문제로 이동
      state = state.copyWith(
        currentIndex: state.currentIndex + 1,
        showingFeedback: false,
        lastAnswerCorrect: null,
      );
    }
  }

  /// 피드백 숨기기
  void hideFeedback() {
    state = state.copyWith(
      showingFeedback: false,
    );
  }

  /// 특정 문제로 이동 (복습용)
  void goToQuestion(int index) {
    if (index < 0 || index >= state.totalQuestions) return;

    state = state.copyWith(
      currentIndex: index,
      showingFeedback: false,
      lastAnswerCorrect: null,
    );
  }

  /// 퀴즈 재시작
  void restartQuiz() {
    if (state.questions.isEmpty) return;

    state = QuizState(
      questions: state.questions,
      currentIndex: 0,
      userAnswers: [],
      status: QuizStatus.inProgress,
    );
  }

  /// 오답만 다시 풀기
  void retryIncorrectOnly() {
    final incorrectQuestions = state.incorrectQuestions;
    if (incorrectQuestions.isEmpty) return;

    state = QuizState(
      questions: incorrectQuestions,
      currentIndex: 0,
      userAnswers: [],
      status: QuizStatus.inProgress,
    );
  }

  /// 퀴즈 초기화
  void resetQuiz() {
    state = const QuizState();
  }
}
