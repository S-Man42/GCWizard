import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/utils/complex_return_types.dart';

void main() {
  group("DateTimeTimezone.toLocalTime:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : DateTimeTimezone(dateTimeUtc: DateTime.utc(2024, 9, 30, 12), timezone: const Duration()), 'expectedOutput' : DateTime.utc(2024, 9, 30, 12)},
      {'input' : DateTimeTimezone(dateTimeUtc: DateTime.utc(2024, 9, 30, 12), timezone: const Duration(hours: 2)), 'expectedOutput' : DateTime.utc(2024, 9, 30, 14)},
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var _actual = (elem['input'] as DateTimeTimezone).toLocalTime();
        expect(_actual, elem['expectedOutput']);
      });
    }
  });

  group("DateTimeTimezone.fromLocalTime:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : DateTime.utc(2024, 9, 30, 12), 'timezone': const Duration(), 'expectedOutput' : DateTimeTimezone(dateTimeUtc: DateTime.utc(2024, 9, 30, 12), timezone: const Duration())},
      {'input' : DateTime.utc(2024, 9, 30, 14), 'timezone': const Duration(hours: 2), 'expectedOutput' : DateTimeTimezone(dateTimeUtc: DateTime.utc(2024, 9, 30, 12), timezone: const Duration(hours: 2))},
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']} timezone: ${elem['timezone']}', () {
        var _actual = DateTimeTimezone.fromLocalTime(elem['input'] as DateTime, elem['timezone'] as Duration);
        expect(_actual.dateTimeUtc, (elem['expectedOutput'] as DateTimeTimezone).dateTimeUtc);
        expect(_actual.timezone, (elem['expectedOutput'] as DateTimeTimezone).timezone);
      });
    }
  });
}