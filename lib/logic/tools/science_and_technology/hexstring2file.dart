import 'dart:io';
import 'dart:typed_data';
import 'package:file/memory.dart';
import 'package:intl/intl.dart';

Map<List<int>, String> fileTypes = {
  [0x50, 0x4B, 0x03, 0x04] : ".zip",
  [0x52, 0x61, 0x72, 0x21] : ".rar",
  [0x1F, 0x8B, 0x08, 0x00] : ".tar",
  [0xFF, 0xD8, 0xFF, 0xE0] : ".jpg",
  [0xFF, 0xD8, 0xFF, 0xE1] : ".jpg",
  [0xFF, 0xD8, 0xFF, 0xFE] : ".jpg",
  [0x89, 0x50, 0x4E, 0x47] : ".png",
  [0x42, 0x4D, 0xF8, 0xA9] : ".bmp",
  [0x42, 0x4D, 0x62, 0x25] : ".bmp",
  [0x42, 0x4D, 0x76, 0x03] : ".bmp",
  [0x47, 0x49, 0x46, 0x38, 0x39, 0x61] : ".gif",
  [0x47, 0x49, 0x46, 0x38, 0x37, 0x61] : ".gif",
  [0x30, 0x26, 0xB2, 0x75] : ".wmv",
  [0x49, 0x44, 0x33, 0x2E] : ".mp3",
  [0x49, 0x44, 0x33, 0x03] : ".mp3",
  [0x25, 0x50, 0x44, 0x46] : ".pdf",
  [0x4D, 0x5A, 0x50, 0x00] : ".exe",
  [0x4D, 0x5A, 0x90, 0x00] : ".exe",
};

File hexstring2file(String input) {
  var blobBytes = _hexstring2bytes(input);

  if (blobBytes != null) {
    var extension = _getFilType(blobBytes);
    var fileName = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '_' + 'hex2file' + extension;

    return MemoryFileSystem().file(fileName)..writeAsBytesSync(blobBytes);
  }
  return null;
}

String file2hexstring(Uint8List input) {
  if (input == null)
    return null;

  var output =input.map((byte){
    return byte.toRadixString(16);
  })
  .join(' ');

  return output;
}

String _getFilType(Uint8List blobBytes) {
  fileTypes.forEach((key, type) {
    if (blobBytes.sublist(0, key.length) == key)
      return type;
  });
  return ".txt";
}

Uint8List _hexstring2bytes(String input) {
  if (input == null || input == "")
    return null;

  Uint8List data = Uint8List(0);

  String hex = input.toUpperCase().replaceAll(RegExp("^[0-9A-F]"), "");
  if (hex == "")
    return null;

  for (var i=0; i<hex.length; i+2) {
    var valueString = hex.substring(i,i+2);
    var value = int.parse(valueString, radix: 16);

    data.add(value);
  }

  return data;
}
