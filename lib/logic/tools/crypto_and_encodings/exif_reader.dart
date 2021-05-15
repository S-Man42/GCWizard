import 'package:exif/exif.dart';
import 'package:file_picker/file_picker.dart';
import 'package:gc_wizard/logic/tools/coords/converter/dec.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/widgets/common/gcw_imageview.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';
import 'package:latlong/latlong.dart';

Future<Map<String, IfdTag>> parseExif(PlatformFile file) async {
  Map<String, IfdTag> data = await readExifFromBytes(await getFileData(file),
      details: true,
      // debug: true, //XMP (experimental)
      //strict: false,
      truncate_tags: false);

  if (data == null || data.isEmpty) {
    print("No EXIF information found\n");
    return null;
  }
  return data;
}

GCWImageViewData completeThumbnail(Map<String, IfdTag> data) {
  if (data.containsKey('JPEGThumbnail')) {
    print('File has JPEG thumbnail');
    var _jpgBytes = data['JPEGThumbnail'].values;
    data.remove('JPEGThumbnail');
    return GCWImageViewData(_jpgBytes);
  } else if (data.containsKey('TIFFThumbnail')) {
    print('File has TIFF thumbnail');
    var _tiffBytes = data['TIFFThumbnail'].values;
    data.remove('TIFFThumbnail');
    return GCWImageViewData(_tiffBytes);
  }
  return null;
}

///
///  GPS Latitude         : 37.885000 deg (37.000000 deg, 53.100000 min, 0.000000 sec N)
//   GPS Longitude        : -122.622500 deg (122.000000 deg, 37.350000 min, 0.000000 sec W)
///
LatLng completeGPSData(Map<String, IfdTag> data) {
  try {
    if (data.containsKey('GPS GPSLatitude') &&
        data.containsKey('GPS GPSLongitude') &&
        data.containsKey('GPS GPSLatitudeRef') &&
        data.containsKey('GPS GPSLongitudeRef')) {
      IfdTag latRef = data['GPS GPSLatitudeRef'];
      IfdTag lat = data['GPS GPSLatitude'];
      double _lat = _getCoordDecFromIfdTag(lat, latRef.printable, true);
      if (_lat.isNaN) return null;

      IfdTag lngRef = data['GPS GPSLongitudeRef'];
      IfdTag lng = data['GPS GPSLongitude'];
      double _lng = _getCoordDecFromIfdTag(lng, lngRef.printable, false);
      if (_lng.isNaN) return null;

      // DEC should be the pivot format from EXIF
      LatLng _point = decToLatLon(DEC(_lat, _lng));

      print("_point = ${_point}");
      return _point;
    }
  } catch (error) {
    print("silent error: ${error}");
  }

  return null;
}

double _getCoordDecFromIfdTag(IfdTag tag, String latlngRef, bool isLatitude) {
  return getCoordDecFromText(tag.values, latlngRef, isLatitude);
}

double getCoordDecFromText(List<dynamic> values, String latlngRef, bool isLatitude) {
  double _degrees = _getRatioValue(values[0]);
  double _minutes = _getRatioValue(values[1]);
  double _seconds = _getRatioValue(values[2]);
  int _sign = getCoordinateSignFromString(latlngRef, isLatitude);
  return _sign * (_degrees + _minutes / 60 + _seconds / 3600);
}

double _getRatioValue(Ratio _ratio) {
  return _ratio.numerator / _ratio.denominator;
}

Map<String, List<List<dynamic>>> buildTablesExif(Map<String, IfdTag> data) {
  var map = <String, List<List>>{};

  data.forEach((key, tag) {
    List<String> groupedKey = _parseKey(key);
    String section = groupedKey[0];
    String code = groupedKey[1];

    // groupBy section
    (map[section] ??= []).add([code, _formatExifValue(tag)]);
  });
  return map;
}

Map<T, List<S>> _groupBy<S, T>(Iterable<S> values, T Function(S) key) {
  var map = <T, List<S>>{};
  for (var element in values) {
    (map[key(element)] ??= []).add(element);
  }
  return map;
}

List<String> _parseKey(String key) {
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

String _formatExifValue(IfdTag tag) {
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
      //TODO: makerNote can be display as ascii text
      //return _ascii2string(tag.values);
      return tag.printable;
    default:
      return tag.printable;
  }
}

_ascii2string(List<dynamic> values) {
  return values.map((e) => String.fromCharCode(e)).join();
}
