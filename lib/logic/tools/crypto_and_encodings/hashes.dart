import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/api.dart';
import 'package:pointycastle/digests/blake2b.dart';
import 'package:pointycastle/digests/md2.dart';
import 'package:pointycastle/digests/md4.dart';
import 'package:pointycastle/digests/md5.dart';
import 'package:pointycastle/digests/ripemd128.dart';
import 'package:pointycastle/digests/ripemd160.dart';
import 'package:pointycastle/digests/ripemd256.dart';
import 'package:pointycastle/digests/ripemd320.dart';
import 'package:pointycastle/digests/sha1.dart';
import 'package:pointycastle/digests/sha224.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/digests/sha384.dart';
import 'package:pointycastle/digests/sha512.dart';
import 'package:pointycastle/digests/sha512t.dart';
import 'package:pointycastle/export.dart';

// Wrapper for PointyCastle library

String _digest(Digest digest, String data) {
  if (data == null)
    data = '';

  Uint8List dataToDigest = utf8.encode(data);
  return digest.process(dataToDigest).map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
}

String blake2b_160Digest(String data) {
  return _digest(Blake2bDigest(digestSize: (160 / 8).floor()), data);
}

String blake2b_224Digest(String data) {
  return _digest(Blake2bDigest(digestSize: (224 / 8).floor()), data);
}

String blake2b_256Digest(String data) {
  return _digest(Blake2bDigest(digestSize: (256 / 8).floor()), data);
}

String blake2b_384Digest(String data) {
  return _digest(Blake2bDigest(digestSize: (384 / 8).floor()), data);
}

String blake2b_512Digest(String data) {
  return _digest(Blake2bDigest(), data);
}

String md2Digest(String data) {
  return _digest(MD2Digest(), data);
}

String md4Digest(String data) {
  return _digest(MD4Digest(), data);
}

String md5Digest(String data) {
  return _digest(MD5Digest(), data);
}

String ripemd_128Digest(String data) {
  return _digest(RIPEMD128Digest(), data);
}

String ripemd_160Digest(String data) {
  return _digest(RIPEMD160Digest(), data);
}

String ripemd_256Digest(String data) {
  return _digest(RIPEMD256Digest(), data);
}

String ripemd_320Digest(String data) {
  return _digest(RIPEMD320Digest(), data);
}

String sha1Digest(String data) {
  return _digest(SHA1Digest(), data);
}

String sha224Digest(String data) {
  return _digest(SHA224Digest(), data);
}

String sha256Digest(String data) {
  return _digest(SHA256Digest(), data);
}

String sha384Digest(String data) {
  return _digest(SHA384Digest(), data);
}

String sha512Digest(String data) {
  return _digest(SHA512Digest(), data);
}

String sha512_224Digest(String data) {
  return _digest(SHA512tDigest((224 / 8).floor()), data);
}

String sha512_256Digest(String data) {
  return _digest(SHA512tDigest((256 / 8).floor()), data);
}

String sha3_224Digest(String data) {
  return _digest(SHA3Digest(224, false), data);
}

String sha3_256Digest(String data) {
  return _digest(SHA3Digest(256, false), data);
}

String sha3_384Digest(String data) {
  return _digest(SHA3Digest(384, false), data);
}

String sha3_512Digest(String data) {
  return _digest(SHA3Digest(512, false), data);
}

String keccak_224Digest(String data) {
  return _digest(SHA3Digest(224), data);
}

String keccak_256Digest(String data) {
  return _digest(SHA3Digest(256), data);
}

String keccak_288Digest(String data) {
  return _digest(SHA3Digest(288), data);
}

String keccak_384Digest(String data) {
  return _digest(SHA3Digest(384), data);
}

String keccak_512Digest(String data) {
  return _digest(SHA3Digest(512), data);
}

String tiger_192Digest(String data) {
  return _digest(TigerDigest(), data);
}

String whirlpool_512Digest(String data) {
  return _digest(WhirlpoolDigest(), data);
}