import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';
import 'package:intl/intl.dart';

part 'gcwizard_script_codes.dart';
part 'gcwizard_script_functions_codes_base.dart';
part 'gcwizard_script_functions_codes_crypto.dart';
part 'gcwizard_script_functions_codes_hash.dart';
part 'gcwizard_script_functions_datetime.dart';
part 'gcwizard_script_functions_graphic.dart';
part 'gcwizard_script_functions_math.dart';
part 'gcwizard_script_functions_math_nested.dart';
part 'gcwizard_script_functions_string.dart';
part 'gcwizard_script_functions_waypoints.dart';
part 'gcwizard_script_loops.dart';

void main() {
  group("gcwizard_script.interpretScript:", () {
    List<Map<String, Object?>> _inputsToExpected = _inputsCodesToExpected;
    _inputsToExpected.addAll(_inputsMathToExpected);
    _inputsToExpected.addAll(_inputsBaseToExpected);
    _inputsToExpected.addAll(_inputsLoopsToExpected);
    _inputsToExpected.addAll(_inputsHashToExpected);
    _inputsToExpected.addAll(_inputsCryptoToExpected);
    _inputsToExpected.addAll(_inputsDateTimeToExpected);
    _inputsToExpected.addAll(_inputsStringToExpected);
    _inputsToExpected.addAll(_inputsGraphicToExpected);
    _inputsToExpected.addAll(_inputsWaypoinsToExpected);
    _inputsToExpected.addAll(_inputsMathNestedFunctionsToExpected);


    for (var elem in _inputsToExpected) {
      test('code: ${elem['code']}, input: ${elem['input']}', () async {
        var _actual = await interpretScript(elem['code'] as String, (elem['input'] as String?) ?? '', defaultBaseCoordinate.toLatLng()!, null);

        expect(_actual.STDOUT, (elem['expectedOutput'] as String));
        expect(_actual.ErrorMessage, elem['error'] ?? '');
      });
    }
  });
}