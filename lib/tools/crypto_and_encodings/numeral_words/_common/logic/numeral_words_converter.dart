// ignore_for_file: equal_keys_in_map

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/science_and_technology/numeral_bases/logic/numeral_bases.dart';
import 'package:gc_wizard/utils/collection_utils.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/utils/string_utils.dart';

part 'package:gc_wizard/tools/crypto_and_encodings/numeral_words/_common/logic/numeral_words_maps.dart';
part 'package:gc_wizard/tools/crypto_and_encodings/numeral_words/_common/logic/numeral_words_classes.dart';
part 'package:gc_wizard/tools/crypto_and_encodings/numeral_words/_common/logic/numeral_words_converter.dart';

List<NumeralWordsDecodeOutput> decodeNumeralwords(
    {required String input, required NumeralWordsLanguage language, bool decodeModeWholeWords = false}) {
  RegExp expr;
  List<NumeralWordsDecodeOutput> output = [];
  if (input.isEmpty) {
    output.add(NumeralWordsDecodeOutput('', '', 'numeralwords_language_empty'));
    return output;
  }

  input = removeAccents(input.toLowerCase());

  _languageList = {NumeralWordsLanguage.NUM: 'numeralwords_language_num'};
  _languageList!.addAll(NUMERALWORDS_LANGUAGES);

  bool _alreadyFound = false;
  List<String> decodeText;

  if (decodeModeWholeWords) {
    // search only whole words

    String? helpText;
    String? helpText1;
    String inputToDecode;

    // simplify input
    input = input.replaceAll(RegExp(r'\s+'), ' ');

    // trim korean
    input = input
        .replaceAll('hah - nah', 'hah-nah')
        .replaceAll('dah suht', 'dahsuht')
        .replaceAll('yuh suht', 'yuhsuht')
        .replaceAll('eel gob', 'eelgob')
        .replaceAll('yuh duh', 'yuhduh')
        .replaceAll('ah hob', 'ahhob')
        .replaceAll('-sip', 'sip')
        .replaceAll('sip-', 'sip')
        .replaceAll('yeol-', 'yeol');

    // trim Klingon
    // identify west
    expr = RegExp(r"(ting 'ev|'ev ting)");
    if (expr.hasMatch(input)) {
      helpText = input.replaceAllMapped(expr, (Match m) {
        return m.group(0)!.replaceAll(' ', '');
      });
      input = helpText;
    }

    // identify complex klingon numbers
    //expr = RegExp(r"((wa'|cha'|wej|los|vagh|jav|soch|chorgh|hut)( |-)?(bip|netlh|sad|sanid|vatlh|mah))+( |-)?(wa'|cha'|wej|los|vagh|jav|soch|chorgh|hut)?\s");
    expr = RegExp(
        r"((wa'|cha'|wej|los|vagh|jav|soch|chorgh|hut)(bip|netlh|sad|sanid|vatlh|mah)[ -]?)+(wa'|cha'|wej|los|vagh|jav|soch|chorgh|hut)?(\s|$)");
    if (expr.hasMatch(input)) {
      helpText = input.replaceAllMapped(expr, (Match m) {
        return _complexMultipleKlingon(m.group(0)!);
      });
      input = helpText;
    }

    // identify single digits - change "-" to " "
    expr =
        RegExp(r"(pagh|wa'|cha'|wej|los|vagh|jav|soch|chorgh|hut)(-(pagh|wa'|cha'|wej|los|vagh|jav|soch|chorgh|hut))+");
    if (expr.hasMatch(input)) {
      helpText = input.replaceAllMapped(expr, (Match m) {
        return m.group(0)!.replaceAll('-', ' ');
      });
      input = helpText;
    }

    // trim english: identify correct numeral words and remove spaces
    expr = RegExp(
        '(one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|thirteen|fourteen|fifteen|sixteen|seventeen|eighteen|nineteen)[ ](hundred|thousand)');
    if (expr.hasMatch(input)) {
      helpText1 = input.replaceAllMapped(expr, (Match m) {
        return m.group(0)!.replaceAll(' ', '');
      });
    } else {
      helpText1 = input;
    }

    if (helpText1.startsWith('a hundred')) {
      helpText = helpText1.replaceFirst('a hundred', 'onehundred');
    } else if (helpText1.startsWith('a thousand')) {
      helpText = helpText1.replaceFirst('a thousand', ' a thousand');
    } else {
      helpText = helpText1;
    }

    // trim esperanto : identify correct numeral words and remove spaces
    expr = RegExp('cent( )(unu|du|tri|kvar|kvin|ses|sep|ok|nau|dek)');
    if (expr.hasMatch(helpText)) {
      helpText1 = helpText.replaceAllMapped(expr, (Match m) {
        return m.group(0)!.replaceAll(' ', '');
      });
    } else {
      helpText1 = helpText;
    }

    expr = RegExp('dek( )(unu|du|tri|kvar|kvin|ses|sep|ok|nau)');
    if (expr.hasMatch(helpText1)) {
      helpText = helpText1.replaceAllMapped(expr, (Match m) {
        return m.group(0)!.replaceAll(' ', '');
      });
    } else {
      helpText = helpText1;
    }

    // trim solresol : identify correct numeral words and remove spaces
    // 1st trim: SOL_farere => SOLfarere_
    expr = RegExp(r'(redodo|remimi|refafa|resolsol|relala|resisi|mimido|mimire|mimifa) farere');
    if (expr.hasMatch(helpText)) {
      helpText1 = helpText.replaceAllMapped(expr, (Match m) {
        return (m.group(0) != ' ') ? m.group(0)!.replaceAll(' ', '') : '';
      });
    } else {
      helpText1 = helpText;
    }

    // 2nd trim:
    expr = RegExp(
        r'(fafare|fafami|fafasol|fafala|fafasi|fadodo) (mimisol|mimila|mimisi|midodo|mirere|mifafa|misolsol|milala|misisi|fafado|redodo|remimi|refafa|resolsol|relala|resisi|mimido|mimire|mimifa)');
    if (expr.hasMatch(helpText1)) {
      helpText = helpText1.replaceAllMapped(expr, (Match m) {
        return (m.group(0) != ' ') ? m.group(0)!.replaceAll(' ', '') : '';
      });
    } else {
      helpText = helpText1;
    }

    expr = RegExp(r'mimisol (redodo|remimi|refafa|resolsol|relala|resisi|mimido|mimire|mimifa)');
    if (expr.hasMatch(helpText)) {
      helpText1 = helpText.replaceAllMapped(expr, (Match m) {
        return (m.group(0) != ' ') ? m.group(0)!.replaceAll(' ', '') : '';
      });
    } else {
      helpText1 = helpText;
    }

    // 3rd trim: SOLfarere_SOL => SOLfarereSOL
    expr = RegExp(
        r'(redodo|remimi|refafa|resolsol|relala|resisi|mimido|mimire|mimifa)farere (fafare|fafami|fafasol|fafala|fafasi|fadodo|mimisol|mimila|mimisi|midodo|mirere|mifafa|misolsol|milala|misisi|fafado|redodo|remimi|refafa|resolsol|relala|resisi|mimido|mimire|mimifa)');
    if (expr.hasMatch(helpText1)) {
      helpText = helpText1.replaceAllMapped(expr, (Match m) {
        return (m.group(0) != ' ') ? m.group(0)!.replaceAll(' ', '') : '';
      });
    } else {
      helpText = helpText1;
    }

    //4th trim: famimi_SOL => SOLfamimiSOL
    expr = RegExp(
        r'famimi (farere|fafare|fafami|fafasol|fafala|fafasi|fadodo|mimisol|mimila|mimisi|midodo|mirere|mifafa|misolsol|milala|misisi|fafado|redodo|remimi|refafa|resolsol|relala|resisi|mimido|mimire|mimifa)');
    if (expr.hasMatch(helpText)) {
      helpText1 = helpText.replaceAllMapped(expr, (Match m) {
        return (m.group(0) != ' ') ? m.group(0)!.replaceAll(' ', '') : '';
      });
    } else {
      helpText1 = helpText;
    }

    // 5th trim: SOL_famimi => SOLfamimi
    expr = RegExp(
        r'(farere|fafare|fafami|fafasol|fafala|fafasi|fadodo|mimisol|mimila|mimisi|midodo|mirere|mifafa|misolsol|milala|misisi|fafado|redodo|remimi|refafa|resolsol|relala|resisi|mimido|mimire|mimifa) famimi');
    if (expr.hasMatch(helpText1)) {
      helpText = helpText1.replaceAllMapped(expr, (Match m) {
        return (m.group(0) != ' ') ? m.group(0)!.replaceAll(' ', '') : '';
      });
    } else {
      helpText = helpText1;
    }

    // trim esperanto: identify correct numeral words and remove spaces
    expr = RegExp(
        r'(.*unu|.*du|.*tri|.*kvar|.*kvin|.*ses|.*sep|.*ok|.*nau)( )mil(( )(unu.*|du.*|tri.*|kvar.*|kvin.*|ses.*|spe.*|ok.*|nau.*))?');
    if (expr.hasMatch(helpText)) {
      helpText1 = helpText.replaceAllMapped(expr, (Match m) {
        return m.group(0)!.replaceAll(' ', '');
      });
    } else {
      helpText1 = helpText;
    }

    // trim german
    inputToDecode = helpText1
        .replaceAll('zehnten', 'zehn')
        .replaceAll('zehnter', 'zehn')
        .replaceAll('zehnte', 'zehn')
        .replaceAll('zigsten', 'zig')
        .replaceAll('zigster', 'zig')
        .replaceAll('zigste', 'zig')
        .replaceAll('hundertsten', 'hundert')
        .replaceAll('hundertster', 'hundert')
        .replaceAll('hundertste', 'hundert')
        .replaceAll('tausendsten', 'tausend')
        .replaceAll('tausendster', 'tausend')
        .replaceAll('tausendste', 'tausend')
        .replaceAll(' a hundred', ' onehundred')
        .replaceAll(' hundred ', 'hundred ')
        .replaceAll('hundred and ', 'hundred')
        .replaceAll(' a thousand', ' onethousand')
        .replaceAll(' thousand', 'thousand')
        .replaceAll('thousand and ', 'thousand')
        .replaceAll('einhundert', 'einshundert')
        .replaceAll('eintausend', 'einstausend')
        .replaceAll('hundertund', 'hundert')
        .replaceAll('tausendund', 'tausend')
        .replaceAll('mil ', 'mil');

    // build map to identify numeral words
    var searchLanguages = <NumeralWordsLanguage, Map<String, String>>{};
    if (language == NumeralWordsLanguage.ALL) {
      // search element in all languages
      NUMERAL_WORDS.forEach((key, value) {
        // key: language  value: map
        var sKey = key;
        var sValue = <String, String>{};
        value.forEach((key, value) {
          sValue[removeAccents(key.toLowerCase())] = value;
        });
        searchLanguages[sKey] = sValue;
      });
    } else {
      // search only in one language
      var sValue = <String, String>{};
      NUMERAL_WORDS[language]!.forEach((key, value) {
        sValue[removeAccents(key.toLowerCase())] = value;
      });
      searchLanguages[language] = sValue;
    }

    // check degree ° and dot .
    inputToDecode = inputToDecode.replaceAll('°', ' ° ').replaceAll('.', ' . ').replaceAll('  ', ' ');
    // start decoding
    decodeText = inputToDecode.split(RegExp(r'[ ]'));
    for (var element in decodeText) {
      _alreadyFound = false;
      if (element != '') {
        if (element == '°') {
          output.add(NumeralWordsDecodeOutput(element, element, ''));
        } else if (element == '.') {
          output.add(NumeralWordsDecodeOutput(element, element, ''));
        } else if (_isShadoks(element) &&
            (language == NumeralWordsLanguage.ALL || language == NumeralWordsLanguage.SHA)) {
          output.add(NumeralWordsDecodeOutput(
              _decodeShadoks(element), element, _languageList?[NumeralWordsLanguage.SHA] ?? ''));
        } else if (_isMinion(element) &&
            (language == NumeralWordsLanguage.ALL || language == NumeralWordsLanguage.MIN)) {
          output.add(NumeralWordsDecodeOutput(
              _decodeMinion(element), element, _languageList?[NumeralWordsLanguage.MIN] ?? ''));
        } else if (_isKlingon(element) &&
            (language == NumeralWordsLanguage.ALL || language == NumeralWordsLanguage.KLI)) {
          output.add(NumeralWordsDecodeOutput(_decodeKlingon(element), element.replaceAll('€', ' ').trim(),
              _languageList?[NumeralWordsLanguage.KLI] ?? ''));
        } else if (_isNavi(element) &&
            (language == NumeralWordsLanguage.ALL || language == NumeralWordsLanguage.NAVI)) {
          output.add(
              NumeralWordsDecodeOutput(_decodeNavi(element), element, _languageList?[NumeralWordsLanguage.NAVI] ?? ''));
        } else if (_isNumeral(element)) {
          // checks - if is a number/digit
          output.add(NumeralWordsDecodeOutput(element, element, _languageList?[NumeralWordsLanguage.NUM] ?? ''));
        } else {
          _alreadyFound = false;
          searchLanguages.forEach((key, value) {
            var result = _isNumeralWordTable(element, key, value); // checks - if element is part of a map
            if (result.state) {
              if (!_alreadyFound) {
                output.add(NumeralWordsDecodeOutput(result.output, element, _languageList?[key] ?? ''));
                _alreadyFound = true;
              } else {
                output.add(NumeralWordsDecodeOutput('', '', _languageList?[key] ?? ''));
              }
            } else {
              result = _isNumeralWord(element, key, value); // checks - if is a numeral word
              if (result.state) {
                output.add(NumeralWordsDecodeOutput(result.output, element, _languageList?[key] ?? ''));
              }
            }
          }); //forEach searchLanguage
        }
      }
    }
    //for each element to decode
    if (output.isEmpty) {
      output.add(NumeralWordsDecodeOutput('', '', 'numeralwords_language_empty'));
    }
    return output;
  } else {
    // entire parts - search parts of words: weight => eight => 8

    input = input
        .replaceAll(RegExp(r'[\s]'), '')
        .replaceAll('^', '')
        .replaceAll('°', '')
        .replaceAll('!', '')
        .replaceAll('"', '')
        .replaceAll('§', '')
        .replaceAll('\$', '')
        .replaceAll('%', '')
        .replaceAll('&', '')
        .replaceAll('/', '')
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll('=', '')
        .replaceAll('?', '')
        .replaceAll('´', '')
        .replaceAll('`', '')
        .replaceAll('{', '')
        .replaceAll('}', '')
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll('\\', '')
        .replaceAll('>', '')
        .replaceAll('<', '')
        .replaceAll('|', '')
        .replaceAll(';', '')
        .replaceAll(',', '')
        .replaceAll('.', '')
        .replaceAll(':', '')
        .replaceAll('-', '')
        .replaceAll('_', '')
        .replaceAll('#', '')
        .replaceAll("'", '')
        .replaceAll('+', '')
        .replaceAll('*', '')
        .replaceAll('~', '')
        .replaceAll('µ', '')
        .replaceAll('@', '')
        .replaceAll('€', '');
    for (int i = 0; i < input.length; i++) {
      String checkWord = input.substring(i);
      if (language == NumeralWordsLanguage.ALL) {
        // used by Numeral Words Language search
        _alreadyFound = false;
        int oldValueInt = 0;
        String oldValueStr = '';

        NUMERAL_WORDS.forEach((key, value) {
          // forEach language
          var _language = key;
          value.forEach((key, value) {
            // check language map
            if (_language == NumeralWordsLanguage.KLI) {
              key = key.replaceAll('-', '').replaceAll(' ', '').replaceAll("'", '');
            }
            if (checkWord.startsWith(removeAccents(key))) {
              if (!_alreadyFound) {
                _alreadyFound = true;
                if (int.tryParse(value) == null) {
                  oldValueStr = value;
                } else {
                  oldValueInt = int.parse(value);
                }
                output
                    .add(NumeralWordsDecodeOutput(value, removeAccents(key), NUMERALWORDS_LANGUAGES[_language] ?? ''));
              } else {
                if (int.tryParse(value) == null) {
                  if (oldValueStr == value) {
                    output
                        .add(NumeralWordsDecodeOutput('', removeAccents(key), NUMERALWORDS_LANGUAGES[_language] ?? ''));
                  } else {
                    output.add(
                        NumeralWordsDecodeOutput(value, removeAccents(key), NUMERALWORDS_LANGUAGES[_language] ?? ''));
                  }
                } else if (oldValueInt == int.parse(value)) {
                  output.add(NumeralWordsDecodeOutput('', removeAccents(key), NUMERALWORDS_LANGUAGES[_language] ?? ''));
                } else {
                  output.add(
                      NumeralWordsDecodeOutput(value, removeAccents(key), NUMERALWORDS_LANGUAGES[_language] ?? ''));
                }
              }
            }
          });
        });
      } else {
        // search for specific language
        _alreadyFound = false;
        NUMERAL_WORDS[language]!.forEach((key, value) {
          if (!_alreadyFound) {
            if (checkWord.startsWith(removeAccents(key))) {
              _alreadyFound = true;
              output.add(NumeralWordsDecodeOutput(value, removeAccents(key), NUMERALWORDS_LANGUAGES[language] ?? ''));
            }
          }
        });
      } // else
    } // for element

    if (output.isEmpty) {
      output.add(NumeralWordsDecodeOutput('', '', 'numeralwords_language_empty'));
    }
    return output;
  }
}

