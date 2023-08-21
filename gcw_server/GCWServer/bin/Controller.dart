import 'dart:convert';

import 'APIMapper.dart';
import 'AlphabetValuesAPIMapper.dart';
import 'CoordsAPIMapper.dart';
import 'MorseAPIMapper.dart';
import 'ReverseAPIMapper.dart';
import 'RotatorAPIMapper.dart';
import 'gcw_server.dart';

String? request(WebParameter parameter) {
  APIMapper? apiMapper;
  switch  (parameter.title.toLowerCase()) {
    case 'alphabetvalues': apiMapper = AlphabetValuesAPIMapper(); break;
    case 'coords_formatconverter': apiMapper = CoordsFormatconverterAPIMapper(); break;
    case 'morse': apiMapper = MorseAPIMapper(); break;
    case 'reverse': apiMapper = ReverseAPIMapper(); break;
    case 'rotate': apiMapper = RotatorAPIMapper(); break;


  }

  if (apiMapper == null) return null;
  apiMapper.setParams(parameter.arguments);

  return jsonEncode(apiMapper.calculate());
}