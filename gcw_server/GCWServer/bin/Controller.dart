import 'dart:convert';

import 'APIMapper.dart';
import 'RotatorAPIMapper.dart';

String request(String toolName, Map<String, String> queryParams) {
  APIMapper myAPIMapper;
  switch  (toolName) {
    case 'rotate': myAPIMapper = new RotatorAPIMapper();
  }

  myAPIMapper.setParams(queryParams);

 // x = myAPIMapper.Logic()
 //  myAPIMapper.safety(x);


  return jsonEncode(myAPIMapper.calculate());
}