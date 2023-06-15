import 'package:flutter_test/flutter_test.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze.dart';

List<WherigoAnswerData> testOutputANSWER = [
  WherigoAnswerData(AnswerAnswer: '', AnswerHash: '', AnswerActions: []),
];

String testInputANSWER = 'objupdate_distance = Wherigo.ZTimer(objKlausMastermindKlabuster)\n' +
    'objupdate_distance.Id = "f8e161bb-9069-4a91-8f41-ea3927d37561"\n' +
    'objupdate_distance.Name = "update_distance"\n' +
    'objupdate_distance.Description = ""\n' +
    'objupdate_distance.Visible = true\n' +
    'objupdate_distance.Duration = 3\n' +
    'objupdate_distance.Type = "Interval"';

void expectANSWER(
  List<WherigoAnswerData> actual,
  List<WherigoAnswerData> expected,
) {
  expect(actual, expected);
}
