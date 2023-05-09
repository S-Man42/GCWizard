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
  Map<String, String> params = {};

  void setParams(Map<String, String> parameter) {
    params = parameter;
  }

  String doLogic() {
    return '';
  }

  Map<String, String> toMap(Object result);

  Map<String, String> calculate() {
    return toMap(doLogic());
  }
}