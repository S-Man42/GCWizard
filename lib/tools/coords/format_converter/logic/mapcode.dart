import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_constants.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/external_libs/mapcode/mapcode.dart';
import 'package:latlong2/latlong.dart';

class MapCode extends BaseCoordinate {
  List<McInfo> coords;

  MapCode(this.coords) {
    _format = CoordinateFormat(CoordinateFormatKey.MAPCODE);
  }

  @override
  LatLng? toLatLng() {
    return MapCodeToLatLon(this);
  }

  static MapCode fromLatLon(LatLng coord, [int precision = 2]) {
    return latLonToMapCode(coord);
  }

  static MapCode? parse(String input) {
    return parseMapCode(input);
  }

  @override
  String toString([int? precision]) {
    return coords.isEmpty ? '' : coords.first.fullmapcode;
  }
}

const int _DEFAULT_PRECISION = 0;
const defaultMapCodeType = CoordinateFormatKey.MAPCODE_LOCAL;

const Map<int, CoordinateFormatKey> MAPCODE_CODE = {
  0: CoordinateFormatKey.MAPCODE_LOCAL,
  1: CoordinateFormatKey.MAPCODE_INTERNATIONAL,
};

MapCode latLonToMapCode(LatLng coord, {required CoordinateFormatKey subtype, int precision = _DEFAULT_PRECISION}) {
  if (subtype == CoordinateFormatKey.MAPCODE_INTERNATIONAL) {
    return MapCode(encodeInternationalWithPrecision(coord.latitude, coord.longitude, precision), subtype);
  } else {
    return MapCode(encodeWithPrecision(coord.latitude, coord.longitude, precision, ''), subtype);
  }
}

LatLng? MapCodeToLatLon(MapCode mapcode) {
  if (mapcode.coords.isEmpty) return null;
  return decode(mapcode.coords.first.fullmapcode, '');
}

MapCode? parseMapCode(String input, {String territory = ''}) {
  var match = RegExp(_regexString()).firstMatch(input);
  if (match == null) return null;

  var mapCode = match.group(0).toString();
  if (territory.isNotEmpty) {
    if (match.group(1) != null) {
      mapCode = mapCode.replaceFirst(match.group(1)!, territory);
    } else {
      mapCode = territory + ' ' + mapCode;
    }
  }
  var latLon = decode(mapCode, territory);
  if (latLon == null) {
    return null;
  } else {
    var coords = <McInfo>[];
    var mcInfo = McInfo();
    mcInfo.fullmapcode = mapCode;
    coords.add(mcInfo);

    return MapCode(coords, defaultMapCodeType);
  }
}

String _regexString() {
  // https://github.com/sindresorhus/mapcode-regex/blob/main/index.js
  var rx = "(?:(11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65|71|91|92";
  for (var element in iso3166alpha) {
    rx += "|" + element;
  }
  const letter = r"[ABCDEFGHJKLMNPQRSTUVWXYZabcdefghjklmnpqrstuvwxyz\d]";
  // var rx1 = "";
  // for (var element in isofullname) {
  //   rx1 += element + "|";
  // }
  //rx1 = rx1.replaceAll( "(", '').replaceAll( ")", '');
  // rx1 = rx1.substring(0, rx1.length-1);
  // rx += rx1;
  //rx = rx.substring(0, rx.length-1);
  rx += r")\s*)?" + letter + r"{2,}\." + letter + r"{2,}(-\d{1,8})?";
  return rx;
}

class McInfo {
  String mapcode = '';
  String territoryAlphaCode = '';
  String fullmapcode = '';
  int territoryNumber = 0;
}
