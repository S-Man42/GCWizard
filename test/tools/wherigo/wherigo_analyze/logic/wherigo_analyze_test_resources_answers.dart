import 'package:flutter_test/flutter_test.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze.dart';

List<WherigoAnswerData> testOutputANSWER = [
  WherigoAnswerData(AnswerAnswer: '', AnswerHash: '', AnswerActions: []),
];

String testInputANSWER = '''
''';

void expectANSWER(
  List<WherigoAnswerData> actual,
  List<WherigoAnswerData> expected,
) {
  expect(actual, expected);
}
