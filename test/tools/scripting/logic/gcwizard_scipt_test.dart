import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

part 'gcwizard_script_functions_math.dart';

void main() {
  group("gcwizard_script.interpretScript:", () {
    List<Map<String, Object?>> _inputsToExpected = _inputsMathToExpected;

    for (var elem in _inputsToExpected) {
      test('code: ${elem['code']}, input: ${elem['input']}', () async {
        var _actual = await interpretScript(elem['code'] as String, (elem['input'] as String?) ?? '');

        expect(_actual.STDOUT, (elem['expectedOutput'] as String));
        expect(_actual.ErrorMessage, elem['error'] ?? '');
      });
    }
  });
}