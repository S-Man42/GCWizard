import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_constants.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_metadata.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';

class CoordinateFormat {
  final CoordinateFormatKey type;
  CoordinateFormatKey? subtype;

  CoordinateFormat(this.type, [this.subtype]);

  static CoordinateFormat fromPersistenceKey(String persistenceKey) {
    var coordFormat = coordinateFormatMetadataByPersistenceKey(persistenceKey);
    if (coordFormat == null) {
      return defaultCoordinateFormat;
    } else {
      return CoordinateFormat(coordFormat.type);
    }
  }

  @override
  String toString() {
    return 'type: $type; subtype: $subtype';
  }
}

class CoordinateFormatDefinition {
  final CoordinateFormatKey type;
  final BaseCoordinate defaultCoordinate;
  final String persistenceKey;

  CoordinateFormatDefinition(this.type, this.defaultCoordinate, this.persistenceKey);
}

class CoordinateFormatWithSubtypesDefinition extends CoordinateFormatDefinition {
  final List<CoordinateFormatDefinition> subtypes;

  CoordinateFormatWithSubtypesDefinition(super.type, super.defaultCoordinate,
      super.persistenceKey, this.subtypes);
}

bool equalsCoordinateFormats(CoordinateFormat a, CoordinateFormat b) {
  return a.type == b.type && a.subtype == b.subtype;
}

bool isCoordinateFormatWithSubtype(CoordinateFormatKey format) {
  var coordFormat = coordinateFormatDefinitionByKey(format);
  return coordFormat is CoordinateFormatWithSubtypesDefinition;
}

bool isSubtypeOfCoordinateFormat(CoordinateFormatKey baseFormat, CoordinateFormatKey typeToCheck) {
  var coordFormat = coordinateFormatDefinitionByKey(baseFormat);
  if (coordFormat is! CoordinateFormatWithSubtypesDefinition) {
    return false;
  }

  return coordFormat.subtypes.map((CoordinateFormatDefinition _format) => _format.type).contains(typeToCheck);
}
