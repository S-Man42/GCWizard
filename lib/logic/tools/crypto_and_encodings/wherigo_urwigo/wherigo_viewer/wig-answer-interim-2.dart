
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
  ActionData action;
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
  bool sectionButtonsAnalysed = false;

  for (int i = 0; i < lines.length; i++) {
    if (lines[i].trimRight().endsWith(':OnGetInput(input)')) {
      // function for getting all inputs for an inputobject found
      print((i+1).toString()+' '+lines[i]);
      inputObject = '';
      question = '';
      help = '';
      answer = '';
      answerActions = [];
      answerCorrect = [];
      answerWrong = [];
      actionsToCheck = true;
      sectionAnalysed = false;
      getInputAnalysed = false;
      skipWrongSection = false;
      multiAnswer = false;
      answerFound = false;
      numberInput = false;

      // getting name of function
      inputObject = lines[i].replaceAll('function ', '').replaceAll(
          ':OnGetInput(input)', '');
      inputs.forEach((element) {
        if (element.InputLUAName == inputObject) {
          question = element.InputName;
          help = element.InputText;
        }
      });

      //check type of input: number or text and handle NIL input
      do {
        i++;
        if (lines[i].trimLeft() == 'input = tonumber(input)') {
          numberInput = true;
        }

        else if (lines[i].trimLeft() == 'if input == nil then') {
          answer = 'NIL';
          i++;
          sectionAnalysed = false;
          do {
            if (lines[i].trimLeft().startsWith('Buttons = ')) {
              do {
                i++;
                if (lines[i].trim() != '}') {
                  if (lines[i].trimLeft().startsWith(obfuscator))
                    answerWrong.add(ActionData('btn', deobfuscateUrwigoText(lines[i], dtable)));
                  else
                    answerWrong.add(ActionData('btn', lines[i]));
                }
              } while (lines[i].trim() != '}');
            }
            else {
              action = _handleLine(lines[i].trimLeft(), dtable, obfuscator);
              if (action != null)
                answerWrong.add(action);
            }
            i++;
            if (lines[i].trim() == 'end')
              sectionAnalysed = true;
          } while (!sectionAnalysed);
          answerFound = true;
          result.add(AnswerData(
              inputObject,
              question,
              help,
              answer,
              answerActions,
              answerCorrect,
              answerWrong
          ));
        }

      } while (!answerFound );

      // get all inputs for the function
      do {
        i++;
        if (lines[i].endsWith(' = tonumber(input)')) {
          // get answer
          answer = lines[i].trim();

          // get actions
          answerActions = [];
          do {
            i++;
            if (lines[i].trimLeft().startsWith('Buttons = ')) {
              sectionAnalysed = false;
              do {
                i++;
                if (lines[i].trimLeft().startsWith(obfuscator))
                  answerActions.add(
                      ActionData(
                          'btn',
                          deobfuscateUrwigoText(
                              lines[i].trimLeft().replaceAll(obfuscator + '("', '').replaceAll('")', ''),
                              dtable)));
                else
                  answerActions.add(ActionData('btn', lines[i]));
                if (lines[i].trimLeft().startsWith('}'))
                  sectionAnalysed = true;
              } while (!sectionAnalysed);
            }
            else {
              action = _handleLine(lines[i].trimLeft(), dtable, obfuscator);
              if (action != null)
                answerActions.add(action);
            }
          } while (lines[i].trim() != 'end');

          // add answer
          result.add(AnswerData(
              inputObject,
              question,
              help,
              answer,
              answerActions,
              answerCorrect,
              answerWrong
          ));
        } // end if tonumber(input)

        else if (lines[i].trimLeft().startsWith('if input == ') ||
            lines[i].trimLeft().startsWith('elseif input == ')) {
          print((i+1).toString()+' '+lines[i]);
          // get answer
          answerList = lines[i].trimLeft()
              .replaceAll('if', '')
              .replaceAll('else', '')
              .replaceAll('input == ', '')
              .replaceAll('then', '')
              .replaceAll(' ', '')
              .split('or');

          if (answerList.length > 1)
            multiAnswer = true;
          answer = answerList[0];

          // get actions for "correct" branch
          answerActions = [];
          answerCorrect = [];
          sectionAnalysed = false;
          skipWrongSection = false;
          do {
            i++;
            if (lines[i].trimLeft().startsWith('Buttons = ')) {
              sectionButtonsAnalysed = false;
              do {
                i++;
                if (lines[i].trimLeft().startsWith(obfuscator))
                  answerCorrect.add(
                      ActionData(
                          'btn',
                          deobfuscateUrwigoText(
                              lines[i].trimLeft().replaceAll(obfuscator + '("', '').replaceAll('")', ''),
                              dtable)));
                else
                  answerCorrect.add(ActionData('btn', lines[i]));
                if (lines[i].trimLeft().startsWith('}'))
                  sectionButtonsAnalysed = true;
              } while (!sectionButtonsAnalysed);
            }
            else {
              action = _handleLine(lines[i].trimLeft(), dtable, obfuscator);
              if (action != null)
                answerCorrect.add(action);
            }
            if (lines[i].trim() == 'else')
              sectionAnalysed = true;
            if (i > lines.length ||
                lines[i].trim() == 'end' && lines[i + 1].trim().startsWith('function')) {
              sectionAnalysed = true;
              getInputAnalysed = true;
              skipWrongSection = true;
            }
          } while (!sectionAnalysed );

          // get actions for "wrong" branch
          answerWrong = [];
          if (!skipWrongSection && !getInputAnalysed) {
            sectionAnalysed = false;
            do { // analyse wrong branch
              i++;
              if (lines[i].trimLeft().startsWith('Buttons = ')) {
                sectionButtonsAnalysed = false;
                do {
                  i++;
                  if (lines[i].trimLeft().startsWith(obfuscator))
                    answerWrong.add(
                        ActionData(
                            'btn',
                            deobfuscateUrwigoText(
                                lines[i].trimLeft().replaceAll(obfuscator + '("', '').replaceAll('")', ''),
                                dtable)));
                  else
                    answerWrong.add(ActionData('btn', lines[i]));
                  if (lines[i].trimLeft().startsWith('}'))
                    sectionButtonsAnalysed = true;
                } while (!sectionButtonsAnalysed);
              }
              else {
                action = _handleLine(lines[i].trimLeft(), dtable, obfuscator);
                if (action != null)
                  answerWrong.add(action);
              }

              if (lines[i].trimLeft().startsWith('end') && lines[i + 1].trimLeft().startsWith('elseif input == ')) {
                print('end wrong section');
                sectionAnalysed = true;
              }

              if (lines[i].trimLeft().startsWith('end') && lines[i + 1].trim().startsWith('function')) {
                sectionAnalysed = true;
                getInputAnalysed = true;
              }
            } while (!sectionAnalysed && !getInputAnalysed);
          } // end if skipWrongSection

          // add answers
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
          print('end of input number');
        } // end if input == ...

        else if (lines[i].trimLeft().startsWith('if Wherigo.NoCaseEquals(') ||
            lines[i].trimLeft().startsWith('elseif Wherigo.NoCaseEquals(')) {

          // get answer
          answer = lines[i].trimLeft()
              .replaceAll('if Wherigo.NoCaseEquals(', '')
              .replaceAll('else', '')
              .replaceAll('"', '')
              .replaceAll(')', '')
              .replaceAll(' then', '');
          answer = answer.split(',')[1];

          // get actions for "correct" branch
          answerActions = [];
          answerCorrect = [];
          sectionAnalysed = false;
          skipWrongSection = false;
          do {
            i++;
            if (lines[i].trimLeft().startsWith('Buttons = ')) {
              sectionButtonsAnalysed = false;
              do {
                i++;
                if (lines[i].trimLeft().startsWith(obfuscator))
                  answerCorrect.add(
                      ActionData(
                          'btn',
                          deobfuscateUrwigoText(
                              lines[i].trimLeft().replaceAll(obfuscator + '("', '').replaceAll('")', ''),
                              dtable)));
                else
                  answerCorrect.add(ActionData('btn', lines[i]));
                if (lines[i].trimLeft().startsWith('}'))
                  sectionButtonsAnalysed = true;
              } while (!sectionButtonsAnalysed);
            }
            else {
              action = _handleLine(lines[i].trimLeft(), dtable, obfuscator);
              if (action != null)
                answerCorrect.add(action);
            }
            if (lines[i].trim() == 'else')
              sectionAnalysed = true;
            if (i > lines.length ||
                lines[i].trim() == 'end' && lines[i + 1].trim().startsWith('function')) {
              sectionAnalysed = true;
              getInputAnalysed = true;
              skipWrongSection = true;
            }
          } while (!sectionAnalysed );

          // get actions for "wrong" branch
          answerWrong = [];
          if (!skipWrongSection && !getInputAnalysed) {
            sectionAnalysed = false;
            do {
              i++;
              if (lines[i].trimLeft().startsWith('Buttons = ')) {
                sectionButtonsAnalysed = false;
                do {
                  i++;
                  if (lines[i].trimLeft().startsWith(obfuscator))
                    answerWrong.add(
                        ActionData(
                            'btn',
                            deobfuscateUrwigoText(
                                lines[i].trimLeft().replaceAll(obfuscator + '("', '').replaceAll('")', ''),
                                dtable)));
                  else
                    answerWrong.add(ActionData('btn', lines[i]));
                  if (lines[i].trimLeft().startsWith('}'))
                    sectionButtonsAnalysed = true;
                } while (!sectionButtonsAnalysed);
              }
              else {
                action = _handleLine(lines[i].trimLeft(), dtable, obfuscator);
                if (action != null)
                  answerWrong.add(action);
              }
              if (lines[i].trim().startsWith('elseif Wherigo.NoCaseEquals('))
                sectionAnalysed = true;
              if (lines[i].trim() == 'end' && lines[i + 1].trim().startsWith('function')) {
                sectionAnalysed = true;
                getInputAnalysed = true;
              }
            } while (!sectionAnalysed && !getInputAnalysed);
          }

          // add answer
          result.add(AnswerData(
              inputObject,
              question,
              help,
              answer,
              answerActions,
              answerCorrect,
              answerWrong
          ));
        } // end if Wherigo.NoCaseEquals

        else if (lines[i].trimLeft().startsWith('if _Urwigo.Hash(') ||
            lines[i].trimLeft().startsWith('if _Urwigo.Hash(')) {

        }

        if (lines[i].trimLeft() != 'function')
          getInputAnalysed = true;
      } while (!getInputAnalysed);
    } // end if - got all answers for the function
  } // end for - got all functions

  return result;
}


ActionData _handleLine(String line, String dtable, String obfuscator) {
  if (line.startsWith('_Urwigo') ||
      line.startsWith('Callback') ||
      line.startsWith('Wherigo') ||
      line.startsWith('end') ||
      line == 'else' ||
      line.startsWith('if action') ||
      line.startsWith('{') ||
      line.startsWith('}'))
    return null;
  else
  if (line.startsWith('Text = '))
    if (line.replaceAll('Text = ', '').startsWith(obfuscator))
      return ActionData('txt', getTextData(line, obfuscator, dtable));
    else
      return ActionData('txt', line);
  else
  if (line.startsWith('Media = '))
    return ActionData('img', line.trimLeft().replaceAll('Media = ', ''));
  else
  if (line.startsWith('if '))
    return ActionData('cse', line.trimLeft());
  if (line.startsWith('elseif '))
    return ActionData('cse', line.trimLeft());
  if (line.startsWith('else '))
    return ActionData('cse', line.trimLeft());
  else
    return ActionData('act', line.trimLeft());
}


