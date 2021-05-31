import 'dart:typed_data';
import 'package:qrscan/qrscan.dart' as scanner;

/// Parse to code string with uint8list
Future<String> scanBytes(Uint8List bytes) async {
  return scanner.scanBytes(bytes);
}

/// Generating Bar Code
Future<Uint8List> generateBarCode(String code) async {
  scanner.generateBarCode(code);
}
