import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:isolate';

import 'package:latlong2/latlong.dart';

import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_constants.dart';

class LatLngFromW3WJobData {
  final String words;
  final String APIKey;

  LatLngFromW3WJobData(this.words, this.APIKey);
}

class W3WFromLatLngJobData {
  final LatLng coordinates;
  final CoordinateFormatKey language;
  final String APIKey;

  W3WFromLatLngJobData(this.coordinates, this.language, this.APIKey);
}

class W3WResults {
  final int statusCode;
  final String error;
  final String country;
  final String nearestPlace;
  final LatLng square_sw;
  final LatLng square_ne;
  final LatLng center;

  W3WResults(
      {required this.statusCode,
      required this.error,
      required this.country,
      required this.nearestPlace,
      required this.square_sw,
      required this.square_ne,
      required this.center});
}

class CoordinateResults {
  final int statusCode;
  final String error;
  final String coordinatesW3W;

  CoordinateResults({required this.statusCode, required this.error, required this.coordinatesW3W});
}

const _URL_w3wToCoordinate = 'https://api.what3words.com/v3/convert-to-coordinates';
const _URL_coordinates2w2w = 'https://api.what3words.com/v3/convert-to-3wa';


String _convertLanguageFromFormatKey(CoordinateFormatKey formatKey) {
  switch (formatKey) {
    case CoordinateFormatKey.WHAT3WORDS_DE:
      return 'de';
    case CoordinateFormatKey.WHAT3WORDS_EN:
      return 'en';
    case CoordinateFormatKey.WHAT3WORDS_FR:
      return 'fr';
    case CoordinateFormatKey.WHAT3WORDS_ZH:
      return 'zh';
    case CoordinateFormatKey.WHAT3WORDS_DK:
      return 'da';
    case CoordinateFormatKey.WHAT3WORDS_NL:
      return 'nl';
    case CoordinateFormatKey.WHAT3WORDS_IT:
      return 'it';
    case CoordinateFormatKey.WHAT3WORDS_JA:
      return 'ja';
    case CoordinateFormatKey.WHAT3WORDS_KO:
      return 'ko';
    case CoordinateFormatKey.WHAT3WORDS_PL:
      return 'pl';
    case CoordinateFormatKey.WHAT3WORDS_RU:
      return 'ru';
    case CoordinateFormatKey.WHAT3WORDS_SP:
      return 'sp';
    case CoordinateFormatKey.WHAT3WORDS_CZ:
      return 'cs';
    default:
      return 'en';
  }
}

W3WResults _errorHandlingW3WResults(http.Response response){
  String error = '';
  switch (response.statusCode) {
    case 400: break;
    case 401: break;
    case 404: break;
    case 405: break;
    default:
  }
  return W3WResults(
    statusCode: response.statusCode,
    error: error,
    country: '',
    nearestPlace: '',
    square_sw: const LatLng(0.0, 0.0),
    square_ne: const LatLng(0.0, 0.0),
    center: const LatLng(0.0, 0.0),
  );
}

Future<W3WResults> convertLatLonFromW3Wasync(GCWAsyncExecuterParameters? jobData) async {
  if (jobData?.parameters is! LatLngFromW3WJobData) {
    return Future.value(W3WResults(
      statusCode: 0,
      error: '',
      country: '',
      nearestPlace: '',
      square_sw: LatLng(0.0, 0.0),
      square_ne: LatLng(0.0, 0.0),
      center: LatLng(0.0, 0.0),
    ));
  }

  var buildLatLonjob = jobData!.parameters as LatLngFromW3WJobData;
  var output =
      await _getLatLonFromW3W(buildLatLonjob.words, buildLatLonjob.APIKey, sendAsyncPort: jobData.sendAsyncPort!);

  jobData.sendAsyncPort?.send(output);

  return output;
}

