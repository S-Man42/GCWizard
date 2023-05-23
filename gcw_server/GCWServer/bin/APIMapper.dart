enum WEBPARAMETER {
  input,
  modeencode,
  parameter1,
  parameter2,
  fromformat,
  toformat,
  result
}

abstract class APIMapper {
  Map<String, String> webParameter = {};

  void setParams(Map<String, String> parameter) {
    webParameter = parameter;
  }

  String doLogic() {
    return '';
  }

  Map<String, String> toMap(Object result);

  Map<String, String> calculate() {
    return toMap(doLogic());
  }

  String? getWebParameter(WEBPARAMETER parameter) {
    return webParameter[enumName(parameter.toString())];
  }
}

String enumName(String fullName) {
  return fullName.split('.').last;
}