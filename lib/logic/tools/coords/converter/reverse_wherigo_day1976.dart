import 'package:gc_wizard/logic/tools/coords/converter/dec.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:latlong2/latlong.dart';


String _letterForValue(int value){
  switch (value.toInt()) {
    case 0 : return "0";
    case 1 : return "1";
    case 2 : return "2";
    case 3 : return "3";
    case 4 : return "4";
    case 5 : return "5";
    case 6 : return "6";
    case 7 : return "7";
    case 8 : return "8";
    case 9 : return "9";
    case 10: return "a";
    case 11: return "b";
    case 12: return "c";
    case 13: return "d";
    case 14: return "e";
    case 15: return "f";
    case 16: return "g";
    case 17: return "h";
    case 18: return "i";
    case 19: return "j";
    case 20: return "k";
    case 21: return "l";
    case 22: return "m";
    case 23: return "n";
    case 24: return "o";
    case 25: return "p";
    case 26: return "q";
    case 27: return "r";
    case 28: return "s";
    case 29: return "t";
    case 30: return "u";
    case 31: return "v";
    case 32: return "w";
    case 33: return "x";
    case 34: return "y";
    case 35: return "z";
    default: return "";
  }
}

double _valueForLetter(String letter){
  switch (letter) {
    case "0": return 0;
    case "1": return 1;
    case "2": return 2;
    case "3": return 3;
    case "4": return 4;
    case "5": return 5;
    case "6": return 6;
    case "7": return 7;
    case "8": return 8;
    case "9": return 9;
    case "a": return 10;
    case "b": return 11;
    case "c": return 12;
    case "d": return 13;
    case "e": return 14;
    case "f": return 15;
    case "g": return 16;
    case "h": return 17;
    case "i": return 18;
    case "j": return 19;
    case "k": return 20;
    case "l": return 21;
    case "m": return 22;
    case "n": return 23;
    case "o": return 24;
    case "p": return 25;
    case "q": return 26;
    case "r": return 27;
    case "s": return 28;
    case "t": return 29;
    case "u": return 30;
    case "v": return 31;
    case "w": return 32;
    case "x": return 33;
    case "y": return 34;
    case "z": return 35;
    default: return 0;
  }
}

LatLng day1976ToLatLon(Day1976 day1976) {

  double _cTzKn = _valueForLetter(day1976.a[0]);
  double _dJuU = _valueForLetter(day1976.a[1]);
  double _IIW = _valueForLetter(day1976.a[2]);
  double _9Ve7 = _valueForLetter(day1976.a[3]);
  double _KsA = _valueForLetter(day1976.a[4]);

  double _QrbCA = _valueForLetter(day1976.b[0]);
  double _Avr3k = _valueForLetter(day1976.b[1]);
  double _QWQ = _valueForLetter(day1976.b[2]);
  double _ErSZ = _valueForLetter(day1976.b[3]);
  double _rai = _valueForLetter(day1976.b[4]);

  double lat = _IIW * 1679616 + _KsA * 46656 + _QrbCA * 1296 + _Avr3k * 36 + _rai;
  double lon = _cTzKn * 1679616 + _dJuU * 46656 + _9Ve7 * 1296 + _QWQ * 36 + _ErSZ;
  lat = lat / 100000;
  lon = lon / 100000;
  lat = lat - 90;
  lon = lon - 180;

  return decToLatLon(DEC(lat, lon));
}

Day1976 latLonToDay1976(LatLng coord) {
  var lat = coord.latitude + 90;
  var lon = coord.longitude + 180;

  lat = lat * 100000;
  lon = lon * 100000;
  var _IIW = (lat / 1679616).floor();
  lat = lat - _IIW * 1679616;
  var _KsA = (lat / 46656).floor();
  lat = lat - _KsA * 46656;
  var _QrbCA = (lat / 1296).floor();
  lat = lat - _QrbCA * 1296;
  var _Avr3k = (lat / 36).floor();
  var _rai = (lat - _Avr3k * 36).toInt();

  var _cTzKn = (lon / 1679616).floor();
  lon = lon - _cTzKn * 1679616;
  var _dJuU = (lon / 46656).floor();
  lon = lon - _dJuU * 46656;
  var _9Ve7 = (lon / 1296).floor();
  lon = lon - _9Ve7 * 1296;
  var _QWQ = (lon / 36).floor();
  var _ErSZ = (lon - _QWQ * 36).toInt();

  return Day1976(
      _letterForValue(_cTzKn) + _letterForValue(_dJuU) + _letterForValue(_IIW) + _letterForValue(_9Ve7) + _letterForValue(_KsA),
      _letterForValue(_QrbCA) + _letterForValue(_Avr3k) + _letterForValue(_QWQ) + _letterForValue(_ErSZ) + _letterForValue(_rai)
  );
}

Day1976 parseDay1976(String input) {
  RegExp regExp = RegExp(r'^\s*([0-9a-z]+)(\s*,\s*|\s+)([0-9a-z]+)\s*$');
  var matches = regExp.allMatches(input);
  if (matches.length == 0) return null;

  var match = matches.elementAt(0);

  var a = int.tryParse(match.group(1));
  var b = int.tryParse(match.group(3));

  if (a == null || b == null) return null;

  return Day1976(match.group(1), match.group(3));
}
