import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/common/date_utils.dart';

void main() {
  group("DayCalculator.JulianDateToGregorianCalendar:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'jd' : 0.0, 'round':  false, 'expectedOutput' : DateOutput('24.5', '11', '-4713')},
      {'jd' : 0.0, 'round':  true, 'expectedOutput' : DateOutput('25', '11', '-4713')},
    ];

    _inputsToExpected.forEach((elem) {
      test('jd: ${elem['jd']}, round: ${elem['round']}', () {
        var _actual = JulianDateToGregorianCalendar(elem['jd'], elem['round']);
        if (_actual == null)
          expect(_actual, elem['expectedOutput']);
        else {
          expect(_actual.day, elem['expectedOutput'].day);
          expect(_actual.month, elem['expectedOutput'].month);
          expect(_actual.year, elem['expectedOutput'].year);
        }
      });
    });
  });

  group("DayCalculator.JulianDateToJulianCalendar:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'jd' : 0.0, 'round':  true, 'expectedOutput' : DateOutput('1', '1', '-4712')},
    ];

    _inputsToExpected.forEach((elem) {
      test('jd: ${elem['jd']}, round: ${elem['round']}', () {
        var _actual = JulianDateToJulianCalendar(elem['jd'], elem['round']);
        if (_actual == null)
          expect(_actual, elem['expectedOutput']);
        else {
          expect(_actual.day, elem['expectedOutput'].day);
          expect(_actual.month, elem['expectedOutput'].month);
          expect(_actual.year, elem['expectedOutput'].year);
        }
      });
    });
  });


  group("DayCalculator.GregorianCalendarToJulianDate:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'date' : DateTime(-4713,11,24), 'expectedOutput' : -0.5},
    ];

    _inputsToExpected.forEach((elem) {
      test('date: ${elem['date']}', () {
        var _actual = GregorianCalendarToJulianDate(elem['date']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("DayCalculator.JulianCalendarToJulianDate:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'date' : DateTime(-4712,1,1), 'expectedOutput' : -0.5},
    ];

    _inputsToExpected.forEach((elem) {
      test('date: ${elem['date']}', () {
        var _actual = JulianCalendarToJulianDate(elem['date']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });


  group("DayCalculator.JulianDateToModifiedJulianDateTo:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
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

  group("DayCalculator.ModifedJulianDateToJulianDate:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
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

}