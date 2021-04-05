// https://en.wikisource.org/wiki/An_Introduction_to_the_Study_of_the_Maya_Hieroglyphs/Chapter_3#fig19
// https://en.wikipedia.org/wiki/Maya_calendar
// https://en.wikipedia.org/wiki/Haab%CA%BC
// https://en.wikipedia.org/wiki/Tzolk%CA%BCin

import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';

final maya_longcount = {
  1 : 'kin',
  2 : 'uinal',
  3 : 'tun',
  4 : 'katun',
  5 : 'baktun',
  6 : 'pictun',
  7 : 'kalabtun',
  8 : 'kinchiltun',
  9 : 'alatun'
};

final maya_tzolkin = {
  1 : 'Imix',
  2 : 'Ik',
  3 : 'Akbal',
  4 : 'Kan',
  5 : 'Chiccan',
  6 : 'Cimi',
  7 : 'Manik',
  8 : 'Lamat',
  9 : 'Muluc',
  10 : 'Oc',
  11 : 'Chuen',
  12 : 'Eb',
  13 : 'Ben',
  14 : 'Ix',
  15 : 'Men',
  16 : 'Cib',
  17 : 'Caban',
  18 : 'Etznab',
  19 : 'Cauac',
  20 : 'Ahau',
};

final maya_haab = {
  1 : 'Pop',
  2 : 'Uo',
  3 : 'Zip',
  4 : 'Zotz',
  5 : 'Tzek',
  6 : 'Xul',
  7 : 'Yaxkin',
  8 : 'Mol',
  9 : 'Chen',
  10 : 'Yax',
  11 : 'Zac',
  12 : 'Ceh',
  13 : 'Mac',
  14 : 'Kankin',
  15 : 'Muan',
  16 : 'Pax',
  17 : 'Kayab',
  18 : 'Cumhu',
  19 : 'Uayeb'
};

final Map<int, List<String>> _numbersToSegments = {
  0: [],
  1: ['d'],
  2: ['d', 'e'],
  3: ['d', 'e', 'f'],
  4: ['d', 'e', 'f', 'g'],
  5: ['c'],
  6: ['c', 'd'],
  7: ['c', 'd', 'e'],
  8: ['c', 'd', 'e', 'f'],
  9: ['c', 'd', 'e', 'f', 'g'],
  10: ['b', 'c'],
  11: ['b', 'c', 'd'],
  12: ['b', 'c', 'd', 'e'],
  13: ['b', 'c', 'd', 'e', 'f'],
  14: ['b', 'c', 'd', 'e', 'f', 'g'],
  15: ['a', 'b', 'c'],
  16: ['a', 'b', 'c', 'd'],
  17: ['a', 'b', 'c', 'd', 'e'],
  18: ['a', 'b', 'c', 'd', 'e', 'f'],
  19: ['a', 'b', 'c', 'd', 'e', 'f', 'g'],
};

const _alphabet = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

List<int> mayaCalendarSystem = [1, 20, 360, 7200, 144000, 2880000, 57600000, 1152000000, 23040000000];

Map <String, int> mayaSystemPosition = {'0' : 0, '1' : 1, '2' : 2, '3' : 3, '4' : 4, '5' : 5, '6' : 6, '7' : 7, '9' : 9,
  'A' : 10, 'B' : 11, 'C' : 12, 'D' : 13, 'E' : 14, 'F' : 15, 'G' : 16, 'H' : 17, 'I' : 18, 'J' : 19};


List<List<String>> encodeMayaCalendar(String input) {
  if (input == null || input == '') return [];

  input = input.split('.').reversed.toList().join('.');
  List<int> longCount = new List<int>();
  for (int i = 0; i < input.split('.').length; i++) {
    print(input.split('.').toString());
    longCount.insert(0, int.parse(input.split('.')[i]));
  }
  if (longCount.length > 1 && longCount[1] > 17) return [];

  int dayCount = longCountToDayCount(longCount);

  var vigesimal = '';
  vigesimal = convertDecToMayaCalendar(dayCount.toString());
  return vigesimal.split('').map((digit) {
    return _numbersToSegments[int.tryParse(convertBase(digit, 20, 10))];
  }).toList();
}

