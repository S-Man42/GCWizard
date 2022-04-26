//http://www.crumlin.dk/geocaching/gade/#:~:text=A%20Gade%20is%20a%20method%2C%20invented%20by%20the,least%20one%20variable%20containing%20each%20digit%20%28including%20zero%29.

import 'package:gc_wizard/logic/tools/crypto_and_encodings/alphabet_values.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution.dart';
import 'package:tuple/tuple.dart';

Tuple2<Map<String, String>, String> buildGade(String key, String formula, {bool onlyNumber = false}) {
  if (key == null) return null;
  var outputList = <String>[];
  var gadeMap = Map<String, String>();
  String valuesString;

  if (onlyNumber)
    valuesString = key;
  else {
    var values = AlphabetValues().textToValues(key, keepNumbers: true);
    valuesString = values.map((value) => value.toString()).join();
  }

  outputList = valuesString.replaceAll(RegExp(r'[^0-9]'), '').split('');
  outputList.sort();

  for (int index = 0; index <= 9; index++)
    if (!outputList.contains(index.toString()))
      outputList.add(index.toString());


  for (int index = 0; index < outputList.length; index++)
    if (index < 26)
      gadeMap[String.fromCharCode(index + 65)] = outputList[index];

  var formulaOutput = substitution(formula, gadeMap);

  return Tuple2(gadeMap, formulaOutput);
}
