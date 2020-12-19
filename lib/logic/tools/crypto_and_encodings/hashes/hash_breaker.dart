import 'package:gc_wizard/logic/common/parser/variable_string_expander.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/hashes/hashes.dart';

final _ALERT_MAXIMUM = 25000;

Map<String, dynamic> breakHash(String input, String searchMask, Map<String, String> substitutions, Function hashFunction, {calculateAll: false}) {
  if (
    input == null || input.length == 0
    || searchMask == null || searchMask.length == 0
    || substitutions == null || hashFunction == null
  )
    return null;

  List<Map<String, dynamic>> expandedTexts = expandText(searchMask, substitutions);
  if (expandedTexts.length >= _ALERT_MAXIMUM && calculateAll == false)
    return {'state': 'error', 'count': expandedTexts.length};

  if (expandedTexts == null || expandedTexts.length == 0)
    return null;

  input = input.toLowerCase();

  for (String expandedText in expandedTexts.map((text) => text['text'].replaceAll(RegExp(r'[\[\]]'), '')).toList()) {
    String hash = hashFunction(expandedText);

    if (hash.toLowerCase() == input)
      return {'state': 'ok', 'text': expandedText};
  }

  return {'state': 'not_found'};
}