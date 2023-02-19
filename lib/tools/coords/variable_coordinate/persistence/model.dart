import 'package:gc_wizard/utils/data_type_utils/object_type_utils.dart';
import 'package:gc_wizard/tools/formula_solver/persistence/model.dart';

List<Formula> formulas = [];

class ProjectionFormula {
  String distance;
  String distanceUnit;
  String bearing;
  bool reverse;

  ProjectionFormula(this.distance, this.distanceUnit, this.bearing, this.reverse);

  Map<String, Object> toMap() => {
        'distance': distance,
        'distanceUnit': distanceUnit,
        'bearing': bearing,
        'reverse': reverse,
      };

  ProjectionFormula.fromJson(Map<String, Object?> json)
      : distance = toStringOrNull(json['distance']),
        distanceUnit = toStringOrNull(json['distanceUnit']),
        bearing = toStringOrNull(json['bearing']),
        reverse = toBoolOrNull(json['reverse']);

  @override
  String toString() {
    return toMap().toString();
  }
}

class Formula {
  int? id;
  String name;
  String? formula;
  ProjectionFormula? projection;
  List<FormulaValue> values = [];

  Formula(this.name);

  Map<String, Object> toMap() => {
        'id': id,
        'name': name,
        'formula': formula,
        'projection': projection == null ? {} : projection!.toMap(),
        'values': values.map((value) => value.toMap()).toList(),
      };

  Formula.fromJson(Map<String, Object?> json) {
    var _name = toStringOrNull(json['name']);
    if (_name == null)

    id = toIntOrNull(json['id']),
    formula = toStringOrNull(json['formula']),
    projection = ProjectionFormula.fromJson(json['projection']),
    values = List<FormulaValue>.from(json['values'].map((value) => FormulaValue.fromJson(value)));

  }

  @override
  String toString() {
    return toMap().toString();
  }
}
