import 'dart:typed_data';

import 'package:gc_wizard/tools/images_and_files/stegano/logic/stegano_decoder.dart';
import 'package:gc_wizard/tools/images_and_files/stegano/logic/stegano_encoder.dart';
import 'package:gc_wizard/tools/images_and_files/stegano/logic/requests/stegano_decode_request.dart';
import 'package:gc_wizard/tools/images_and_files/stegano/logic/requests/stegano_encode_request.dart';
import 'package:gc_wizard/tools/utils/gcw_file/widget/gcw_file.dart' as local;

const int MAX_LENGTH = 5000;

Future<Uint8List> encodeStegano(local.GCWFile file, String message, String key, String filename) async {
  Uint8List data = file.bytes;
  // the key is use to encrypt your message with AES256 algorithm
  SteganoEncodeRequest request = SteganoEncodeRequest(data, message, key: key, filename: filename);
  Uint8List response = await encodeSteganoMessageIntoImageAsync(request);
  return response;
}

Future<String> decodeStegano(local.GCWFile file, String key) async {
  Uint8List data = file.bytes;
  // the key is use to decrypt your encrypted message with AES256 algorithm
  SteganoDecodeRequest request = SteganoDecodeRequest(data, key: key);
  String response = await decodeSteganoMessageFromImageAsync(request);
  if (response != null && response.length > MAX_LENGTH) {
    throw Exception('abnormal_length_nothing_to_decode');
  }
  return response;
}
