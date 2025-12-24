// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 퀴즈 ViewModel
///
/// 퀴즈 진행 상태를 관리하고 사용자 인터랙션을 처리합니다.
/// keepAlive: true로 설정하여 화면 전환 후에도 상태가 유지됩니다.

@ProviderFor(QuizViewModel)
const quizViewModelProvider = QuizViewModelProvider._();

/// 퀴즈 ViewModel
///
/// 퀴즈 진행 상태를 관리하고 사용자 인터랙션을 처리합니다.
/// keepAlive: true로 설정하여 화면 전환 후에도 상태가 유지됩니다.
final class QuizViewModelProvider
    extends $NotifierProvider<QuizViewModel, QuizState> {
  /// 퀴즈 ViewModel
  ///
  /// 퀴즈 진행 상태를 관리하고 사용자 인터랙션을 처리합니다.
  /// keepAlive: true로 설정하여 화면 전환 후에도 상태가 유지됩니다.
  const QuizViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'quizViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$quizViewModelHash();

  @$internal
  @override
  QuizViewModel create() => QuizViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(QuizState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<QuizState>(value),
    );
  }
}

String _$quizViewModelHash() => r'e46c9bc1fb4dee67eda5dd88e80bddd984108900';

/// 퀴즈 ViewModel
///
/// 퀴즈 진행 상태를 관리하고 사용자 인터랙션을 처리합니다.
/// keepAlive: true로 설정하여 화면 전환 후에도 상태가 유지됩니다.

abstract class _$QuizViewModel extends $Notifier<QuizState> {
  QuizState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<QuizState, QuizState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<QuizState, QuizState>,
              QuizState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
