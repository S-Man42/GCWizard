import 'package:flutter/material.dart';
import 'package:gc_wizard/utils/string_utils.dart';

enum WEBPARAMETER {
  input,
  modeencode,
  parameter1,
  parameter2,
  fromformat,
  toformat,
  result
}

abstract class GCWWebStatefulWidget extends StatefulWidget {
  Map<String, String>? webParameter;
  bool webParameterInitActive = true;

  GCWWebStatefulWidget({Key? key, this.webParameter}): super(key: key);

  set webQueryParameter(Map<String, String> parameter) {
    webParameter = parameter;
  }

  bool hasWebParameter() {
    return webParameter == null || webParameter!.isEmpty;
  }

  String? getWebParameter(WEBPARAMETER parameter) {
    return webParameter?[enumName(parameter.toString())];
  }

  // bool sendJsonResultToWeb() {
  //   return getWebParameter(WebParameter.result) == 'json';
  // }
  //
  // void sendResultToWeb(String json) {
  //   print(json);
  //   //sendWebResult(json);
  // }
}


