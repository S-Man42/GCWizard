
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/urwigo_tools.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_input.dart';

class AnswerData{
  final String AnswerInput;
  final String AnswerQuestion;
  final String AnswerHelp;
  final String AnswerAnswer;

  AnswerData(
      this.AnswerInput,
      this.AnswerQuestion,
      this.AnswerHelp,
      this.AnswerAnswer);
}



List<AnswerData>getAnswersFromCartridge(String LUA, List<InputData> inputs, dtable, obfuscator){
  List<String> lines = LUA.split('\n');
  String line = '';
  List<AnswerData> result = [];
  String inputObject = '';
  String question = '';
  String help = '';
  String answer = '';

  for (int i = 0; i < lines.length; i++){
    line = lines[i];
    if (line.trimRight().endsWith(':OnGetInput(input)')) {
      inputObject = line.replaceAll('function ', '').replaceAll(':OnGetInput(input)', '');
      inputs.forEach((element) {
        if (element.InputLUAName == inputObject){
          question = element.InputName;
          help = element.InputText;
        }
      });
      answer = lines[i + 4].trimLeft().replaceAll('if _Urwigo.Hash(string.lower(input)) == ', '').replaceAll(' then', '');
      answer = breakUrwigoHash(int.parse(answer));
      result.add(
          AnswerData(
              inputObject,
              question,
              help,
              answer));
      i = i + 4;
    }
  };
  return result;
}
