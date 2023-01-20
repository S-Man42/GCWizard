abstract class APIMapper {
  Map<String, String> params;

  void setParams(Map<String, String> param) {
    this.params = param;
  }

  Function doLogic();

  Map<String, String> toMap(dynamic stuff);

  Map<String, String> calculate() {
    return toMap(() => doLogic());
  }
}