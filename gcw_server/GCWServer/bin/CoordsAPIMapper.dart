import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_constants.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_metadata.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_parser.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';

import 'APIMapper.dart';

class CoordsFormatconverterAPIMapper extends APIMapper {

  @override
  String doLogic() {
    var input = getWebParameter(WEBPARAMETER.input);
    if (input == null) {
      return '';
    }
    var results = parseCoordinates(input);
    if (results.isEmpty) return '';

    results.first.toLatLng();
    var targetFormat = getWebParameter(WEBPARAMETER.toformat);
    var key = _getCoordinateFormatKey(targetFormat ?? '');
    var format = CoordinateFormat(key);

    return format.toString();
  }

  /// convert doLogic output to map
  @override
  Map<String, String> toMap(Object result) {
    return <String, String>{enumName(WEBPARAMETER.result.toString()) : result.toString()};
  }
}

CoordinateFormatKey _getCoordinateFormatKey(String key) {
  var formatKey = coordinateFormatMetadataByPersistenceKey(key)?.type;
  if (formatKey != null) return formatKey;

  return defaultCoordinateFormat.type;
}
