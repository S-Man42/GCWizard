import 'package:flutter/material.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';

enum PhoneKeySpace { SPACE_ON_KEY_0, SPACE_ON_KEY_1 }

class PhoneModel {
  String name;
  PhoneKeySpace keySpace;

  PhoneModel(this.name, this.keySpace);

  @override
  String toString() {
    return this.name;
  }
}

const _PHONE_MODEL_KEY_NOKIA = 'Nokia'; //tested 105,1661,6030,6303i,
const _PHONE_MODEL_KEY_SAMSUNG = 'Samsung'; //tested  GT-E1200I
const _PHONE_MODEL_KEY_SIEMENS = 'Siemens'; //tested ME45

final NOKIA = PhoneModel(_PHONE_MODEL_KEY_NOKIA, PhoneKeySpace.SPACE_ON_KEY_0);
final SAMSUNG = PhoneModel(_PHONE_MODEL_KEY_SAMSUNG, PhoneKeySpace.SPACE_ON_KEY_0);
final SIEMENS = PhoneModel(_PHONE_MODEL_KEY_SIEMENS, PhoneKeySpace.SPACE_ON_KEY_1);

final PHONE_MODELS = [NOKIA, SAMSUNG, SIEMENS];

final Map<String, String> _vanityNokiaSmall = {
  '1': '.,?!\'"1-()@/:_',
  '2': 'abc2äàáãâåæç',
  '3': 'def3èéëêð',
  '4': 'ghi4ìíîï',
  '5': 'jkl5£',
  '6': 'mno6öòóôõøñ',
  '7': 'pqrs7ß\$',
  '8': 'tuv8üùúû',
  '9': 'wxyz9ýϷ',
  '0': ' 0\n',
  '*': '.,\'?!"-()@/:_;+&%*=<>£€\$¥¤[]{}\~^`¡¿§#| \n',
};

final Map<String, String> _vanityNokiaCapital = {
  '1': '.,?!\'"1-()@/:_',
  '2': 'ABC2ÄÀÁÃÂÅÆÇ',
  '3': 'DEF3ÈÉËÊÐ',
  '4': 'GHI4ÌÍÎÏ',
  '5': 'JKL5£',
  '6': 'MNO6ÖÒÓÔÕØÑ',
  '7': 'PQRS7\$',
  '8': 'TUV8ÜÙÚÛ',
  '9': 'WXYZ9Ýϸ',
  '0': ' 0\n',
  '*': '.,\'?!"-()@/:_;+&%*=<>£€\$¥¤[]{}\~^`¡¿§#| \n',
};

final Map<String, String> _vanitySamsungSmall = {
  '1': '.,?!1@\'"-()/:_;',
  '2': 'abcäàåæΓ2',
  '3': 'defèéΦ3',
  '4': 'ghiìΨ4',
  '5': 'jklΛ5',
  '6': 'mnoñöòø6',
  '7': 'pqrsßΣΞ7',
  '8': 'tuvüù8',
  '9': 'wxyzΩ9',
  '0': ' 0\n',
  '*': '.,-!?@~_\n\/&"\';^|:()<{}>[]=€\$£§%¥*+#¿¡¤'
};

final Map<String, String> _vanitySamsungCapital = {
  '1': '.,?!1@\'"-()/:_;',
  '2': 'ABCÄÅÆÇΓ2',
  '3': 'DEFÉΔΦ3',
  '4': 'GHIΘΨ4',
  '5': 'JKLΛ5',
  '6': 'MNOÑÖØ6',
  '7': 'PQRSΠΣΞ7',
  '8': 'TUVÜ8',
  '9': 'WXYZΩ9',
  '0': ' 0\n',
  '*': '.,-!?@~_\n\/&"\';^|:()<{}>[]=€\$£§%¥*+#¿¡¤',
};

final Map<String, String> _vanitySiemensSmall = {
  '0': '.,?!0+-:¿¡"\'_',
  '1': ' 1€£\$¥¤',
  '2': 'abc2äàçæå',
  '3': 'def3éè',
  '4': 'ghi4ì',
  '5': 'jkl5',
  '6': 'mno6öñòø',
  '7': 'pqrs7ß',
  '8': 'tuv8üù',
  '9': 'wxyz9'
};

final Map<String, String> _vanitySiemensCapital = {
  '0': '.,?!0+-:¿¡"\'_',
  '1': ' 1€£\$¥¤',
  '2': 'ABC2ÄÆÅ',
  '3': 'DEF3É',
  '4': 'GHI4',
  '5': 'JKL5',
  '6': 'MNO6ÖÑØ',
  '7': 'PQRS7',
  '8': 'TUV8Ü',
  '9': 'WXYZ9'
};

enum _InputMode { SMALL, CAPITAL, NUMBERS }

String encodeVanitySingleNumbers(String input, PhoneModel model) {
  return _encodeVanity(input, model).map((code) => code[0]).join();
}

Map<String, String> _prepareAZToNumberblocks(Map<String, String> keyMap) {
  Map<String, String> AZToNumberblocks = {};
  keyMap.entries.forEach((element) {
    element.value.split('').asMap().forEach((index, character) {
      AZToNumberblocks.putIfAbsent(character, () => '${element.key}' * (index + 1));
    });
  });

  return AZToNumberblocks;
}