OutputConvertToNumber decodeNumeralWordToNumber(NumeralWordsLanguage _currentLanguage, String currentDecodeInput) {
  if (currentDecodeInput.isEmpty) return OutputConvertToNumber(number: 0, numbersystem: '', title: '', error: '');

  if (_currentLanguage == NumeralWordsLanguage.ROU) {
    if (_isROU(currentDecodeInput)) {
      String number = _decodeROU(currentDecodeInput);
      return OutputConvertToNumber(number: int.parse(number), numbersystem: number, title: '', error: '');
    } else {
      return OutputConvertToNumber(number: 0, numbersystem: '', title: '', error: 'numeralwords_converter_error_rou');
    }
  }
  if (_currentLanguage == NumeralWordsLanguage.NAVI) {
    if (_isNavi(currentDecodeInput)) {
      return OutputConvertToNumber(
          number: int.parse(_decodeNavi(currentDecodeInput)),
          numbersystem: convertBase(_decodeNavi(currentDecodeInput), 10, 8),
          title: 'common_numeralbase_octenary',
          error: '');
    } else {
      return OutputConvertToNumber(number: 0, numbersystem: '', title: '', error: 'numeralwords_converter_error_navi');
    }
  }
  if (_currentLanguage == NumeralWordsLanguage.SHA) {
    if (_isShadoks(currentDecodeInput)) {
      return OutputConvertToNumber(
          number: int.parse(_decodeShadoks(currentDecodeInput)),
          numbersystem: convertBase(_decodeShadoks(currentDecodeInput), 10, 4),
          title: 'common_numeralbase_quaternary',
          error: '');
    } else {
      return OutputConvertToNumber(
          number: 0, numbersystem: '', title: '', error: 'numeralwords_converter_error_shadoks');
    }
  } else if (_currentLanguage == NumeralWordsLanguage.MIN) {
    if (_isMinion(currentDecodeInput)) {
      return OutputConvertToNumber(
          number: int.parse(_decodeMinion(currentDecodeInput)), numbersystem: '', title: '', error: '');
    } else {
      return OutputConvertToNumber(
          number: 0, numbersystem: '', title: '', error: 'numeralwords_converter_error_minion');
    }
  } else if (_currentLanguage == NumeralWordsLanguage.KLI) {
    if (_isKlingon(currentDecodeInput)) {
      RegExp expr = RegExp(
          r"((wa'|cha'|wej|los|vagh|jav|soch|chorgh|hut)(bip|netlh|sad|sanid|vatlh|mah)[ -]?)+(wa'|cha'|wej|los|vagh|jav|soch|chorgh|hut)?(\s|$)");
      if (expr.hasMatch(currentDecodeInput)) {
        String helpText = currentDecodeInput.replaceAllMapped(expr, (Match m) {
          return _complexMultipleKlingon(m.group(0)!);
        });
        currentDecodeInput = helpText;
      }
      return OutputConvertToNumber(
          number: int.parse(_decodeMultipleKlingon(currentDecodeInput.replaceAll(' ', ''))),
          numbersystem: '',
          title: '',
          error: '');
    } else {
      return OutputConvertToNumber(
          number: 0, numbersystem: '', title: '', error: 'numeralwords_converter_error_klingon');
    }
  } else {
    return OutputConvertToNumber(number: 0, numbersystem: '', title: '', error: '');
  }
}

