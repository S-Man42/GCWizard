import 'dart:isolate';

import 'package:what3words/what3words.dart';
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

Future<LatLng> convertLatLonFromW3Wasync(GCWAsyncExecuterParameters? jobData) async {
  if (jobData?.parameters is! LatLngFromW3WJobData) {
    return Future.value(LatLng(0.0, 0.0));
  }

  var buildLatLonjob = jobData!.parameters as LatLngFromW3WJobData;
  var output = await _getLatLonFromW3W(buildLatLonjob.words, buildLatLonjob.APIKey, sendAsyncPort: jobData.sendAsyncPort!);

  jobData.sendAsyncPort?.send(output);

  return output;
}

Future<LatLng> _getLatLonFromW3W(String words, String APIKey, {required SendPort sendAsyncPort}) async {
  var api = What3WordsV3(APIKey);

  var coordinates = await api.convertToCoordinates(words).execute();

  return LatLng(coordinates.data()!.coordinates.lat, coordinates.data()!.coordinates.lng);
}

Future<String> convertW3WFromLatLngAsync(GCWAsyncExecuterParameters? jobData) async {
  if (jobData?.parameters is! W3WFromLatLngJobData) {
    return Future.value('');
  }

  var buildW3Wjob = jobData!.parameters as W3WFromLatLngJobData;
  var output = await _getW3WFromLatLng(buildW3Wjob.coordinates, buildW3Wjob.APIKey, buildW3Wjob.language, sendAsyncPort: jobData.sendAsyncPort!);

  jobData.sendAsyncPort?.send(output);

  return output;
}

Future<String> _getW3WFromLatLng(LatLng coordinates, String APIKey, CoordinateFormatKey language, {required SendPort sendAsyncPort}) async {
  var api = What3WordsV3(APIKey);

  var words = await api
      .convertTo3wa(Coordinates(51.508344, -0.12549900))
      .language(_convertLanguageFromFormatKey(language))
      .execute();

  return words.data()?.words as String;
}