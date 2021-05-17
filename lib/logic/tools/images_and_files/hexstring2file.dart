import 'dart:math';
import 'dart:typed_data';
import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';

enum MIMETYPE {IMAGE, ARCHIV, DATA, TEXT}

Uint8List hexstring2file(String input) {
  if (_isBinary(input))
    return _binaryString2bytes(input);
  else
    return _hexString2bytes(input);
}

MIMETYPE getMimeType(String fileName) {
  if (fileName.endsWith('.jpg') ||
      fileName.endsWith('.gif') ||
      fileName.endsWith('.png') ||
      fileName.endsWith('.bmp') ||
      fileName.endsWith('.tif') ||
      fileName.endsWith('.tiff') ||
      fileName.endsWith('.webp'))
    return MIMETYPE.IMAGE;
  else if (fileName.endsWith('.zip') ||
      fileName.endsWith('.rar') ||
      fileName.endsWith('.7z') ||
      fileName.endsWith('.tar'))
    return MIMETYPE.ARCHIV;
  else if (fileName.endsWith('.txt'))
    return MIMETYPE.TEXT;
  else
    return MIMETYPE.DATA;
}

String file2hexstring(Uint8List input) {
  if (input == null)
    return null;

  var output =input.map((byte){
    return byte.toRadixString(16).padLeft(2,'0');
  })
  .join(' ');

  return output.toUpperCase();
}

Uint8List _hexString2bytes(String input) {
  if (input == null || input == "")
    return null;

  var data = <int>[];

  input = input.replaceAll("0x", "");
  String hex = input.toUpperCase().replaceAll(RegExp("[^0-9A-F]"), "");
  if (hex == "")
    return null;

  for (var i=0; i<hex.length; i=i+2) {
    var valueString = hex.substring(i, min(i+2, hex.length-1));
    if (valueString.length  > 0) {
      int value = int.tryParse(convertBase(valueString, 16, 10));
      data.add(value);
    }
  }

  return Uint8List.fromList(data);
}

bool _isBinary(String input) {
  if (input == null)
    return false;
  String binary = input.replaceAll(RegExp("[01\\s]"), "");
  return binary.length == 0;
}

Uint8List _binaryString2bytes(String input) {
  if (input == null || input == "")
    return null;

  var data = <int>[];

  String binary = input.replaceAll(RegExp("[^01]"), "");
  if (binary == "")
    return null;

  for (var i=0; i<binary.length; i=i+8) {
    var valueString = binary.substring(i, min(i+8, binary.length-1));
    if (valueString.length  > 0) {
      int value = int.tryParse(convertBase(valueString, 2, 10));
      data.add(value);
    }
  }

  return Uint8List.fromList(data);
}