Map<String, dynamic> decodeMayaCalendar(List<String> inputs) {
  if (inputs == null || inputs.length == 0)
    return {
      'displays': [[]],
      'numbers': [0],
      'vigesimal': BigInt.zero
    };

  var oneCharacters = ['d', 'e', 'f', 'g'];
  var fiveCharacters = ['a', 'b', 'c'];

  var displays = <List<String>>[];

  List<int> numbers = inputs.where((input) => input != null).map((input) {
    var number = 0;
    var display = <String>[];
    input.toLowerCase().split('').forEach((segment) {
      if (oneCharacters.contains(segment)) {
        number += 1;
        display.add(segment);
        return;
      }
      if (fiveCharacters.contains(segment)) {
        number += 5;
        display.add(segment);
        return;
      }
      return;
    });

    displays.add(display);

    return number;
  }).toList();

  String total;
  total = '0';
  bool invalid = false;
  for (int i = 0; i < numbers.length; i++) {
    if ((i == numbers.length - 2) && (mayaCalendarSystem[numbers.length - i - 1] == 20) && (numbers[i] > 17))
      invalid = true;
    else
      total = (int.parse(total) + numbers[i] * mayaCalendarSystem[numbers.length - i - 1])
          .toString();
  }
  if (invalid)
    total = "-1";

  return {'displays': displays, 'numbers': numbers, 'vigesimal': BigInt.tryParse(total)};
}

String convertDecToMayaCalendar(String input) {
  if (input == null || input == '')
    return '';

  BigInt numberDec = BigInt.parse(input);
  if (numberDec == BigInt.from(0))
    return '0';

  String result = '';
  int start = 0;
  while (numberDec < BigInt.from(mayaCalendarSystem[mayaCalendarSystem.length - 1 - start]))
    start++;
  for (int position = mayaCalendarSystem.length - start; position > 0; position--) {
    int value = 0;
    while (numberDec >= BigInt.from(mayaCalendarSystem[position - 1])) {
      value++;
      numberDec = numberDec - BigInt.from(mayaCalendarSystem[position - 1]);
    }
    result = result + _alphabet[value];
  }
  return result;
}

String dayCountToTzolkin(List longCount) {
  int dayCount = longCountToDayCount(longCount);
  if (dayCount == 0) return '4 Ahau';

  dayCount = dayCount + 159;
  dayCount = 1 + dayCount % 260;
  print(dayCount % 20);
  return (1 + (dayCount - 1) % 13).toString() + ' ' + maya_tzolkin[1 + (dayCount - 1) % 20];
}

String dayCountToHaab(List longCount) {
  int dayCount = longCountToDayCount(longCount);
  if (dayCount == 0) return '8 Cumhu';

  dayCount = dayCount + 347;
  dayCount = 1 + dayCount % 365;
  return (1 + (dayCount - 1) % 20).toString() + ' ' + maya_haab[1 + (dayCount - 1) ~/ 20];
}

String longCount(List<int> longCount) {
  if (longCountToDayCount(longCount) == 0) return [0,0,0,0,13,0,0,0,0].join('.');

  List<int> result = new List<int>();
  for (int i = longCount.length; i < 9; i++) result.add(0);
  for (int i = 0; i < longCount.length; i++) result.add(longCount[i]);
  if (result[4] == 0) result[4] = 13;
  return result.join('.');
}

int longCountToDayCount(List<int> longCount){
  int dayCount = 0;
  longCount = longCount.reversed.toList();
  for (int i = 0; i < longCount.length; i++) dayCount = dayCount + longCount[i] * mayaCalendarSystem[i];
  return dayCount;
}
