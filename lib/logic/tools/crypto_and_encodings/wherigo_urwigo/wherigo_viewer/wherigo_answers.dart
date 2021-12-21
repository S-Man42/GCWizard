
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/urwigo_tools.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_input.dart';

class AnswerData{
  final String AnswerInput;
  final String AnswerQuestion;
  final String AnswerHelp;
  final String AnswerAnswer;
  final List<ActionData> AnswerCorrect;
  final List<ActionData> AnswerWrong;

  AnswerData(
      this.AnswerInput,
      this.AnswerQuestion,
      this.AnswerHelp,
      this.AnswerAnswer,
      this.AnswerCorrect,
      this.AnswerWrong);
}

class ActionData{
  final String ActionType;
  final String ActionContent;

  ActionData(
      this.ActionType,
      this.ActionContent
      );
}


List<AnswerData>getAnswersFromCartridge(String LUA, List<InputData> inputs, dtable, obfuscator){
  List<String> lines = LUA.split('\n');
  List<AnswerData> result = [];
  String inputObject = '';
  String question = '';
  String help = '';
  String answer = '';
  List<ActionData> answerCorrect = [];
  List<ActionData> answerWrong = [];
  bool answerToCheck = true;
  bool elseIf = false;
  int elseIfStart = 0;
  int k = 0;

  for (int i = 0; i < lines.length; i++){
    if (lines[i].trimRight().endsWith(':OnGetInput(input)')) {
      inputObject = '';
      question = '';
      help = '';
      answer = '';
      answerCorrect = [];
      answerWrong = [];
      answerToCheck = true;
      elseIf = false;
      elseIfStart = 0;

      inputObject = lines[i].replaceAll('function ', '').replaceAll(':OnGetInput(input)', '');
      inputs.forEach((element) {
        if (element.InputLUAName == inputObject){
          question = element.InputName;
          help = element.InputText;
        }
      });

      if (lines[i + 1].endsWith('if input == nil then')) {
        if (lines[i + 4].trimLeft().startsWith('if Wherigo.NoCaseEquals(input')) {
          answer = lines[i + 4].trimLeft()
              .replaceAll('if Wherigo.NoCaseEquals(input, "', '')
              .replaceAll('") then', '');
        } else if (lines[i + 4].trimLeft().endsWith('= tonumber(input)')) {
          answer = lines[i + 4].trimLeft();
          answerToCheck = false;
        } else {
          answer = lines[i + 4].trimLeft()
              .replaceAll('input', '')
              .replaceAll('string.lower()', '')
              .replaceAll('string.upper()', '')
              .replaceAll('if _Urwigo.Hash() == ', '')
              .replaceAll(' then', '');
          if (int.tryParse(answer) != null) {
            answer = breakUrwigoHash(int.parse(answer));
          } else {
            answer = lines[i + 4].trimLeft();
          }
        }
          if (answerToCheck) {
            // get actions for correct answer
            answerCorrect = [];
            k = 1;
            do {
              if (lines[i + 4 + k].trimLeft().startsWith('_Urwigo') ||
                  lines[i + 4 + k].trimLeft().startsWith('{') ||
                  lines[i + 4 + k].trimLeft().startsWith('}') ||
                  lines[i + 4 + k].trimLeft().startsWith('Wherigo') ||
                  lines[i + 4 + k].trimLeft().startsWith('end')) {
              } else if (lines[i + 4 + k].trimLeft().startsWith('elseif _Urwigo.Hash(') ||
                  lines[i + 4 + k].trimLeft().startsWith('elseif input == ')) {
                elseIf = true;
                elseIfStart = i + 4 + k;
              } else {
                if (!elseIf) {
                  if (lines[i + 4 + k].trimLeft().startsWith('Text'))
                    answerCorrect.add(ActionData('txt', getTextData(lines[i + 4 + k], obfuscator, dtable)));
                  else if (lines[i + 4 + k].trimLeft().startsWith('Media'))
                    answerCorrect.add(ActionData('img', lines[i + 4 + k].trimLeft().replaceAll('Media = ', '')));
                  else
                    answerCorrect.add(ActionData('act', lines[i + 4 + k].trimLeft()));
                }
              }
              k++;
            } while (lines[i + 4 + k].trimLeft() != 'else');

            // get actions else
            answerWrong = [];
            k++;
            do {
              if (lines[i + 4 + k].trimLeft().startsWith('_Urwigo') ||
                  lines[i + 4 + k].trimLeft().startsWith('{') ||
                  lines[i + 4 + k].trimLeft().startsWith('}') ||
                  lines[i + 4 + k].trimLeft().startsWith('Wherigo') ||
                  lines[i + 4 + k].trimLeft().startsWith('Callback') ||
                  lines[i + 4 + k].trimLeft().startsWith('if action') ||
                  lines[i + 4 + k].trimLeft().startsWith('end')) {
              } else {
                if (lines[i + 4 + k].trimLeft().startsWith('Text'))
                  answerWrong.add(ActionData('txt', getTextData(lines[i + 4 + k], obfuscator, dtable)));
                else if (lines[i + 4 + k].trimLeft().startsWith('Media'))
                  answerWrong.add(ActionData('img', lines[i + 4 + k].trimLeft().replaceAll('Media = ', '')));
                else
                  answerWrong.add(ActionData('act', lines[i + 4 + k].trimLeft()));
              }
              k++;
            } while (lines[i + 4 + k].trimLeft() != 'end');
          }

          result.add(
              AnswerData(
                  inputObject,
                  question,
                  help,
                  answer,
                  answerCorrect,
                  answerWrong));
          i = i + 4 + k;
        //}
      } else if (lines[i + 1].endsWith('input = tonumber(input)')) {
        answer = lines[i + 5].trimLeft()
            .replaceAll('if input == ', '')
            .replaceAll(' then', '');

        // get actions else
        answerWrong = [];
        do {
          if (lines[i + 4 + k].trimLeft().startsWith('_Urwigo') ||
              lines[i + 4 + k].trimLeft().startsWith('{') ||
              lines[i + 4 + k].trimLeft().startsWith('}') ||
              lines[i + 4 + k].trimLeft().startsWith('Wherigo') ||
              lines[i + 4 + k].trimLeft().startsWith('end')) {
          } else {
            if (lines[i + 4 + k].trimLeft().startsWith('Text'))
              answerWrong.add(ActionData('txt', getTextData(lines[i + 4 + k], obfuscator, dtable)));
            else if (lines[i + 4 + k].trimLeft().startsWith('Media'))
              answerWrong.add(ActionData('img', lines[i + 4 + k].trimLeft().replaceAll('Media = ', '')));
            else
              answerWrong.add(ActionData('act', lines[i + 4 + k].trimLeft()));
          }
          k++;
        } while (lines[i + 4 + k].trimLeft() != 'end');

        result.add(
            AnswerData(
                inputObject,
                question,
                help,
                answer,
                answerCorrect,
                answerWrong));
        i = i + 5;
      }
      if (elseIf) {
        answer = '';
        answerCorrect = [];
        answerWrong = [];

        if (lines[elseIfStart].trimLeft().startsWith('elseif _Urwigo.Hash(')){
          answer = lines[elseIfStart].trimLeft()
              .replaceAll('input', '')
              .replaceAll('string.lower()', '')
              .replaceAll('string.upper()', '')
              .replaceAll('elseif _Urwigo.Hash() == ', '')
              .replaceAll(' then', '');
          answer = breakUrwigoHash(int.parse(answer));
        }

        if (lines[elseIfStart].trimLeft().startsWith('elseif input == ')) {
          answer = lines[elseIfStart].trimLeft()
              .replaceAll('if input == ', '')
              .replaceAll(' then', '');
        }

        // get actions
        k = 1;
        do {
          if (lines[elseIfStart + k].trimLeft().startsWith('_Urwigo') ||
              lines[elseIfStart + k].trimLeft().startsWith('{') ||
              lines[elseIfStart + k].trimLeft().startsWith('}') ||
              lines[elseIfStart + k].trimLeft().startsWith('Wherigo') ||
              lines[elseIfStart + k].trimLeft().startsWith('end')) {
          } else {
            if (lines[elseIfStart + k].trimLeft().startsWith('Text'))
              answerCorrect.add(ActionData('txt', getTextData(lines[elseIfStart + k], obfuscator, dtable)));
            else if (lines[elseIfStart + k].trimLeft().startsWith('Media'))
              answerCorrect.add(ActionData('img', lines[elseIfStart + k].trimLeft().replaceAll('Media = ', '')));
            else
              answerCorrect.add(ActionData('act', lines[elseIfStart + k].trimLeft()));
          }
          k++;
        } while (lines[elseIfStart + k].trimLeft() != 'end');

        result.add(
            AnswerData(
                inputObject,
                question,
                help,
                answer,
                answerCorrect,
                answerWrong));
        i = elseIfStart + k;
      }
    }
  };
  return result;
}
