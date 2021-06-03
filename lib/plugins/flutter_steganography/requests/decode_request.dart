import 'dart:typed_data';

import 'base_request.dart';

class DecodeRequest extends BaseRequest {
  DecodeRequest(Uint8List imageData, {String key}) : super(imageData, key: key);
}
