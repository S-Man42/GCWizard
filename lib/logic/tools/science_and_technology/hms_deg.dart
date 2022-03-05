import 'package:tuple/tuple.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';

/// equatorial coordinate system
class Equatorial {
  int sign;
  int hours;
  int minutes;
  int seconds;
  double mSeconds;

  Equatorial(int neg, int hours , int min, int sec, double msec ) {
    this.sign = neg;
    this.hours = hours.abs();
    this.minutes = min.abs();
    this.seconds = sec.abs();
    this.mSeconds = msec.abs();
  }

  static Equatorial parse (String input) {
    var regex = new RegExp(r"([+|-]?)([\d]*):([0-5]?[0-9]):([0-5]?[0-9])(\.\d*)*");
    if (input == null) return null;

    var matches = regex.allMatches(input);

    if (matches.length > 0) {
      return new Equatorial(
          (matches.first.group(1) == "-") ? -1 : 1,
          int.parse(matches.first.group(2)),
          int.parse(matches.first.group(3)),
          int.parse(matches.first.group(4)),
          matches.first.group(5).isEmpty ? 0 : double.parse('0' + matches.first.group(5))
      );
    }
    else
      return null;
  }

  @override
  String toString() {
    return (sign < 0 ? '-' : '') +
      hours.toString() + ":" +
      minutes.toString() + ":" +
      (seconds + mSeconds).toString();
  }
}

/// Right ascension to equatorial coordinate system
Equatorial raDeg2Hms(double ra) {
  if (ra == null) return null;
  var deg = ra.abs();

  var hour = (deg / 15.0).floor();
  var min = (((deg / 15.0) - hour) * 60).floor();
  var sec = ((((deg / 15.0) - hour) * 60) - min) * 60;
  var msec = sec - sec.truncate();

  return Equatorial(_sign(ra), hour, min, sec.truncate(), msec);
}

/// declination degrees to equatorial coordinate system
Equatorial decDeg2Hms(double dec) {
  if (dec == null) return null;

  var deg = dec.abs();

  var hour = deg.floor();
  var min = ((deg - hour) * 60).floor().abs();
  var sec = (((deg - hour).abs() * 60) - min) * 60;
  var msec = sec - sec.truncate();

  return Equatorial(_sign(dec), hour, min, sec.truncate(), msec);
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

/// declination hms to degrees
double decHms2Deg(Equatorial equatorial) {
  if (equatorial == null) return null;

  var d = equatorial.hours;
  var m = equatorial.minutes;
  var s = equatorial.seconds + equatorial.mSeconds;

  var sDeg = (s / 3600.0);
  var deg = d + (m / 60.0) + sDeg;

  return equatorial.sign * deg;
}

/// right ascension hms to degrees
double raHms2Deg(Equatorial equatorial) {
  if (equatorial == null) return null;

  var h = equatorial.hours;
  var m = equatorial.minutes;
  var s = equatorial.seconds + equatorial.mSeconds;

  var sDeg = (s / 240.0);
  var deg = (h * 15.0) + (m / 4.0) + sDeg;

  return equatorial.sign * deg;
}


DMSPart toLatLon(Equatorial equatorial) {
  if (equatorial == null) return null;

  var result = _calcModuloRest(equatorial.seconds, 60);
  equatorial.minutes += result.item1;
  equatorial.seconds = result.item2;

  result = _calcModuloRest(equatorial.minutes, 60);
  equatorial.hours += result.item1;
  equatorial.minutes = result.item2;

  equatorial.hours %= 24;

  var dmsGrad = (equatorial.hours * 360.0 / 24).toInt();
  var result1 = _calcTransfer(equatorial.minutes);
  dmsGrad += result1.item1;
  var dmsMin = result1.item2.toInt();
  result1 = _calcTransfer(equatorial.seconds);
  dmsMin += result1.item1;
  var dmsSec = result1.item2;

  return DMSPart(equatorial.sign, dmsGrad, dmsMin, dmsSec);
}

Equatorial fromLatLon(int dmsGrad, int dmsMin, int dmsSec) {
  var sign = _sign(dmsGrad);
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

  return Equatorial(sign, h, min, sec, 0);
}

Tuple2<int, double> _calcTransfer(int value) {
  var rest = value % 4;
  return new Tuple2<int, double>(((value - rest) / 4).toInt(), (rest * 15).toDouble());
}

Tuple2<int, int> _calcModuloRest(int value, int divider) {
  var transfer = (value - (value % divider)) / divider;
  return new Tuple2<int, int>(transfer.toInt(), value % divider);
}

int _sign(num) {
  return num < 0 ? -1 : 1;
}