import 'dart:math';

import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/hashes/logic/hashes.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:collection/collection.dart';


String _generateBinaryFromCoord(double coord, double lowerBound, double upperBound, int length) {
  var binaryOut = '';

  while (binaryOut.length < length) {
    var middle = (lowerBound + upperBound) / 2.0;
    if (coord >= middle) {
      binaryOut += '1';
      lowerBound = middle;
    } else {
      binaryOut += '0';
      upperBound = middle;
    }
  }

  return binaryOut;
}

Geohash latLonToGeohashing(LatLng coords, int geohashLength) {
  String date =

  var binary = '';
  int i = 0;
  while (i < latBinaryOut.length) {
    binary += lonBinaryOut[i] + latBinaryOut[i];
    i++;
  }

  return Geohashing(_splitIntoBinaryChunks(binary).map((chunk) => _getCharacterByBinary(chunk)).where((element) => element != null).join());
}

LatLng? geohashingToLatLon(Geohashing geohashing) {
  var date = DateFormat('yyyy-dd-MM').format(geohashing.date);
  var md5 = md5Digest(date);
  md5.sp

  return null;
}

Geohash? parseGeohash(String input) {
  input = input.trim();
  if (input == '') return null;

  var _geohash = Geohash(input);
  return geohashToLatLon(_geohash) == null ? null : _geohash;
}

const _VALID_CHARS = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';

double _hexToDec(String input) {
  var memo = 0.0;
  _toValidChars(input).split('').toList().mapIndexed((index, char) => memo += _charToValue(char, index));

  return memo;
}

String _toValidChars(String input) {
  return input = input.toUpperCase().replaceAll(RegExp('[^' + _VALID_CHARS +']'), '');
}

double _charToValue (String char, int index) {
  return _VALID_CHARS.indexOf(char) * pow(16, -(index + 1)).toDouble();
}