OutputConvertToNumeralWord encodeNumberToNumeralWord(NumeralWordsLanguage _currentLanguage, int currentNumber) {
  switch (_currentLanguage) {
    case NumeralWordsLanguage.NAVI:
      return _encodeNavi(currentNumber);
    case NumeralWordsLanguage.SHA:
      return _encodeShadok(currentNumber);
    case NumeralWordsLanguage.MIN:
      return _encodeMinion(currentNumber);
    case NumeralWordsLanguage.KLI:
      return _encodeKlingon(currentNumber);
    case NumeralWordsLanguage.ROU:
      return _encodeROU(currentNumber);
    default:
      return OutputConvertToNumeralWord(numeralWord: '', targetNumberSystem: '', title: '', errorMessage: '');
  }
}

String _complexMultipleKlingon(String kliNumber) {
  return '€' + kliNumber.trim().replaceAll('-', '€').replaceAll(' ', '€') + '€ ';
}

String _decodeKlingon(String element) {
  if (element.isEmpty) return '';
  if (element[0] == '€' && element[element.length - 1] == '€') {
    return _decodeMultipleKlingon(element.substring(1, element.length - 1));
  }
  if (element == 'chan') return 'numeralwords_e';
  if (element == "ting'ev" || element == "'evting" || element == 'maH') return 'numeralwords_w';
  if (element == "'oy'") return 'numeralwords_n';
  if (element == 'watlh') return 'numeralwords_s';
  if (element == 'ngev' || element == 'ghob') return '.';
  if (element == 'qoch') return '°';
  String result = element
      .replaceAll('pagh', '0')
      .replaceAll("wa'", '1')
      .replaceAll("cha'", '2')
      .replaceAll('wej', '3')
      .replaceAll('los', '4')
      .replaceAll('vagh', '5')
      .replaceAll('jav', '6')
      .replaceAll('soch', '7')
      .replaceAll('chorgh', '8')
      .replaceAll('hut', '9')
      .replaceAll('mah', '0')
      .replaceAll('vatlh', '00')
      .replaceAll('sad', '000')
      .replaceAll('sanid', '000')
      .replaceAll('netlh', '0000')
      .replaceAll('bip', '00000');
  return result;
}

