import 'dart:collection';

import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution.dart';

main() {
  // var x = <String, String>{};
  // var a;
  // for (int i = 10000; i <= 30000; i++) {
  //   if (i % 1000 == 0)
  //     print(i);
  //   for (int j = 55000; j <= 70000; j++) {
  //      a = Map<String, String>.from(x);
  //   }
  // }
  //
  // print(a);

  var x = VariableStringExpander('AB', {'A': '10000-30000', 'B': '55000-70000'}, () => true);

  x.expand();
}

class VariableStringExpander{
  String text;
  Map<String, String> substitutions;
  Function isResultIf;
  Function breakIf;

  VariableStringExpander(this.text, this.substitutions, this.isResultIf, {this.breakIf});

  Map<String, List<int>> expandedSubstitutions = {};
  List<String> expSubstKeys;

  List<int> _expandVariableGroup(String group) {
    var output = SplayTreeSet<int>();

    if (group == null)
      return [];

    group = group.replaceAll(RegExp(r'[^\d,\-#]'), '');

    if (group.length == 0)
      return [];

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

    return output.toList();
  }
  List<Map<String, String>> results = [];

  void _generateCartesianVariables(int keyIndex) {
    // var keys = expandedSubstitutions.keys.toList();
    if (keyIndex == expSubstKeys.length) {
      // results.add(current);
      return;
    }

    var key = expSubstKeys[keyIndex];
    var list = expandedSubstitutions[key];
    for (int i = 0; i < list.length; i++) {
      if (keyIndex == 0 && i % 1000 == 0)
        print(i);

      // var newList = Map<String, String>.from(current);
      // newList.putIfAbsent(key, () => list[i].toString());
      _generateCartesianVariables(keyIndex + 1);
    }
  }

  List<Map<String, dynamic>> expand() {
    var expandedList = SplayTreeSet<String>();

    if (text == null || text.length == 0)
      return [];

    if (substitutions == null || substitutions.length == 0) {
      return [{'text': text, 'variables': {}}];
    }

    text = sanitizeForFormula(text);

    substitutions.entries.forEach((substitution) => expandedSubstitutions.putIfAbsent(
        substitution.key,
            () => _expandVariableGroup(substitution.value).toList()
    ));

    expSubstKeys = expandedSubstitutions.keys.toList();

    print('A');
    _generateCartesianVariables(0);

    List<Map<String, dynamic>> output = [];

    // RegExp regExp = new RegExp(r'\[.+?\]');
    // var matches = regExp.allMatches(text.trim());
    //
    // variableCombinations.forEach((combination) {
    //   var substituted = text;
    //
    //   matches.forEach((match) {
    //     var content = substitution(match.group(0), combination, caseSensitive: false);
    //     substituted = substituted.replaceAll(match.group(0), content);
    //   });
    //
    //   if (expandedList.add(substituted)) {
    //     output.add({'text': substituted, 'variables': combination});
    //   }
    // });

    return output;
  }
}




sanitizeForFormula(String formula) {
  RegExp regExp = new RegExp(r'\[.+?\]');
  if (regExp.hasMatch(formula))
    return formula;

  return '[$formula]';
}