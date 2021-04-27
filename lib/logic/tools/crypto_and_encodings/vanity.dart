import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/numeral_words.dart';

enum PhoneKeySpace { SPACE_ON_KEY_0, SPACE_ON_KEY_1 }

class _ModeSwitch {
  String switchKey;
  List<PhoneInputMode> switchOrder;
  Map<PhoneInputMode, String> switchCharacters;

  _ModeSwitch(this.switchKey, this.switchOrder, this.switchCharacters);

  String codeSwitch(PhoneInputMode from, PhoneInputMode to) {
    var indexFrom = switchOrder.indexOf(from);
    var indexTo = switchOrder.indexOf(to);

    if (indexFrom < indexTo) return switchKey * (indexTo - indexFrom) + ' ';

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

final NOKIA = PhoneModel(
    _PHONE_MODEL_KEY_NOKIA,
    PhoneKeySpace.SPACE_ON_KEY_0,
    _ModeSwitch(
        '#',
        [PhoneInputMode.FIRST_CAPITAL, PhoneInputMode.SMALL, PhoneInputMode.CAPITAL, PhoneInputMode.NUMBERS],
        {PhoneInputMode.SMALL: ' ', PhoneInputMode.FIRST_CAPITAL: '.?!'}));
final SAMSUNG = PhoneModel(
    _PHONE_MODEL_KEY_SAMSUNG,
    PhoneKeySpace.SPACE_ON_KEY_0,
    _ModeSwitch(
        '#',
        [PhoneInputMode.FIRST_CAPITAL, PhoneInputMode.SMALL, PhoneInputMode.CAPITAL, PhoneInputMode.NUMBERS],
        {PhoneInputMode.SMALL: ' ', PhoneInputMode.FIRST_CAPITAL: '.?!'}));
final SIEMENS = PhoneModel(
    _PHONE_MODEL_KEY_SIEMENS,
    PhoneKeySpace.SPACE_ON_KEY_1,
    _ModeSwitch('*', [PhoneInputMode.FIRST_CAPITAL, PhoneInputMode.SMALL, PhoneInputMode.NUMBERS],
        {PhoneInputMode.SMALL: ' ', PhoneInputMode.FIRST_CAPITAL: '.?!'}));

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

class VanityWordsDecodeOutput {
  final String number;
  final String numWord;
  final String digit;
  final bool ambigous;
  VanityWordsDecodeOutput(this.number, this.numWord, this.digit, this.ambigous);
}

final VanityToDEU = {
  '6855' : 'NULL',
  '3467' : 'EINS',
  '9934' : 'ZWEI',
  '996' : 'ZWO',
  '7334' : 'DREI',
  '8437' : 'VIER',
  '38363' : 'FUENF',
  '73247' : 'SECHS',
  '743236' : 'SIEBEN',
  '2248' : 'ACHT',
  '6386' : 'NEUN',
};
final VanityToENG = {
  '9376' : 'ZERO',
  '663' : 'ONE',
  '896' : 'TWO',
  '84733' : 'THREE',
  '3687' : 'FOUR',
  '3483' : 'FIVE',
  '749' : 'SIX',
  '73836' : 'SEVEN',
  '34448' : 'EIGHT',
  '6386' : 'NINE',
};
final VanityToFRA = {
  '9376' : 'ZÉRO',
  '86' : 'UN',
  '3389' : 'DEUX',
  '8764' : 'TROIS',
  '782873' : 'QUATRE',
  '2467' : 'CINQ',
  '749' : 'SIX',
  '7378' : 'SEPT',
  '4848' : 'HUIT',
  '6386' : 'NEUF',
};
final VanityToITA = {
  '9376':'ZERO',
  '866':'UNO',
  '383':'DUE',
  '873':'TRE',
  '7828876':'QUATTRO',
  '346783':'CINQUE',
  '734':'SEI',
  '73883':'SETTE',
  '6886':'OTTO',
  '6683':'NOVE',
};
final VanityToDNK = {
  '685' : 'NUL',
  '36' : 'EN',
  '86' : 'TO',
  '873' : 'TRE',
  '3473' : 'FIRE',
  '336' : 'FEM',
  '7253' : 'SEKS',
  '7983' : 'SYVE',
  '6883' : 'OTTE',
  '64' : 'NI',
};
final VanityToESP = {
  '2376':'CERO',
  '876':'UNO',
  '872':'UNA',
  '367':'DOS',
  '8737':'TRES',
  '282876':'CUATRO',
  '24626':'CINCO',
  '7347':'SEIS',
  '74383':'SIETE',
  '6246':'OCHO',
  '68383':'NUEVE',
};
final VanityToNLD = {
  '685': 'NUL',
  '336': 'EEN',
  '9933': 'ZWEE',
  '8743': 'TRIE',
  '8437': 'VIER',
  '8453': 'VIJF',
  '937': 'ZES',
  '93836': 'ZEVEN',
  '2248': 'ACHT',
  '6343': 'NEGEN',
};
final VanityToNOR = {
  '685':'NUL',
  '36':'EN',
  '388':'ETT',
  '86':'TO',
  '873':'TRE',
  '3473':'FIRE',
  '336':'FEM',
  '7357':'SEKS',
  '758':'SJU',
  '798':'SYV',
  '2883':'ÅTTE',
  '64':'NI',
};
final VanityToPOL = {
  '9376':'ZERO',
  '53336':'JEDEN',
  '53362':'JEDNA',
  '53366':'JEDNO',
  '392':'DWA',
  '3943':'DWIE',
  '8779':'TRZY',
  '298379':'CZTERY',
  '7342':'PIĘĆ',
  '79372':'SZEŚĆ',
  '743336':'SIEDEM',
  '67436':'OSIEM',
  '39439432':'DZIEWIĘĆ',
};
final VanityToPOR = {
  '9376':'ZERO',
  '86':'UM',
  '3647':'DOIS',
  '3827':'DUAS',
  '8737':'TRES',
  '72876':'QUATRO',
  '24626':'CINCO',
  '7347':'SEIS',
  '7393':'SETE',
  '6886':'OITO',
  '6683':'NOVE',
};
final VanityToSWE = {
  '8655' : 'NOLL',
  '36' : 'EN',
  '388':'ETT',
  '882':'TVÅ',
  '873':'TRE',
  '3972':'FYRA',
  '336':'FEM',
  '739':'SEX',
  '758':'SJU',
  '2882':'ÅTTA',
  '646':'NIO',
};
final VanityToRUS = {
  '665':'NOL',
  '685':'NUL',
  '2363':'ADNA',
  '2366':'ADNO',
  '2346':'ADIN',
  '392':'DWA',
  '3953':'DWJE',
  '874':'TRI',
  '2389743':'ČETÝRIE',
  '7528':'PJAT',
  '7378':'ŠEST',
  '736':'SEM',
  '86736':'VOSEM',
  '3538528':'DJEVJAT',
};
final VanityToVOL = {
  '737':'SER',
  '225':'BAL',
  '835':'TEL',
  '545':'KIL',
  '365':'FOL',
  '585':'LUL',
  '6235':'MAEL',
  '935':'VEL',
  '5635':'JOEL',
  '9835':'ZUEL',
};
final VanityToEPO = {
  '6856':'NULO',
  '868':'UNU',
  '38':'DU',
  '874':'TRI',
  '5927':'KVAR',
  '5946':'KVIN',
  '737':'SES',
  '737':'SEP',
  '65':'OK',
  '628':'NAǓ',
};
final VanityToSOL = {
  '765':'SOLDO',
  '733636':'REDODO',
  '736464':'REMIMI',
  '733232':'REFAFA',
  '73765765':'RESOLSOL',
  '735252':'RELALA',
  '737474':'RESISI',
  '646436':'MIMIDO',
  '646473':'MIMIRE',
  '646432':'MIMIFA',
};
final VanityToLAT = {
  '93786' : 'ZERUM',
  '685586': 'NULLUM',
  '8687' : 'UNUS',
  '386' : 'DUO',
  '8742' : 'TRIA',
  '8737' : 'TRES',
  '78288867' : 'QUATTUOR',
  '7846783' : 'QUINQUE',
  '43927' : 'HEXAS',
  '739' : 'SEX',
  '737836' : 'SEPTEM',
  '6286' : 'OCTO',
  '66836' : 'NOVEM',
};

Map VanWords = {
  NumeralWordsLanguage.DEU: VanityToDEU,
  NumeralWordsLanguage.ENG: VanityToENG,
  NumeralWordsLanguage.FRA: VanityToFRA,
  NumeralWordsLanguage.ITA: VanityToITA,
  NumeralWordsLanguage.DNK: VanityToDNK,
  NumeralWordsLanguage.ESP: VanityToESP,
  NumeralWordsLanguage.NLD: VanityToNLD,
  NumeralWordsLanguage.NOR: VanityToNOR,
  NumeralWordsLanguage.POL: VanityToPOL,
  NumeralWordsLanguage.POR: VanityToPOR,
  NumeralWordsLanguage.SWE: VanityToSWE,
  NumeralWordsLanguage.RUS: VanityToRUS,
  NumeralWordsLanguage.VOL: VanityToVOL,
  NumeralWordsLanguage.EPO: VanityToEPO,
  NumeralWordsLanguage.SOL: VanityToSOL,
  NumeralWordsLanguage.LAT: VanityToLAT
};

Map<NumeralWordsLanguage, String> VANITYWORDS_LANGUAGES = {
  NumeralWordsLanguage.DEU: 'common_language_german',
  NumeralWordsLanguage.ENG: 'common_language_english',
  NumeralWordsLanguage.FRA: 'common_language_french',
  NumeralWordsLanguage.ITA: 'common_language_italian',
  NumeralWordsLanguage.DNK: 'common_language_danish',
  NumeralWordsLanguage.ESP: 'common_language_spanish',
  NumeralWordsLanguage.NLD: 'common_language_dutch',
  NumeralWordsLanguage.NOR: 'common_language_norwegian',
  NumeralWordsLanguage.POL: 'common_language_polish',
  NumeralWordsLanguage.POR: 'common_language_portuguese',
  NumeralWordsLanguage.SWE: 'common_language_swedish',
  NumeralWordsLanguage.RUS: 'common_language_russian',
  NumeralWordsLanguage.VOL: 'common_language_volapuek',
  NumeralWordsLanguage.EPO: 'common_language_esperanto',
  NumeralWordsLanguage.SOL: 'common_language_solresol',
  NumeralWordsLanguage.LAT: 'common_language_latin'
};

List<VanityWordsDecodeOutput> decodeVanityWords(String text, NumeralWordsLanguage language){
  List<VanityWordsDecodeOutput> output = new List<VanityWordsDecodeOutput>();
  if (text == null || text == '') {
    output.add(VanityWordsDecodeOutput('', '', '', false));
    return output;
  }

  // build map to identify numeral words
  Map decodingTable = new Map();
  VanWords[language].forEach((key, value) {
      decodingTable[removeAccents(key)] = value;
  });

  // start decoding text with searchlanguages
  bool found = false;
  bool ambigous = false;
  String hDigits = '';
  String hWord = '';
  text = text.replaceAll(' ', '');
  while (text.length > 0) {
    found = false;
    ambigous = false;
    hDigits = '';
    hWord = '';
    decodingTable.forEach((digits, word) {
      if (text.startsWith(digits)) {
        if (!found) {
          hDigits = digits;
          hWord = word;
          found = true;
        } else { // already found
          ambigous = true;
          output.add(VanityWordsDecodeOutput(hDigits, hWord, NumWords[language][hWord.toString().toLowerCase()], true));
          output.add(VanityWordsDecodeOutput(digits, word, NumWords[language][word.toString().toLowerCase()], true));
        }
      };
    }); // end decodingTable.forEach

    if (found && !ambigous) {
      output.add(VanityWordsDecodeOutput(hDigits, hWord, NumWords[language][hWord.toString().toLowerCase()], false));
      if (hDigits.length > 0) text = text.substring(hDigits.length - 1);
    }
    if (!found) {
      output.add(VanityWordsDecodeOutput('?', '', '', false));}
    if (text.length > 0) text = text.substring(1);
    if (ambigous) text='';
  } // end while text.lewngth > 0
  return output;
}

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
        if (firstCapitalFirst && !isUpperCase(character)) {
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
