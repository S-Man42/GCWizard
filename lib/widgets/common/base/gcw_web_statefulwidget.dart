import 'package:flutter/material.dart';

abstract class GCWWebStatefulWidget extends StatefulWidget {
  Map<String, String> webParameter;

  GCWWebStatefulWidget({Key key}): super(key: key);

  void set webQueryParameter(Map<String, String> parameter) {
    this.webParameter = parameter;
  }

  bool hasWebParameter() {
    return webParameter != null;
  }

  String getWebParameter(WebParameter parameter) {
    return webParameter[parameter.toString()];
  }
}

enum WebParameter {
  input,
  parameter1,
  parameter2
}

