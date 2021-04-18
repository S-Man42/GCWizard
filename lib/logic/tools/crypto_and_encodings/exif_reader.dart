import 'package:exif/exif.dart';
import 'package:file_picker/file_picker.dart';
import 'package:gc_wizard/logic/tools/coords/converter/dms.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/exif_reader.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';
import 'package:latlong/latlong.dart';

Future<Map<String, IfdTag>> parseExif(PlatformFile file) async {
  Map<String, IfdTag> data = await readExifFromBytes(await getFileData(file),
      details: true,
      debug: true, //XMP (experimental)
      //strict: false,
      truncate_tags: false);

  if (data == null || data.isEmpty) {
    print("No EXIF information found\n");
    return null;
  }
  return data;
}

Thumbnail completeThumbnail(Map<String, IfdTag> data) {
  if (data.containsKey('JPEGThumbnail')) {
    print('File has JPEG thumbnail');
    var _jpgBytes = data['JPEGThumbnail'].values;
    data.remove('JPEGThumbnail');
    return Thumbnail(_jpgBytes);
  } else if (data.containsKey('TIFFThumbnail')) {
    print('File has TIFF thumbnail');
    var _tiffBytes = data['TIFFThumbnail'].values;
    data.remove('TIFFThumbnail');
    return Thumbnail(_tiffBytes);
  }
  return null;
}

LatLng completeGPSData(Map<String, IfdTag> data) {
  if (data.containsKey('GPS GPSLatitude') && data.containsKey('GPS GPSLongitude')) {
    print('File has GPS data');

    IfdTag latRef = data['GPS GPSLatitudeRef'];
    IfdTag lat = data['GPS GPSLatitude'];
    DMSLatitude _lat = getCoordLat(lat, latRef.printable);

    IfdTag lngRef = data['GPS GPSLongitudeRef'];
    IfdTag lng = data['GPS GPSLongitude'];
    DMSLongitude _lng = getCoordLng(lng, lngRef.printable);

    // GPS Latitude         : 37.885000 deg (37.000000 deg, 53.100000 min, 0.000000 sec N)
    // GPS Longitude        : -122.622500 deg (122.000000 deg, 37.350000 min, 0.000000 sec W)

    // coord = N37.531 W122.3735
    LatLng _point = dmsToLatLon(DMS(_lat, _lng));
    print("_point = ${_point}");
    return _point;
  }

  return null;
}

DMSLatitude getCoordLat(IfdTag lat, String latRef) {
  double latDegrees = getRatioValue(lat.values[0]);
  double latMinutes = getRatioValue(lat.values[1]);
  double latSeconds = getRatioValue(lat.values[2]);
  int latSign = getSignFromString(latRef, true);
  return DMSLatitude(latSign, latDegrees, latMinutes, latSeconds);
}

DMSLongitude getCoordLng(IfdTag lng, String lngRef) {
  double lngDegrees = getRatioValue(lng.values[0]);
  double lngMinutes = getRatioValue(lng.values[1]);
  double lngSeconds = getRatioValue(lng.values[2]);
  int lngSign = getSignFromString(lngRef, false);
  return DMSLongitude(lngSign, lngDegrees, lngMinutes, lngSeconds);
}

double getRatioValue(Ratio _ratio) {
  return _ratio.numerator / _ratio.denominator;
}

Map<String, List<List<dynamic>>> buildTablesExif(Map<String, IfdTag> data) {
  var map = <String, List<List>>{};

  data.forEach((key, tag) {
    List<String> groupedKey = parseKey(key);
    String section = groupedKey[0];
    String code = groupedKey[1];

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

List<String> parseKey(String key) {
  String group;
  String code;
  List<String> words = key.split(" ");
  if (words.length >= 2) {
    group = words[0];
    code = words.sublist(1).join(" ");
  } else {
    group = "general";
    code = key;
  }
  return [group, code];
}

String formatExifValue(IfdTag tag) {
  switch (tag.tagType) {
    case 'ASCII':
      return tag.printable;
    case ' Short':
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
