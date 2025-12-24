import 'package:freezed_annotation/freezed_annotation.dart';

part 'question.freezed.dart';
part 'question.g.dart';

/// O/X 문제를 나타내는 모델
@freezed
abstract class Question with _$Question {
  const Question._();

  const factory Question({
    /// 문제 고유 ID
    required int id,

    /// 문제 내용
    required String question,

    /// 정답 ("O" 또는 "X")
    required String answer,

    /// 해설
    required String explanation,

    /// 정정 내용 (Nullable - 오답일 경우 올바른 내용)
    String? correction,

    /// 태그 목록
    @Default([]) List<String> tags,

    /// 중요도 (1~5)
    @Default(3) int importance,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  /// 정답이 O인지 확인
  bool get isAnswerO => answer.toUpperCase() == 'O';

  /// 정답이 X인지 확인
  bool get isAnswerX => answer.toUpperCase() == 'X';

  /// 사용자 답변이 정답인지 확인
  bool checkAnswer(bool userAnsweredO) {
    return userAnsweredO == isAnswerO;
  }
}
