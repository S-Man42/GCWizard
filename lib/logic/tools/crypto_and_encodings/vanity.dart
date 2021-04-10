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

const _PHONE_MODEL_KEY_SIEMENS_ME45 = 'Siemens ME45';
final SIEMENS_ME45 = PhoneModel(_PHONE_MODEL_KEY_SIEMENS_ME45, PhoneKeySpace.SPACE_ON_KEY_1);

final PHONE_MODELS = [SIEMENS_ME45];

final Map<int, String> _vanitySiemensME45 = {
  0: '.,?!0+-:¿¡"\'_',
  1: ' 1€£\$¥¤',
  2: 'abc2äàçæå',
  3: 'def3éè',
  4: 'ghi4ì',
  5: 'jkl5',
  6: 'mno6öñòø',
  7: 'pqrs7ß',
  8: 'tuv8üù',
  9: 'wxyz9'

  /*
  Capital letters:
1: as normal
2: A B C 2 Ä Æ Å
3: D E F 3 É
4: G H I 4
5: J K L 5
6: M N O 6 Ö Ñ Ø
7: P Q R S 7
8: T U V 8 Ü
9: W X Y Z 9
0: as normal
   */
};

String encodeVanitySingleNumbers(String input, PhoneModel model) {
  return _encodeVanity(input, model).map((code) => code[0]).join();
}

_encodeVanity(String input, PhoneModel model) {
  if (input == null || model == null) return [];

  Map<int, String> keyMap;
  switch (model.name) {
    case _PHONE_MODEL_KEY_SIEMENS_ME45:
      keyMap = _vanitySiemensME45;
      break;
  }

  var list = keyMap.values.join().split('').toList();
  input = input.toLowerCase().split('').map((character) {
    return list.contains(character) ? character : '';
  }).join();

  if (input.isEmpty) return [];

  Map<String, String> AZToNumberblocks = {};
  keyMap.entries.forEach((element) {
    element.value.split('').asMap().forEach((index, character) {
      AZToNumberblocks.putIfAbsent(character, () => '${element.key}' * (index + 1));
    });
  });

  return input.split('').map((character) {
    return AZToNumberblocks[character];
  }).toList();
}

String encodeVanityMultipleNumbers(String input, PhoneModel model) {
  return _encodeVanity(input, model).join(' ');
}

String decodeVanityMultipleNumbers(String input, PhoneModel model) {
  if (input == null || input.isEmpty || model == null) return '';

  var numberBlocks = input
      .replaceAll(RegExp(r'[^0-9 ]'), '')
      .split(' ')
      .where((element) => element != null && !element.isEmpty)
      .toList();

  if (numberBlocks.isEmpty) return '';

  Map<int, String> keyMap;
  switch (model.name) {
    case _PHONE_MODEL_KEY_SIEMENS_ME45:
      keyMap = _vanitySiemensME45;
      break;
  }

  Map<String, String> numberblocksToAZ = {};
  keyMap.entries.forEach((element) {
    element.value.split('').asMap().forEach((index, character) {
      numberblocksToAZ.putIfAbsent('${element.key}' * (index + 1), () => character);
    });
  });

  return numberBlocks
      .map((numberBlock) {
        var character = numberblocksToAZ[numberBlock];
        if (character == null) return UNKNOWN_ELEMENT;

        return character;
      })
      .join()
      .toUpperCase();
}
