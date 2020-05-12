import 'dart:collection';

import 'package:gc_wizard/logic/tools/coords/parser/latlon.dart';
import 'package:gc_wizard/logic/tools/coords/projection.dart';
import 'package:gc_wizard/logic/tools/crypto/substitution.dart';
import 'package:gc_wizard/logic/tools/formula_solver/parser.dart';
import 'package:latlong/latlong.dart';

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

void generateCartesianVariables(Map<String, List<int>> lists, List<Map<String, String>> result, int keyIndex, Map<String, String> current) {
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
    generateCartesianVariables(lists, result, keyIndex + 1, newList);
  }
}

Set<String> _expandText(String text, Map<String, String> substitutions) {
  var expandedList = SplayTreeSet<String>();

  if (text == null || text.length == 0)
    return expandedList;

  if (substitutions == null || substitutions.length == 0) {
    expandedList.add(text);
    return expandedList;
  }

  Map<String, List<int>> expandedSubstitutions = {};
  substitutions.entries.forEach((substitution) => expandedSubstitutions.putIfAbsent(
    substitution.key,
    () => _expandVariableGroup(substitution.value).toList()
  ));

  List<Map<String, String>> variableCombinations = [];
  generateCartesianVariables(expandedSubstitutions, variableCombinations, 0, {});

  variableCombinations.forEach((combination) {
    expandedList.add(substitution(text, combination));
  });

  return expandedList;
}

_sanitizeVariableDoubleText(String text) {
  if (text == null)
    return null;

  return text.replaceAll(',', '.').replaceAll(RegExp(r'[^0-9\.\[\]]'), '');
}

List<LatLng> parseVariableLatLon(String coordinate, Map<String, String> substitutions, {Map<String, dynamic> projectionData = const {}}) {
  var textToExpand = coordinate;

  var withProjection = false;
  if (projectionData != null) {
    if (projectionData['bearing'] != null && projectionData['distance'] != null) {
      withProjection = true;
      textToExpand += String.fromCharCode(1) + projectionData['bearing'];
      textToExpand += String.fromCharCode(1) + projectionData['distance'];
    }
  }

  var expandedTexts = _expandText(textToExpand, substitutions);

  var formulaParser = FormulaParser();
  var coords = <LatLng>[];

  for (String expandedText in expandedTexts) {
    var evaluatedFormula = formulaParser.parse(expandedText, {});
    if (evaluatedFormula['state'] == STATE_ERROR)
      continue;

    if (withProjection) {
      var evaluatedTexts = evaluatedFormula['result'].split(String.fromCharCode(1));

      var parsedCoord = parseLatLon(evaluatedTexts[0]);
      if (parsedCoord == null)
        continue;

      var parsedBearing = double.tryParse(_sanitizeVariableDoubleText(evaluatedTexts[1]));
      var parsedDistance = double.tryParse(_sanitizeVariableDoubleText(evaluatedTexts[2]));

      if (parsedBearing == null || parsedDistance == null)
        continue;

      coords.add(projection(parsedCoord, parsedBearing, parsedDistance, projectionData['ellipsoid']));
    } else {
      var parsedCoords = parseLatLon(evaluatedFormula['result']);
      if (parsedCoords != null) {
        coords.add(parsedCoords);
      }
    }
  }

  return coords;
}