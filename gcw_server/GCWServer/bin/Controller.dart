import 'dart:convert';

import 'APIMapper.dart';
import 'AlphabetValuesAPIMapper.dart';
import 'CoordsAPIMapper.dart';
import 'MorseAPIMapper.dart';
import 'ReverseAPIMapper.dart';
import 'RomanNumbersAPIMapper.dart';
import 'RotatorAPIMapper.dart';
import 'gcw_server.dart';

final Set<APIMapper> _apiList = {
  AlphabetValuesAPIMapper(),
  CoordsFormatconverterAPIMapper(),
  MorseAPIMapper(),
  ReverseAPIMapper(),
  RomanNumbersAPIMapper(),
  RotatorAPIMapper(),
};

String? request(WebParameter parameter) {
  APIMapper? apiMapper;

  try {
    var title = parameter.title.toLowerCase();
    if (title != '?') {
      apiMapper = _apiList.firstWhere((entry) => title == entry.Key);
    } else {
      apiMapper = APIInfo();
    }
  } catch (e) {};

  if (apiMapper == null) return null;
  apiMapper.setParams(parameter.arguments);

  return jsonEncode(apiMapper.calculate());
}

class APIInfo extends APIMapper {
  @override
  String doLogic() {
    return _apiList.map((entry) => entry.apiSpecification()).join('\n\n');
  }

  /// convert doLogic output to map
  @override
  Map<String, String> toMap(Object result) {
    return <String, String>{enumName(WEBPARAMETER.result.toString()) : result.toString()};
  }
}

