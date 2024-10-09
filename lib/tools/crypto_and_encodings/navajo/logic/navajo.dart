// https://www.history.navy.mil/research/library/online-reading-room/title-list-alphabetically/n/navajo-code-talker-dictionary.html
// https://www.ancestrycdn.com/aa-k12/1112/assets/Navajo-Code-Talkers-dictionary.pdf

import 'dart:math';

import 'package:collection/collection.dart';
import 'package:gc_wizard/utils/constants.dart';

part 'package:gc_wizard/tools/crypto_and_encodings/navajo/logic/navajo_dictionary.dart';

String _shrinkText(String input) {
  return input
      .replaceAll('COMMANDING GEN.', 'COMMANDINGGEN')
      .replaceAll('MAJOR GEN.', 'MAJORGEN')
      .replaceAll('BRIGADIER GEN.', 'BRIGADIERGEN')
      .replaceAll('LT. COLONEL', 'LTCOLONEL')
      .replaceAll('COMMANDING OFFICER', 'COMMANDINGOFFICER')
      .replaceAll('EXECUTIVE OFFICER', 'EXECUTIVEOFFICER')
      .replaceAll('SOUTH AMERICA', 'SOUTHAMERICA')
      .replaceAll('DIVE BOMBER', 'DIVEBOMBER')
      .replaceAll('TORPEDO PLANE', 'TORPEDOPLANE')
      .replaceAll('OBS. PLAN', 'OBSPLAN')
      .replaceAll('FIGHTER PLANE', 'FIGHTERPLANE')
      .replaceAll('BOMBER PLANE', 'BOMBERPLANE')
      .replaceAll('PATROL PLANE', 'PATROLPLANE')
      .replaceAll('MINE SWEEPER', 'MINESWEEPER')
      .replaceAll('MOSQUITO BOAT', 'MOSQUITOBOAT')
      .replaceAll('BOOBY TRAP', 'BOOBYTRAP')
      .replaceAll('BULL DOZER', 'BULLDOZER')
      .replaceAll('COAST GUARD', 'COASTGUARD')
      .replaceAll('COUNTER ATTACK ', 'COUNTERATTACK ')
      .replaceAll('DIG IN', 'DIGIN')
      .replaceAll('FLAME THROWER', 'FLAMETHROWER')
      .replaceAll('HALF TRACK', 'HALFTRACK')
      .replaceAll('HIGH EXPLOSIVE', 'HIGHEXPLOSIVE')
      .replaceAll('MACHINE GUN', 'MACHINEGUN')
      .replaceAll('MERCHANT SHIP', 'MERCHANTSHIP')
      .replaceAll('PILL BOX', 'PILLBOX')
      .replaceAll('PINNED DOWN', 'PINNEDDOWN')
      .replaceAll('ROBOT BOMB', 'ROBOTBOMB')
      .replaceAll('SEMI COLON', 'SEMICOLON')
      .replaceAll('SUPPLY SHIP', 'SUPPLYSHIP')
      .replaceAll('TANK DESTROYER', 'TANKDESTROYER')
      .replaceAll('TRAFFIC DIAGRAM', 'TRAFFICDIAGRAM');
}

