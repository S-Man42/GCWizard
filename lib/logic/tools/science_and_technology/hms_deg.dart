import 'package:tuple/tuple.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';

DateTime raDeg2Hms(double ra) {
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

  return DateTime(0, 0, 0, prefix * hour, min, sec.truncate(), msec);
}

DateTime decDeg2Hms(double dec) {
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

  return DateTime(0, 0, 0, prefix * hour, min, sec.truncate(), msec);
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

double decHms2Deg(DateTime dec) {
  var sign = 1;
  var d = dec.hour + dec.day * 24;
  var m = dec.minute;
  var s = dec.second + dec.millisecond / 1000.0;
  if (d < 0) {
    sign = -1;
    d = d.abs();
  }
  var sDeg = (s / 3600.0);
  var deg = d + (m / 60.0) + sDeg;

  return deg * sign;
}


DMSPart toLatLon(int h, int min, int sec, int msec) {
  h = h.abs();
  min = min.abs();
  sec = sec.abs();

  var result = _calcModuloRest(sec, 60);
  min += result.item1;
  sec = result.item2;

  result = _calcModuloRest(min, 60);
  h += result.item1;
  min = result.item2;

  h = h % 24;

  var dmsGrad = (h * 360.0 / 24).toInt();
  var result1 = _calcTransfer(min);
  dmsGrad += result1.item1;
  var dmsMin = result1.item2.toInt();
  result1 = _calcTransfer(sec);
  dmsMin += result1.item1;
  var dmsSec = result1.item2;

  return DMSPart(1, dmsGrad, dmsMin, dmsSec);
}

DateTime fromLatLon(int dmsGrad, int dmsMin, int dmsSec) {
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

  return DateTime(0, 0, 0, h, min, sec);
}

Tuple2<int, double> _calcTransfer(int value) {
  var rest = value % 4;
  return new Tuple2<int, double>(((value - rest) / 4).toInt(), (rest * 15).toDouble());
}

Tuple2<int, int> _calcModuloRest(int value, int divider) {
  var transfer = (value - (value % divider)) / divider;
  return new Tuple2<int, int>(transfer.toInt(), value % divider);
}