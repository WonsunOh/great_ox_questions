import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject_info.freezed.dart';
part 'subject_info.g.dart';

/// 과목 및 챕터 정보를 담는 모델
@freezed
abstract class SubjectInfo with _$SubjectInfo {
  const factory SubjectInfo({
    /// 과목명
    @JsonKey(name: 'subject_name') required String subjectName,

    /// 대단원
    @JsonKey(name: 'chapter_major') required String chapterMajor,

    /// 소단원
    @JsonKey(name: 'chapter_minor') required String chapterMinor,

    /// 출처
    @JsonKey(name: 'source_reference') required String sourceReference,

    /// 버전
    required String version,
  }) = _SubjectInfo;

  factory SubjectInfo.fromJson(Map<String, dynamic> json) =>
      _$SubjectInfoFromJson(json);
}
