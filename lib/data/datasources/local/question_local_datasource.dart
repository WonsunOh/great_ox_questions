import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../models/models.dart';

/// 로컬 JSON 파일에서 문제 데이터를 로드하는 DataSource
class QuestionLocalDataSource {
  /// assets 폴더 내 데이터 경로
  static const String _assetsPath = 'assets/data';

  /// 등록된 문제 파일 목록
  /// 새 문제 파일 추가 시 이 목록에 추가해야 합니다.
  static const List<String> _registeredFiles = [
    'constitutional_law_ch1.json',
    // 추가 파일은 여기에 등록
  ];

  /// JSON 파일에서 QuestionSet 로드
  Future<QuestionSet> loadQuestionSet(String fileName) async {
    try {
      final jsonString = await rootBundle.loadString('$_assetsPath/$fileName');
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return QuestionSet.fromJson(jsonMap);
    } on FlutterError catch (e) {
      throw QuestionDataException(
        'Failed to load question file: $fileName',
        cause: e,
      );
    } on FormatException catch (e) {
      throw QuestionDataException(
        'Invalid JSON format in file: $fileName',
        cause: e,
      );
    }
  }

  /// 모든 등록된 문제 세트 로드
  Future<List<QuestionSet>> loadAllQuestionSets() async {
    final results = <QuestionSet>[];

    for (final fileName in _registeredFiles) {
      try {
        final questionSet = await loadQuestionSet(fileName);
        results.add(questionSet);
      } on QuestionDataException {
        // 개별 파일 로드 실패 시 스킵하고 계속 진행
        continue;
      }
    }

    return results;
  }

  /// 사용 가능한 파일 목록 반환
  List<String> getAvailableFiles() {
    return List.unmodifiable(_registeredFiles);
  }

  /// JSON 문자열에서 직접 QuestionSet 파싱 (테스트/동적 로딩용)
  QuestionSet parseQuestionSet(String jsonString) {
    try {
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return QuestionSet.fromJson(jsonMap);
    } on FormatException catch (e) {
      throw QuestionDataException(
        'Invalid JSON format',
        cause: e,
      );
    }
  }
}

/// 문제 데이터 관련 예외
class QuestionDataException implements Exception {
  const QuestionDataException(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() {
    if (cause != null) {
      return 'QuestionDataException: $message (caused by: $cause)';
    }
    return 'QuestionDataException: $message';
  }
}
