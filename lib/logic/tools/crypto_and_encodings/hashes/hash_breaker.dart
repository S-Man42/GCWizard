import 'package:gc_wizard/logic/common/parser/variable_string_expander.dart';

final _ALARM_COUNT = 100000;

Map<String, dynamic> preCheck(Map<String, String> substitutions) {
  var expander = VariableStringExpander('DUMMY', substitutions, (e) => false);
  var count = expander.run(onlyPrecheck: true);

  if (count[0]['count'] >= _ALARM_COUNT)
    return {'status' : 'high_count', 'count': count[0]['count']};

  return {'status' : 'ok'};
}

Map<String, dynamic> breakHash(String input, String searchMask, Map<String, String> substitutions, Function hashFunction) {
  if (
    input == null || input.length == 0
    || searchMask == null || searchMask.length == 0
    || substitutions == null || hashFunction == null
  )
    return null;

  input = input.toLowerCase();
  var expander = VariableStringExpander(searchMask, substitutions, (expandedText) {
    var withoutBrackets = expandedText.replaceAll(RegExp(r'[\[\]]'), '');
    var hashValue = hashFunction(withoutBrackets).toLowerCase();

    if (hashValue == input)
      return withoutBrackets;
    else return null;
  }, breakCondition: VariableStringExpanderBreakCondition.BREAK_ON_FIRST_FOUND);

  var results = expander.run();

  if (results == null || results.length == 0)
    return {'state': 'not_found'};

  return {'state': 'ok', 'text': results[0]['text']};
}