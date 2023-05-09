import 'package:flutter/material.dart';

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

  String? getWebParameter(WebParameter parameter) {
    return webParameter?[parameter.name];
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

enum WebParameter {
  input,
  modeencode,
  parameter1,
  parameter2,
  fromformat,
  toformat,
  result
}

