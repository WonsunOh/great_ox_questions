import 'package:flutter/services.dart';

/// 네이티브 코드에서 암호화 키 일부를 가져오는 Platform Channel
class NativeKeyChannel {
  static const _channel = MethodChannel('com.oxquiz/native_key');

  static String? _cachedKeyPart;

  /// 네이티브에서 난독화된 키 일부 가져오기
  static Future<String> getKeyPart() async {
    if (_cachedKeyPart != null) {
      return _cachedKeyPart!;
    }

    try {
      final result = await _channel.invokeMethod<String>('getKeyPart');
      _cachedKeyPart = result ?? '';
      return _cachedKeyPart!;
    } on PlatformException {
      // 네이티브 채널 실패 시 폴백 (개발 중에만 사용)
      return '';
    }
  }
}
