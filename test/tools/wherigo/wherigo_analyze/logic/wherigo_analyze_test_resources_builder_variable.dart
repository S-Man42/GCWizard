import 'package:flutter_test/flutter_test.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze.dart';

String testInputBUILDERVARIABLE =
    'buildervar.Answer = {}\n' +
    'buildervar.Answer.Id = "00000000-0000-0000-0000-000000000000"\n' +
    'buildervar.Answer.Name = "Answer"\n' +
    'buildervar.Answer.Type = "String"\n' +
    'buildervar.Answer.Data = ""\n' +
    'buildervar.Answer.Description = ""\n' +
    'buildervar.EnteredFinalZone = {}\n' +
    'buildervar.EnteredFinalZone.Id = "00000000-0000-0000-0000-000000000001"\n' +
    'buildervar.EnteredFinalZone.Name = "EnteredFinalZone"\n' +
    'buildervar.EnteredFinalZone.Type = "Flag"\n' +
    'buildervar.EnteredFinalZone.Data = "False"\n' +
    'buildervar.EnteredFinalZone.Description = "Has the player entered the final zone? &nbsp;Used so the final zone can stay active, but the events will not be triggered a second time."';

List<WherigoBuilderVariableData> testOutputBUILDERVARIABLE = [
  const WherigoBuilderVariableData(
  BuilderVariableID: '00000000-0000-0000-0000-000000000000',
  BuilderVariableName: 'Answer',
  BuilderVariableType: 'String',
  BuilderVariableData: '',
  BuilderVariableDescription: '',
  ),
  const WherigoBuilderVariableData(
  BuilderVariableID: '00000000-0000-0000-0000-000000000001',
  BuilderVariableName: 'EnteredFinalZone',
  BuilderVariableType: 'Flag',
  BuilderVariableData: 'False',
  BuilderVariableDescription: 'Has the player entered the final zone? &nbsp;Used so the final zone can stay active, but the events will not be triggered a second time.',
  ),
];


void expectBuilderVariable(List<WherigoBuilderVariableData> actual, List<WherigoBuilderVariableData> expected) {
  for (int i = 0; i < expected.length; i++) {
    expect(actual[i].BuilderVariableID, expected[i].BuilderVariableID);
    expect(actual[i].BuilderVariableName, expected[i].BuilderVariableName);
    expect(actual[i].BuilderVariableType, expected[i].BuilderVariableType);
    expect(actual[i].BuilderVariableData, expected[i].BuilderVariableData);
    expect(actual[i].BuilderVariableDescription, expected[i].BuilderVariableDescription);
  }
}
