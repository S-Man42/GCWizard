import 'dart:math';
import 'package:gc_wizard/logic/common/parser/variable_string_expander.dart';
import 'dart:async';
import 'dart:isolate';

final _ALARM_COUNT = 100000;

ReceivePort outputPort= ReceivePort(); //port for this main isolate to receive output messages.
ReceivePort progressPort= ReceivePort(); //port for this main isolate to receive messages.
ReceivePort progressGetPort= ReceivePort(); //port for this main isolate to receive messages.

ReceivePort testPort= ReceivePort(); //port for this main isolate to receive messages.


class HashBreakerJobData {
  final String input;
  final String searchMask;
  final Map<String, String> substitutions;
  final Function hashFunction;
  final SendPort sendPort ;

  HashBreakerJobData({
    this.input = '',
    this.searchMask = '',
    this.substitutions = null,
    this.hashFunction = null,
    this.sendPort = null,
  });
}

var _calcCount = 0;
var _currentCalcCount = 0;
double get Progress {
  return min(_currentCalcCount / max(_calcCount, 1), 1);
}


Map<String, dynamic> preCheck(Map<String, String> substitutions) {
  var expander = VariableStringExpander('DUMMY', substitutions, (e) => false);
  var count = expander.run(onlyPrecheck: true);

  _calcCount = max(count[0]['count'],1);
  _currentCalcCount = 0;

  if (count[0]['count'] >= _ALARM_COUNT)
    return {'status' : 'high_count', 'count': count[0]['count']};

  return {'status' : 'ok'};
}

void breakHash(HashBreakerJobData jobData) async {
  jobData.sendPort.send(0.5);

  ReceivePort receivePort= ReceivePort();
  jobData.sendPort.send(receivePort.sendPort);

  print("_calcCount " + _calcCount.toString());

  var _currentOutputFuture = breakHash1(jobData.input, jobData.searchMask, jobData.substitutions, jobData.hashFunction);
  _currentOutputFuture.then((output) {
    print('SEND: ' + output['state'] + ' - ');
    jobData.sendPort.send(output);
  });

  receivePort.listen((get) {
    print('RECEIVE: ' + get.toString() + ', ');
    var progress = Progress;
    print('SEND: ' + progress.toString() + ' - ');
    jobData.sendPort.send(progress);
  });
}

Future<Map<String, dynamic>> breakHash1(String input, String searchMask, Map<String, String> substitutions, Function hashFunction) async {



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
    _currentCalcCount += 1;

    if (hashValue == input)
      return withoutBrackets;
    else return null;
  }, breakCondition: VariableStringExpanderBreakCondition.BREAK_ON_FIRST_FOUND);

  var results = expander.run();

    if (results == null || results.length == 0)
      return {'state': 'not_found'};

    return {'state': 'ok', 'text': results[0]['text']};
}


