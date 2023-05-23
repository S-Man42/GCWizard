import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
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
  int binaryCoordLength = (geohashLength / 2).floor() * _binaryLength;

  String latBinaryOut = _generateBinaryFromCoord(coords.latitude, -90.0, 90.0, binaryCoordLength);
  String lonBinaryOut = _generateBinaryFromCoord(coords.longitude, -180.0, 180.0, binaryCoordLength);

  var binary = '';
  int i = 0;
  while (i < latBinaryOut.length) {
    binary += lonBinaryOut[i] + latBinaryOut[i];
    i++;
  }

  return Geohashing(_splitIntoBinaryChunks(binary).map((chunk) => _getCharacterByBinary(chunk)).where((element) => element != null).join());
}

LatLng? geohashingToLatLon(Geohashing geohashing) {
  try {
    var _geohash = geohash.text.toLowerCase();
    var binary = _geohash.split('').map((character) => _getBinaryByCharacter(character)).where((element) => element != null).join();

    var latBinary = '';
    var lonBinary = '';

    var i = 0;
    while (i < binary.length) {
      lonBinary += binary[i];
      if ((i + 1) < binary.length) latBinary += binary[i + 1];
      i += 2;
    }

    var lat = _getCoordFromBinary(latBinary, -90.0, 90.0);
    var lon = _getCoordFromBinary(lonBinary, -180.0, 180.0);

    if (lat == 0.0 && lon == 0.0) return null;

    return LatLng(lat, lon);
  } catch (e) {}

  return null;
}

Geohash? parseGeohash(String input) {
  input = input.trim();
  if (input == '') return null;

  var _geohash = Geohash(input);
  return geohashToLatLon(_geohash) == null ? null : _geohash;
}

double _getCoordFromBinary(String binary, double lowerBound, double upperBound) {
  var coord = 0.0;

  binary.split('').forEach((bit) {
    var middle = (lowerBound + upperBound) / 2.0;

    if (bit == '1') {
      lowerBound = middle;
    } else {
      upperBound = middle;
    }

    coord = (lowerBound + upperBound) / 2.0;
  });

  return coord;
}
