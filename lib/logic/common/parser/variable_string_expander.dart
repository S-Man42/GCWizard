import 'dart:collection';

import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution.dart';

Set<int> _expandVariableGroup(String group) {
  var output = SplayTreeSet<int>();

  if (group == null)
    return output;

  group = group.replaceAll(RegExp(r'[^\d,\-#]'), '');

  if (group.length == 0)
    return output;

  var ranges = group.split(',');
  ranges.forEach((range) {
    var rangeParts = range.split('#');
    var rangeBounds = rangeParts[0].split('-');
    if(rangeBounds.length == 1) {
      output.add(int.tryParse(rangeBounds[0]));
      return;
    }

    var start = int.tryParse(rangeBounds[0]);
    var end = int.tryParse(rangeBounds[1]);

    if (start == end) {
      output.add(start);
      return;
    }

    var increment = 1;
    if (rangeParts.length > 1)
      increment = int.tryParse(rangeParts[1]);

    if (start < end) {
      for (int i = start; i <= end; i += increment)
        output.add(i);
    } else {
      for (int i = start; i >= end; i -= increment)
        output.add(i);
    }
  });

  return output;
}

void _generateCartesianVariables(Map<String, List<int>> lists, List<Map<String, String>> result, int keyIndex, Map<String, String> current) {
  var keys = lists.keys.toList();
  if (keyIndex == keys.length) {
    result.add(current);
    return;
  }

  var key = keys[keyIndex];
  var list = lists[key];
  for (int i = 0; i < list.length; i++) {
    var newList = Map<String, String>.from(current);
    newList.putIfAbsent(key, () => list[i].toString());
    _generateCartesianVariables(lists, result, keyIndex + 1, newList);
  }
}

sanitizeForFormula(String formula) {
  RegExp regExp = new RegExp(r'\[.+?\]');
  if (regExp.hasMatch(formula))
    return formula;

  return '[$formula]';
}

List<Map<String, dynamic>> expandText(String text, Map<String, String> substitutions) {
  var expandedList = SplayTreeSet<String>();

  if (text == null || text.length == 0)
    return [];

  if (substitutions == null || substitutions.length == 0) {
    expandedList.add(text);
    return [];
  }

  text = sanitizeForFormula(text);

  Map<String, List<int>> expandedSubstitutions = {};
  substitutions.entries.forEach((substitution) => expandedSubstitutions.putIfAbsent(
      substitution.key,
          () => _expandVariableGroup(substitution.value).toList()
  ));

  List<Map<String, String>> variableCombinations = [];
  _generateCartesianVariables(expandedSubstitutions, variableCombinations, 0, {});

  List<Map<String, dynamic>> output = [];

  RegExp regExp = new RegExp(r'\[.+?\]');
  var matches = regExp.allMatches(text.trim());

  variableCombinations.forEach((combination) {
    var substituted = text;

    matches.forEach((match) {
      var content = substitution(match.group(0), combination, caseSensitive: false);
      substituted = substituted.replaceAll(match.group(0), content);
    });

    if (expandedList.add(substituted)) {
      output.add({'text': substituted, 'variables': combination});
    }
  });

  return output;
}