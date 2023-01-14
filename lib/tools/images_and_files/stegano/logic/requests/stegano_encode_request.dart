import 'dart:typed_data';

import 'stegano_base_request.dart';

class SteganoEncodeRequest extends SteganoBaseRequest {
  final String message;
  final String filename;

  SteganoEncodeRequest(Uint8List imageData, this.message, {String key, this.filename}) : super(imageData, key: key);
}
