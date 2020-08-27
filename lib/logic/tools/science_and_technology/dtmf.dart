import 'package:gc_wizard/utils/common_utils.dart';
/*
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
*/

final DigitToDTMF = {'0' : [941, 1336], '1' : [697, 1209], '2' : [697, 1336], '3' : [697, 1477], '4' : [770, 1209],
                     '5' : [770, 1336], '6' : [770, 1477], '7' : [852, 1209], '8' : [852, 1336], '9' : [852, 1477],
                     'A' : [697, 1633], 'B' : [770, 1633], 'C' : [852, 1633], 'D' : [941, 1633],
                     '*' : [941, 1209], '#' : [941, 1477]};
final DTMFToDigit = switchMapKeyValue(DigitToDTMF);

final DTMFFrequencies = {'697' : 697, '770' : 770, '852' : 852, '941' : 941, '1209' : 1209, '1336' : 1336, '1477' : 1477, '1633' : 1633};


String encodeDTMF(String plain) {
  return plain
      .toUpperCase()
      .split('')
      .where((digit) => DigitToDTMF[digit] != null)
      .map((digit) => DigitToDTMF[digit])
      .join('   ');
}


String decodeDTMF(String chiffre) {
  List _tones = new List<int>();
  List _dtmfCodeClean = new List();
  var _character;
  String _result = '';

  List _dtmfCode = new List<List>();

  // split input into numbers
  List _chiffreList = chiffre.split(RegExp(r'[^0123456789]'));

  // remove all numbers which are not correct frequencies
  for (var i = 0; i < _chiffreList.length - 1; i++) {
    if (DTMFFrequencies[_chiffreList[i]] != null) {
      print (DTMFFrequencies[_chiffreList[i]]);
      _dtmfCodeClean.add(DTMFFrequencies[_chiffreList[i]]);
    }
  }

  // build new list with pairs of frequencies
  for(var i = 0; i < _dtmfCodeClean.length - 1; i = i + 2) {
    if (i + 1 < _dtmfCodeClean.length - 1) {
      _tones = [_dtmfCodeClean[i], _dtmfCodeClean[i + 1]];
      _tones.sort();
      _dtmfCode.add(_tones);
    }
  }

  //decode list
  for (var i = 0; i < _dtmfCode.length - 1; i++) {
    _tones = _dtmfCode[i];
    _character = DTMFToDigit[_tones];
    if (_character != null) {
      _result = _result + _character;
    } else {
      _result = _result + '?';
    }
  }
  return _result;

}