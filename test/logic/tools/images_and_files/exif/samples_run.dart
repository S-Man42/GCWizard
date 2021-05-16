import 'dart:io';
import 'dart:typed_data';

import 'package:exif/exif.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gc_wizard/logic/tools/images_and_files/exif_reader.dart';
import 'package:latlong/latlong.dart';

runSamplesTest(FileSystemEntity file) async {
  Uint8List content = _getFileData(file.path);

  var tags = await readExifFromBytes(content);
  expect(tags.length, isNonZero);
}

runSamplesTestGps(
  FileSystemEntity file,
  double expectedLatitude,
  double expectedLongitude,
) async {
  //Uint8List content = _getFileData(file.path);

  PlatformFile platformFile = PlatformFile(path: file.path);
  // Uint8List content = await getFileData(platformFile);
  // var tags = await readExifFromBytes(content);

  var tags = await parseExif(platformFile);
  expect(tags.length, isNonZero);
  expect(tags, contains("GPS GPSLatitude"));
  var lat = tags["GPS GPSLatitude"];
  print(lat);

  LatLng _point = completeGPSData(tags);
  expect(_point, isNotNull);
  expect(_point.latitude, equals(expectedLatitude));
  expect(_point.longitude, equals(expectedLongitude));
}

Uint8List _getFileData(String path) {
  File file = File(path);
  return file.readAsBytesSync();
}
