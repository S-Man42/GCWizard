
import 'package:gc_wizard/logic/tools/coords/converter/djvanderlaan/rijksdriehoek/rijksdriehoek_js.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:latlong2/latlong.dart';

DutchGrid latLonToDutchGrid(LatLng coord) {
  var dutchGrid = rijksdriehoek(coord.longitude, coord.latitude);
  return DutchGrid(dutchGrid[0], dutchGrid[1]);
}

LatLng dutchGridToLatLon(DutchGrid dutchGrid) {
  var latLon = rijksdriehoekInverse(dutchGrid.x, dutchGrid.y);
  print(latLon);
  return LatLng(latLon[1], latLon[0]);
}

DutchGrid parseDutchGrid(String input) {
  RegExp regExp = RegExp(r'^\s*([\-0-9\.]+)(\s*\,\s*|\s+)([\-0-9\.]+)\s*$');
  var matches = regExp.allMatches(input);
  var _xString = '';
  var _yString = '';

  if (matches.length > 0) {
    var match = matches.elementAt(0);
    _xString = match.group(1);
    _yString = match.group(3);
  }
  if (matches.length == 0) {
    regExp = RegExp(r'^\s*(X|x)\:?\s*([\-0-9\.]+)(\s*\,?\s*)(Y|y)\:?\s*([\-0-9\.]+)\s*$');
    matches = regExp.allMatches(input);
    if (matches.length > 0) {
      var match = matches.elementAt(0);
      _xString = match.group(2);
      _yString = match.group(5);
    }
  }

  if (matches.length == 0) return null;

  var x = double.tryParse(_xString);
  if (x == null) return null;

  var y = double.tryParse(_yString);
  if (y == null) return null;

  return DutchGrid(x, y);
}