String _decodeMinion(String element) {
  int number = 0;
  element.replaceAll('hana', '1').replaceAll('dul', '2').replaceAll('sae', '3').split('').forEach((element) {
    number = number + int.parse(element);
  });
  return number.toString();
}

String _decodeMultipleKlingon(String kliNumber) {
  kliNumber = kliNumber.trim();
  if (kliNumber.isEmpty) return '';
  int number = 0;
  kliNumber.split('€').forEach((element) {
    if (int.tryParse(_decodeKlingon(element)) != null) number = number + int.parse(_decodeKlingon(element));
  });
  return number.toString();
}

String _decodeNavi(String element) {
  // https://de.wikipedia.org/wiki/Na%E2%80%99vi-Sprache#Zahlen
  // https://james-camerons-avatar.fandom.com/de/wiki/Oktale_Arithmetik
  // https://forum.learnnavi.org/navi-lernen/das-navi-zahlensystem/#:~:text=Das%20Na%27vi%20hat%20zwei%20Lehnw%C3%B6rter%20aus%20dem%20Englischen.,Ziffern%2C%20wie%20z.%20B.%20Telefonnummern%2C%20Autokennzeichen%2C%20IDs%20etc.
  String octal = '';
  if (_NAVIWordToNum[element] != null) return (_NAVIWordToNum[element] ?? '');

  element = element
      .replaceAll('zame', 'zamme')
      .replaceAll('zavo', 'zamvo')
      .replaceAll('zapxe', 'zampxe')
      .replaceAll('zatsi', 'zamtsi')
      .replaceAll('zapu', 'zampu')
      .replaceAll('zamrr', 'zammrr')
      .replaceAll('zaki', 'zamki')
      .replaceAll('zasing', 'zamsing')
      .replaceAll('voaw', 'volaw')
      .replaceAll('vomun', 'volmun')
      .replaceAll('vopey', 'volpey')
      .replaceAll('vosing', 'volsing')
      .replaceAll('vomrr', 'volmrr')
      .replaceAll('vofu', 'volfu')
      .replaceAll('vohin', 'volhin');

  // check 4096
  if (element.contains('kizazam') ||
      element.contains('puzazam') ||
      element.contains('mrrzazam') ||
      element.contains('tsizazam') ||
      element.contains('pxezazam') ||
      element.contains('mezazam') ||
      element.contains('zazam')) {
    if (element.contains('kizazam')) {
      octal = '7';
      element = element.replaceAll('kizazam', '');
    } else if (element.contains('puzazam')) {
      octal = '6';
      element = element.replaceAll('puzazam', '');
    } else if (element.contains('mrrzazam')) {
      octal = '5';
      element = element.replaceAll('mrrzazam', '');
    } else if (element.contains('tsizazam')) {
      octal = '4';
      element = element.replaceAll('tsizazam', '');
    } else if (element.contains('pxezazam')) {
      octal = '3';
      element = element.replaceAll('pxezazam', '');
    } else if (element.contains('mezazam')) {
      octal = '2';
      element = element.replaceAll('mezazam', '');
    } else if (element.contains('zazam')) {
      octal = '1';
      element = element.replaceAll('zazam', '');
    }
  } else {
    octal = '0';
  }

  // check 512
  if (element.contains('kivozam') ||
      element.contains('puvozam') ||
      element.contains('mrrvozam') ||
      element.contains('tsivozam') ||
      element.contains('pxevozam') ||
      element.contains('mevozam') ||
      element.contains('vozam')) {
    if (element.contains('kivozam')) {
      octal = octal + '7';
      element = element.replaceAll('kivozam', '');
    } else if (element.contains('puvozam')) {
      octal = octal + '6';
      element = element.replaceAll('puvozam', '');
    } else if (element.contains('mrrvozam')) {
      octal = octal + '5';
      element = element.replaceAll('mrrvozam', '');
    } else if (element.contains('tsivozam')) {
      octal = octal + '4';
      element = element.replaceAll('tsivozam', '');
    } else if (element.contains('pxevozam')) {
      octal = octal + '3';
      element = element.replaceAll('pxevozam', '');
    } else if (element.contains('mevozam')) {
      octal = octal + '2';
      element = element.replaceAll('mevozam', '');
    } else if (element.contains('vozam')) {
      octal = octal + '1';
      element = element.replaceAll('vozam', '');
    }
  } else {
    octal = octal + '0';
  }

  // check 64
  if (element.contains('kizam') ||
      element.contains('puzam') ||
      element.contains('mrrzam') ||
      element.contains('tsizam') ||
      element.contains('pxezam') ||
      element.contains('mezam') ||
      element.contains('zam')) {
    if (element.contains('kizam')) {
      octal = octal + '7';
      element = element.replaceAll('kizam', '');
    } else if (element.contains('puzam')) {
      octal = octal + '6';
      element = element.replaceAll('puzam', '');
    } else if (element.contains('mrrzam')) {
      octal = octal + '5';
      element = element.replaceAll('mrrzam', '');
    } else if (element.contains('tsizam')) {
      octal = octal + '4';
      element = element.replaceAll('tsizam', '');
    } else if (element.contains('pxezam')) {
      octal = octal + '3';
      element = element.replaceAll('pxezam', '');
    } else if (element.contains('mezam')) {
      octal = octal + '2';
      element = element.replaceAll('mezam', '');
    } else if (element.contains('zam')) {
      octal = octal + '1';
      element = element.replaceAll('zam', '');
    }
  } else {
    octal = octal + '0';
  }

  // check 8
  if (element.contains('kivol') ||
      element.contains('puvol') ||
      element.contains('mrrvol') ||
      element.contains('tsivol') ||
      element.contains('pxevol') ||
      element.contains('mevol') ||
      element.contains('vol')) {
    if (element.contains('kivol')) {
      octal = octal + '7';
      element = element.replaceAll('kivol', '');
    } else if (element.contains('puvol')) {
      octal = octal + '6';
      element = element.replaceAll('puvol', '');
    } else if (element.contains('mrrvol')) {
      octal = octal + '5';
      element = element.replaceAll('mrrvol', '');
    } else if (element.contains('tsivol')) {
      octal = octal + '4';
      element = element.replaceAll('tsivol', '');
    } else if (element.contains('pxevol')) {
      octal = octal + '3';
      element = element.replaceAll('pxevol', '');
    } else if (element.contains('mevol')) {
      octal = octal + '2';
      element = element.replaceAll('mevol', '');
    } else if (element.contains('vol')) {
      octal = octal + '1';
      element = element.replaceAll('vol', '');
    }
  } else {
    octal = octal + '0';
  }

  // check 1
  if (element.contains('hin') ||
      element.contains('fu') ||
      element.contains('mrr') ||
      element.contains('sing') ||
      element.contains('pey') ||
      element.contains('mun') ||
      element.contains('aw')) {
    if (element.contains('hin')) {
      octal = octal + '7';
    } else if (element.contains('fu')) {
      octal = octal + '6';
    } else if (element.contains('mrr')) {
      octal = octal + '5';
    } else if (element.contains('sing')) {
      octal = octal + '4';
    } else if (element.contains('pey')) {
      octal = octal + '3';
    } else if (element.contains('mun')) {
      octal = octal + '2';
    } else if (element.contains('aw')) {
      octal = octal + '1';
    }
  } else {
    octal = octal + '0';
  }

  return convertBase(octal, 8, 10);
}

