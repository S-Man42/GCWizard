import 'package:gc_wizard/utils/common_utils.dart';

final DigitToDTMF = {'0' : '1336 941', '1' : '1209 697', '2' : '1336 697', '3' : '1477 697', '4' : '1209 770',
                     '5' : '1336 770', '6' : '1477 770', '7' : '1209 852', '8' : '1336 852', '9' : '1477 852',
                     'A' : '1633 697', 'B' : '1633 770', 'C' : '1633 852', 'D' : '1633 941',
                     '*' : '1209 941', '#' : '1477 941'};
final DTMFToDigit = {'1336 941' : '0', '1209 697' : '1', '1336 697' : '2', '1477 697' : '3', '1209 770' : '4',
                     '941 1336' : '0', '697 1209' : '1', '697 1336' : '2', '697 1477' : '3', '770 1209' : '4',
                     '1336 770' : '5', '1477 770' : '6', '1209 852' : '7', '1336 852' : '8', '1477 852' : '9',
                     '770 1336' : '5', '770 1477' : '6', '852 1209' : '7', '852 1336' : '8', '852 1477' : '9',
                     '1633 697' : 'A', '1633 770' : 'B', '1633 852' : 'C', '1633 941' : 'D',
                     '697 1633' : 'A', '770 1633' : 'B', '852 1633' : 'C', '941 1633' : 'D',
                     '1209 941' : '*', '1477 941' : '#',
                     '941 1209' : '*', '941 1477' : '#'};

/*
final DigitToDTMF = {'0' : [941, 1336], '1' : [697, 1209], '2' : [697, 1336], '3' : [697, 1477], '4' : [770, 1209],
                     '5' : [770, 1336], '6' : [770, 1477], '7' : [852, 1209], '8' : [852, 1336], '9' : [852, 1477],
                     'A' : [697, 1633], 'B' : [770, 1633], 'C' : [852, 1633], 'D' : [941, 1633],
                     '*' : [941, 1209], '#' : [941, 1477]};

final DTMFToDigit = switchMapKeyValue(DigitToDTMF);
*/

String encodeDTMF(String plain) {
  return plain
      .toUpperCase()
      .split('')
      .where((digit) => DigitToDTMF[digit] != null)
      .map((digit) => DigitToDTMF[digit])
      .join('   ');

}


String decodeDTMF(String chiffre) {
  List chiffreList = chiffre.split(' ');
  List dtmfCode = new List<String>();
//  List dtmfCode = new List();
//  List tones = new List();

  for(var i = 0; i < chiffreList.length - 1; i = i + 2) {
    dtmfCode.add(chiffreList[i] + ' ' + chiffreList[i + 1]);
//    tones = [int.tryParse(chiffreList[i]), int.tryParse(chiffreList[i + 1])];
//    tones.sort();
//    dtmfCode.add(tones);
  }

  return dtmfCode
    .map((tone) {
      var character = DTMFToDigit[tone];
//      var character = DTMFToDigit[tone].toString();
      return character != null ? character : '';
    })
    .join(' ');
}