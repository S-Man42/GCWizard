import 'dart:typed_data';
import 'dart:math';

import 'package:exif/exif.dart';
import 'package:gc_wizard/logic/tools/coords/converter/dec.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/widgets/common/gcw_imageview.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart' as local;
import 'package:latlong2/latlong.dart';

Future<Map<String, IfdTag>> parseExif(local.PlatformFile file) async {
  Map<String, IfdTag> data;

  try {
    data = await readExifFromBytes(file.bytes,
        details: true,
        // debug: true, //XMP (experimental)
        //strict: false,
        truncateTags: false);
  } on Exception catch (e) {
    // silent error
  }

  if (data == null || data.isEmpty) {
    // print("No EXIF information found\n");
    return null;
  }
  return data;
}

GCWImageViewData completeThumbnail(Map<String, IfdTag> data) {
  if (data.containsKey('JPEGThumbnail')) {
    // print('File has JPEG thumbnail');
    var _jpgBytes = data['JPEGThumbnail'].values;
    data.remove('JPEGThumbnail');
    return GCWImageViewData(_jpgBytes.toList());
  } else if (data.containsKey('TIFFThumbnail')) {
    // print('File has TIFF thumbnail');
    var _tiffBytes = data['TIFFThumbnail'].values;
    data.remove('TIFFThumbnail');
    return GCWImageViewData(_tiffBytes.toList());
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
  return getCoordDecFromText(tag.values.toList(), latlngRef, isLatitude);
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
    case 'Short':
      return tag.printable;
    case 'Long':
      return tag.printable;
    case 'Byte':
      try {
        List<int> byteList = tag.values.toList();
        return String.fromCharCodes(byteList);
      } catch (e) {
        return tag.printable;
      }
      break;
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

Uint8List extraData(Uint8List data) {
  if (data == null) return null;
  int imageLength;

  switch (getFileType(data)) {
    case '.jpg':
      imageLength = jpgImageSize(data);
      break;
    case '.png':
      imageLength = pngImageSize(data);
      break;
    case '.gif':
      imageLength = gifImageSize(data);
      break;
    default:
      return null;
  }

  if ((imageLength != null) & (imageLength > 0) & (data.length > imageLength))
    return Uint8List.fromList(data.sublist(imageLength));

  return null;
}

int jpgImageSize(Uint8List data) {
  var sum = 0;
  if (data == null) return null;
  if (getFileType(data) != '.jpg') return null;

  for (int i = 0; i < data.length - 2; i++) {
    // Segment ?
    if ((data[i] == 0xFF) & (data[i + 1] == 0xD8)) {
      var offset = 0;
      sum += 2;
      do {
        offset = _jpgSegmentLength(data, sum);
        sum += offset;
      } while (offset > 0);

      sum += _jpgSosSegmentLength(data, sum);

      return sum;
    }
  }

  return sum;
}

int _jpgSegmentLength(Uint8List data, int offset) {
  // Data Segment and not SOS Segment
  if ((offset + 3 < data.length) & (data[offset] == 0xFF) & (data[offset + 1] != 0xDA))
    return 256 * data[offset + 2] + data[offset + 3] + 2;
  return 0;
}

int _jpgSosSegmentLength(Uint8List data, int offset) {
  //  SOS Segment ?
  if ((offset + 1 < data.length) & (data[offset] == 0xFF) & (data[offset + 1] == 0xDA))
  for (int i = offset + 2; i < data.length - 1; i++)
    // EOI-Segment ?
    if (data[i] == 0xFF && data[i + 1] == 0xD9)
      return i - offset + 2;

  return 0;
}

int pngImageSize(Uint8List data) {

  var startIndex = 0;
  var endIndex = 0;
  if (data == null) return null;
  if (getFileType(data) != '.png') return null;

  for (int i = 0; i < data.length - 3; i++)
  {
    // IDAT ??
    if ((data[i] == 0x49) & (data[i + 1] == 0x44) & (data[i + 2] == 0x41) & (data[i + 3] == 0x54)) {
      startIndex = i + 4;
      break;
    }
  }

  if (startIndex > 0) {
    for (int i = startIndex; i < data.length - 7; i++)
    {
      // IEND ??
      if ((data[i] == 0x49) & (data[i + 1] == 0x45) & (data[i + 2] == 0x4E) & (data[i + 3] == 0x44) &
      (data[i + 4] == 0xAE) & (data[i + 5] == 0x42) & (data[i + 6] == 0x60) & (data[i + 7] == 0x82)) {
        endIndex = i + 4 + 4;
        break;
      }
    }
  }

  return endIndex;
}

int gifImageSize(Uint8List data) {
  if (data == null) return null;
  if (getFileType(data) != '.gif') return null;

  var offset = "GIF89a".length; //GIF Signature
  offset += 7; //Screen Descriptor

  //Global Color Map
  offset = _gifColorMap(data, offset, -3);

  do {
    if (offset + 1 >= data.length) return data.length;

    // Application Extension, Comment Extension
    if ((data[offset] == 0x21) & ((data[offset + 1] == 0xFF) | (data[offset] == 0xFE)))
      offset = _gifExtensionBlock(data, offset);
    else
    {
      //Graphics Control Extension (option)
      offset = _gifExtensionBlock(data, offset);

      if (offset + 1 >= data.length) return data.length;

      if ((data[offset] == 0x21) & (data[offset + 1] == 0xFF))
        // Plain Text Extension
        offset = _gifExtensionBlock(data, offset);
      else {
        //Image Descriptor
        offset += 10;

        //Local Color Map
        offset = _gifColorMap(data, offset, -1);

        //Image Data
        offset += 1;
        while ((offset < data.length) & (data[offset] != 0))
        {
          offset += 1;
          offset += data[offset - 1];
        }

        offset += 1; //Terminator 0x00
      }
    }
  } while ((offset >= data.length) | (data[offset] != 0x3B));
  offset += 1; //0x3B

  return min(offset, data.length);
}

int _gifExtensionBlock(Uint8List data, int offset) {
  if (offset >= data.length) return data.length;
  if (data[offset] == 0x21) {
    offset += 3;
    offset += data[offset - 1];
    offset += 1; //Terminator 0x00
  }
  return offset;
}

int _gifColorMap(Uint8List data, int offset, int countOffset) {
  if (offset >= data.length) return data.length;
  if ((data[offset + countOffset] & 0x80) != 0) {
    var bitsPerPixel = (data[offset + countOffset] & 0x7) + 1;
    offset += (pow(2, bitsPerPixel) * 3).toInt();
  }

  return offset;
}
