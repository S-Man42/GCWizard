import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as crypto;
import 'package:flutter/foundation.dart';
import 'package:gc_wizard/plugins/flutter_steganography/requests/decode_request.dart';
import 'package:image/image.dart';

import 'pad_key.dart';

int _extractLastBit(int pixel) {
  int lastBit = pixel & 1;
  return lastBit;
}

int _assembleBit(Uint8List byte) {
  if (byte.length != 8) {
    throw FlutterError('byte_incorrect_size');
  }
  int assembled = 0;
  for (int i = 0; i < 8; ++i) {
    if (byte[i] != 1 && byte[i] != 0) {
      throw FlutterError('bit_not_0_or_1');
    }
    assembled = assembled << 1;
    assembled = assembled | byte[i];
  }
  return assembled;
}

String decodeMessageFromImage(DecodeRequest req) {
  Image origin = decodeImage(req.imageData);
  Uint8List img = origin.getBytes();

  Uint8List extracted = Uint8List(img.length);
  for (int i = 0; i < img.length; i++) {
    extracted[i] = _extractLastBit(img[i]);
  }

  int padSize = 8 - extracted.length % 8;
  Uint8List padded = Uint8List(extracted.length + padSize);
  for (int i = 0; i < extracted.length; ++i) {
    padded[i] = extracted[i];
  }
  for (int i = 0; i < padSize; ++i) {
    padded[extracted.length + i] = 0;
  }

  if ((padded.length % 8) != 0) {
    throw FlutterError('bits_contain_incomplete_byte');
  }
  int byteCnt = padded.length ~/ 8;
  Uint8List byteMsg = Uint8List(byteCnt);
  for (int i = 0; i < byteCnt; ++i) {
    Uint8List bitsOfByte = Uint8List.fromList(padded.getRange(i * 8, i * 8 + 8).toList());
    int byte = _assembleBit(bitsOfByte);
    byteMsg[i] = byte;
  }

  int lastNonZeroIdx = byteMsg.length - 1;
  while (byteMsg[lastNonZeroIdx] == 0) {
    --lastNonZeroIdx;
  }
  Uint8List sanitized = Uint8List.fromList(byteMsg.getRange(0, lastNonZeroIdx + 1).toList());
  String msg = String.fromCharCodes(sanitized);

  String token = req.key;
  if (req.canEncrypt()) {
    crypto.Key key = crypto.Key.fromUtf8(padKey(token));
    crypto.IV iv = crypto.IV.fromLength(16);
    crypto.Encrypter encrypter = crypto.Encrypter(crypto.AES(key));
    crypto.Encrypted encryptedMsg = crypto.Encrypted.fromBase64(msg);
    msg = encrypter.decrypt(encryptedMsg, iv: iv);
  }
  return msg;
}

Future<String> decodeMessageFromImageAsync(DecodeRequest req) async {
  final String res = await compute(decodeMessageFromImage, req);
  return res;
}
