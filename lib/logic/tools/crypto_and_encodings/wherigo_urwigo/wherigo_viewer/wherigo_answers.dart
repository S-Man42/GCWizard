
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/urwigo_tools.dart';
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
  List<AnswerData> result = [];
  String inputObject = '';
  String question = '';
  String help = '';
  String answer = '';

  for (int i = 0; i < lines.length; i++){
    if (lines[i].trimRight().endsWith(':OnGetInput(input)')) {
      inputObject = '';
      question = '';
      help = '';
      answer = '';

      inputObject = lines[i].replaceAll('function ', '').replaceAll(':OnGetInput(input)', '');
      inputs.forEach((element) {
        if (element.InputLUAName == inputObject){
          question = element.InputName;
          help = element.InputText;
        }
      });

      if (lines[i + 1].endsWith('if input == nil then')) {
        if (lines[i + 4].trimLeft().startsWith('if Wherigo.NoCaseEquals(input')) {

        } else {
          answer = lines[i + 4].trimLeft()
              .replaceAll('input', '')
              .replaceAll('string.lower()', '')
              .replaceAll('string.upper()', '')
              .replaceAll('if _Urwigo.Hash() == ', '')
              .replaceAll(' then', '');
          answer = breakUrwigoHash(int.parse(answer));
          result.add(
              AnswerData(
                  inputObject,
                  question,
                  help,
                  answer));
          i = i + 4;
        }
      }
      if (lines[i + 1].endsWith('input = tonumber(input)')) {
        answer = lines[i + 5].trimLeft()
            .replaceAll('if input == ', '')
            .replaceAll(' then', '');
        result.add(
            AnswerData(
                inputObject,
                question,
                help,
                answer));
        i = i + 5;
      }
    }
  };
  return result;
}