String _decodeROU(String element) {
  int decodeTripel(String element, Map<String, String> ROU_numbers) {
    List<String> syllables = [];

    int decodeTupel(String element, Map<String, String> ROU_numbers) {
      if (element.contains('sprezece')) return int.parse((ROU_numbers[element.trim()] ?? ''));

      syllables = element.split('si');
      if (syllables.length == 2) {
        return int.parse((ROU_numbers[syllables[0].trim()] ?? '')) +
            int.parse((ROU_numbers[syllables[1].trim()] ?? ''));
      } else {
        return int.parse((ROU_numbers[syllables[0].trim()] ?? ''));
      }
    }

    if (element.contains('o suta')) return 100 + decodeTupel(element.trim(), ROU_numbers);

    if (element.contains('sute')) {
      // element > 199
      syllables = element.split('sute');
      return int.parse((ROU_numbers[syllables[0].trim()] ?? '')) * 100 + decodeTupel(syllables[1].trim(), ROU_numbers);
    }

    return decodeTupel(element.trim(), ROU_numbers);
  }

  List<String> syllables = [];
  if (element.contains('de mii')) {
    syllables = element.split('de mii');
  } else {
    syllables = element.split('mii');
  }
  Map<String, String> ROU_numbers = _normalize(_ROUWordToNum);
  if (syllables.length == 1) {
    return decodeTripel(syllables[0].trim(), ROU_numbers).toString();
  } else {
    return (decodeTripel(syllables[0].trim(), ROU_numbers) * 1000 + decodeTripel(syllables[1].trim(), ROU_numbers))
        .toString();
  }
}

String _decodeShadoks(String element) {
  return convertBase(
      element.replaceAll('ga', '0').replaceAll('bu', '1').replaceAll('zo', '2').replaceAll('meu', '3'), 4, 10);
}

OutputConvertToNumeralWord _encodeKlingon(int currentNumber) {
  String numeralWord = '';
  numeralWord = '';
  if (currentNumber == 0) {
    return OutputConvertToNumeralWord(numeralWord: 'pagh', targetNumberSystem: '', title: '', errorMessage: '');
  }

  bool negative = false;
  if (currentNumber < 0) {
    negative = true;
    currentNumber = -1 * currentNumber;
  }
  int tenth = (pow(10, (currentNumber.toString().length - 1))).toInt();
  while (currentNumber > 0) {
    switch (currentNumber ~/ tenth) {
      case 0:
        numeralWord = numeralWord + "pagh";
        break;
      case 1:
        numeralWord = numeralWord + "wa'";
        break;
      case 2:
        numeralWord = numeralWord + "cha'";
        break;
      case 3:
        numeralWord = numeralWord + "wej";
        break;
      case 4:
        numeralWord = numeralWord + "loS";
        break;
      case 5:
        numeralWord = numeralWord + "vagh";
        break;
      case 6:
        numeralWord = numeralWord + "jav";
        break;
      case 7:
        numeralWord = numeralWord + "Soch";
        break;
      case 8:
        numeralWord = numeralWord + "chorgh";
        break;
      case 9:
        numeralWord = numeralWord + "Hut";
        break;
    }
    switch (tenth) {
      case 10:
        numeralWord = numeralWord + "maH ";
        break;
      case 100:
        numeralWord = numeralWord + "vatlh ";
        break;
      case 1000:
        numeralWord = numeralWord + "SaD ";
        break;
      case 10000:
        numeralWord = numeralWord + "SanID ";
        break;
      case 100000:
        numeralWord = numeralWord + "netlh ";
        break;
      case 1000000:
        numeralWord = numeralWord + "bIp ";
        break;
      case 10000000:
        numeralWord = numeralWord + "'uy' ";
        break;
      case 100000000:
        numeralWord = numeralWord + "Saghan ";
        break;
    }
    currentNumber = currentNumber % tenth;
    tenth = tenth ~/ 10;
  }
  if (negative) numeralWord = numeralWord + ' Dop';
  return OutputConvertToNumeralWord(numeralWord: numeralWord, targetNumberSystem: '', title: '', errorMessage: '');
}

OutputConvertToNumeralWord _encodeMinion(int currentNumber) {
  String numeralWord = '';
  if (currentNumber < 1) {
    return OutputConvertToNumeralWord(numeralWord: '', targetNumberSystem: '', title: '', errorMessage: '');
  }
  List<String> digits = [];
  numeralWord = '';
  while (currentNumber >= 3) {
    currentNumber = currentNumber - 3;
    digits.add('3');
  }
  while (currentNumber >= 2) {
    currentNumber = currentNumber - 2;
    digits.add('2');
  }
  while (currentNumber >= 1) {
    currentNumber = currentNumber - 1;
    digits.add('1');
  }
  numeralWord = digits.join('').replaceAll('3', 'SAE').replaceAll('2', 'DUL').replaceAll('1', 'HANA');
  return OutputConvertToNumeralWord(numeralWord: numeralWord, targetNumberSystem: '', title: '', errorMessage: '');
}

OutputConvertToNumeralWord _encodeNavi(int currentNumber) {
  String numeralWord = '';
  String octal = '';
  if (0 <= currentNumber && currentNumber <= 7) {
    switch (currentNumber) {
      case 0:
        numeralWord = 'kew';
        break;
      case 1:
        numeralWord = "'aw";
        break;
      case 2:
        numeralWord = 'mune';
        break;
      case 3:
        numeralWord = 'pxey';
        break;
      case 4:
        numeralWord = 'tsìng';
        break;
      case 5:
        numeralWord = 'mrr';
        break;
      case 6:
        numeralWord = 'pukap';
        break;
      case 7:
        numeralWord = 'kinä';
        break;
    }
  } else {
    octal = convertBase(currentNumber.toString(), 10, 8);
    while (octal.length < 5) {
      octal = '0' + octal;
    }
    switch (octal[0]) {
      //  4096
      case '0':
        numeralWord = '';
        break;
      case '1':
        numeralWord = 'zazam';
        break;
      case '2':
        numeralWord = 'mezazam';
        break;
      case '3':
        numeralWord = 'pxezazam';
        break;
      case '4':
        numeralWord = 'tsìzazam';
        break;
      case '5':
        numeralWord = 'mrrzazam';
        break;
      case '6':
        numeralWord = 'puzazam';
        break;
      case '7':
        numeralWord = 'kizazam';
        break;
    }
    switch (octal[1]) {
      // 512
      case '0':
        numeralWord = numeralWord + '';
        break;
      case '1':
        numeralWord = numeralWord + 'vozam';
        break;
      case '2':
        numeralWord = numeralWord + 'mevozam';
        break;
      case '3':
        numeralWord = numeralWord + 'pxevozam';
        break;
      case '4':
        numeralWord = numeralWord + 'tsìvozam';
        break;
      case '5':
        numeralWord = numeralWord + 'mrrvozam';
        break;
      case '6':
        numeralWord = numeralWord + 'puvozam';
        break;
      case '7':
        numeralWord = numeralWord + 'kivozam';
        break;
    }
    switch (octal[2]) {
      // 64
      case '0':
        numeralWord = numeralWord + '';
        break;
      case '1':
        numeralWord = numeralWord + 'zam';
        break;
      case '2':
        numeralWord = numeralWord + 'mezam';
        break;
      case '3':
        numeralWord = numeralWord + 'pxezam';
        break;
      case '4':
        numeralWord = numeralWord + 'tsìzam';
        break;
      case '5':
        numeralWord = numeralWord + 'mrrzam';
        break;
      case '6':
        numeralWord = numeralWord + 'puzam';
        break;
      case '7':
        numeralWord = numeralWord + 'kizam';
        break;
    }
    if (octal[4] == '0') {
      switch (octal[3]) {
        // 8
        case '0':
          numeralWord = numeralWord + '';
          break;
        case '1':
          numeralWord = numeralWord + 'vol';
          break;
        case '2':
          numeralWord = numeralWord + 'mevol';
          break;
        case '3':
          numeralWord = numeralWord + 'pxevol';
          break;
        case '4':
          numeralWord = numeralWord + 'tsìvol';
          break;
        case '5':
          numeralWord = numeralWord + 'mrrvol';
          break;
        case '6':
          numeralWord = numeralWord + 'puvol';
          break;
        case '7':
          numeralWord = numeralWord + 'kivol';
          break;
      }
    } else {
      switch (octal[3]) {
        // 8
        case '0':
          numeralWord = numeralWord + '';
          break;
        case '1':
          numeralWord = numeralWord + 'vo';
          break;
        case '2':
          numeralWord = numeralWord + 'mevo';
          break;
        case '3':
          numeralWord = numeralWord + 'pxevo';
          break;
        case '4':
          numeralWord = numeralWord + 'tsìvo';
          break;
        case '5':
          numeralWord = numeralWord + 'mrrvo';
          break;
        case '6':
          numeralWord = numeralWord + 'puvo';
          break;
        case '7':
          numeralWord = numeralWord + 'kivo';
          break;
      }
    }
    switch (octal[4]) {
      // 1
      case '0':
        numeralWord = numeralWord + '';
        break;
      case '1':
        numeralWord = numeralWord + 'aw';
        break;
      case '2':
        numeralWord = numeralWord + 'mun';
        break;
      case '3':
        numeralWord = numeralWord + 'pey';
        break;
      case '4':
        numeralWord = numeralWord + 'sìng';
        break;
      case '5':
        numeralWord = numeralWord + 'mrr';
        break;
      case '6':
        numeralWord = numeralWord + 'fu';
        break;
      case '7':
        numeralWord = numeralWord + 'hin';
        break;
    }
  }
  // normalize - Hinweis: Das m von zam fällt weg, wenn der Rest mit einem Konsonant beginnt.
  numeralWord = numeralWord
      .replaceAll('zamk', 'zak')
      .replaceAll('zamp', 'zap')
      .replaceAll('zams', 'zas')
      .replaceAll('zamt', 'zat')
      .replaceAll('zamv', 'zav')
      .replaceAll('zamm', 'zam');

  // normalize - inweis: Das l von vol fällt weg, wenn der Rest mit einem Konsonant beginnt.
  numeralWord = numeralWord
      .replaceAll('volk', 'vok')
      .replaceAll('volp', 'vop')
      .replaceAll('volt', 'vot')
      .replaceAll('volm', 'vom')
      .replaceAll('voaw', 'volaw');

  return OutputConvertToNumeralWord(
      numeralWord: numeralWord,
      targetNumberSystem: convertBase(currentNumber.toString(), 10, 8),
      title: 'common_numeralbase_octenary',
      errorMessage: '');
}