String _enfoldText(String input) {
  return input
      .replaceAll('COMMANDINGGEN', 'COMMANDING GEN.')
      .replaceAll('MAJORGEN', 'MAJOR GEN.')
      .replaceAll('BRIGADIERGEN', 'BRIGADIER GEN.')
      .replaceAll('LTCOLONEL', 'LT. COLONEL')
      .replaceAll('COMMANDINGOFFICER', 'COMMANDING OFFICER')
      .replaceAll('EXECUTIVEOFFICER', 'EXECUTIVE OFFICER')
      .replaceAll('SOUTHAMERICA', 'SOUTH AMERICA')
      .replaceAll('DIVEBOMBER', 'DIVE BOMBER')
      .replaceAll('TORPEDOPLANE', 'TORPEDO PLANE')
      .replaceAll('OBSPLAN', 'OBS. PLAN')
      .replaceAll('FIGHTERPLANE', 'FIGHTER PLANE')
      .replaceAll('BOMBERPLANE', 'BOMBER PLANE')
      .replaceAll('PATROLPLANE', 'PATROL PLANE')
      .replaceAll('MINESWEEPER', 'MINE SWEEPER')
      .replaceAll('MOSQUITOBOAT', 'MOSQUITO BOAT')
      .replaceAll('BOOBYTRAP', 'BOOBY TRAP')
      .replaceAll('BULLDOZER', 'BULL DOZER')
      .replaceAll('COASTGUARD', 'COAST GUARD')
      .replaceAll('COUNTERATTACK ', 'COUNTER ATTACK ')
      .replaceAll('DIGIN', 'DIG IN')
      .replaceAll('FLAMETHROWER', 'FLAME THROWER')
      .replaceAll('HALFTRACK', 'HALF TRACK')
      .replaceAll('HIGHEXPLOSIVE', 'HIGH EXPLOSIVE')
      .replaceAll('MACHINEGUN', 'MACHINE GUN')
      .replaceAll('MERCHANTSHIP', 'MERCHANT SHIP')
      .replaceAll('PILLBOX', 'PILL BOX')
      .replaceAll('PINNEDDOWN', 'PINNED DOWN')
      .replaceAll('ROBOTBOMB', 'ROBOT BOMB')
      .replaceAll('SEMICOLON', 'SEMI COLON')
      .replaceAll('SUPPLYSHIP', 'SUPPLY SHIP')
      .replaceAll('TANKDESTROYER', 'TANK DESTROYER')
      .replaceAll('TRAFFICDIAGRAM', 'TRAFFIC DIAGRAM');
}

String decodeNavajo(String cipherText, bool useOnlyAlphabet) {
  List<String> result = <String>[];
  if (cipherText.isEmpty) return '';

  cipherText = cipherText.toUpperCase().replaceAll(RegExp(r'\s{3,}'), '  ').replaceAll('.', ' . ').trim();

  cipherText.split('  ').forEach((element) {
    element.split(' ').forEach((element) {
      var entry = _NAVAJO_ALPHABET.firstWhereOrNull((entry) => entry.value == element);
      if (entry == null) {
        if (useOnlyAlphabet) {
          result.add(UNKNOWN_ELEMENT);
        } else {
          var entry = _NAVAJO_DICTIONARY.firstWhereOrNull((entry) => entry.value == element);
          if (entry == null) {
            result.add(UNKNOWN_ELEMENT);
          } else {
            result.add(_enfoldText(entry.key));
            result.add(' ');
          }
        }
      } else {
        result.add(entry.key);
      }
    });
    result.add(' ');
  });
  return _enfoldText(result.join('').trim());
}

String encodeNavajo(String plainText, bool useOnlyAlphabet) {
  List<String> result = <String>[];
  if (plainText.isEmpty) return '';
  var dictionary =  Map.fromEntries(_NAVAJO_DICTIONARY);

  _shrinkText(plainText.toUpperCase()).split(' ').forEach((element) {
    if (useOnlyAlphabet) {
      result.add(encodeLetterWise(element));
    } else if (dictionary[element] == null) {
      result.add(encodeLetterWise(element));
    } else {
      result.add(dictionary[element]!);
    }
    result.add('');
  });
  return result.join(' ').trim();
}

String encodeLetterWise(String plainText) {
  List<String> result = <String>[];
  plainText.split('').forEach((element) {
    var entrys = _NAVAJO_ALPHABET.where((entry) => entry.key == element);
    if (entrys.isEmpty) {
      result.add(element);
    } else {
      result.add(entrys.elementAt(Random().nextInt(entrys.length)).value);
    }
  });
  return result.join(' ');
}
