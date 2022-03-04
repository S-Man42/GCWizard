import 'package:tuple/tuple.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';

class Equatorial {
  bool neg;
  int days;
  int hours;
  int min;
  int sec;
  int msec;

  Equatorial(bool neg, int days , int hours , int min, int sec, int msec ) {
    this.neg = neg;
    this.days = days;
    this.hours = hours;
    this.min = min;
    this.sec = sec;
    this.msec = msec;
  }

  static Equatorial parse (String input) {
    var regex = new RegExp(r"([+|-]?)([\d]*)([d|D]*)(\s*)([+|-]?)([\d]*):([0-5]?[0-9]):([0-5]?[0-9])(\.\d*)*");

    var matches = regex.allMatches(input);

    if (matches.length > 0) {
      for (var i = 0; i < matches.first.groupCount; i++) {
        print(matches.first.group(i));
      };
      return new Equatorial(
          (matches.first.group(1) == "-") | (matches.first.group(5) == "-"),
          int.parse(matches.first.group(2)),
          int.parse(matches.first.group(6)),
          int.parse(matches.first.group(7)),
          int.parse(matches.first.group(8)),
          int.parse(matches.first.group(9))
      );
    }
    else
      return null;
  }
}


Equatorial raDeg2Hms(double ra) {
  var prefix = 1;
  var deg = ra;

  if (deg < 0) {
    prefix = -1;
    deg = deg.abs();
  }
  var hour = (deg / 15.0).floor();
  var min = (((deg / 15.0) - hour) * 60).floor();
  var sec = ((((deg / 15.0) - hour) * 60) - min) * 60;
  var msec = ((sec - sec.truncate()).toInt() * 1000);

  return Equatorial(prefix < 0, 0, hour, min, sec.truncate(), msec);
}

Equatorial decDeg2Hms(double dec) {
  var prefix = 1;
  var deg = dec;

  if (deg < 0) {
    prefix = -1;
    deg = deg.abs();
  }
  var hour = deg.floor();
  var min = ((deg - hour) * 60).floor().abs();
  var sec = (((deg - hour).abs() * 60) - min) * 60;
  var msec = ((sec - sec.truncate()) * 1000).toInt();

  return Equatorial(prefix < 0, 0, prefix * hour, min, sec.truncate(), msec);
}

// module.exports.decHms2Deg = function(dec, round) {
//   var parts = dec.split(':')
//   var sign = 1
//   var d = parseFloat(parts[0])
//   var m = parseFloat(parts[1])
//   var s = parseFloat(parts[2])
//   if (d.toString()[0] === '-') {
//     sign = -1
//     d = Math.abs(d)
//   }
//   var sDeg = (s / 3600)
//   if (round) sDeg = Math.floor(sDeg)
//   var deg = d + (m / 60) + sDeg
//   return deg * sign
// }

double decHms2Deg(Equatorial equatorial) {
  var d = equatorial.hours + equatorial.days * 24;
  var m = equatorial.min;
  var s = equatorial.sec + equatorial.msec / 1000.0;

  var sDeg = (s / 3600.0);
  var deg = d + (m / 60.0) + sDeg;

  return equatorial.neg ? deg * -1 : deg;
}


DMSPart toLatLon(Equatorial equatorial) {
  var result = _calcModuloRest(equatorial.sec, 60);
  equatorial.min += result.item1;
  equatorial.sec = result.item2;

  result = _calcModuloRest(equatorial.min, 60);
  equatorial.hours += result.item1;
  equatorial.min = result.item2;

  equatorial.hours %= 24;

  var dmsGrad = (equatorial.hours * 360.0 / 24).toInt();
  var result1 = _calcTransfer(equatorial.min);
  dmsGrad += result1.item1;
  var dmsMin = result1.item2.toInt();
  result1 = _calcTransfer(equatorial.sec);
  dmsMin += result1.item1;
  var dmsSec = result1.item2;

  return DMSPart(1, dmsGrad, dmsMin, dmsSec);
}

Equatorial fromLatLon(int dmsGrad, int dmsMin, int dmsSec) {
  dmsGrad = dmsGrad.abs();
  dmsMin = dmsMin.abs();
  dmsSec = dmsSec.abs();

  var result = _calcModuloRest(dmsGrad, 15);
  dmsGrad = result.item1 * 15;
  dmsMin += result.item2 * 15;

  result = _calcModuloRest(dmsMin, 4);
  dmsGrad += result.item1 * 15;
  dmsMin = result.item2;

  result = _calcModuloRest(dmsSec, 4);
  dmsMin += result.item1 * 15;
  dmsSec = result.item2;

  var h = (dmsGrad % 360 / 15.0).ceil();
  var min = (dmsMin / 15.0).ceil();
  var sec = (dmsSec / 15.0).ceil();

  return Equatorial(false, 0, h, min, sec, 0);
}

Tuple2<int, double> _calcTransfer(int value) {
  var rest = value % 4;
  return new Tuple2<int, double>(((value - rest) / 4).toInt(), (rest * 15).toDouble());
}

Tuple2<int, int> _calcModuloRest(int value, int divider) {
  var transfer = (value - (value % divider)) / divider;
  return new Tuple2<int, int>(transfer.toInt(), value % divider);
}