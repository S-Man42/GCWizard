import 'package:gc_wizard/application/settings/logic/preferences.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/length.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/unit.dart';
import 'package:gc_wizard/utils/data_type_utils/object_type_utils.dart';
import 'package:gc_wizard/tools/formula_solver/persistence/model.dart';
import 'package:gc_wizard/utils/json_utils.dart';
import 'package:prefs/prefs.dart';

List<Formula> formulas = [];

class ProjectionData {
  String distance;
  Length distanceUnit;
  String bearing;
  bool reverse;

  ProjectionData(this.distance, this.distanceUnit, this.bearing, this.reverse);

  Map<String, Object?> toMap() => {
        'distance': distance,
        'distanceUnit': distanceUnit.name,
        'bearing': bearing,
        'reverse': reverse,
      };

  ProjectionData.fromJson(Map<String, Object?> json)
      : distance = toStringOrNull(json['distance']) ?? '',
        distanceUnit = getUnitByName<Length>(
          allLengths(),
          toStringOrNull(json['distanceUnit'])
            ?? getUnitBySymbol<Length>(allLengths(), Prefs.getString(PREFERENCE_DEFAULT_LENGTH_UNIT)).name
        ),
        bearing = toStringOrNull(json['bearing']) ?? '',
        reverse = toBoolOrNull(json['reverse']) ?? false;

  @override
  String toString() {
    return toMap().toString();
  }
}

class Formula {
  int? id;
  late String name;
  String formula = '';
  ProjectionData? projection;
  List<FormulaValue> values = [];

  Formula(this.name);

  Map<String, Object?> toMap() => {
        'id': id,
        'name': name,
        'formula': formula,
        'projection': projection == null ? {} : projection!.toMap(),
        'values': values.map((value) => value.toMap()).toList(),
      };

  Formula.fromJson(Map<String, Object?> json) {
    name = toStringOrNull(json['name']) ?? ''; // TODO Proper default types if key is not in map
    id = toIntOrNull(json['id']);
    formula = toStringOrNull(json['formula']) ?? '';
    projection = ProjectionData.fromJson(asJsonMapOrNull(json['projection']) ?? <String, Object?>{});

    var valuesRaw = toObjectWithNullableContentListOrNull(json['values']);
    this.values = <FormulaValue>[];
    if (valuesRaw != null) {
      valuesRaw.forEach((Object? element) {
        var value = asJsonMapOrNull(element);
        if (value == null) return;

        this.values.add(FormulaValue.fromJson(value));
      });
    }
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