OutputConvertToNumeralWord _encodeROU(int currentNumber) {
  String encodeTripel(int currentNumber, Map<String, String> ROU_numbers) {
    int hundred = 0;
    int ten = 0;
    int one = 0;

    if (currentNumber == 0) return '';

    if (currentNumber < 20) {
      return (ROU_numbers[currentNumber.toString()] ?? '');
    }

    if (currentNumber < 100) {
      if (currentNumber % 10 == 0) return (ROU_numbers[(currentNumber ~/ 10 * 10).toString()] ?? '');
      return (ROU_numbers[(currentNumber ~/ 10 * 10).toString()] ?? '') +
          ' şi ' +
          (ROU_numbers[(currentNumber % 10).toString()] ?? '');
    }

    if (currentNumber < 120) {
      currentNumber = currentNumber - 100;
      if (currentNumber == 0) return 'o sută';
      return 'o sută ' + (ROU_numbers[(currentNumber).toString()] ?? '');
    }

    if (currentNumber < 200) {
      currentNumber = currentNumber - 100;
      return 'o sută ' +
          (ROU_numbers[(currentNumber ~/ 10 * 10).toString()] ?? '') +
          ((currentNumber % 10 == 0) ? '' : ' şi ' + (ROU_numbers[(currentNumber % 10).toString()] ?? ''));
    }

    if (currentNumber % 100 == 0) return (ROU_numbers[(currentNumber ~/ 100).toString()] ?? '') + ' sute';

    hundred = currentNumber ~/ 100;
    ten = (currentNumber - (currentNumber ~/ 100) * 100) ~/ 10;
    one = currentNumber % 10;

    return (ROU_numbers[hundred.toString()] ?? '') +
        ' sute ' +
        (ten == 0
            ? (ROU_numbers[one.toString()] ?? '')
            : (ten == 1)
                ? (ROU_numbers[(ten * 10 + one).toString()] ?? '')
                : (ROU_numbers[(ten * 10).toString()] ?? '') +
                    (one == 0 ? '' : ' şi ' + (ROU_numbers[one.toString()] ?? '')));
  }

  Map<String, String> ROU_numbers = switchMapKeyValue(_ROUWordToNum);
  if (currentNumber < 20) {
    return OutputConvertToNumeralWord(
        numeralWord: (ROU_numbers[currentNumber.toString()] ?? ''),
        targetNumberSystem: currentNumber.toString(),
        title: '',
        errorMessage: '');
  }
  if (currentNumber < 100) {
    if (currentNumber % 10 == 0) {
      return OutputConvertToNumeralWord(
          numeralWord: (ROU_numbers[(currentNumber ~/ 10 * 10).toString()] ?? ''),
          targetNumberSystem: currentNumber.toString(),
          title: '',
          errorMessage: '');
    }
    return OutputConvertToNumeralWord(
        numeralWord: (ROU_numbers[(currentNumber ~/ 10 * 10).toString()] ?? '') +
            ' şi ' +
            (ROU_numbers[(currentNumber % 10).toString()] ?? ''),
        targetNumberSystem: currentNumber.toString(),
        title: '',
        errorMessage: '');
  }
  if (currentNumber < 1000) {
    return OutputConvertToNumeralWord(
        numeralWord: encodeTripel(currentNumber, ROU_numbers),
        targetNumberSystem: currentNumber.toString(),
        title: '',
        errorMessage: '');
  }
  if (currentNumber < 2000) {
    return OutputConvertToNumeralWord(
        numeralWord: 'oh mie ' + encodeTripel(currentNumber - 1000, ROU_numbers),
        targetNumberSystem: currentNumber.toString(),
        title: '',
        errorMessage: '');
  }
  if (currentNumber < 10000) {
    return OutputConvertToNumeralWord(
        numeralWord: (ROU_numbers[(currentNumber ~/ 1000).toString()] ?? '') +
            ' mii ' +
            encodeTripel(currentNumber % 1000, ROU_numbers),
        targetNumberSystem: currentNumber.toString(),
        title: '',
        errorMessage: '');
  }
  return OutputConvertToNumeralWord(
      numeralWord: encodeTripel(currentNumber ~/ 1000, ROU_numbers) +
          ' de mii ' +
          encodeTripel(currentNumber % 1000, ROU_numbers),
      targetNumberSystem: currentNumber.toString(),
      title: '',
      errorMessage: '');
}

OutputConvertToNumeralWord _encodeShadok(int currentNumber) {
  String numeralWord = '';
  numeralWord = convertBase(currentNumber.toString(), 10, 4)
      .toString()
      .replaceAll('0', 'GA')
      .replaceAll('1', 'BU')
      .replaceAll('2', 'ZO')
      .replaceAll('3', 'MEU');
  return OutputConvertToNumeralWord(
      numeralWord: numeralWord,
      targetNumberSystem: convertBase(currentNumber.toString(), 10, 4),
      title: 'common_numeralbase_quaternary',
      errorMessage: '');
}

