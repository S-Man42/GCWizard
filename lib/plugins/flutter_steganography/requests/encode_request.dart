import 'dart:typed_data';

import 'base_request.dart';

class EncodeRequest extends BaseRequest {
  final String message;
  final String filename;

  EncodeRequest(Uint8List imageData, this.message, {String key, this.filename}) : super(imageData, key: key);
}
