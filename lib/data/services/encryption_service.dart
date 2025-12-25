import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';

import 'native_key_channel.dart';

/// 암호화 서비스 V2 - 분산 키 + 랜덤 IV 지원
/// V1 (OXQENC1) 파일도 하위 호환성 유지
class EncryptionService {
  // V1 레거시 키 (하위 호환용)
  static const String _legacyKey = 'OxQuestionGen2024SecretKey!!@@##';
  static const String _legacyIv = 'OxGenIV16Bytes!!';

  // V2 분산 키 조각
  static const String _keyPart1 = 'OxQuestion'; // Dart에 저장 (10바이트)
  // _keyPart2는 네이티브에서 가져옴: 'Gen2024Secret' (13바이트)
  static const List<int> _keyPart3Data = [
    0x4B, 0x65, 0x79, 0x21, 0x21, 0x40, 0x40, 0x23, 0x23
  ]; // 'Key!!@@##' (9바이트)

  static String? _cachedKey;

  /// V2 분산 키 조합
  static Future<String> _getSecretKey() async {
    if (_cachedKey != null) return _cachedKey!;

    final part2 = await NativeKeyChannel.getKeyPart();
    final part3 = String.fromCharCodes(_keyPart3Data);

    // 키 조합: Part1 + Part2 + Part3 = 32바이트
    _cachedKey = '$_keyPart1$part2$part3';
    return _cachedKey!;
  }

  /// V1 암호화된 문자열을 복호화 (레거시)
  static String _decryptV1(String encryptedText) {
    final key = Key.fromUtf8(_legacyKey);
    final iv = IV.fromUtf8(_legacyIv);

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    return encrypter.decrypt64(encryptedText, iv: iv);
  }

  /// V2 암호화된 바이트 복호화 (랜덤 IV 포함)
  static Future<String> _decryptV2(Uint8List bytes) async {
    // 헤더(7) + IV(16) + 암호문
    if (bytes.length < 23) {
      throw Exception('파일이 손상되었습니다.');
    }

    final ivBytes = bytes.sublist(7, 23);
    final encryptedBytes = bytes.sublist(23);

    final secretKey = await _getSecretKey();
    final key = Key.fromUtf8(secretKey);
    final iv = IV(ivBytes);

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    return encrypter.decrypt(Encrypted(encryptedBytes), iv: iv);
  }

  /// 바이너리 데이터를 복호화하여 JSON 반환 (V1, V2 자동 감지)
  static Future<String> decryptFromBytes(Uint8List bytes) async {
    if (bytes.length < 7) {
      throw Exception('잘못된 파일 형식입니다.');
    }

    final header = utf8.decode(bytes.sublist(0, 7));

    if (header == 'OXQENC2') {
      // V2: 분산 키 + 랜덤 IV
      return _decryptV2(bytes);
    } else if (header == 'OXQENC1') {
      // V1: 레거시 (고정 키, 고정 IV)
      final combined = utf8.decode(bytes);
      final encrypted = combined.substring(7);
      return _decryptV1(encrypted);
    } else {
      throw Exception('지원하지 않는 파일 형식입니다.');
    }
  }

  /// 암호화된 파일인지 확인 (V1 또는 V2)
  static bool isEncryptedFile(Uint8List bytes) {
    if (bytes.length < 7) return false;

    try {
      final header = utf8.decode(bytes.sublist(0, 7));
      return header == 'OXQENC1' || header == 'OXQENC2';
    } catch (e) {
      return false;
    }
  }

  /// 파일 확장자로 암호화 파일인지 확인
  static bool isEncryptedFileName(String fileName) {
    return fileName.toLowerCase().endsWith('.oxq');
  }

  /// 파일 버전 확인
  static int? getFileVersion(Uint8List bytes) {
    if (bytes.length < 7) return null;

    try {
      final header = utf8.decode(bytes.sublist(0, 7));
      if (header == 'OXQENC1') return 1;
      if (header == 'OXQENC2') return 2;
      return null;
    } catch (e) {
      return null;
    }
  }
}
