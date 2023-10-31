import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_constants.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_metadata.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';

class CoordinateFormat {
  final CoordinateFormatKey type;
  CoordinateFormatKey? subtype;

  CoordinateFormat(this.type, [this.subtype]);

  static CoordinateFormat fromPersistenceKey(String persistenceKey) {
    var coordFormat = coordinateFormatDefinitionByPersistenceKey(persistenceKey);
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

abstract class AbstractCoordinateFormatDefinition {
  late final CoordinateFormatKey type;
  late final BaseCoordinate defaultCoordinate;
  late final String persistenceKey;
}

abstract class AbstractCoordinateFormatWithSubtypesDefinition extends AbstractCoordinateFormatDefinition {
  late final List<CoordinateFormatKey> subtypes;
}

bool equalsCoordinateFormats(CoordinateFormat a, CoordinateFormat b) {
  return a.type == b.type && a.subtype == b.subtype;
}

bool isCoordinateFormatWithSubtype(CoordinateFormatKey format) {
  var coordFormat = coordinateFormatMetadataByKey(format);
  return coordFormat.subtypes != null;
}

bool isSubtypeOfCoordinateFormat(CoordinateFormatKey baseFormat, CoordinateFormatKey typeToCheck) {
  var coordFormat = coordinateFormatMetadataByKey(baseFormat);
  if (coordFormat.subtypes == null) {
    return false;
  }

  return coordFormat.subtypes!.map((CoordinateFormatMetadata _format) => _format.type).contains(typeToCheck);
}
