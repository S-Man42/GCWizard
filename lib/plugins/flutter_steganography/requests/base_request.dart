import 'dart:typed_data';

class BaseRequest {
  final Uint8List imageData;
  final String key;

  BaseRequest(this.imageData, {this.key});

  bool canEncrypt() {
    return (key != null && key.isNotEmpty);
  }
}
