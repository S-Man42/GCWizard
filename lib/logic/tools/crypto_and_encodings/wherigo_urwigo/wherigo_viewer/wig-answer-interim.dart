
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
  bool answerFound = false;
  bool numberInput = false;
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
      answerFound = false;
      numberInput = false;

      // getting name of function
      inputObject = lines[i].replaceAll('function ', '').replaceAll(':OnGetInput(input)', '');
      inputs.forEach((element) {
        if (element.InputLUAName == inputObject){
          question = element.InputName;
          help = element.InputText;
        }
      });

      //check type of input: number or text
      if (lines[i + 1].trimLeft() == 'input = tonumber(input)')
        numberInput = true;

      //get all inputs for the function

      if (numberInput) {

      }

      else {

      }


      // if (lines[i + 1].trimLeft() == 'if input == nil then')
      //   i = i + 3;
      // else if (lines[i + 1].trimLeft() == 'input = tonumber(input)')
      //   i = i + 4;

      // searching for inputs and actions
      k = 1;
      l = 1;
      do {
        sectionAnalysed = false;
        skipWrongSection = false;

        // search for answer
        while(!answerFound) {
          if (i + k + 1 > lines.length) {
            getInputAnalysed = true;
          }

          else if (lines[i + k].trimLeft().startsWith('end') && lines[i + k + 1].trimLeft().startsWith('function')) {
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
            answerFound = true;
            // get actions branch - correct answer
            // get actions branch - wrong answer
            actionsToCheck = true;

          }

          else if (lines[i + k].trimLeft().startsWith('if Wherigo.NoCaseEquals(') ||
              lines[i + k].trimLeft().startsWith('elseif Wherigo.NoCaseEquals(')) {
            // get answer
            answer = lines[i + k].trimLeft()
                .replaceAll('if Wherigo.NoCaseEquals(', '')
                .replaceAll('else', '')
                .replaceAll('"', '')
                .replaceAll(') then', '')
                .replaceAll(' ', '');
            if (answer.split(',').length == 2) {
              answer = answer.split(',')[1];
            }
            answerFound = true;
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
            answerFound = true;

            if (answerList.length > 1)
              multiAnswer = true;
            answer = answerList[0];

            // get actions branch - correct answer
            // get actions branch - wrong answer
            actionsToCheck = true;
          }

          else if (lines[i + k].trim().endsWith(' = tonumber(input)')){

            sectionAnalysed = false;
            answerActions = [];
            answerCorrect = [];
            answerWrong = [];
            l = 1;
            do { // get all cases for input number
              do {
                if (lines[i + k + l].trimLeft().startsWith('if input == nil')) {
                  answer = 'nil';
                }

                else

                if (true) {

                }
              } while (!lines[i + k +l].trimLeft().startsWith('end'));
              result.add(
                  AnswerData(
                      inputObject,
                      question,
                      help,
                      answer,
                      answerActions,
                      answerCorrect,
                      answerWrong));

              if (lines[i + k + l].trimLeft().startsWith('end') && lines[i + k + l + 1].trimLeft().startsWith('function'))
                sectionAnalysed = true;

            } while (!sectionAnalysed);

            // get answer
            answer = lines[i + k].trimLeft();
            answerFound = true;

            skipWrongSection = true;
            // get actions branch - correct answer
            l = 1;
            sectionAnalysed = false;
            do {

              if (lines[i + k + l].trimLeft().startsWith('if') ||
                  lines[i + k + l].trimLeft().startsWith('else')) {
                answerActions.add(ActionData(
                    'cse', lines[i + k + l].trimLeft()
                    .replaceAll('else', '')
                    .replaceAll('if ', '')
                    .replaceAll(' or ', '\n')
                    .replaceAll('==', '=')
                    .replaceAll(' then', '')));
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

              else if (lines[i + k + l].trimLeft().startsWith('Text')) {
                answerActions.add(ActionData(
                    'txt', getTextData(lines[i + k + l], obfuscator, dtable)));
              }

              else if (lines[i + k + l].trimLeft().startsWith('Media')) {
                answerActions.add(ActionData('img',
                    lines[i + k + l].trimLeft().replaceAll('Media = ', '')));
              }

              else if (lines[i + k + l].trimLeft().startsWith('Buttons')) {
                l++;
                do {
                  answerActions.add(ActionData('btn',
                      getTextData('Text = ' + lines[i + k + l].trim(), obfuscator, dtable)));
                  l++;
                } while (!lines[i + k + l].trimLeft().startsWith('}'));
              }

              else {
                answerActions.add(ActionData('act', lines[i + k + l].trimLeft()));
              }

              l++;
              if (lines[i + k + l].trimLeft().startsWith('end') && lines[i + k + l + 1].trimLeft().startsWith('function'))
                sectionAnalysed = true;
            } while (!sectionAnalysed);

            actionsToCheck = false;
          }
          k++;
        }

        // check actions
        if (actionsToCheck) {
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
        if (lines[i].trimLeft().startsWith('end') && lines[i + 1].trimLeft().startsWith('function'))
          getInputAnalysed = true;

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
