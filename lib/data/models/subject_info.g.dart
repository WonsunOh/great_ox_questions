// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubjectInfo _$SubjectInfoFromJson(Map<String, dynamic> json) => _SubjectInfo(
  subjectName: json['subject_name'] as String,
  chapterMajor: json['chapter_major'] as String,
  chapterMinor: json['chapter_minor'] as String,
  sourceReference: json['source_reference'] as String,
  version: json['version'] as String,
);

Map<String, dynamic> _$SubjectInfoToJson(_SubjectInfo instance) =>
    <String, dynamic>{
      'subject_name': instance.subjectName,
      'chapter_major': instance.chapterMajor,
      'chapter_minor': instance.chapterMinor,
      'source_reference': instance.sourceReference,
      'version': instance.version,
    };
