final AZToChicken = {
  'a' : 'ahadefa', 'e' : 'ehedefe', 'i' : 'ihidefi', 'o' : 'ohodefo', 'u' : 'uhudefu',
  String.fromCharCode(228) : String.fromCharCode(228) + 'h' + String.fromCharCode(228) + 'def' + String.fromCharCode(228), // ä
  String.fromCharCode(246) : String.fromCharCode(246) + 'h' + String.fromCharCode(246) + 'def' + String.fromCharCode(246), // ö
  String.fromCharCode(252) : String.fromCharCode(252) + 'h' + String.fromCharCode(252) + 'def' + String.fromCharCode(252), // ü
  'au' : 'auhaudefau', 'eu' : 'euheudefeu', 'ei' : 'eiheidefei', 'ie' : 'iehiedefie',
};

String encodeChickenLanguage(String input) {
  if (input == null || input.length == 0)
    return '';

  var out = '';
  var stored = '0';

  input.toLowerCase().split('').forEach((character) {
    if ((stored == 'a' && character == 'u') || (stored == 'e' && (character == 'i' || character == 'u')) || (stored == 'i' && character == 'e')) {
      out += AZToChicken[stored + character] ?? '';
      stored = '0';
      return;
    }

    if (stored != '0') {
      out += AZToChicken[stored] ?? '';
      stored = '0';
    }

    if (character == 'a' || character == 'e' || character == 'i')
      stored = character;
    else
      out += AZToChicken[character] ?? character;
  });
  if (stored != '0')
    out += AZToChicken[stored] ?? '';

  return out;
}

String decodeChickenLanguage(String input) {
  if (input == null || input.length == 0)
    return '';

  return input.toLowerCase().replaceAll('ahadefa', 'a').replaceAll('ehedefe', 'e').replaceAll('ihidefi', 'i').replaceAll('ohodefo', 'o').replaceAll('uhudefu', 'u')
    .replaceAll('ähädefä', 'ä').replaceAll('öhödefö', 'ö').replaceAll('ühüdefü', 'ü')
    .replaceAll('auhaudefau', 'au').replaceAll('eiheidefei', 'ei').replaceAll('euheudefeu', 'eu').replaceAll('iehiedefie', 'ie');
}
