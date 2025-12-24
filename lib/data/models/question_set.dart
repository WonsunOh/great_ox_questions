import 'package:freezed_annotation/freezed_annotation.dart';

import 'question.dart';
import 'subject_info.dart';

part 'question_set.freezed.dart';
part 'question_set.g.dart';

/// 전체 JSON 구조를 나타내는 모델 (subject_info + questions)
@freezed
abstract class QuestionSet with _$QuestionSet {
  const QuestionSet._();

  const factory QuestionSet({
    /// 과목 정보
    @JsonKey(name: 'subject_info') required SubjectInfo subjectInfo,

    /// 문제 목록
    @Default([]) List<Question> questions,
  }) = _QuestionSet;

  factory QuestionSet.fromJson(Map<String, dynamic> json) =>
      _$QuestionSetFromJson(json);

  /// 문제 개수
  int get questionCount => questions.length;

  /// 중요도별 문제 필터링
  List<Question> filterByImportance(int minImportance) {
    return questions.where((q) => q.importance >= minImportance).toList();
  }

  /// 태그별 문제 필터링
  List<Question> filterByTag(String tag) {
    return questions.where((q) => q.tags.contains(tag)).toList();
  }

  /// 모든 태그 목록 (중복 제거)
  Set<String> get allTags {
    return questions.expand((q) => q.tags).toSet();
  }
}
