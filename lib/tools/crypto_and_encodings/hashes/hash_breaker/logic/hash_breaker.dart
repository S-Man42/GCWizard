import 'dart:isolate';

import 'package:gc_wizard/common_widgets/gcw_async_executer.dart';
import 'package:gc_wizard/utils/variable_string_expander.dart';

class HashBreakerJobData {
  final String input;
  final String searchMask;
  final Map<String, String> substitutions;
  final Function hashFunction;

  HashBreakerJobData({
    this.input = '',
    this.searchMask = '',
    required this.substitutions,
    required this.hashFunction,
  });
}

Future<Map<String, Object>?> breakHashAsync(GCWAsyncExecuterParameters? jobData) async {
  if (jobData?.parameters is! HashBreakerJobData) return null;

  var data = jobData!.parameters as HashBreakerJobData;
  var output = breakHash(data.input, data.searchMask, data.substitutions,
      data.hashFunction,
      sendAsyncPort: jobData.sendAsyncPort);

  jobData.sendAsyncPort.send(output);

  return output;
}

Map<String, Object>? breakHash(
    String? input, String? searchMask, Map<String, String>? substitutions, Function? hashFunction,
    {SendPort? sendAsyncPort}) {
  if (input == null ||
      input.isEmpty ||
      searchMask == null ||
      searchMask.isEmpty ||
      substitutions == null ||
      hashFunction == null) return null;

  input = input.toLowerCase();
  var expander = VariableStringExpander(searchMask, substitutions, onAfterExpandedText: (expandedText) {
    var withoutBrackets = expandedText.replaceAll(RegExp(r'[\[\]]'), '');
    var hashValue = hashFunction(withoutBrackets).toLowerCase();

    if (hashValue == input)
      return withoutBrackets;
    else
      return null;
  }, breakCondition: VariableStringExpanderBreakCondition.BREAK_ON_FIRST_FOUND, sendAsyncPort: sendAsyncPort);

  var results = expander.run();

  if (results == null || results.isEmpty) return {'state': 'not_found'};

  return {'state': 'ok', 'text': results[0]['text']};
}
