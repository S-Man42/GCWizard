import 'dart:convert';

import 'package:gcw_server/APIMapper.dart';
import 'package:gcw_server/RotatorAPIMapper.dart';

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