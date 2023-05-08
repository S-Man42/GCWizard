import 'dart:convert';

import 'APIMapper.dart';
import 'RotatorAPIMapper.dart';
import 'gcw_server.dart';

String? request(WebParameter parameter) {
  APIMapper? myAPIMapper;
  switch  (parameter.title) {
    case 'rotate': myAPIMapper = RotatorAPIMapper();
  }

  if (myAPIMapper == null) return null;
  myAPIMapper.setParams(parameter.arguments);

 // x = myAPIMapper.Logic()
 //  myAPIMapper.safety(x);


  return jsonEncode(myAPIMapper.calculate());
}