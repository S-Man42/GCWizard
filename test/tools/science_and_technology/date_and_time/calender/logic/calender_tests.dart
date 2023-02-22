import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/science_and_technology/date_and_time/calendar/logic/calendar.dart';

void main() {

  group("DateTimeUtils.JulianDateToModifiedJulianDateTo:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'jd' : 0.0, 'round':  true, 'expectedOutput' : -2400000.5},
      {'jd' : 2400000.5, 'round':  true, 'expectedOutput' : 0.0},
    ];

    _inputsToExpected.forEach((elem) {
      test('jd: ${elem['jd']}', () {
        var _actual = JulianDateToModifedJulianDate(elem['jd']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("DateTimeUtils.ModifedJulianDateToJulianDate:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'jd' : 0.0, 'round':  true, 'expectedOutput' : 2400000.5},
      {'jd' : -2400000.5, 'round':  true, 'expectedOutput' : 0.0},
    ];

    _inputsToExpected.forEach((elem) {
      test('jd: ${elem['jd']}', () {
        var _actual = ModifedJulianDateToJulianDate(elem['jd']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("DayCalculator.www.aoi.uzh.ch.JulianDateToPersianYazdegardCal:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'jd' : 2459363.0, 'expectedOutput' : DateTime(1390, 11, 16)},
    ];

    _inputsToExpected.forEach((elem) {
      test('jd: ${elem['jd']}', () {
        var _actual = JulianDateToPersianYazdegardCalendar(elem['jd']);
        expect(_actual.day, elem['expectedOutput'].day);
        expect(_actual.month, elem['expectedOutput'].month);
        expect(_actual.year, elem['expectedOutput'].year);
      });
    });
  });

  group("DayCalculator.www.aoi.uzh.ch.JulianDateToHebrewCal:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'jd' : 2459363.0, 'expectedOutput' : DateTime(5781, 9, 17)},
    ];

    _inputsToExpected.forEach((elem) {
      test('jd: ${elem['jd']}', () {
        var _actual = JulianDateToHebrewCalendar(elem['jd']);
        expect(_actual.day, elem['expectedOutput'].day);
        expect(_actual.month, elem['expectedOutput'].month);
        expect(_actual.year, elem['expectedOutput'].year);
      });
    });
  });

  group("DayCalculator.www.aoi.uzh.ch.JulianDateToIslamicCal:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'jd' : 2459363.0, 'expectedOutput' : DateTime(1442, 10, 16)},
    ];

    _inputsToExpected.forEach((elem) {
      test('jd: ${elem['jd']}', () {
        var _actual = JulianDateToIslamicCalendar(elem['jd']);
        expect(_actual.day, elem['expectedOutput'].day);
        expect(_actual.month, elem['expectedOutput'].month);
        expect(_actual.year, elem['expectedOutput'].year);
      });
    });
  });

  group("DateTimeUtils.www.aoi.uzh.ch.JulianDateToCopticCal:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'jd' : 2459363.0, 'expectedOutput' : DateTime(1737, 9, 20)},
    ];

    _inputsToExpected.forEach((elem) {
      test('jd: ${elem['jd']}', () {
        var _actual = JulianDateToCopticCalendar(elem['jd']);
        expect(_actual.day, elem['expectedOutput'].day);
        expect(_actual.month, elem['expectedOutput'].month);
        expect(_actual.year, elem['expectedOutput'].year);
      });
    });
  });

}
