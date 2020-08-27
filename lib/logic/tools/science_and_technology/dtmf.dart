import 'package:gc_wizard/utils/common_utils.dart';

final DigitToDTMF = {'1' : [697, 1209], '2' : [697, 1336], '3' : [697, 1477], 'A' : [697, 1633],
                     '4' : [770, 1209], '5' : [770, 1336], '6' : [770, 1477], 'B' : [770, 1633],
                     '7' : [852, 1209], '8' : [852, 1336], '9' : [852, 1477], 'C' : [852, 1633],
                     '*' : [941, 1209], '0' : [941, 1336], '#' : [941, 1477], 'D' : [941, 1633]};
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
  List _chiffreList = chiffre.split(RegExp(r'[^0123456789]'));
  List _dtmfCode = new List();
  List _chiffreListClean = new List();
  List _tones = new List();
  var _character;

  for (var i = 0; i < _chiffreList.length - 1; i++) {
    if (DTMFFrequencies[_chiffreList[i]] != null) {
      _chiffreListClean.add(DTMFFrequencies[_chiffreList[i]]);
    }
  }

  for(var i = 0; i < _chiffreListClean.length - 1; i = i + 2) {
    if (i + 1 <= _chiffreListClean.length - 1) {
      _tones = [_chiffreListClean[i], _chiffreListClean[i + 1]];
      _tones.sort();
      _dtmfCode.add(_tones);
    }
  }

  return _dtmfCode
    .map((frequencies) {
      DTMFToDigit.forEach((key, value) {
      if (key.join() == frequencies.join()) {
        _character = value;
      }
    });
    return _character != null ? _character : '';
    })
    .join('');
}
