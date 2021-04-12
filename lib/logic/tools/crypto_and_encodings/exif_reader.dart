import 'dart:io';

import 'package:exif/exif.dart';

Future<List<List>> parseExif(String path) async {
  Map<String, IfdTag> data = await readExifFromBytes(await new File(path).readAsBytes());

  if (data == null || data.isEmpty) {
    print("No EXIF information found\n");
    return null;
  }

  if (data.containsKey('JPEGThumbnail')) {
    print('File has JPEG thumbnail');
    data.remove('JPEGThumbnail');
  }
  if (data.containsKey('TIFFThumbnail')) {
    print('File has TIFF thumbnail');
    data.remove('TIFFThumbnail');
  }

  return buildTableExif(data);
}

List<List<dynamic>> buildTableExif(Map<String, IfdTag> data) {
  return data.entries.map((entry) {
    IfdTag tag = entry.value;
    return [entry.key, tag.printable];
  }).toList();
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
