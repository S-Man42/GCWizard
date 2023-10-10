
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/external_libs/mapcode/ctrynams_short.dart';
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

const int _DEFAULT_PRECISION = 2;

MapCode latLonToMapCode(LatLng coord, {int precision = _DEFAULT_PRECISION}) {
  return MapCode(encodeWithPrecision(coord.latitude, coord.longitude, precision, ''));
}

LatLng? MapCodeToLatLon(MapCode mapcode) {
  return decode(mapcode.coords.first.fullmapcode, '');
}

MapCode? parseMapCode(String input) {
  // https://github.com/sindresorhus/mapcode-regex/blob/main/index.js
  var rx = "(?:(11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65|71|91|92|";
  for (var element in iso3166alpha) {
    rx += element + "|";
  }
  var rx1 = "";
  for (var element in isofullname) {
    rx1 += element + "|";
  }
  rx1 = rx1.replaceAll( "(", '').replaceAll( ")", '');
  rx1 = rx1.substring(0, rx1.length-1);
  rx += rx1;
  rx += r") )?[ABCDEFGHJKLMNPQRSTUVWXYZabcdefghjklmnpqrstuvwxyz\d]{2,}\.[ABCDEFGHJKLMNPQRSTUVWXYZabcdefghjklmnpqrstuvwxyz\d]{2,}(-\d{1,8})?";

  var match = RegExp(rx).firstMatch(input);
  if (match == null) return null;

  var mapCode = input.substring(match.start, match.end);
  var latLon = decode(mapCode, '');
  if (latLon == null) {
    return null;
  } else {
    var coords = <McInfo>[];
    var mcInfo = McInfo();
    mcInfo.fullmapcode = mapCode;
    coords.add(mcInfo);

    return MapCode(coords);
  }
}

class McInfo {
  String mapcode = '';
  String territoryAlphaCode = '';
  String fullmapcode = '';
  int territoryNumber = 0;
}
