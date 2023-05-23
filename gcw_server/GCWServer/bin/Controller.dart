import 'dart:convert';

import 'APIMapper.dart';
import 'ReverseAPIMapper.dart';
import 'RotatorAPIMapper.dart';
import 'gcw_server.dart';

String? request(WebParameter parameter) {
  APIMapper? apiMapper;
  switch  (parameter.title) {
    case 'rotate': apiMapper = RotatorAPIMapper(); break;
    case 'reverse': apiMapper = ReverseAPIMapper(); break;
  }

  if (apiMapper == null) return null;
  apiMapper.setParams(parameter.arguments);

  return jsonEncode(apiMapper.calculate());
}