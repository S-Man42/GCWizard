import 'package:flutter/material.dart';

abstract class GCWWebStatefulWidget extends StatefulWidget {
  Map<String, String> webParameter;
  bool webParameterInitActive = true;

  GCWWebStatefulWidget({Key key, this.webParameter}): super(key: key);

  void set webQueryParameter(Map<String, String> parameter) {
    this.webParameter = parameter;
  }

  bool hasWebParameter() {
    return webParameter != null;
  }

  String getWebParameter(WebParameter parameter) {
    return webParameter[parameter.name];
  }

  bool sendJsonResultToWeb() {
    return getWebParameter(WebParameter.result) == 'json';
  }

  sendResultToWeb(String json) {
    return;
  }
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

