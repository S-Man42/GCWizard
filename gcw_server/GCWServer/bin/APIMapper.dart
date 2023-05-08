abstract class APIMapper {
  Map<String, String> params = {};

  void setParams(Map<String, String> parameter) {
    params = parameter;
  }

  Function doLogic();

  Map<String, String> toMap(Object stuff);

  Map<String, String> calculate() {
    return toMap(() => doLogic());
  }
}