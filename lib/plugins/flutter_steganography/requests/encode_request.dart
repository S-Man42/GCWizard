import 'dart:typed_data';

import 'base_request.dart';

class EncodeRequest extends BaseRequest {
  final String message;

  EncodeRequest(Uint8List imageData, this.message, {String key}) : super(imageData, key: key);
}