CoordinateResults _errorHandlingCoordinatesResults(http.Response response){
  String error = '';
  switch (response.statusCode) {
    case 400: break;
    case 401: break;
    case 404: break;
    case 405: break;
    default:
  }
  return CoordinateResults(
    statusCode: response.statusCode,
    error: error,
    coordinatesW3W: '',
  );
}

Future<W3WResults> _getLatLonFromW3W(String words, String APIKey, {required SendPort sendAsyncPort}) async {
  String address = _URL_w3wToCoordinate + '?words=' + words + '&key=' + APIKey + '&format=json';
  var uri = Uri.parse(address);
  http.Response response = await http.get(uri);

  try {
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = json.decode(data);
      double sw_lat = double.parse(decodedData['square']['southwest']['lat'].toString());
      double sw_lon = double.parse(decodedData['square']['southwest']['lng'].toString());
      double ne_lat = double.parse(decodedData['square']['northeast']['lat'].toString());
      double ne_lon = double.parse(decodedData['square']['northeast']['lng'].toString());
      double ct_lat = double.parse(decodedData['coordinates']['lat'].toString());
      double ct_lon = double.parse(decodedData['coordinates']['lng'].toString());
      return W3WResults(
        statusCode: 200,
        error: '',
        country: decodedData['country'].toString(),
        nearestPlace: decodedData['nearestPlace'].toString(),
        square_sw: LatLng(sw_lat, sw_lon),
        square_ne: LatLng(ne_lat, ne_lon),
        center: LatLng(ct_lat, ct_lon),
      );
    } else {
      return _errorHandlingW3WResults(response);
    }
  } catch (e) {
    W3WResults(
      statusCode: 0,
      error: '',
      country: '',
      nearestPlace: '',
      square_sw: const LatLng(0.0, 0.0),
      square_ne: const LatLng(0.0, 0.0),
      center: const LatLng(0.0, 0.0),
    );
  }
  return W3WResults(
    statusCode: 0,
    error: '',
    country: '',
    nearestPlace: '',
    square_sw: const LatLng(0.0, 0.0),
    square_ne: const LatLng(0.0, 0.0),
    center: const LatLng(0.0, 0.0),
  );
}

Future<CoordinateResults> convertW3WFromLatLngAsync(GCWAsyncExecuterParameters? jobData) async {
  if (jobData?.parameters is! W3WFromLatLngJobData) {
    return Future.value(CoordinateResults(
      statusCode: 0,
      error: '',
      coordinatesW3W: '',
    ));
  }

  var buildW3Wjob = jobData!.parameters as W3WFromLatLngJobData;
  var output = await _getW3WFromLatLng(buildW3Wjob.coordinates, buildW3Wjob.APIKey, buildW3Wjob.language,
      sendAsyncPort: jobData.sendAsyncPort!);

  jobData.sendAsyncPort?.send(output);

  return output;
}

Future<CoordinateResults> _getW3WFromLatLng(LatLng coordinates, String APIKey, CoordinateFormatKey language,
    {required SendPort sendAsyncPort}) async {

  String address = _URL_coordinates2w2w +
      '?key=' + APIKey +
      '&coordinates=' + coordinates.latitude.toString() + ',' + coordinates.longitude.toString() +
      '&language=' + _convertLanguageFromFormatKey(language) +
      '&format=json';
  var uri = Uri.parse(address);
  http.Response response = await http.get(uri);
  print(response.statusCode);
  print(response.body);
  try {
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = json.decode(data);
      print(decodedData);
      return CoordinateResults(
        statusCode: 0,
        error: '',
        coordinatesW3W: decodedData['words'].toString(),
      );
    } else {
      return _errorHandlingCoordinatesResults(response);
    }
  } catch (e) {
    CoordinateResults(
      statusCode: 0,
      error: '',
      coordinatesW3W: '',
    );
  }
  return CoordinateResults(
    statusCode: 0,
    error: '',
    coordinatesW3W: '',
  );
}
