package com.example.great_ox_questions

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.oxquiz/native_key"

    // XOR key for obfuscation
    private val xorKey: Byte = 0x5A

    // Obfuscated key data: "Gen2024Secret" XOR 0x5A
    private val obfuscatedData = byteArrayOf(
        0x1D, 0x3F, 0x34, 0x68, 0x6A, 0x68, 0x6E,
        0x09, 0x3F, 0x39, 0x28, 0x3F, 0x2E
    )

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getKeyPart") {
                val keyPart = getObfuscatedKeyPart()
                result.success(keyPart)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getObfuscatedKeyPart(): String {
        val decoded = ByteArray(obfuscatedData.size)
        for (i in obfuscatedData.indices) {
            decoded[i] = (obfuscatedData[i].toInt() xor xorKey.toInt()).toByte()
        }
        return String(decoded, Charsets.UTF_8)
    }
}
