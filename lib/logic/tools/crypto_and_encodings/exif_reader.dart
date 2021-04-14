import 'dart:io';

import 'package:exif/exif.dart';

Future<Map<String, List<List<dynamic>>>> parseExif(String path) async {
  Map<String, IfdTag> data = await readExifFromBytes(
      await new File(path).readAsBytes(),
      details: true,
  );

  if (data == null || data.isEmpty) {
    print("No EXIF information found\n");
    return null;
  }

  // if (data.containsKey('JPEGThumbnail')) {
  //   print('File has JPEG thumbnail');
  //   data.remove('JPEGThumbnail');
  // }
  // if (data.containsKey('TIFFThumbnail')) {
  //   print('File has TIFF thumbnail');
  //   data.remove('TIFFThumbnail');
  // }

  if (data.containsKey('GPS GPSLatitude')) {
      print('File has TIFF thumbnail');
      var lat = data['GPS GPSLatitude'];
      var latv = lat.values;
      var latp = lat.printable;
      print("Latitude ${lat.printable}");
    }
  return buildTablesExif(data);
}

Map<String,List<List<dynamic>>> buildTablesExif(Map<String, IfdTag> data) {
  var map = <String, List<List>>{};

  data.forEach((key, tag) {
    List<String> groupedKey = parseKey(key);
    String section=groupedKey[0];
    String code=groupedKey[1];

    // groupBy section
    (map[section] ??= []).add([code, tag.printable]);
  });
  return map;
}

Map<T, List<S>> groupBy<S, T>(Iterable<S> values, T Function(S) key) {
  var map = <T, List<S>>{};
  for (var element in values) {
    (map[key(element)] ??= []).add(element);
  }
  return map;
}

List<String> parseKey(String key){
  String group;
  String code;
  List<String> words = key.split(" ");
  if (words.length>=2){
     group = words[0];
     code = words.sublist(1).join(" ");
  }else{
    group = "general";
    code = key;
  }
  return [group, code];
}

String formatExifValue(IfdTag tag){
  switch(tag.tagType){
    case 'ASCII':
      return tag.printable;
    case' Short':
      return tag.printable;
    case 'Long':
      return tag.printable;
    case 'Byte':
      return tag.printable;
    case 'Ratio':
      return tag.values.toString();
    case 'Signed Ratio':
      return tag.values.toString();
    case 'Undefined':
      return tag.printable;
    default:
      return tag.printable;
  }
}

int getExifRotation(Map<String, IfdTag> tags) {
  IfdTag orientation = tags["Image Orientation"];
  int orientationValue = orientation.values[0];
  int rotationCorrection = 0;
  // in degress
  print("orientation: ${orientation.printable}/${orientation.values[0]}");
  switch (orientationValue) {
    case 6:
      rotationCorrection = 90;
      break;
    case 3:
      rotationCorrection = 180;
      break;
    case 8:
      rotationCorrection = 270;
      break;
    default:
  }
  return rotationCorrection;
}
