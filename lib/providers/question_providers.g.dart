// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// QuestionLocalDataSource Provider

@ProviderFor(questionLocalDataSource)
const questionLocalDataSourceProvider = QuestionLocalDataSourceProvider._();

/// QuestionLocalDataSource Provider

final class QuestionLocalDataSourceProvider
    extends
        $FunctionalProvider<
          QuestionLocalDataSource,
          QuestionLocalDataSource,
          QuestionLocalDataSource
        >
    with $Provider<QuestionLocalDataSource> {
  /// QuestionLocalDataSource Provider
  const QuestionLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'questionLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$questionLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<QuestionLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  QuestionLocalDataSource create(Ref ref) {
    return questionLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(QuestionLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<QuestionLocalDataSource>(value),
    );
  }
}

String _$questionLocalDataSourceHash() =>
    r'fc9c5971a01a2f55a79c65446916f3ac24370ea9';

/// QuestionRepository Provider

@ProviderFor(questionRepository)
const questionRepositoryProvider = QuestionRepositoryProvider._();

/// QuestionRepository Provider

final class QuestionRepositoryProvider
    extends
        $FunctionalProvider<
          QuestionRepository,
          QuestionRepository,
          QuestionRepository
        >
    with $Provider<QuestionRepository> {
  /// QuestionRepository Provider
  const QuestionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'questionRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$questionRepositoryHash();

  @$internal
  @override
  $ProviderElement<QuestionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  QuestionRepository create(Ref ref) {
    return questionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(QuestionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<QuestionRepository>(value),
    );
  }
}

String _$questionRepositoryHash() =>
    r'c0b00feff3e354ad8ccae3469684ca45cc76c8c4';

/// 모든 문제 세트 로드 Provider

@ProviderFor(allQuestionSets)
const allQuestionSetsProvider = AllQuestionSetsProvider._();

/// 모든 문제 세트 로드 Provider

final class AllQuestionSetsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<QuestionSet>>,
          List<QuestionSet>,
          FutureOr<List<QuestionSet>>
        >
    with
        $FutureModifier<List<QuestionSet>>,
        $FutureProvider<List<QuestionSet>> {
  /// 모든 문제 세트 로드 Provider
  const AllQuestionSetsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allQuestionSetsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allQuestionSetsHash();

  @$internal
  @override
  $FutureProviderElement<List<QuestionSet>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<QuestionSet>> create(Ref ref) {
    return allQuestionSets(ref);
  }
}

String _$allQuestionSetsHash() => r'd24a29c9505b7c7d8fe0dcdf47cd0622c6ef7f38';

/// 특정 파일의 문제 세트 로드 Provider

@ProviderFor(questionSet)
const questionSetProvider = QuestionSetFamily._();

/// 특정 파일의 문제 세트 로드 Provider

final class QuestionSetProvider
    extends
        $FunctionalProvider<
          AsyncValue<QuestionSet>,
          QuestionSet,
          FutureOr<QuestionSet>
        >
    with $FutureModifier<QuestionSet>, $FutureProvider<QuestionSet> {
  /// 특정 파일의 문제 세트 로드 Provider
  const QuestionSetProvider._({
    required QuestionSetFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'questionSetProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$questionSetHash();

  @override
  String toString() {
    return r'questionSetProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<QuestionSet> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<QuestionSet> create(Ref ref) {
    final argument = this.argument as String;
    return questionSet(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is QuestionSetProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$questionSetHash() => r'1e7566f8e795705146ca56e77c63e56ea310220c';

/// 특정 파일의 문제 세트 로드 Provider

final class QuestionSetFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<QuestionSet>, String> {
  const QuestionSetFamily._()
    : super(
        retry: null,
        name: r'questionSetProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 특정 파일의 문제 세트 로드 Provider

  QuestionSetProvider call(String fileName) =>
      QuestionSetProvider._(argument: fileName, from: this);

  @override
  String toString() => r'questionSetProvider';
}

/// 사용 가능한 파일 목록 Provider

@ProviderFor(availableQuestionFiles)
const availableQuestionFilesProvider = AvailableQuestionFilesProvider._();

/// 사용 가능한 파일 목록 Provider

final class AvailableQuestionFilesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  /// 사용 가능한 파일 목록 Provider
  const AvailableQuestionFilesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'availableQuestionFilesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$availableQuestionFilesHash();

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    return availableQuestionFiles(ref);
  }
}

String _$availableQuestionFilesHash() =>
    r'2e80e16866ac83685f638ccb5620d0e3133b9090';

/// 현재 선택된 문제 세트 Provider (상태 관리)

@ProviderFor(SelectedQuestionSet)
const selectedQuestionSetProvider = SelectedQuestionSetProvider._();

/// 현재 선택된 문제 세트 Provider (상태 관리)
final class SelectedQuestionSetProvider
    extends $NotifierProvider<SelectedQuestionSet, QuestionSet?> {
  /// 현재 선택된 문제 세트 Provider (상태 관리)
  const SelectedQuestionSetProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedQuestionSetProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedQuestionSetHash();

  @$internal
  @override
  SelectedQuestionSet create() => SelectedQuestionSet();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(QuestionSet? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<QuestionSet?>(value),
    );
  }
}

String _$selectedQuestionSetHash() =>
    r'a5af5ffee3a23443574f9c4d8861c72d7a1b8e15';

/// 현재 선택된 문제 세트 Provider (상태 관리)

abstract class _$SelectedQuestionSet extends $Notifier<QuestionSet?> {
  QuestionSet? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<QuestionSet?, QuestionSet?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<QuestionSet?, QuestionSet?>,
              QuestionSet?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
