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
        expect(_actual.cartridgeTestTask.TaskLUAName, testOutputTASK.TaskLUAName);
        expect(_actual.cartridgeTestTask.TaskID, testOutputTASK.TaskID);
        expect(_actual.cartridgeTestTask.TaskName, testOutputTASK.TaskName);
        expect(_actual.cartridgeTestTask.TaskDescription, testOutputTASK.TaskDescription);
        expect(_actual.cartridgeTestTask.TaskVisible, testOutputTASK.TaskVisible);
        expect(_actual.cartridgeTestTask.TaskMedia, testOutputTASK.TaskMedia);
        expect(_actual.cartridgeTestTask.TaskIcon, testOutputTASK.TaskIcon);
        expect(_actual.cartridgeTestTask.TaskActive, testOutputTASK.TaskActive);
        expect(_actual.cartridgeTestTask.TaskComplete, testOutputTASK.TaskComplete);
        expect(_actual.cartridgeTestTask.TaskCorrectstate, testOutputTASK.TaskCorrectstate);
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
        expect(_actual.cartridgeTestTimer.TimerLUAName, testOutputTIMER.TimerLUAName);
        expect(_actual.cartridgeTestTimer.TimerID, testOutputTIMER.TimerID);
        expect(_actual.cartridgeTestTimer.TimerName, testOutputTIMER.TimerName);
        expect(_actual.cartridgeTestTimer.TimerDescription, testOutputTIMER.TimerDescription);
        expect(_actual.cartridgeTestTimer.TimerVisible, testOutputTIMER.TimerVisible);
        expect(_actual.cartridgeTestTimer.TimerDuration, testOutputTIMER.TimerDuration);
        expect(_actual.cartridgeTestTimer.TimerType, testOutputTIMER.TimerType);
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
        expect(_actual, elem['expectedOutput']);
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
        expect(_actual, elem['expectedOutput']);
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
        expect(_actual, elem['expectedOutput']);
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
        expect(_actual.cartridgeTestItem.ItemLUAName, testOutputITEM.ItemLUAName);
        expect(_actual.cartridgeTestItem.ItemID, testOutputITEM.ItemID);
        expect(_actual.cartridgeTestItem.ItemName, testOutputITEM.ItemName);
        expect(_actual.cartridgeTestItem.ItemDescription, testOutputITEM.ItemDescription);
        expect(_actual.cartridgeTestItem.ItemVisible, testOutputITEM.ItemVisible);
        expect(_actual.cartridgeTestItem.ItemMedia, testOutputITEM.ItemMedia);
        expect(_actual.cartridgeTestItem.ItemIcon, testOutputITEM.ItemIcon);
        expect(_actual.cartridgeTestItem.ItemLocation, testOutputITEM.ItemLocation);
        expect(_actual.cartridgeTestItem.ItemZonepoint, testOutputITEM.ItemZonepoint);
        expect(_actual.cartridgeTestItem.ItemContainer, testOutputITEM.ItemContainer);
        expect(_actual.cartridgeTestItem.ItemLocked, testOutputITEM.ItemLocked);
        expect(_actual.cartridgeTestItem.ItemOpened, testOutputITEM.ItemOpened);
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
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group("Wherigo_analyze.VARIABLES:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {
        'input': testInputVARIABLE,
        'expectedOutput': testOutputVARIABLE,
      }
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}}', () {
        var _actual = wherigoTest(elem['input'], WHERIGO_OBJECT.VARIABLES);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });



}
