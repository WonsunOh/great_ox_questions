import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../models/models.dart';
import '../../services/encryption_service.dart';

/// 로컬 JSON 파일에서 문제 데이터를 로드하는 DataSource
class QuestionLocalDataSource {
  /// assets 폴더 내 데이터 경로
  static const String _assetsPath = 'assets/data';

  /// 등록된 문제 파일 목록
  /// 새 문제 파일 추가 시 이 목록에 추가해야 합니다.
  /// .json (일반) 또는 .oxq (암호화) 파일 모두 지원
  static const List<String> _registeredFiles = [
    'constitutional_law_ch1.json', // 샘플 문제
  ];

  /// JSON 파일에서 QuestionSet 로드
  Future<QuestionSet> loadQuestionSet(String fileName) async {
    try {
      final bytes = await rootBundle.load('$_assetsPath/$fileName');
      final data = bytes.buffer.asUint8List();

      String jsonString;

      // 암호화된 파일인지 확인
      if (EncryptionService.isEncryptedFileName(fileName) ||
          EncryptionService.isEncryptedFile(data)) {
        // 암호화된 파일 복호화
        jsonString = await EncryptionService.decryptFromBytes(data);
      } else {
        // 일반 JSON 파일
        jsonString = utf8.decode(data);
      }

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
    } catch (e) {
      throw QuestionDataException(
        'Error loading file: $fileName',
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

  /// 암호화된 바이트 데이터에서 QuestionSet 파싱
  Future<QuestionSet> parseEncryptedQuestionSet(Uint8List encryptedBytes) async {
    try {
      final jsonString = await EncryptionService.decryptFromBytes(encryptedBytes);
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return QuestionSet.fromJson(jsonMap);
    } on FormatException catch (e) {
      throw QuestionDataException(
        'Invalid JSON format after decryption',
        cause: e,
      );
    } catch (e) {
      throw QuestionDataException(
        'Decryption failed',
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
