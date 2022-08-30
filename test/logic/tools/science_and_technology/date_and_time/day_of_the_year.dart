import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/science_and_technology/date_and_time/day_of_the_year.dart';

void main() {
  group("DayOfTheYear.decode:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'start' : null, 'end': null, 'countStart': true, 'countEnd': true, 'expectedOutput' : null},

      {'start' : DateTime(2020, 10, 16), 'end': DateTime(2020, 10, 16), 'countStart': true, 'countEnd': true, 'expectedOutput' : DayOfTheYearOutput(1, 24, 1440, 86400)},
      {'start' : DateTime(2020, 10, 16), 'end': DateTime(2020, 10, 16), 'countStart': false, 'countEnd': true, 'expectedOutput' : DayOfTheYearOutput(1, 24, 1440, 86400)},
      {'start' : DateTime(2020, 10, 16), 'end': DateTime(2020, 10, 16), 'countStart': true, 'countEnd': false, 'expectedOutput' : DayOfTheYearOutput(1, 24, 1440, 86400)},
      {'start' : DateTime(2020, 10, 16), 'end': DateTime(2020, 10, 16), 'countStart': false, 'countEnd': false, 'expectedOutput' : DayOfTheYearOutput(0, 0, 0, 0)},

      {'start' : DateTime(2020, 10, 16), 'end': DateTime(2020, 10, 17), 'countStart': true, 'countEnd': true, 'expectedOutput' : DayOfTheYearOutput(2, 48, 2880, 172800)},
      {'start' : DateTime(2020, 10, 16), 'end': DateTime(2020, 10, 17), 'countStart': false, 'countEnd': true, 'expectedOutput' : DayOfTheYearOutput(1, 24, 1440, 86400)},
      {'start' : DateTime(2020, 10, 16), 'end': DateTime(2020, 10, 17), 'countStart': true, 'countEnd': false, 'expectedOutput' : DayOfTheYearOutput(1, 24, 1440, 86400)},
      {'start' : DateTime(2020, 10, 16), 'end': DateTime(2020, 10, 17), 'countStart': false, 'countEnd': false, 'expectedOutput' : DayOfTheYearOutput(0, 0, 0, 0)},

      {'start' : DateTime(2020, 10, 17), 'end': DateTime(2020, 10, 16), 'countStart': true, 'countEnd': true, 'expectedOutput' : DayOfTheYearOutput(2, 48, 2880, 172800)},
      {'start' : DateTime(2020, 10, 17), 'end': DateTime(2020, 10, 16), 'countStart': false, 'countEnd': true, 'expectedOutput' : DayOfTheYearOutput(1, 24, 1440, 86400)},
      {'start' : DateTime(2020, 10, 17), 'end': DateTime(2020, 10, 16), 'countStart': true, 'countEnd': false, 'expectedOutput' : DayOfTheYearOutput(1, 24, 1440, 86400)},
      {'start' : DateTime(2020, 10, 17), 'end': DateTime(2020, 10, 16), 'countStart': false, 'countEnd': false, 'expectedOutput' : DayOfTheYearOutput(0, 0, 0, 0)},

      {'start' : DateTime(2020, 10, 16), 'end': DateTime(2020, 10, 18), 'countStart': true, 'countEnd': true, 'expectedOutput' : DayOfTheYearOutput(3, 72, 4320, 259200)},
      {'start' : DateTime(2020, 10, 16), 'end': DateTime(2020, 10, 18), 'countStart': false, 'countEnd': true, 'expectedOutput' : DayOfTheYearOutput(2, 48, 2880, 172800)},
      {'start' : DateTime(2020, 10, 16), 'end': DateTime(2020, 10, 18), 'countStart': true, 'countEnd': false, 'expectedOutput' : DayOfTheYearOutput(2, 48, 2880, 172800)},
      {'start' : DateTime(2020, 10, 16), 'end': DateTime(2020, 10, 18), 'countStart': false, 'countEnd': false, 'expectedOutput' : DayOfTheYearOutput(1, 24, 1440, 86400)},

      {'start' : DateTime(2020, 10, 18), 'end': DateTime(2020, 10, 16), 'countStart': true, 'countEnd': true, 'expectedOutput' : DayOfTheYearOutput(3, 72, 4320, 259200)},
      {'start' : DateTime(2020, 10, 18), 'end': DateTime(2020, 10, 16), 'countStart': false, 'countEnd': true, 'expectedOutput' : DayOfTheYearOutput(2, 48, 2880, 172800)},
      {'start' : DateTime(2020, 10, 18), 'end': DateTime(2020, 10, 16), 'countStart': true, 'countEnd': false, 'expectedOutput' : DayOfTheYearOutput(2, 48, 2880, 172800)},
      {'start' : DateTime(2020, 10, 18), 'end': DateTime(2020, 10, 16), 'countStart': false, 'countEnd': false, 'expectedOutput' : DayOfTheYearOutput(1, 24, 1440, 86400)},

      //daylight change days
      {'start' : DateTime(2019, 03, 31), 'end': DateTime(2019, 04, 01), 'countStart': true, 'countEnd': true, 'expectedOutput' : DayOfTheYearOutput(2, 47, 2820, 169200)},
      {'start' : DateTime(2019, 03, 31), 'end': DateTime(2019, 04, 01), 'countStart': false, 'countEnd': true, 'expectedOutput' : DayOfTheYearOutput(1, 23, 1380, 82800)},
      {'start' : DateTime(2019, 03, 31), 'end': DateTime(2019, 04, 01), 'countStart': true, 'countEnd': false, 'expectedOutput' : DayOfTheYearOutput(1, 23, 1380, 82800)},
      {'start' : DateTime(2019, 03, 31), 'end': DateTime(2019, 04, 01), 'countStart': false, 'countEnd': false, 'expectedOutput' : DayOfTheYearOutput(0, -1, -60, -3600)},

      {'start' : DateTime(2019, 03, 30), 'end': DateTime(2019, 04, 02), 'countStart': true, 'countEnd': true, 'expectedOutput' : DayOfTheYearOutput(4, 95, 5700, 342000)},
      {'start' : DateTime(2019, 03, 30), 'end': DateTime(2019, 04, 02), 'countStart': false, 'countEnd': true, 'expectedOutput' : DayOfTheYearOutput(3, 71, 4260, 255600)},
      {'start' : DateTime(2019, 03, 30), 'end': DateTime(2019, 04, 02), 'countStart': true, 'countEnd': false, 'expectedOutput' : DayOfTheYearOutput(3, 71, 4260, 255600)},
      {'start' : DateTime(2019, 03, 30), 'end': DateTime(2019, 04, 02), 'countStart': false, 'countEnd': false, 'expectedOutput' : DayOfTheYearOutput(2, 47, 2820, 169200)},

      {'start' : DateTime(2019, 10, 27), 'end': DateTime(2019, 10, 28), 'countStart': true, 'countEnd': true, 'expectedOutput' : DayOfTheYearOutput(2, 49, 2940, 176400)},
      {'start' : DateTime(2019, 10, 27), 'end': DateTime(2019, 10, 28), 'countStart': false, 'countEnd': true, 'expectedOutput' : DayOfTheYearOutput(1, 25, 1500, 90000)},
      {'start' : DateTime(2019, 10, 27), 'end': DateTime(2019, 10, 28), 'countStart': true, 'countEnd': false, 'expectedOutput' : DayOfTheYearOutput(1, 25, 1500, 90000)},
      {'start' : DateTime(2019, 10, 27), 'end': DateTime(2019, 10, 28), 'countStart': false, 'countEnd': false, 'expectedOutput' : DayOfTheYearOutput(0, 1, 60, 3600)},

      {'start' : DateTime(2019, 10, 26), 'end': DateTime(2019, 10, 29), 'countStart': true, 'countEnd': true, 'expectedOutput' : DayOfTheYearOutput(4, 97, 5820, 349200)},
      {'start' : DateTime(2019, 10, 26), 'end': DateTime(2019, 10, 29), 'countStart': false, 'countEnd': true, 'expectedOutput' : DayOfTheYearOutput(3, 73, 4380, 262800)},
      {'start' : DateTime(2019, 10, 26), 'end': DateTime(2019, 10, 29), 'countStart': true, 'countEnd': false, 'expectedOutput' : DayOfTheYearOutput(3, 73, 4380, 262800)},
      {'start' : DateTime(2019, 10, 26), 'end': DateTime(2019, 10, 29), 'countStart': false, 'countEnd': false, 'expectedOutput' : DayOfTheYearOutput(2, 49, 2940, 176400)},
    ];

    _inputsToExpected.forEach((elem) {
      test('start: ${elem['start']}, end: ${elem['end']}, countStart: ${elem['countStart']}, countEnd: ${elem['countEnd']}', () {
        DayOfTheYearOutput _actual = calculateDayDifferences(elem['start'], elem['end'], countStart: elem['countStart'], countEnd: elem['countEnd']);
        if (_actual == null)
          expect(_actual, elem['expectedOutput']);
        else {
          expect(_actual.days, elem['expectedOutput'].days);
          expect(_actual.hours, elem['expectedOutput'].hours);
          expect(_actual.minutes, elem['expectedOutput'].minutes);
          expect(_actual.seconds, elem['expectedOutput'].seconds);
        }
      });
    });
  });

  group("DayOfTheYear.isoWeekOfYear:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : null},

      {'input' : DateTime(2020, 1, 1), 'expectedOutput' : 1},
      {'input' : DateTime(2021, 1, 1), 'expectedOutput' : 53},
      {'input' : DateTime(2022, 1, 1), 'expectedOutput' : 52},
      {'input' : DateTime(2020, 12, 31), 'expectedOutput' : 1},
      {'input' : DateTime(2021, 12, 31), 'expectedOutput' : 53},
      {'input' : DateTime(2022, 12, 31), 'expectedOutput' : 52},

      {'input' : DateTime(2022, 1, 3), 'expectedOutput' : 1},
      {'input' : DateTime(2018, 1, 7), 'expectedOutput' : 1},
      {'input' : DateTime(2018, 1, 8), 'expectedOutput' : 2},

      {'input' : DateTime(2020, 2, 29), 'expectedOutput' : 9},
      {'input' : DateTime(2021, 2, 29), 'expectedOutput' : null},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = isoWeekOfYear(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}