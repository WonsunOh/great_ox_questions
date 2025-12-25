#include "native_key.h"

// XOR key for obfuscation
static const unsigned char kXorKey = 0x5A;

// Obfuscated key data: "Gen2024Secret" XOR 0x5A
static const unsigned char kObfuscatedData[] = {
    0x1D, 0x3F, 0x34, 0x68, 0x6A, 0x68, 0x6E,
    0x09, 0x3F, 0x39, 0x28, 0x3F, 0x2E
};
static const size_t kDataLength = 13;

std::string GetObfuscatedKeyPart() {
    std::string result;
    result.reserve(kDataLength);

    for (size_t i = 0; i < kDataLength; ++i) {
        result.push_back(static_cast<char>(kObfuscatedData[i] ^ kXorKey));
    }

    return result;
}