_encodeVanity(String input, PhoneModel model, {caseSensitive: false}) {
  if (input == null || model == null) return [];

  Map<String, String> keyMapSmall;
  Map<String, String> keyMapCapital;
  switch (model.name) {
    case _PHONE_MODEL_KEY_NOKIA:
      keyMapSmall = _vanityNokiaSmall;
      keyMapCapital = _vanityNokiaCapital;
      break;
    case _PHONE_MODEL_KEY_SAMSUNG:
      keyMapSmall = _vanitySamsungSmall;
      keyMapCapital = _vanitySamsungCapital;
      break;
    case _PHONE_MODEL_KEY_SIEMENS:
      keyMapSmall = _vanitySiemensSmall;
      keyMapCapital = _vanitySiemensCapital;
      break;
  }

  var list = keyMapSmall.values.join().split('').toList();

  if (caseSensitive) {
    list += keyMapCapital.values.join().split('').toList();
  } else {
    input = input.toLowerCase();
  }

  input = input.split('').map((character) {
    return list.contains(character) ? character : '';
  }).join();

  if (input.isEmpty) return [];

  Map<String, String> AZToNumberblocksSmall = _prepareAZToNumberblocks(keyMapSmall);
  Map<String, String> AZToNumberblocksCapital = _prepareAZToNumberblocks(keyMapCapital);

  var _currentMode = _InputMode.SMALL;

  return input.split('').map((character) {
    var switchMode = '';
    if (caseSensitive && isOnlyLetters(input)) {
      if (_currentMode == _InputMode.SMALL && isUpperCase(character)) {
        switchMode = '#'; // TODO
        _currentMode = _InputMode.CAPITAL;
      } else if (_currentMode == _InputMode.CAPITAL && !isUpperCase(character)) {
        switchMode = '#'; // TODO
        _currentMode = _InputMode.SMALL;
      }
    }

    var out;
    switch (_currentMode) {
      case _InputMode.SMALL:
        out = AZToNumberblocksSmall[character];
        break;
      case _InputMode.CAPITAL:
        out = AZToNumberblocksCapital[character];
        break;
    }

    return switchMode + out;
  }).toList();
}

String encodeVanityMultipleNumbers(String input, PhoneModel model) {
  return _encodeVanity(input, model).join(' ');
}

Map<String, String> _prepareNumberblocksToAZ(Map<String, String> keyMap) {
  Map<String, String> numberblocksToAZ = {};
  keyMap.entries.forEach((element) {
    element.value.split('').asMap().forEach((index, character) {
      numberblocksToAZ.putIfAbsent('${element.key}' * (index + 1), () => character);
    });
  });

  return numberblocksToAZ;
}

String decodeVanityMultipleNumbers(String input, PhoneModel model) {
  if (input == null || input.isEmpty || model == null) return '';

  var numberBlocks = input
      .replaceAll(RegExp(r'[^0-9#* ]'), '')
      .split(' ')
      .where((element) => element != null && !element.isEmpty)
      .toList();

  if (numberBlocks.isEmpty) return '';

  Map<String, String> keyMapSmall;
  Map<String, String> keyMapCapital;
  switch (model.name) {
    case _PHONE_MODEL_KEY_NOKIA:
      keyMapSmall = _vanityNokiaSmall;
      keyMapCapital = _vanityNokiaCapital;
      break;
    case _PHONE_MODEL_KEY_SAMSUNG:
      keyMapSmall = _vanitySamsungSmall;
      keyMapCapital = _vanitySamsungCapital;
      break;
    case _PHONE_MODEL_KEY_SIEMENS:
      keyMapSmall = _vanitySiemensSmall;
      keyMapCapital = _vanitySiemensCapital;
      break;
  }

  Map<String, String> numberblocksToAZSmall = _prepareNumberblocksToAZ(keyMapSmall);
  Map<String, String> numberblocksToAZCapital = _prepareNumberblocksToAZ(keyMapCapital);

  var _currentMode = _InputMode.SMALL;

  return numberBlocks.map((numberBlock) {
    if (!allSameCharacters(numberBlock)) {
      return UNKNOWN_ELEMENT;
    }

    var firstCharacter = numberBlock[0];

    var maxLength;
    switch (_currentMode) {
      case _InputMode.SMALL:
        maxLength = keyMapSmall[firstCharacter].length;
        break;
      case _InputMode.CAPITAL:
        maxLength = keyMapSmall[firstCharacter].length;
        break;
      case _InputMode.NUMBERS:
        maxLength = 1;
        break;
    }

    var blockLength = numberBlock.length % maxLength;
    if (blockLength == 0) blockLength = maxLength;

    var _numberBlock =
        numberBlock.substring(0, blockLength); // e.g. if '2:ABC2' then '22222' should return A -> rotation!

    var character;
    switch (_currentMode) {
      case _InputMode.SMALL:
        character = numberblocksToAZSmall[_numberBlock];
        break;
      case _InputMode.CAPITAL:
        character = numberblocksToAZCapital[_numberBlock];
        break;
      case _InputMode.NUMBERS:
        character = firstCharacter;
        break;
    }

    if (character == null) return UNKNOWN_ELEMENT;

    return character;
  }).join();
}
