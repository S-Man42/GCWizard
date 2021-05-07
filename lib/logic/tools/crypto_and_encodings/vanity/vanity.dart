import 'package:flutter/cupertino.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vanity/phone_models.dart';
import 'package:gc_wizard/utils/common_utils.dart';

PhoneCaseMode _getModeFromState(String state) {
  switch (state.split('_')[0]) {
    case 'ABC': return PhoneCaseMode.UPPER_CASE;
    case 'Abc': return PhoneCaseMode.CAMEL_CASE;
    case 'abc': return PhoneCaseMode.LOWER_CASE;
    case '123': return PhoneCaseMode.NUMBERS;
    case 'char': return PhoneCaseMode.SPECIAL_CHARACTERS;
  }
}

// Map<String, String> _initializeCharacterGroups(Map<String, Map<String, String>> stateModel, Map<PhoneCaseMode, Map<String, String>> characterMap, PhoneInputLanguage inputLanguage) {
//   Map<String, Map<String, String>> characterGroups = {};
//
//   var x = stateModel.forEach((key, value) {
//     var state = key;
//     var mode = _getModeFromState(state);
//
//     Map<String, String> stateCharacterGroups = {};
//
//     var availableStateCharacters = characterMap[mode].keys.join();
//
//     var transitionSymbols = value.values.join();
//
//     if (transitionSymbols.contains('_')) {
//       var spaceSymbols = availableStateCharacters.replaceAll(RegExp(r'[^\s]'), '');
//       stateCharacterGroups.putIfAbsent('_', () => spaceSymbols);
//       availableStateCharacters = availableStateCharacters.replaceAll(RegExp(r'[^\s]'), '');
//     }
//
//     ['0', '#', '*'].forEach((character) {
//       if (transitionSymbols.contains(character)) {
//         stateCharacterGroups.putIfAbsent(character, () => character);
//         availableStateCharacters = availableStateCharacters.replaceAll(character, '');
//       }
//     });
//
//     if (transitionSymbols.contains('?')) {
//       stateCharacterGroups.putIfAbsent('?', () => '?!.');
//       availableStateCharacters = availableStateCharacters.replaceAll(RegExp(r'[^\?!\.]'), '');
//     }
//
//     stateCharacterGroups.putIfAbsent('x', () => availableStateCharacters);
//   });
// }

List<String> _sanitizeDecodeInput(String input) {
  var sanitizedInput = '';
  var prevCharacter = input[0];
  input.trim().replaceAll(RegExp(r'\s+'), ' ').split('').forEach((character) {
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

  return sanitizedInput.split(' ').where((element) => element != null && element.length > 0).toList();
}

bool _isTransitionCharacter(Map<String, Map<String, String>> stateModel, String state, String character) {
  return !('_?'.contains(character)) && stateModel[state][character] != null;
}

Map<String, String> _getCharMap(Map<PhoneCaseMode, Map<String, String>> languageCharMap, PhoneCaseMode mode) {
  // print(languageCharMap);
  // print(mode);

  return languageCharMap[mode == PhoneCaseMode.CAMEL_CASE ? PhoneCaseMode.UPPER_CASE : mode];
}

Map<String, dynamic> decodeVanityMultitap(String input, PhoneModel model, PhoneInputLanguage inputLanguage) {
  if (model == null || inputLanguage == null)
    return null;

  var stateModel = model.defaultCaseStateModel;

  if (model.specificCaseStateModels != null && model.specificCaseStateModels[inputLanguage] != null)
    stateModel = model.specificCaseStateModels[inputLanguage];

  var currentState = stateModel[PHONE_STATEMODEL_START].values.first;
  var currentMode = _getModeFromState(currentState);

  if (input == null || input.trim().isEmpty)
    return {'mode': currentMode, 'output': ''};

  var languageIndex = model.languages.indexWhere((langList) => langList.contains(inputLanguage));
  var languageCharmap = model.characterMap[languageIndex];
  var currentCharmap = _getCharMap(languageCharmap, currentMode);

  // print(currentState);
  print(currentMode);
  print(languageIndex);
  print(languageCharmap);
  print(currentCharmap);

  List<String> inputBlocks = _sanitizeDecodeInput(input);
  if (inputBlocks.isEmpty)
    return {'mode': currentMode, 'output': ''};

  var output = '';
  for (int i = 0; i < inputBlocks.length; i++) {
    var block = inputBlocks[i];
    var firstLetter = block[0];

    var characters = currentCharmap[firstLetter];
    if (characters == null && !_isTransitionCharacter(stateModel, currentState, firstLetter))
      continue;

    if (characters != null) {
      if (characters.length == 1 && block.length > 1) {
        output += characters;
        currentState = stateModel[currentState]['x'];
        currentMode = _getModeFromState(currentState);
        currentCharmap = _getCharMap(languageCharmap, currentMode);

        inputBlocks[i] = inputBlocks[i].substring(1);
        i--;
        continue;
      }

      output += characters[(block.length - 1) % characters.length];

      currentState = stateModel[currentState]['x'];
      currentMode = _getModeFromState(currentState);
      currentCharmap = languageCharmap[currentMode];
    } else {
      currentState = stateModel[currentState][firstLetter];
      currentMode = _getModeFromState(currentState);
      currentCharmap = _getCharMap(languageCharmap, currentMode);

      if (block.length > 1) {
        inputBlocks[i] = inputBlocks[i].substring(1);
        i--;
      }
    }
  }

  return {'mode': currentMode, 'output': output};
}