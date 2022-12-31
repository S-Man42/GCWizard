import 'package:gc_wizard/tools/coords/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/external_libs/net/logic/makaney.dart' as lib;
import 'package:latlong2/latlong.dart';

LatLng makaneyToLatLon(Makaney makaney) {
  if (makaney == null || makaney.text == null || makaney.text.isEmpty) return null;

  var _text = makaney.text.toLowerCase().replaceAll(RegExp(r'[^\-\+abo2zptscjkwmgnxqfd984ery3h5l76ui]'), '');

  var regexCheck = RegExp(r'\-?[a-z0-9]+(\+|\-)[a-z0-9]+');
  if (!regexCheck.hasMatch(_text)) {
    return null;
  }

  var latLon = lib.makaneyToLatLon(_text);
  if (latLon.contains(null)) return null;

  try {
    return LatLng(latLon[0], latLon[1]);
  } catch (e) {
    return null;
  }
}

Makaney latLonToMakaney(LatLng latLon) {
  if (latLon == null) return null;

  return Makaney(lib.latLonToMakaney(latLon.latitude, latLon.longitude).toUpperCase());
}

Makaney parseMakaney(String input) {
  var makaney = Makaney(input);
  return makaneyToLatLon(makaney) == null ? null : makaney;
}