bool _isKlingon(String element) {
  if (element != '') {
    return (element
            .replaceAll(' ', '')
            .replaceAll('€', '')
            .replaceAll('pagh', '')
            .replaceAll("wa'", '')
            .replaceAll("cha'", '')
            .replaceAll('wej', '')
            .replaceAll('los', '')
            .replaceAll('vagh', '')
            .replaceAll('jav', '')
            .replaceAll('soch', '')
            .replaceAll('chorgh', '')
            .replaceAll('hut', '')
            .replaceAll('mah', '')
            .replaceAll('vatlh', '')
            .replaceAll('sad', '')
            .replaceAll('sanid', '')
            .replaceAll('netlh', '')
            .replaceAll('bip', '')
            .replaceAll('chan', '') ==
        '');
  } else {
    return false;
  }
}

bool _isMinion(String element) {
  if (element != '') {
    return (element.replaceAll('hana', '').replaceAll('dul', '').replaceAll('sae', '').isEmpty);
  } else {
    return false;
  }
}

bool _isNavi(String element) {
  element = element
      //.replaceAll('zam', 'zamm')
      .replaceAll('zak', 'zamk')
      .replaceAll('zap', 'zamp')
      .replaceAll('zamr', 'zammr')
      .replaceAll('zas', 'zams')
      .replaceAll('zat', 'zamt')
      .replaceAll('zav', 'zamv')
      .replaceAll('zamu', 'zammu')
      .replaceAll('zame', 'zamme');
  if (element.endsWith('mm')) {
    element = element.substring(0, element.length - 1);
  }
  element = element
      .replaceAll('vok', 'volk')
      .replaceAll('vom', 'volm')
      .replaceAll('vop', 'volp')
      .replaceAll('vot', 'volt')
      .replaceAll('voz', 'volz')
      .replaceAll('volaw', 'volaw');

  element = element
      .replaceAll('mezazam', '')
      .replaceAll('pxezazam', '')
      .replaceAll('tsizazam', '')
      .replaceAll('mrrzazam', '')
      .replaceAll('puzazam', '')
      .replaceAll('kizazam', '')
      .replaceAll('zazam', '')
      .replaceAll('mevozam', '')
      .replaceAll('pxevozam', '')
      .replaceAll('tsivozam', '')
      .replaceAll('mrrvozam', '')
      .replaceAll('puvozam', '')
      .replaceAll('kivozam', '')
      .replaceAll('vozam', '')
      .replaceAll('mezam', '')
      .replaceAll('pxezam', '')
      .replaceAll('tsizam', '')
      .replaceAll('mrrzam', '')
      .replaceAll('puzam', '')
      .replaceAll('kizam', '')
      .replaceAll('zam', '')
      .replaceAll('mevol', '')
      .replaceAll('pxevol', '')
      .replaceAll('tsivol', '')
      .replaceAll('mrrvol', '')
      .replaceAll('puvol', '')
      .replaceAll('kivol', '')
      .replaceAll('vol', '')
      .replaceAll('mevo', '')
      .replaceAll('pxevo', '')
      .replaceAll('tsivo', '')
      .replaceAll('mrrvo', '')
      .replaceAll('puvo', '')
      .replaceAll('kivo', '')
      .replaceAll('vo', '')
      .replaceAll('kew', '')
      .replaceAll('aw', '')
      .replaceAll('mune', '')
      .replaceAll('mun', '')
      .replaceAll('mrr', '')
      .replaceAll('peysing', '')
      .replaceAll('pxey', '')
      .replaceAll('pey', '')
      .replaceAll('fu', '')
      .replaceAll('hin', '')
      .replaceAll('tsing', '')
      .replaceAll('pukap', '')
      .replaceAll('kinae', '')
      .replaceAll('sing', '')
      .replaceAll('za', '')
      .replaceAll('ki', '');
  return (element.isEmpty);
}

bool _isNumeral(String input) {
  return (int.tryParse(input) != null);
}

bool _isROU(String element) {
  if (element != '') {
    element = element
        .replaceAll(' ', '')
        .replaceAll('zero', '')
        .replaceAll('unu', '')
        .replaceAll('una', '')
        .replaceAll('doi', '')
        .replaceAll('doua', '')
        .replaceAll('trei', '')
        .replaceAll('patru', '')
        .replaceAll('cinci', '')
        .replaceAll('sase', '')
        .replaceAll('sapte', '')
        .replaceAll('opt', '')
        .replaceAll('noua', '')
        .replaceAll('zece', '')
        .replaceAll('spre', '')
        .replaceAll('pai', '')
        .replaceAll('si', '')
        .replaceAll('un', '')
        .replaceAll('zeci', '')
        .replaceAll('o suta', '')
        .replaceAll('sute', '')
        .replaceAll('apte', '')
        .replaceAll('oh mie', '')
        .replaceAll('dou', '')
        .replaceAll('de', '')
        .replaceAll('sai', '')
        .replaceAll('mii', '');

    return (element.isEmpty);
  }
  return false;
}

