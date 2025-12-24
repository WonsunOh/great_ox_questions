// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuestionSet _$QuestionSetFromJson(Map<String, dynamic> json) => _QuestionSet(
  subjectInfo: SubjectInfo.fromJson(
    json['subject_info'] as Map<String, dynamic>,
  ),
  questions:
      (json['questions'] as List<dynamic>?)
          ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$QuestionSetToJson(_QuestionSet instance) =>
    <String, dynamic>{
      'subject_info': instance.subjectInfo,
      'questions': instance.questions,
    };
