import 'package:flutter/material.dart';
import 'package:gc_wizard/utils/string_utils.dart';

enum WEBPARAMETER {
  input,
  mode,
  parameter1,
  parameter2,
  fromformat,
  toformat,
  result
}

enum MODE {
  encode,
  decode
}

abstract class GCWWebStatefulWidget extends StatefulWidget {
  Map<String, String>? webParameter;
  final String? apiSpecification;

  GCWWebStatefulWidget({Key? key, this.webParameter, required this.apiSpecification}): super(key: key);

  set webQueryParameter(Map<String, String> parameter) {
    webParameter = parameter;
  }

  bool hasWebParameter() {
    return webParameter != null && webParameter!.isNotEmpty;
  }

  String? getWebParameter(WEBPARAMETER parameter) {
    return webParameter?[enumName(parameter.toString())];
  }
}


