import 'dart:convert';

import 'APIMapper.dart';
import 'AlphabetValuesAPIMapper.dart';
import 'MorseAPIMapper.dart';
import 'ReverseAPIMapper.dart';
import 'RotatorAPIMapper.dart';
import 'gcw_server.dart';

String? request(WebParameter parameter) {
  APIMapper? apiMapper;
  switch  (parameter.title.toLowerCase()) {
    case 'alphabetvalues': apiMapper = AlphabetValuesAPIMapper(); break;
    case 'rotate': apiMapper = RotatorAPIMapper(); break;
    case 'reverse': apiMapper = ReverseAPIMapper(); break;
    case 'morse': apiMapper = MorseAPIMapper(); break;
  }

  if (apiMapper == null) return null;
  apiMapper.setParams(parameter.arguments);

  return jsonEncode(apiMapper.calculate());
}