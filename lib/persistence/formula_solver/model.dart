List<FormulaGroup> formulaGroups = [];

class FormulaGroup {
  int id;
  String name;
  List<Formula> formulas = [];

  FormulaGroup(
    this.name,
    {
      this.id
    }
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'formulas' : formulas.map((formula) => formula.toMap()).toList()
  };

  static FormulaGroup fromJSON(String jsonData) {

  }

  @override
  String toString() {
    return toMap().toString();
  }
}

FormulaGroup getFormulaGroupById(int id) {
  return formulaGroups.firstWhere((group) => group.id == id);
}

class Formula {
  int id;
  String formula;
  List<FormulaValue> values = [];

  Formula(
    this.formula,
    {
      this.id,
    }
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'formula': formula,
    'values' : values.map((value) => value.toMap()).toList(),
  };

  @override
  String toString() {
    return toMap().toString();
  }
}

class FormulaValue {
  int id;
  String key;
  String value;

  FormulaValue(
    this.key,
    this.value,
    {
      this.id,
    }
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'key': key,
    'value': value,
  };

  @override
  String toString() {
    return toMap().toString();
  }
}