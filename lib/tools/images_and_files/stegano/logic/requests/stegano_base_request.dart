import 'dart:typed_data';

class SteganoBaseRequest {
  final Uint8List imageData;
  final String key;

  SteganoBaseRequest(this.imageData, {this.key});

  bool canEncrypt() {
    return (key != null && key.isNotEmpty);
  }
}