bool _isShadoks(String element) {
  if (element != '') {
    if (element.replaceAll('ga', '').replaceAll('bu', '').replaceAll('zo', '').replaceAll('meu', '') == '') {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}

NumeralWordsOutput _isNumeralWord(String input, NumeralWordsLanguage language, Map<String, String> decodingTable) {
  bool state = false;
  String output = '';
  String pattern = '';
  int numberBefore = 0;
  int numberAfter = 0;
  NumeralWordsOutput resultBefore;
  NumeralWordsOutput resultAfter;
  switch (language) {
    case NumeralWordsLanguage.DEU:
    case NumeralWordsLanguage.ENG:
    case NumeralWordsLanguage.VOL:
    case NumeralWordsLanguage.EPO:
    case NumeralWordsLanguage.SOL:
      switch (language) {
        case NumeralWordsLanguage.DEU:
          pattern = 'tausend';
          break;
        case NumeralWordsLanguage.SOL:
          pattern = 'famimi';
          break;
        case NumeralWordsLanguage.ENG:
          pattern = 'thousand';
          break;
        case NumeralWordsLanguage.VOL:
        case NumeralWordsLanguage.EPO:
          pattern = 'mil';
          break;
        default:
      }
      if (input.contains(pattern)) {
        // numeral word contains 1000
        List<String> decode = input.split(pattern);
        if (decode.length == 2) {
          if (decode[0].isEmpty) {
            resultBefore = NumeralWordsOutput(true, '1', _languageList?[language] ?? '');
          } else {
            resultBefore = _isNumeralWordBelow1000(decode[0], language, decodingTable);
          }

          if (decode[1].isEmpty) {
            resultAfter = NumeralWordsOutput(true, '0', _languageList?[language] ?? '');
          } else {
            resultAfter = _isNumeralWordBelow1000(decode[1], language, decodingTable);
          }

          if (resultBefore.state && resultAfter.state) {
            state = true;
            numberBefore = int.parse(resultBefore.output) * 1000;
            numberAfter = int.parse(resultAfter.output);
            output = (numberBefore + numberAfter).toString();
          }
        } else {
          resultBefore = _isNumeralWordBelow1000(decode[0], language, decodingTable);
          if (resultBefore.state) {
            state = true;
            output = resultBefore.output;
          }
        }
      } else {
        resultBefore = _isNumeralWordBelow1000(input, language, decodingTable);
        if (resultBefore.state) {
          state = true;
          output = resultBefore.output;
        }
      }
      break;
    default:
  }
  return NumeralWordsOutput(state, output, _languageList?[language] ?? '');
} // _isNumeralWord

NumeralWordsOutput _isNumeralWord10(String input, NumeralWordsLanguage language, Map<String, String> decodingTable) {
  bool state = false;
  String output = '';
  int orderOne = 0;
  int orderTen = 0;
  RegExp expr;
  if (language == NumeralWordsLanguage.DEU) {
    var pattern =
        '(ein|zwei|drei|vier|fuenf|sechs|sieben|acht|neun)(und)(zwanzig|dreissig|vierzig|fuenfzig|sechzig|siebzig|achtzig|neunzig)';
    expr = RegExp(pattern);
    if (expr.hasMatch(input)) {
      state = true;
      var matches = expr.firstMatch(input)!;
      if (matches.group(1) == 'ein') {
        orderOne = 1;
      } else {
        orderOne = int.parse(decodingTable[matches.group(1)] ?? '');
      }
      orderTen = int.parse(decodingTable[matches.group(3)] ?? '');
      output = (orderTen + orderOne).toString();
    }
  } else if (language == NumeralWordsLanguage.ENG) {
    expr = RegExp(
        r'(twenty|thirty|fourty|fifty|sixty|seventy|eighty|ninety)[-]?(one|two|three|four|five|six|seven|eight|nine)');
    if (expr.hasMatch(input)) {
      state = true;
      var matches = expr.firstMatch(input)!;
      orderOne = int.parse(decodingTable[matches.group(2)] ?? '');
      orderTen = int.parse(decodingTable[matches.group(1)] ?? '');
      output = (orderTen + orderOne).toString();
    }
  } else if (language == NumeralWordsLanguage.VOL) {
    RegExp expr = RegExp('(bal|tel|kil|fol|lul|mael|vel|joel|zuel)?(deg)(bal|tel|kil|fol|lul|mael|vel|joel|zuel)?');
    if (expr.hasMatch(input)) {
      state = true;
      var matches = expr.firstMatch(input)!;
      if (matches.group(1) != null) orderTen = int.parse(decodingTable[matches.group(1)] ?? '');
      if (matches.group(3) != null) orderOne = int.parse(decodingTable[matches.group(3)] ?? '');
      output = (orderTen * 10 + orderOne).toString();
    }
  } else if (language == NumeralWordsLanguage.EPO) {
    expr = RegExp('(unu|du|tri|kvar|kvin|ses|sep|ok|nau)?(dek)(unu|du|tri|kvar|kvin|ses|spe|ok|nau)?');
    if (expr.hasMatch(input)) {
      state = true;
      var matches = expr.firstMatch(input)!;
      if (matches.group(1) != null) orderTen = int.parse(decodingTable[matches.group(1)] ?? '');
      if (matches.group(3) != null) orderOne = int.parse(decodingTable[matches.group(3)] ?? '');
      output = (orderTen * 10 + orderOne).toString();
    }
  } else if (language == NumeralWordsLanguage.SOL) {
    expr = RegExp(
        r'^(mimisol|fafare|fafami|fafasol|fafala|fafasi|fafasimimisol|fadodo|fadodomimisol)?(redodo|remimi|refafa|resolsol|relala|resisi|mimido|mimire|mimifa|mimila|mimisi|midodo|mirere|mifafa|misolsol|milala|misisi|fafado)$');
    if (expr.hasMatch(input)) {
      state = true;
      var matches = expr.firstMatch(input)!;
      if (matches.group(1) != null) {
        if (matches.group(1) == 'fafasimimisol' || matches.group(1) == 'fadodomimisol') {
          orderTen = int.parse(decodingTable[matches.group(1)!.replaceAll('mimisol', ' mimisol')] ?? '');
        } else {
          orderTen = int.parse(decodingTable[matches.group(1)] ?? '');
        }
      }
      if (matches.group(2) != null) orderOne = int.parse(decodingTable[matches.group(2)] ?? '');
      output = (orderTen + orderOne).toString();
    }
  }

  return NumeralWordsOutput(state, output, _languageList?[language]);
}

NumeralWordsOutput _isNumeralWordBelow100(
    String input, NumeralWordsLanguage language, Map<String, String> decodingTable) {
  bool state = false;
  String output = '';
  NumeralWordsOutput result;
  result = _isNumeralWordTable(input, language, decodingTable);
  if (result.state) {
    state = true;
    output = result.output;
  } else {
    result = _isNumeralWord10(input, language, decodingTable);
    if (result.state) {
      state = true;
      output = result.output;
    }
  }
  return NumeralWordsOutput(state, output, _languageList?[language]);
}

NumeralWordsOutput _isNumeralWordBelow1000(
    String input, NumeralWordsLanguage language, Map<String, String> decodingTable) {
  bool state = false;
  String output = '';
  String pattern = '';
  int numberBefore = 0;
  int numberAfter = 0;
  List<String> decode = <String>[];
  NumeralWordsOutput resultBefore;
  NumeralWordsOutput resultAfter;
  switch (language) {
    case NumeralWordsLanguage.DEU:
    case NumeralWordsLanguage.ENG:
    case NumeralWordsLanguage.VOL:
    case NumeralWordsLanguage.EPO:
    case NumeralWordsLanguage.SOL:
      switch (language) {
        case NumeralWordsLanguage.DEU:
          pattern = 'hundert';
          break;
        case NumeralWordsLanguage.ENG:
          pattern = 'hundred';
          break;
        case NumeralWordsLanguage.VOL:
          pattern = 'tum';
          break;
        case NumeralWordsLanguage.EPO:
          pattern = 'cent';
          break;
        case NumeralWordsLanguage.SOL:
          pattern = 'farere';
          break;
        default:
      }
      if (input.contains(pattern)) {
        // numeral word contains 100
        if (language == NumeralWordsLanguage.SOL) {
          if (decodingTable[input.split(pattern)[0]] != null) {
            decode = input.split(pattern);
          } else {
            decode.add(input);
          }
        } else {
          decode = input.split(pattern);
        }
        if (decode.length == 2) {
          if (decode[0].isEmpty) {
            resultBefore = NumeralWordsOutput(true, '1', _languageList?[language]);
          } else {
            resultBefore = _isNumeralWordBelow100(decode[0], language, decodingTable);
          }

          if (decode[1].isEmpty) {
            resultAfter = NumeralWordsOutput(true, '0', _languageList?[language]);
          } else {
            resultAfter = _isNumeralWordBelow100(decode[1], language, decodingTable);
          }

          if (resultBefore.state && resultAfter.state) {
            state = true;
            numberBefore = int.parse(resultBefore.output) * 100;
            numberAfter = int.parse(resultAfter.output);
            output = (numberBefore + numberAfter).toString();
          }
        } else {
          resultBefore = _isNumeralWordBelow100(decode[0], language, decodingTable);
          if (resultBefore.state) {
            state = true;
            output = resultBefore.output;
          }
        }
      } else {
        resultBefore = _isNumeralWordBelow100(input, language, decodingTable);
        if (resultBefore.state) {
          state = true;
          output = resultBefore.output;
        }
      }
      break;
    default:
  }
  return NumeralWordsOutput(state, output, _languageList?[language]);
}

NumeralWordsOutput _isNumeralWordTable(String input, NumeralWordsLanguage language, Map<String, String> decodingTable) {
  bool state = false;
  String output = '';
  String checkWord = '';
  if (language == NumeralWordsLanguage.EPO) {
    if (input.contains('dek')) {
      checkWord = 'dek ' + input.split('dek').join('');
    } else {
      checkWord = input;
    }
  } else {
    checkWord = input;
  }
  decodingTable.forEach((key, value) {
    if (removeAccents(key) == checkWord) {
      state = true;
      output = value;
    }
  });
  return NumeralWordsOutput(state, output, _languageList?[language]);
}

Map<String, String> _normalize(Map<String, String> table) {
  Map<String, String> result = {};
  table.forEach((key, value) {
    result[removeAccents(key)] = removeAccents(value);
  });
  return result;
}
