import '../../data/models/models.dart';

/// 문제 데이터 Repository 인터페이스
///
/// Domain Layer에서 정의하는 추상 인터페이스입니다.
/// Data Layer에서 구현체를 제공합니다.
abstract interface class QuestionRepository {
  /// 모든 문제 세트 목록 조회
  Future<List<QuestionSet>> getAllQuestionSets();

  /// 특정 문제 세트 조회 (파일명 기준)
  Future<QuestionSet> getQuestionSet(String fileName);

  /// 사용 가능한 문제 파일 목록 조회
  Future<List<String>> getAvailableFiles();

  /// 과목별 문제 세트 조회
  Future<List<QuestionSet>> getQuestionSetsBySubject(String subjectName);
}
