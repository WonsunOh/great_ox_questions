// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 샘플 문제 데이터 Provider
///
/// 실제 구현 시 Repository에서 JSON 데이터를 로드하도록 변경합니다.

@ProviderFor(sampleQuestions)
const sampleQuestionsProvider = SampleQuestionsProvider._();

/// 샘플 문제 데이터 Provider
///
/// 실제 구현 시 Repository에서 JSON 데이터를 로드하도록 변경합니다.

final class SampleQuestionsProvider
    extends $FunctionalProvider<List<Question>, List<Question>, List<Question>>
    with $Provider<List<Question>> {
  /// 샘플 문제 데이터 Provider
  ///
  /// 실제 구현 시 Repository에서 JSON 데이터를 로드하도록 변경합니다.
  const SampleQuestionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sampleQuestionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sampleQuestionsHash();

  @$internal
  @override
  $ProviderElement<List<Question>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Question> create(Ref ref) {
    return sampleQuestions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Question> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Question>>(value),
    );
  }
}

String _$sampleQuestionsHash() => r'5241599aec2d4cbee3ef6048315effd1a9e241af';

/// 샘플 과목 정보 Provider

@ProviderFor(sampleSubjectInfo)
const sampleSubjectInfoProvider = SampleSubjectInfoProvider._();

/// 샘플 과목 정보 Provider

final class SampleSubjectInfoProvider
    extends $FunctionalProvider<SubjectInfo, SubjectInfo, SubjectInfo>
    with $Provider<SubjectInfo> {
  /// 샘플 과목 정보 Provider
  const SampleSubjectInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sampleSubjectInfoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sampleSubjectInfoHash();

  @$internal
  @override
  $ProviderElement<SubjectInfo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SubjectInfo create(Ref ref) {
    return sampleSubjectInfo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SubjectInfo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SubjectInfo>(value),
    );
  }
}

String _$sampleSubjectInfoHash() => r'c3bd0975777acd7cb3478c012fd1076a4d08a1ec';
