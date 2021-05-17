import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:gc_wizard/plugins/flutter_steganography/decoder.dart';
import 'package:gc_wizard/plugins/flutter_steganography/encoder.dart';
import 'package:gc_wizard/plugins/flutter_steganography/requests/decode_request.dart';
import 'package:gc_wizard/plugins/flutter_steganography/requests/encode_request.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';

Future<Uint8List> encodeStegano(PlatformFile file, String message, String key) async {
  Uint8List data = await getFileData(file);
  // the key is use to encrypt your message with AES256 algorithm
  EncodeRequest request = EncodeRequest(data, message, key: key);
  Uint8List response = await encodeMessageIntoImageAsync(request);
  return response;
}

Future<String> decodeStegano(PlatformFile file, String key) async {
  Uint8List data = await getFileData(file);
  // the key is use to decrypt your encrypted message with AES256 algorithm
  DecodeRequest request = DecodeRequest(data, key: key);
  String response = await decodeMessageFromImageAsync(request);
  return response;
}
