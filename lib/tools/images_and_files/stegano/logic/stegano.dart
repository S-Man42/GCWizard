import 'dart:typed_data';

import 'package:gc_wizard/plugins/flutter_steganography/decoder.dart';
import 'package:gc_wizard/plugins/flutter_steganography/encoder.dart';
import 'package:gc_wizard/plugins/flutter_steganography/requests/decode_request.dart';
import 'package:gc_wizard/plugins/flutter_steganography/requests/encode_request.dart';
import 'package:gc_wizard/tools/utils/gcw_file/widget/gcw_file.dart' as local;

const int MAX_LENGTH = 5000;

Future<Uint8List> encodeStegano(local.GCWFile file, String message, String key, String filename) async {
  Uint8List data = file.bytes;
  // the key is use to encrypt your message with AES256 algorithm
  EncodeRequest request = EncodeRequest(data, message, key: key, filename: filename);
  Uint8List response = await encodeMessageIntoImageAsync(request);
  return response;
}

Future<String> decodeStegano(local.GCWFile file, String key) async {
  Uint8List data = file.bytes;
  // the key is use to decrypt your encrypted message with AES256 algorithm
  DecodeRequest request = DecodeRequest(data, key: key);
  String response = await decodeMessageFromImageAsync(request);
  if (response != null && response.length > MAX_LENGTH) {
    throw Exception('abnormal_length_nothing_to_decode');
  }
  return response;
}
