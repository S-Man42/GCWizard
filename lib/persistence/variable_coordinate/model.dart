import 'package:gc_wizard/persistence/formula_solver/model.dart';
import 'package:gc_wizard/utils/common_utils.dart';

List<Formula> formulas = [];

class ProjectionFormula {
  String distance;
  String distanceUnit;
  String bearing;
  bool reverse;

  ProjectionFormula(this.distance, this.distanceUnit, this.bearing, this.reverse);

  Map<String, dynamic> toMap() => {
        'distance': distance,
        'distanceUnit': distanceUnit,
        'bearing': bearing,
        'reverse': reverse,
      };

  ProjectionFormula.fromJson(Map<String, dynamic> json)
      : distance = jsonString(json['distance']),
        distanceUnit = jsonString(json['distanceUnit']),
        bearing = jsonString(json['bearing']),
        reverse = jsonBool(json['reverse']);

  @override
  String toString() {
    return toMap().toString();
  }
}

class Formula {
  int id;
  String name;
  String formula;
  ProjectionFormula projection;
  List<FormulaValue> values = [];

  Formula(this.name);

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'formula': formula,
        'projection': projection == null ? {} : projection.toMap(),
        'values': values.map((value) => value.toMap()).toList(),
      };

  Formula.fromJson(Map<String, dynamic> json)
      : id = jsonInt(json['id']),
        name = jsonString(json['name']),
        formula = jsonString(json['formula']),
        projection = ProjectionFormula.fromJson(json['projection']),
        values = List<FormulaValue>.from(json['values'].map((value) => FormulaValue.fromJson(value)));

  @override
  String toString() {
    return toMap().toString();
  }
}
