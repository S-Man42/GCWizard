import 'package:flutter/material.dart';

abstract class GCWWebStatefulWidget extends StatefulWidget {
  Map<String, String> webParameter = {};
  bool webParameterInitActive = true;

  GCWWebStatefulWidget({Key? key, required this.webParameter}): super(key: key);

  set webQueryParameter(Map<String, String> parameter) {
    webParameter = parameter;
  }

  bool hasWebParameter() {
    return webParameter.isEmpty;
  }

  String? getWebParameter(WEBPARAMETER parameter) {
    return webParameter[parameter.name];
  }

  bool sendJsonResultToWeb() {
    return getWebParameter(WEBPARAMETER.result) == 'json';
  }

  void sendResultToWeb(String json) {
    print(json);
    //sendWebResult(json);
  }
}

enum WEBPARAMETER {
  input,
  modeencode,
  parameter1,
  parameter2,
  fromformat,
  toformat,
  result
}

