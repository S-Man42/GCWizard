import 'dart:typed_data';
import 'dart:io' as io;
import 'package:path/path.dart' as path;

import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze.dart';
import 'wherigo_analyze_test_resources_task.dart';
import 'wherigo_analyze_test_resources_timer.dart';
import 'wherigo_analyze_test_resources_zone.dart';
import 'wherigo_analyze_test_resources_input.dart';
import 'wherigo_analyze_test_resources_media.dart';
import 'wherigo_analyze_test_resources_character.dart';
import 'wherigo_analyze_test_resources_messages.dart';
import 'wherigo_analyze_test_resources_item.dart';
import 'wherigo_analyze_test_resources_variable.dart';
import 'wherigo_analyze_test_resources_lua_source.dart';

String testDirPath = 'test/tools/wherigo/wherigo_analyze/resources/';

Uint8List _getFileData(String name) {
  io.File file = io.File(path.join(testDirPath, name));
  return file.readAsBytesSync();
}

void main() {

  group("Wherigo_analyze.TASK:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {
        'input': testInputTASK,
        'expectedOutput': testOutputTASK,
      }
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}}', () {
        var _actual = wherigoTest(elem['input'], WHERIGO_OBJECT.TASKS);
        expectTask(_actual.cartridgeTestTask, elem['expectedOutput'] as WherigoTaskData, );
      });
    }
  });

  group("Wherigo_analyze.TIMER:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {
        'input': testInputTIMER,
        'expectedOutput': testOutputTIMER,
      }
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}}', () {
        var _actual = wherigoTest(elem['input'], WHERIGO_OBJECT.TIMERS);
        expectTimer(_actual.cartridgeTestTimer, elem['expectedOutput'] as WherigoTimerData, );
      });
    }
  });

  group("Wherigo_analyze.ZONE:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {
        'input': testInputZONE,
        'expectedOutput': testOutputZONE,
      }
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}}', () {
        var _actual = wherigoTest(elem['input'], WHERIGO_OBJECT.ZONES);
        expectZone(_actual.cartridgeTestZone, elem['expectedOutput'] as WherigoZoneData, );
      });
    }
  });

  group("Wherigo_analyze.MEDIA:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {
        'input': testInputMEDIA,
        'expectedOutput': testOutputMEDIA,
      }
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}}', () {
        var _actual = wherigoTest(elem['input'], WHERIGO_OBJECT.MEDIAFILES);
        expectMedia(_actual.cartridgeTestMedia, elem['expectedOutput'] as WherigoMediaData, );
      });
    }
  });

  group("Wherigo_analyze.ITEM:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {
        'input': testInputITEM,
        'expectedOutput': testOutputITEM,
      }
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}}', () {
        var _actual = wherigoTest(elem['input'], WHERIGO_OBJECT.ITEMS);
        expectItem(_actual.cartridgeTestItem, elem['expectedOutput'] as WherigoItemData, );
      });
    }
  });

  group("Wherigo_analyze.CHARACTER:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {
        'input': testInputCHARACTER,
        'expectedOutput': testOutputCHARACTER,
      }
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}}', () {
        var _actual = wherigoTest(elem['input'], WHERIGO_OBJECT.CHARACTER);
        expectCharacter(_actual.cartridgeTestCharacter, elem['expectedOutput'] as WherigoCharacterData, );
      });
    }
  });

  group("Wherigo_analyze.INPUT:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {
        'input': testInputINPUT,
        'expectedOutput': testOutputINPUT,
      }
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}}', () {
        var _actual = wherigoTest(elem['input'], WHERIGO_OBJECT.INPUTS);
        expectInput(_actual.cartridgeTestInput, elem['expectedOutput'] as WherigoInputData);
      });
    }
  });

  group("Wherigo_analyze.VARIABLES:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {
        'input': testInputVARIABLE_BUILDERVAR,
        'expectedOutput': testOutputVARIABLE_BUILDERVAR,
      },
      {
        'input': testInputVARIABLE,
        'expectedOutput': testOutputVARIABLE,
      }
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}}', () {
        var _actual = wherigoTest(elem['input'], WHERIGO_OBJECT.VARIABLES);
        expectVariable(_actual.cartridgeTestVariable, elem['expectedOutput'] as List<WherigoVariableData>);
      });
    }
  });





  group("Wherigo_analyze.OBFUSCATION:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {
        'input': testInputLUASOURCE,
        'expectedOutput': ''
      },
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}}', () {
        var _actual = wherigoTest(elem['input'], WHERIGO_OBJECT.OBFUSCATORTABLE);

      });
    }
  });

  group("Wherigo_analyze.GWC:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input': 'test.gwc', 'expectedOutput': ''},
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}}', () {
        var _actual = wherigoTest(_getFileData(elem['input'] as String), WHERIGO_OBJECT.OBFUSCATORTABLE);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });


  group("Wherigo_analyze.MESSAGES:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {
        'input': testInputMESSAGE,
        'expectedOutput': testOutputMESSAGE,
      }
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}}', () {
        var _actual = wherigoTest(elem['input'], WHERIGO_OBJECT.MESSAGES);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

}
