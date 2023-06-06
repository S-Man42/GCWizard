import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

part 'gcwizard_script_codes.dart';
part 'gcwizard_script_functions_codes_base.dart';
part 'gcwizard_script_functions_math.dart';
part 'gcwizard_script_loops.dart';

void main() {
  group("gcwizard_script.interpretScript:", () {
    // List<Map<String, Object?>> _inputsToExpected = _inputsMathToExpected;
    //List<Map<String, Object?>> _inputsToExpected = _inputsCodesToExpected;
    //List<Map<String, Object?>> _inputsToExpected = _inputsBaseToExpected;
    List<Map<String, Object?>> _inputsToExpected = _inputsLoopsToExpected;

    for (var elem in _inputsToExpected) {
      test('code: ${elem['code']}, input: ${elem['input']}', () async {
        var _actual = await interpretScript(elem['code'] as String, (elem['input'] as String?) ?? '');

        expect(_actual.STDOUT, (elem['expectedOutput'] as String));
        expect(_actual.ErrorMessage, elem['error'] ?? '');
      });
    }
  });
}