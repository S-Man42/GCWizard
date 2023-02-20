import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/hashes.dart';

void main() {
  group("Hashes:", () {
    test('input: ABC, Blake2b 160}', () {expect(blake2b_160Digest('ABC'), '4bd5cccca8d964c750542e2f144f27659cfd667d');});
    test('input: ABC, Blake2b 224}', () {expect(blake2b_224Digest('ABC'), '6e577b4b289acc9c218b5fa56b0122eaba8d9bbff3dcb4b6289c073e');});
    test('input: ABC, Blake2b 256}', () {expect(blake2b_256Digest('ABC'), '9fe8acb2641296906a8c91de51516972827e3e2aef2e2c892e5f3b1426cea920');});
    test('input: ABC, Blake2b 384}', () {expect(blake2b_384Digest('ABC'), 'bfd5efad5187f60b33cb8ffb1e20bcc13741914dfa11a65080f538a7fbdcd1b80865e2d4e12137cafbe75ad06525ca40');});
    test('input: ABC, Blake2b 512}', () {expect(blake2b_512Digest('ABC'), '253d75df7b1bbc7a3f98fbc975d31bf25a8f3af84a42f37f15ca326c3feab2a2647673feeb1a4746bd0c59bbfb474dd97434afd4890b00e4ee1201f8c5c9806f');});
    test('input: ABC, MD2}', () {expect(md2Digest('ABC'), '67c7a694b8f99396bb1946eb7950e2c4');});
    test('input: ABC, MD4}', () {expect(md4Digest('ABC'), '6a86685756167ca49fa5ac194f812c61');});
    test('input: ABC, MD5}', () {expect(md5Digest('ABC'), '902fbdd2b1df0c4f70b4a5d23525e932');});
    test('input: ABC, RipeMD 128}', () {expect(ripemd_128Digest('ABC'), 'f1428f840d3a194eccb1b8cb7ea98f4a');});
    test('input: ABC, RipeMD 160}', () {expect(ripemd_160Digest('ABC'), 'df62d400e51d3582d53c2d89cfeb6e10d32a3ca6');});
    test('input: ABC, RipeMD 256}', () {expect(ripemd_256Digest('ABC'), 'b2a837fc4b66a964abd5809333896de83b9f914d00f469e6a5d836879d32cc2e');});
    test('input: ABC, RipeMD 320}', () {expect(ripemd_320Digest('ABC'), '6c46fb0fafd948b8477463d0eb96e1836fefc062adfc4e6a38b52bb61385eee173ce866de6c375f7');});
    test('input: ABC, SHA-1}', () {expect(sha1Digest('ABC'), '3c01bdbb26f358bab27f267924aa2c9a03fcfdb8');});
    test('input: ABC, SHA-224}', () {expect(sha224Digest('ABC'), '107c5072b799c4771f328304cfe1ebb375eb6ea7f35a3aa753836fad');});
    test('input: ABC, SHA-256}', () {expect(sha256Digest('ABC'), 'b5d4045c3f466fa91fe2cc6abe79232a1a57cdf104f7a26e716e0a1e2789df78');});
    test('input: ABC, SHA-384}', () {expect(sha384Digest('ABC'), '1e02dc92a41db610c9bcdc9b5935d1fb9be5639116f6c67e97bc1a3ac649753baba7ba021c813e1fe20c0480213ad371');});
    test('input: ABC, SHA-512}', () {expect(sha512Digest('ABC'), '397118fdac8d83ad98813c50759c85b8c47565d8268bf10da483153b747a74743a58a90e85aa9f705ce6984ffc128db567489817e4092d050d8a1cc596ddc119');});
    test('input: ABC, SHA-512/224}', () {expect(sha512_224Digest('ABC'), '2a2aa10c3ca33a979d6cc7d36f94425fb72a09d3d7137c8b9b5b4474');});
    test('input: ABC, SHA-512/256}', () {expect(sha512_256Digest('ABC'), '625c3e642852cb343b9b06eae14b47a7da0fd292a7be7b8a251208a65271af36');});
    test('input: ABC, SHA3-224}', () {expect(sha3_224Digest('ABC'), '51e6db7cba212f1490b290e44c588e3a028c8334055c877910c3ebe6');});
    test('input: ABC, SHA3-256}', () {expect(sha3_256Digest('ABC'), '7fb50120d9d1bc7504b4b7f1888d42ed98c0b47ab60a20bd4a2da7b2c1360efa');});
    test('input: ABC, SHA3-384}', () {expect(sha3_384Digest('ABC'), '38078331baaa86dbe9b38224a0780e9661daa35b42066a804efd5215b2487b9728a19ae4940ddbcbda39b697f13ebebb');});
    test('input: ABC, SHA3-512}', () {expect(sha3_512Digest('ABC'), '077aa33882b1aaf06da41c7ed3b6a40d7128dee23505ca2689c47637111c4701645fabc5ee1b9dcd039231d2d086bff9819ce2da8647432a73966494dd1a77ad');});
    test('input: ABC, Keccak-224}', () {expect(keccak_224Digest('ABC'), 'e751bc65acf5b088140fc76b934be15ac2caebba4d403ef60a6662a3');});
    test('input: ABC, Keccak-256}', () {expect(keccak_256Digest('ABC'), 'e1629b9dda060bb30c7908346f6af189c16773fa148d3366701fbaa35d54f3c8');});
    test('input: ABC, Keccak-288}', () {expect(keccak_288Digest('ABC'), 'c5c7a3dd87e9a340b960e8fedf3c7741ef767c043a18116ca0a7f9e0ef5ade4aec84c2c4');});
    test('input: ABC, Keccak-384}', () {expect(keccak_384Digest('ABC'), 'a786995442b0677bdcde1f0187c971518a79c65b2726ed9ba0098d6227560c768258db19d9a7e2842d80dc3e50a8a630');});
    test('input: ABC, Keccak-512}', () {expect(keccak_512Digest('ABC'), '49a28c786e950ae7a361416c198873a40fdfd374653e396abc2c9d779c13bd786accd1d0e40374222827d6ddabc2032b698edc48e192175352340afb48e40af4');});
    test('input: ABC, Tiger 192}', () {expect(tiger_192Digest('ABC'), 'c7188daee93509ecce198de5a43c8db47210db7e8d8bb8dd');});
    test('input: ABC, Whirlpool 512}', () {expect(whirlpool_512Digest('ABC'), 'd6e73067f0c7f37151c283c95ff41eb4e69fbade1c8e1437a40809b2acc0b9ab0a22690e853ffe7b4a804d7238f48a4984c2e5d745ccc223420b0af5bb3dc3ed');});
  });
}