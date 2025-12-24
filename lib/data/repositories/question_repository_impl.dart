import '../../domain/repositories/question_repository.dart';
import '../datasources/local/question_local_datasource.dart';
import '../models/models.dart';

/// QuestionRepository 구현체
///
/// Local DataSource를 사용하여 JSON 파일에서 문제 데이터를 로드합니다.
class QuestionRepositoryImpl implements QuestionRepository {
  QuestionRepositoryImpl({
    QuestionLocalDataSource? localDataSource,
  }) : _localDataSource = localDataSource ?? QuestionLocalDataSource();

  final QuestionLocalDataSource _localDataSource;

  /// 캐시된 문제 세트 (메모리 캐싱)
  final Map<String, QuestionSet> _cache = {};

  @override
  Future<List<QuestionSet>> getAllQuestionSets() async {
    final questionSets = await _localDataSource.loadAllQuestionSets();

    // 캐시 업데이트
    for (final qs in questionSets) {
      final key = '${qs.subjectInfo.subjectName}_${qs.subjectInfo.chapterMajor}';
      _cache[key] = qs;
    }

    return questionSets;
  }

  @override
  Future<QuestionSet> getQuestionSet(String fileName) async {
    // 캐시 확인
    if (_cache.containsKey(fileName)) {
      return _cache[fileName]!;
    }

    final questionSet = await _localDataSource.loadQuestionSet(fileName);

    // 캐시 저장
    _cache[fileName] = questionSet;

    return questionSet;
  }

  @override
  Future<List<String>> getAvailableFiles() async {
    return _localDataSource.getAvailableFiles();
  }

  @override
  Future<List<QuestionSet>> getQuestionSetsBySubject(String subjectName) async {
    final allSets = await getAllQuestionSets();
    return allSets
        .where((qs) => qs.subjectInfo.subjectName == subjectName)
        .toList();
  }

  /// 캐시 초기화
  void clearCache() {
    _cache.clear();
  }
}
