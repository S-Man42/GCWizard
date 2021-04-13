import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';

enum PhoneKeySpace { SPACE_ON_KEY_0, SPACE_ON_KEY_1 }

class _ModeSwitch {
  String switchKey;
  List<PhoneInputMode> switchOrder;
  Map<PhoneInputMode, String> switchCharacters;

  _ModeSwitch(this.switchKey, this.switchOrder, this.switchCharacters);

  String codeSwitch(PhoneInputMode from, PhoneInputMode to) {
    var indexFrom = switchOrder.indexOf(from);
    var indexTo = switchOrder.indexOf(to);

    if (indexFrom < indexTo)
      return switchKey * (indexTo - indexFrom) + ' ';

    return switchKey * (indexTo + switchOrder.length - indexFrom) + ' ';
  }
}

class PhoneModel {
  String name;
  PhoneKeySpace keySpace;
  _ModeSwitch modeSwitch;

  PhoneModel(this.name, this.keySpace, this.modeSwitch);

  @override
  String toString() {
    return this.name;
  }
}

const _PHONE_MODEL_KEY_NOKIA = 'Nokia'; //tested 105,1661,6030,6303i,
const _PHONE_MODEL_KEY_SAMSUNG = 'Samsung'; //tested  GT-E1200I
const _PHONE_MODEL_KEY_SIEMENS = 'Siemens'; //tested ME45

final NOKIA = PhoneModel(_PHONE_MODEL_KEY_NOKIA, PhoneKeySpace.SPACE_ON_KEY_0,
    _ModeSwitch('#', [PhoneInputMode.FIRST_CAPITAL, PhoneInputMode.SMALL, PhoneInputMode.CAPITAL, PhoneInputMode.NUMBERS], {PhoneInputMode.SMALL: ' ', PhoneInputMode.FIRST_CAPITAL: '.?!'})
);
final SAMSUNG = PhoneModel(_PHONE_MODEL_KEY_SAMSUNG, PhoneKeySpace.SPACE_ON_KEY_0,
    _ModeSwitch('#', [PhoneInputMode.FIRST_CAPITAL, PhoneInputMode.SMALL, PhoneInputMode.CAPITAL, PhoneInputMode.NUMBERS], {PhoneInputMode.SMALL: ' ', PhoneInputMode.FIRST_CAPITAL: '.?!'})
);
final SIEMENS = PhoneModel(_PHONE_MODEL_KEY_SIEMENS, PhoneKeySpace.SPACE_ON_KEY_1,
    _ModeSwitch('*', [PhoneInputMode.FIRST_CAPITAL, PhoneInputMode.SMALL, PhoneInputMode.NUMBERS], {PhoneInputMode.SMALL: ' ', PhoneInputMode.FIRST_CAPITAL: '.?!'})
);

final PHONE_MODELS = [NOKIA, SAMSUNG, SIEMENS];

PhoneModel getPhoneModelByName(String name) {
  return PHONE_MODELS.firstWhere((model) => model.name == name);
}

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

