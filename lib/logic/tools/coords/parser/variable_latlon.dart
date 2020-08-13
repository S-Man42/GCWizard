import 'dart:collection';

import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/parser/latlon.dart';
import 'package:gc_wizard/logic/tools/coords/projection.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution.dart';
import 'package:gc_wizard/logic/tools/formula_solver/parser.dart';
import 'package:gc_wizard/utils/common_utils.dart';
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

List<Map<String, dynamic>> _expandText(String text, Map<String, String> substitutions) {
  var expandedList = SplayTreeSet<String>();

  if (text == null || text.length == 0)
    return [];

  if (substitutions == null || substitutions.length == 0) {
    expandedList.add(text);
    return [];
  }

  Map<String, List<int>> expandedSubstitutions = {};
  substitutions.entries.forEach((substitution) => expandedSubstitutions.putIfAbsent(
    substitution.key,
    () => _expandVariableGroup(substitution.value).toList()
  ));

  List<Map<String, String>> variableCombinations = [];
  generateCartesianVariables(expandedSubstitutions, variableCombinations, 0, {});

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

_sanitizeVariableDoubleText(String text) {
  if (text == null)
    return null;

  return text.replaceAll(',', '.').replaceAll(RegExp(r'[^0-9\.\[\]]'), '');
}

_sanitizeForFormula(String formula) {
  RegExp regExp = new RegExp(r'\[.+?\]');
  if (regExp.hasMatch(formula))
    return formula;

  return '[$formula]';
}

Map<String, LatLng> _parseCoordText(String text) {
  var parsedCoord = parseLatLon(text);
  if (parsedCoord == null)
    return null;

  var out = <String, LatLng>{'coordinate': parsedCoord['coordinate']};

  if (parsedCoord['format'] == keyCoordsDEG) {
    out.putIfAbsent('leftPadCoordinate', () => parseDEG(text, leftPadMilliMinutes: true));
  }

  return out;
}

Map<String, dynamic> parseVariableLatLon(String coordinate, Map<String, String> substitutions, {Map<String, dynamic> projectionData = const {}}) {
  var textToExpand = _sanitizeForFormula(coordinate);

  var withProjection = false;
  if (projectionData != null) {
    if (projectionData['bearing'] != null && projectionData['bearing'].length > 0
        && projectionData['distance'] != null && projectionData['distance'].length > 0) {
      withProjection = true;
      textToExpand += String.fromCharCode(1) + _sanitizeForFormula(projectionData['bearing']);
      textToExpand += String.fromCharCode(1) + _sanitizeForFormula(projectionData['distance']);
    }
  }

  var expandedTexts = _expandText(textToExpand, substitutions);

  var formulaParser = FormulaParser();
  var coords = <Map<String, dynamic>>[];
  var leftPadCoords = <Map<String, dynamic>>[];

  for (Map<String, dynamic> expandedText in expandedTexts) {
    var evaluatedFormula = formulaParser.parse(expandedText['text'], {});
    evaluatedFormula['result'] = evaluatedFormula['result'].replaceAll(RegExp(r'[\[\]]'), '');

    if (withProjection) {
      var evaluatedTexts = evaluatedFormula['result'].split(String.fromCharCode(1));

      var parsedCoord = _parseCoordText(evaluatedTexts[0]);
      if (parsedCoord == null)
        continue;

      var parsedBearing = double.tryParse(_sanitizeVariableDoubleText(evaluatedTexts[1]));
      var parsedDistance = double.tryParse(_sanitizeVariableDoubleText(evaluatedTexts[2]));

      if (parsedBearing == null || parsedDistance == null)
        continue;

      parsedBearing = modulo(parsedBearing, 360);
      parsedDistance = parsedDistance.abs();

      parsedCoord.entries.forEach((entry) {

        if (projectionData['reverseBearing'] != null && projectionData['reverseBearing']) {

          var revProjected = reverseProjection(entry.value, parsedBearing, projectionData['lengthUnit'].toMeter(parsedDistance), projectionData['ellipsoid']);
          if (revProjected == null || revProjected.length == 0)
            return;

          var projected = revProjected.map((projection) {
            return {'variables': expandedText['variables'], 'coordinate': projection};
          }).toList();

          if (entry.key == 'coordinate')
            coords.addAll(projected);
          else
            leftPadCoords.addAll(projected);

        } else {
          var projected = {
            'coordinate' : projection(entry.value, parsedBearing, projectionData['lengthUnit'].toMeter(parsedDistance), projectionData['ellipsoid']),
            'variables' : expandedText['variables']
          };

          if (entry.key == 'coordinate')
            coords.add(projected);
          else
            leftPadCoords.add(projected);
        }
      });

    } else {
      var parsedCoord = _parseCoordText(evaluatedFormula['result']);
      if (parsedCoord == null)
        continue;

      coords.add({'variables': expandedText['variables'], 'coordinate': parsedCoord['coordinate']});
      if (parsedCoord['leftPadCoordinate'] != null) {
        leftPadCoords.add({'variables': expandedText['variables'], 'coordinate': parsedCoord['leftPadCoordinate']});
      }
    }
  }

  return {'coordinates' : coords, 'leftPadCoordinates': leftPadCoords};
}