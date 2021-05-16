import 'dart:io';
import 'dart:typed_data';

import 'package:exif/exif.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gc_wizard/logic/tools/images_and_files/exif_reader.dart';
import 'package:latlong/latlong.dart';

runSamplesTest(FileSystemEntity file) async {
  Uint8List content = _getFileData(file.path);

  var tags = await readExifFromBytes(content);
  expect(tags.length, isNonZero);
}

runSamplesTestGps(FileSystemEntity file) async {
  Uint8List content = _getFileData(file.path);

  var tags = await readExifFromBytes(content);
  expect(tags.length, isNonZero);
  expect(tags, contains("GPS GPSLatitude"));
  var lat = tags["GPS GPSLatitude"];
  print(lat);

  LatLng _point = completeGPSData(tags);
  expect(_point, isNotNull);
  expect(_point.latitude, equals(37.885));
  expect(_point.longitude, equals(-122.6225));
}

Uint8List _getFileData(String path) {
  File file = File(path);
  return file.readAsBytesSync();
}
