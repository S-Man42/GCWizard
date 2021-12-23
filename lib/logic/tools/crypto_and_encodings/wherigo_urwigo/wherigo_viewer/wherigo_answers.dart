
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/urwigo_tools.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_input.dart';

class AnswerData{
  final String AnswerInput;
  final String AnswerQuestion;
  final String AnswerHelp;
  final String AnswerAnswer;
  final List<ActionData> AnswerActions;
  final List<ActionData> AnswerCorrectActions;
  final List<ActionData> AnswerWrongActions;

  AnswerData(
      this.AnswerInput,
      this.AnswerQuestion,
      this.AnswerHelp,
      this.AnswerAnswer,
      this.AnswerActions,
      this.AnswerCorrectActions,
      this.AnswerWrongActions);
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
  List<String> answerList = [];
  List<AnswerData> result = [];
  String inputObject = '';
  String question = '';
  String help = '';
  String answer = '';
  List<ActionData> answerCorrect = [];
  List<ActionData> answerWrong = [];
  List<ActionData> answerActions = [];
  bool sectionAnalysed = false;
  bool getInputAnalysed = false;
  bool actionsToCheck = true;
  bool multiAnswer = false;
  bool skipWrongSection = false;
  int k = 0;
  int l = 0;

  for (int i = 0; i < lines.length; i++){
    if (lines[i].trimRight().endsWith(':OnGetInput(input)')) {
      // function for getting an input for an inputobject found
      inputObject = '';
      question = '';
      help = '';
      answer = '';
      answerCorrect = [];
      answerWrong = [];
      answerActions = [];
      actionsToCheck = true;
      sectionAnalysed = false;
      getInputAnalysed = false;
      skipWrongSection = false;
      multiAnswer = false;

      // getting name of function
      inputObject = lines[i].replaceAll('function ', '').replaceAll(':OnGetInput(input)', '');
      inputs.forEach((element) {
        if (element.InputLUAName == inputObject){
          question = element.InputName;
          help = element.InputText;
        }
      });

      if (lines[i + 1].trimLeft() == 'if input == nil then')
        i = i + 3;
      else if (lines[i + 1].trimLeft() == 'input = tonumber(input)')
        i = i + 4;

      // searching for inputs and actions
      k = 1;
      l = 1;
      do {
        sectionAnalysed = false;
        skipWrongSection = false;

        if ((i + k + l > lines.length) || (lines[i + k].trimLeft().startsWith('end') && lines[i + k + 1].trimLeft().startsWith('function'))) {
          getInputAnalysed = true;
        }

        else if (lines[i + k].trimLeft().startsWith('if _Urwigo.Hash(') ||
            lines[i + k].trimLeft().startsWith('elseif _Urwigo.Hash(')) {
          // get answer
          answer = lines[i + k].trimLeft()
              .replaceAll('input', '')
              .replaceAll('string.lower()', '')
              .replaceAll('string.upper()', '')
              .replaceAll('if _Urwigo.Hash() == ', '')
              .replaceAll('else', '')
              .replaceAll(' then', '');
            answer = breakUrwigoHash(int.parse(answer));
          // get actions branch - correct answer
          // get actions branch - wrong answer
          actionsToCheck = true;

        }

        else if (lines[i + k].trimLeft().startsWith('if Wherigo.NoCaseEquals(input')) {
          // get answer
          answer = lines[i + k].trimLeft()
              .replaceAll('if Wherigo.NoCaseEquals(input, "', '')
              .replaceAll('") then', '');
          // get actions branch - correct answer
          // get actions branch - wrong answer
          actionsToCheck = true;

        }

        else if ((lines[i + k].trimLeft().startsWith('if input == ') ||
            lines[i + k].trimLeft().startsWith('elseif input == ')) &&
            (lines[i + k].trimLeft() != 'if input == nil then')) {

          // get answer
          answerList = lines[i + k].trimLeft()
              .replaceAll('if', '')
              .replaceAll('else', '')
              .replaceAll('input == ', '')
              .replaceAll('then', '')
              .replaceAll(' ', '').split('or');

          if (answerList.length > 1)
            multiAnswer = true;
          answer = answerList[0];

          // get actions branch - correct answer
          // get actions branch - wrong answer
          actionsToCheck = true;
        }

        else if (lines[i + k].trim().replaceAll('input', '') != '=tonumber()'){
          answerCorrect = [];
          answerWrong = [];
          answerActions = [];

          // get answer
          answer = lines[i + k].trimLeft();

          // get actions branch - correct answer
          l = 1;
          do {
            answerActions.add(ActionData('act', lines[i + k + l].trimLeft()));
            l++;
          } while (!(lines[i + k + l].trimLeft() == 'end' && lines[i + k + l + 1].trimLeft() == 'function'));

          actionsToCheck = false;
        }

        // check actions
        if (actionsToCheck = true) {
          // get actions branch - correct answer
          answerCorrect = [];
          answerWrong = [];
          sectionAnalysed = false;
          getInputAnalysed = false;
          skipWrongSection = false;

          do {
            if (i + k + l + 1 > lines.length) {
              getInputAnalysed = true;
              sectionAnalysed = true;
            }

            else if (lines[i + k + l].trimLeft().startsWith('end') && lines[i + k + l + 1].trimLeft().startsWith('function')) {
              getInputAnalysed = true;
              sectionAnalysed = true;
            }

//            else if (lines[i + k + l].trimLeft().startsWith('end') && lines[i + k + l + 1].trimLeft().startsWith('elseif input ==')) {
            else if (lines[i + k + l].trimLeft().startsWith('elseif input ==')) {
                skipWrongSection = true;
                sectionAnalysed = true;
            }

            else if (lines[i + k + l].trimLeft().startsWith('else')) {
              sectionAnalysed = true;
            }

            else if (lines[i + k + l].trimLeft().startsWith('_Urwigo') ||
                lines[i + k + l].trimLeft().startsWith('{') ||
                lines[i + k + l].trimLeft().startsWith('}') ||
                lines[i + k + l].trimLeft().startsWith('Wherigo') ||
                lines[i + k + l].trimLeft().startsWith('Callback') ||
                lines[i + k + l].trimLeft().startsWith('if action') ||
                lines[i + k + l].trimLeft().startsWith('end')) {
              // do nothing
            }

            else if (lines[i + k + l].trimLeft().startsWith('elseif _Urwigo')) {
              // jump over this input
              do {
                k++;
              } while (!lines[i + k + l + 1].trimLeft().startsWith('else'));
            }

            else if (lines[i + k + l].trimLeft().startsWith('Text')) {
              answerCorrect.add(ActionData(
                  'txt', getTextData(lines[i + k + l], obfuscator, dtable)));
            }

            else if (lines[i + k + l].trimLeft().startsWith('Media')) {
              answerCorrect.add(ActionData('img',
                  lines[i + k + l].trimLeft().replaceAll('Media = ', '')));
            }

            else if (lines[i + k + l].trimLeft().startsWith('Buttons')) {
              l++;
              do {
                answerCorrect.add(ActionData('btn',
                    getTextData('Text = ' + lines[i + k + l].trim(), obfuscator, dtable)));
                l++;
              } while (!lines[i + k + l].trimLeft().startsWith('}'));
            }

            else {
              answerCorrect.add(ActionData('act', lines[i + k + l].trimLeft()));
            }

            l++;
          } while(!sectionAnalysed);

          // get actions branch - wrong answer
          if (!skipWrongSection) {
            answerWrong = [];
            sectionAnalysed = false;
            //l++;
            do {
              if (i + k + l > lines.length) {
                sectionAnalysed = true;
                getInputAnalysed = true;
              }

              else if (lines[i + k + l].trimLeft().startsWith('end') && lines[i + k + l + 1].trimLeft().startsWith('elseif input == ')) {
                getInputAnalysed = true;
                sectionAnalysed = true;
              }

              else if (lines[i + k + l].trimLeft().startsWith('end') && lines[i + k + l + 1].trimLeft().startsWith('function')) {
                sectionAnalysed = true;
                getInputAnalysed = true;
              }

              else if (lines[i + k + l].trimLeft().startsWith('_Urwigo') ||
                  lines[i + k + l].trimLeft().startsWith('{') ||
                  lines[i + k + l].trimLeft().startsWith('}') ||
                  lines[i + k + l].trimLeft().startsWith('Wherigo') ||
                  lines[i + k + l].trimLeft().startsWith('Callback') ||
                  lines[i + k + l].trimLeft().startsWith('if action') ||
                  lines[i + k + l].trimLeft().startsWith('end')) {
              }

              else if (lines[i + k + l].trimLeft().startsWith('Text')) {
                answerWrong.add(ActionData(
                    'txt', getTextData(lines[i + k + l], obfuscator, dtable)));
              }

              else if (lines[i + k + l].trimLeft().startsWith('Media')) {
                answerWrong.add(ActionData('img',
                    lines[i + k + l].trimLeft().replaceAll('Media = ', '').replaceAll(',', '')));
              }

              else if (lines[i + k + l].trimLeft().startsWith('Buttons')) {
                l++;
                do {
                  answerWrong.add(ActionData('btn',
                      getTextData('Text = ' + lines[i + k + l].trim(), obfuscator, dtable)));
                  l++;
                } while (!lines[i + k + l].trimLeft().startsWith('}'));
              }

              else {
                answerWrong.add(ActionData('act', lines[i + k + l].trimLeft()));
              }

              l++;
            } while(!sectionAnalysed && !getInputAnalysed && (i + k + l < lines.length));          }
        }
        i = i + k + l - 1;

        if (multiAnswer)
          answerList.forEach((element) {
            result.add(
                AnswerData(
                    inputObject,
                    question,
                    help,
                    element,
                    answerActions,
                    answerCorrect,
                    answerWrong));
          });
        else
          result.add(
              AnswerData(
                  inputObject,
                  question,
                  help,
                  answer,
                  answerActions,
                  answerCorrect,
                  answerWrong));
      } while (!getInputAnalysed); // do search actions
    } // end if OnGetInput
  } // end for i=0 to lines.length
  return result;
}
