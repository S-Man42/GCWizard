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

final Map<String, String> _vanityNokia = {
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

  /*
  Capital letters:
1: . , ? ! ' " 1 - ( ) @ / : _
2: A B C 2 Ä À Á Ã Â Å Æ Ç
3: D E F 3 È É Ë Ê Ð
4: G H I 4 Ì Í Î Ï
5: J K L 5 £
6: M N O 6 Ö Ò Ó Ô Õ Ø Ñ
7: P Q R S 7 $
8: T U V 8 Ü Ù Ú Û
9: W X Y Z 9 Ý ϸ
0:   0 \n
#: Capital/Small/Number Switch
   */
};

final Map<String, String> _vanitySamsung = {
  '1': '.,?!1@\'"-()/:_;',
  '2': 'abcäàåæΓ2',
  '3': 'defèéΦ3',
  '4': 'ghiìΨ',
  '5': 'jklΛ5',
  '6': 'mnoñöòø6',
  '7': 'pqrsßΣΞ7',
  '8': 'tuvüù8',
  '9': 'wxyzΩ9',
  '0': ' 0\n',
  '*': '.,-!?@~_\n\/&"\';^|:()<{}>[]=€\$£§%¥*+#¿¡¤',

  /*
  Capital letters:
1: . , ? ! 1 @ ' " - ( ) / : _ ;
2: A B C Ä Å Æ Ç Γ 2
3: D E F É Δ Φ 3
4: G H I Θ Ψ 4
5: J K L Λ 5
6: M N O Ñ Ö Ø 6
7: P Q R S Π Σ Ξ 7
8: T U V Ü 8
9: W X Y Z Ω 9
0:  0 \n

#: Switch: Capital/Small/Numbers
*: Menu: . , - ! ? @ ~ _ \n \ / & " ' ; ^ | : ( ) < { } > [ ] = € $ £ § % ¥ * + # ¿ ¡ ¤
:-) :-)) :-> :-] :-D :-( :-(( :-< :-[ :-c :'-( :( :< >:-( :-Q :-s 8-o :-/ :-| ;-) XD :-y :-* :-X :-9 :-b :-O :-() :-V :-@ :-{
   */
};

final Map<String, String> _vanitySiemens = {
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

  Map<String, String> keyMap;
  switch (model.name) {
    case _PHONE_MODEL_KEY_NOKIA:
      keyMap = _vanityNokia;
      break;
    case _PHONE_MODEL_KEY_SAMSUNG:
      keyMap = _vanitySamsung;
      break;
    case _PHONE_MODEL_KEY_SIEMENS:
      keyMap = _vanitySiemens;
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
      .replaceAll(RegExp(r'[^0-9* ]'), '')
      .split(' ')
      .where((element) => element != null && !element.isEmpty)
      .toList();

  if (numberBlocks.isEmpty) return '';

  Map<String, String> keyMap;
  switch (model.name) {
    case _PHONE_MODEL_KEY_NOKIA:
      keyMap = _vanityNokia;
      break;
    case _PHONE_MODEL_KEY_SAMSUNG:
      keyMap = _vanitySamsung;
      break;
    case _PHONE_MODEL_KEY_SIEMENS:
      keyMap = _vanitySiemens;
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
