import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/datasources/local/question_local_datasource.dart';
import '../data/models/models.dart';
import '../data/repositories/question_repository_impl.dart';
import '../domain/repositories/question_repository.dart';

part 'question_providers.g.dart';

/// QuestionLocalDataSource Provider
@riverpod
QuestionLocalDataSource questionLocalDataSource(Ref ref) {
  return QuestionLocalDataSource();
}

/// QuestionRepository Provider
@riverpod
QuestionRepository questionRepository(Ref ref) {
  final localDataSource = ref.watch(questionLocalDataSourceProvider);
  return QuestionRepositoryImpl(localDataSource: localDataSource);
}

/// 모든 문제 세트 로드 Provider
@riverpod
Future<List<QuestionSet>> allQuestionSets(Ref ref) async {
  final repository = ref.watch(questionRepositoryProvider);
  return repository.getAllQuestionSets();
}

/// 특정 파일의 문제 세트 로드 Provider
@riverpod
Future<QuestionSet> questionSet(
  Ref ref,
  String fileName,
) async {
  final repository = ref.watch(questionRepositoryProvider);
  return repository.getQuestionSet(fileName);
}

/// 사용 가능한 파일 목록 Provider
@riverpod
Future<List<String>> availableQuestionFiles(Ref ref) async {
  final repository = ref.watch(questionRepositoryProvider);
  return repository.getAvailableFiles();
}

/// 현재 선택된 문제 세트 Provider (상태 관리)
@riverpod
class SelectedQuestionSet extends _$SelectedQuestionSet {
  @override
  QuestionSet? build() => null;

  void select(QuestionSet questionSet) {
    state = questionSet;
  }

  void clear() {
    state = null;
  }
}
