import 'dart:convert';
import 'dart:math';

import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/hashes/logic/hashes.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

const _VALID_CHARS = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
const _domain = 'http://geo.crox.net/djia';

Geohashing latLonToGeohashing(LatLng coords, int geohashLength) {
  return Geohashing(DateTime.now(), LatLng(0, 0));
}

LatLng? geohashingToLatLon(Geohashing geohashing) {
  var date = DateFormat('yyyy-dd-MM').format(geohashing.date);
  var md5 = md5Digest(date);
  var lat = _hexToDec(md5.substring(0, 15));
  var lng = _hexToDec(md5.substring(16));

  return LatLng(geohashing.location.latitude.truncateToDouble() +  lat,
                geohashing.location.longitude.truncateToDouble() +  lng);
}

Geohashing? parseGeohashing(String input) {
  var regExp = RegExp(r'(\d{4})-(\d{2})-(\d{2})');
  if (regExp.hasMatch(input)) {
    var match = regExp.firstMatch(input);
    var decString = input.substring(0, match!.start);
    var dec = DEC.parse(decString, wholeString: false); // test before date
    if (dec == null) {
      decString = input.substring(match.end);
      dec = DEC.parse(decString, wholeString: false); // test after date
    }
    if (dec != null) {
      return Geohashing(DateTime (
            int.parse(match.group(1)!),
            int.parse(match.group(2)!),
            int.parse(match.group(3)!)),
            dec.toLatLng());
    }
  }
  return null;
}

Future<double?> dowJonesIndex(DateTime date) async {
  if (DateTime.now().difference(date).isNegative) return null;

  var uri = Uri.parse(_domain + '/' + DateFormat('yyyy-MM-dd').format(date));
  var encoding = Encoding.getByName('utf-8');

  http.Response response = await http.post(
    uri,
    encoding: encoding,
  );

  if (response.statusCode != 200) return null;

  return double.parse(response.body);
}

double _hexToDec(String input) {
  var memo = 0.0;
  var t = _toValidChars(input).split('').toList().mapIndexed((index, char) => memo += _charToValue(char, index));

  print(t);
  return memo;
}

String _toValidChars(String input) {
  return input = input.toUpperCase().replaceAll(RegExp('[^' + _VALID_CHARS +']'), '');
}

double _charToValue (String char, int index) {
  return _VALID_CHARS.indexOf(char) * pow(16, -(index + 1)).toDouble();
}