final Map<String, String> _vanityNokiaNumbers = {
  '1': '1',
  '2': '2',
  '3': '3',
  '4': '4',
  '5': '5',
  '6': '6',
  '7': '7',
  '8': '8',
  '9': '9',
  '0': '0'
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

final Map<String, String> _vanitySamsungNumbers = {
  '1': '1',
  '2': '2',
  '3': '3',
  '4': '4',
  '5': '5',
  '6': '6',
  '7': '7',
  '8': '8',
  '9': '9',
  '0': '0'
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

final Map<String, String> _vanitySiemensNumbers = {
  '1': '1',
  '2': '2',
  '3': '3',
  '4': '4',
  '5': '5',
  '6': '6',
  '7': '7',
  '8': '8',
  '9': '9',
  '0': '0',
  '#': '#'
};

enum PhoneInputMode { SMALL, CAPITAL, FIRST_CAPITAL, NUMBERS }

String encodeVanitySingleNumbers(String input, PhoneModel model) {
  return _encodeVanity(input, model, false).map((code) => code[0]).join();
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

_getNextMode(PhoneInputMode currentMode) {
  switch (currentMode) {
    case PhoneInputMode.FIRST_CAPITAL:
      return PhoneInputMode.SMALL;
    case PhoneInputMode.SMALL:
      return PhoneInputMode.CAPITAL;
    case PhoneInputMode.CAPITAL:
      return PhoneInputMode.NUMBERS;
    case PhoneInputMode.NUMBERS:
      return PhoneInputMode.SMALL;
  }
}

_encodeVanity(String input, PhoneModel model, bool caseSensitive) {
  if (input == null || model == null) return [];

  Map<String, String> keyMapSmall;
  Map<String, String> keyMapCapital;
  Map<String, String> keyMapNumbers;
  switch (model.name) {
    case _PHONE_MODEL_KEY_NOKIA:
      keyMapSmall = _vanityNokiaSmall;
      keyMapCapital = _vanityNokiaCapital;
      keyMapNumbers = _vanityNokiaNumbers;
      break;
    case _PHONE_MODEL_KEY_SAMSUNG:
      keyMapSmall = _vanitySamsungSmall;
      keyMapCapital = _vanitySamsungCapital;
      keyMapNumbers = _vanitySamsungNumbers;
      break;
    case _PHONE_MODEL_KEY_SIEMENS:
      keyMapSmall = _vanitySiemensSmall;
      keyMapCapital = _vanitySiemensCapital;
      keyMapNumbers = _vanitySiemensNumbers;
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

  var _currentMode = caseSensitive ? model.modeSwitch.switchOrder[0] : PhoneInputMode.SMALL;
  var firstCapitalFirst = true;

  return input.split('').map((character) {
    var switchMode = '';
    if (caseSensitive && isOnlyLetters(character)) {
      if (_currentMode == PhoneInputMode.SMALL && isUpperCase(character)) {
        switchMode = model.modeSwitch.codeSwitch(PhoneInputMode.SMALL, PhoneInputMode.CAPITAL);
        _currentMode = PhoneInputMode.CAPITAL;
      } else if (_currentMode == PhoneInputMode.CAPITAL && !isUpperCase(character)) {
        switchMode = model.modeSwitch.codeSwitch(PhoneInputMode.CAPITAL, PhoneInputMode.SMALL);
        _currentMode = PhoneInputMode.SMALL;
      } else if (_currentMode == PhoneInputMode.FIRST_CAPITAL) {
        if (firstCapitalFirst && !isUpperCase(character) ) {
          switchMode = model.modeSwitch.codeSwitch(PhoneInputMode.FIRST_CAPITAL, PhoneInputMode.SMALL);
          _currentMode = PhoneInputMode.SMALL;
        } else if (!firstCapitalFirst && isUpperCase(character)) {
          switchMode = model.modeSwitch.codeSwitch(PhoneInputMode.FIRST_CAPITAL, PhoneInputMode.CAPITAL);
          _currentMode = PhoneInputMode.CAPITAL;
        }
      }
    }

    var out;
    switch (_currentMode) {
      case PhoneInputMode.SMALL:
        out = AZToNumberblocksSmall[character];
        break;
      case PhoneInputMode.CAPITAL:
        out = AZToNumberblocksCapital[character];
        break;
      case PhoneInputMode.FIRST_CAPITAL:
        if (firstCapitalFirst)
          out = AZToNumberblocksCapital[character];
        else
          out = AZToNumberblocksSmall[character];
        firstCapitalFirst = false;
        break;
    }

    if (caseSensitive && _currentMode != PhoneInputMode.CAPITAL) {
      var characterSwitchModes = model.modeSwitch.switchCharacters.keys.toList();
      var newMode;
      for (int i = 0; i < characterSwitchModes.length; i++) {
        if (model.modeSwitch.switchCharacters[characterSwitchModes[i]].contains(character)) {
          newMode = characterSwitchModes[i];
          break;
        }
      }
      if (newMode != null && _currentMode != newMode) {
        _currentMode = newMode;
        if (newMode == PhoneInputMode.FIRST_CAPITAL) firstCapitalFirst = true;
      }
    }

    return switchMode + out;
  }).toList();
}

String encodeVanityMultipleNumbers(String input, PhoneModel model, {caseSensitive: false}) {
  return _encodeVanity(input, model, caseSensitive).join(' ');
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

class VanityMultipleNumbersOutput {
  final PhoneInputMode inputMode;
  final String output;

  VanityMultipleNumbersOutput({this.inputMode: PhoneInputMode.FIRST_CAPITAL, this.output: ''});
}

VanityMultipleNumbersOutput decodeVanityMultipleNumbers(String input, PhoneModel model) {
  if (input == null || input.isEmpty || model == null) return VanityMultipleNumbersOutput();

  var sanitizedInput = '';
  var prevCharacter = input[0];
  input.replaceAll(RegExp(r'\s+'), ' ').split('').forEach((character) {
    if (!RegExp(r'[0-9#* ]').hasMatch(character)) return;

    if (character == ' ') {
      prevCharacter = ' ';
      return;
    }

    if (character == prevCharacter) {
      sanitizedInput += character;
    } else {
      sanitizedInput += ' ' + character;
    }

    prevCharacter = character;
  });

  var numberBlocks = sanitizedInput.split(' ').where((element) => element != null && element.length > 0).toList();

  if (numberBlocks.isEmpty) return VanityMultipleNumbersOutput();

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

  var _currentMode = PhoneInputMode.FIRST_CAPITAL;

  var output = numberBlocks.map((rawNumberBlock) {
    var numberBlock = rawNumberBlock;
    while (numberBlock.startsWith('#')) {
      _currentMode = _getNextMode(_currentMode);

      if (numberBlock.length > 1)
        numberBlock = numberBlock.substring(1);
      else
        return '';
    }

    var firstCharacter = numberBlock[0];

    var maxLength;
    var _numberBlock = numberBlock;
    if (_currentMode != PhoneInputMode.NUMBERS) {
      switch (_currentMode) {
        case PhoneInputMode.SMALL:
          if (keyMapSmall[firstCharacter] == null) return UNKNOWN_ELEMENT;

          maxLength = keyMapSmall[firstCharacter].length;
          break;
        case PhoneInputMode.CAPITAL:
        case PhoneInputMode.FIRST_CAPITAL:
          if (keyMapCapital[firstCharacter] == null) return UNKNOWN_ELEMENT;

          maxLength = keyMapCapital[firstCharacter].length;
          break;
      }

      var blockLength = numberBlock.length % maxLength;
      if (blockLength == 0) blockLength = maxLength;

      _numberBlock =
          numberBlock.substring(0, blockLength); // e.g. if '2:ABC2' then '22222' should return A -> rotation!
    }

    var character;
    switch (_currentMode) {
      case PhoneInputMode.SMALL:
        character = numberblocksToAZSmall[_numberBlock];
        break;
      case PhoneInputMode.CAPITAL:
        character = numberblocksToAZCapital[_numberBlock];
        break;
      case PhoneInputMode.FIRST_CAPITAL:
        character = numberblocksToAZCapital[_numberBlock];
        _currentMode = PhoneInputMode.SMALL;
        break;
      case PhoneInputMode.NUMBERS:
        character = _numberBlock;
        break;
    }

    if (character == null) return UNKNOWN_ELEMENT;

    if ([' ', '.', '?', '!'].contains(character)) _currentMode = PhoneInputMode.FIRST_CAPITAL;

    return character;
  }).join();

  return VanityMultipleNumbersOutput(inputMode: _currentMode, output: output);
}
