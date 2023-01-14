import 'dart:typed_data';

import 'package:gc_wizard/tools/images_and_files/stegano/logic/requests/stegano_base_request.dart';

class SteganoDecodeRequest extends SteganoBaseRequest {
  SteganoDecodeRequest(Uint8List imageData, {String key}) : super(imageData, key: key);
}
