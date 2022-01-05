
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/urwigo_tools.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_input.dart';

class AnswerData{
  final String AnswerInput;
  final String AnswerQuestion;
  final String AnswerHelp;
  final String AnswerAnswer;
  final List<ActionData> AnswerActions;

  AnswerData(
      this.AnswerInput,
      this.AnswerQuestion,
      this.AnswerHelp,
      this.AnswerAnswer,
      this.AnswerActions,
      );
}

class ActionData{
  final String ActionType;
  final String ActionContent;

  ActionData(
      this.ActionType,
      this.ActionContent
      );
}

Map<String, dynamic> getAnswersFromCartridge(String LUA, List<InputData> inputs, dtable, obfuscator){
  List<String> lines = LUA.split('\n');
  List<AnswerData> Answers = [];

  List<String> answerList = [];
  Map<String, ObjectData> NameToObject = {};
  var out = Map<String, dynamic>();

  String inputObject = '';
  String question = '';
  String help = '';
  String answer = '';
  ActionData action;
  List<ActionData> answerActions = [];
  bool sectionAnalysed = false;
  bool insideInputFunction = false;

  for (int i = 0; i < lines.length - 1; i++) {
    if (lines[i].trimRight().endsWith(':OnGetInput(input)')) {
      print((i+1).toString()+' '+lines[i]);
      // function for getting all inputs for an inputobject found
      insideInputFunction = true;
      inputObject = '';
      question = '';
      help = '';
      answer = '';
      answerActions = [];

      // getting name of function
      inputObject = lines[i].replaceAll('function ', '').replaceAll(
          ':OnGetInput(input)', '');
      inputs.forEach((element) {
        if (element.InputLUAName == inputObject) {
          question = element.InputName;
          help = element.InputText;
        }
      });
      i++;
    } // end if identify input function

    if (lines[i].trimLeft() == 'input = tonumber(input)') {
      // do nothing;
    }

    else if (lines[i].trimLeft() == 'if input == nil then') {
      // suppress this
      //answer = 'NIL';
      i++;
      sectionAnalysed = false;
      do {
        // if (lines[i].trimLeft().startsWith('Buttons = ')) {
        //   do {
        //     i++;
        //     if (lines[i].trim() != '}' || lines[i].trim() != '{,') {
        //       if (lines[i].trimLeft().startsWith(obfuscator))
        //         answerActions.add(ActionData('btn', deobfuscateUrwigoText(lines[i].trim().replaceAll(obfuscator + '("', '').replaceAll('")', ''), dtable)));
        //       else
        //         answerActions.add(ActionData('btn', lines[i].trim().replaceAll(obfuscator + '("', '').replaceAll('")', '')));
        //     }
        //   } while (!lines[i].trim().startsWith('}'));
        // } // end if buttons
        // else {
        //   action = _handleLine(lines[i].trimLeft(), dtable, obfuscator);
        //   if (action != null)
        //     answerActions.add(action);
        // } // end if other line content
        i++;
        if (lines[i].trim() == 'end')
          sectionAnalysed = true;
      } while (!sectionAnalysed); // end of section

      // result.add(AnswerData(
      //   inputObject,
      //   question,
      //   help,
      //   answer,
      //   answerActions,
      // ));
      // answerActions = [];
    } // end of NIL

    else if (_SectionEnd(lines[i])) { //
      if (insideInputFunction) {
        answerList.forEach((answer) {
          Answers.add(AnswerData(
            inputObject,
            question,
            help,
            answer,
            answerActions,
          ));
        });
        answerActions = [];
        answerList = _getAnswers(i, lines[i], lines[i - 1]);
      }
    }

    else if (_FunctionEnd(lines[i], lines[i + 1])) {
      if (insideInputFunction) {
        insideInputFunction = false;
        answerList.forEach((answer) {
          Answers.add(AnswerData(
            inputObject,
            question,
            help,
            answer,
            answerActions,
          ));
        });
        answerActions = [];
        answerList = [];
      }
    }

    else { // handle action
      if (lines[i].trimLeft().startsWith('Buttons = ')) {
        do {
          i++;
          if (lines[i].trim() != '}' || lines[i].trim() != '{,') {
            if (lines[i].trimLeft().startsWith(obfuscator)) {
              answerActions.add(ActionData(
                  'btn', deobfuscateUrwigoText(lines[i].trim().replaceAll(obfuscator + '("', '').replaceAll('")', ''), dtable)));
            } else {
              answerActions.add(ActionData('btn', lines[i].trim().replaceAll(obfuscator + '("', '').replaceAll('")', '')));
            }
          }
        } while (!lines[i].trim().startsWith('}'));
      } // end if buttons
      else {
        action = _handleLine(lines[i].trimLeft(), dtable, obfuscator);
        if (action != null)
          answerActions.add(action);
      } // end if other line content
    }

  } // end for - got all functions

  out.addAll({'content': Answers});
  out.addAll({'names': NameToObject});
  return out;
}


List<String> _getAnswers(int i, String line, String lineBefore){
  if (line.trim().startsWith('if input == ') ||
      line.trim().startsWith('elseif input == ')) {
    return line.trimLeft()
        .replaceAll('if', '')
        .replaceAll('else', '')
        .replaceAll('input == ', '')
        .replaceAll('then', '')
        .replaceAll(' ', '')
        .split('or');
  }
  else if (line.trim().startsWith('if _Urwigo.Hash(') ||
      line.trim().startsWith('elseif _Urwigo.Hash(')) {
    List<String> results = [];
    int hashvalue = 0;
    line.trim()
        .replaceAll('if ', '')
        .replaceAll('elseif ', '')
        .replaceAll('_Urwigo.Hash', '')
        .replaceAll('input', '')
        .replaceAll('=', '')
        .replaceAll('string.lower', '')
        .replaceAll('string.upper', '')
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll('then', '')
        .replaceAll('else', '')
        .replaceAll(' ', '')
        .split('or').forEach((element) {
          hashvalue = int.parse(element);
      results.add(breakUrwigoHash(hashvalue).toString());
    });
    return results;
  }
  else if (line.trim().startsWith('if Wherigo.NoCaseEquals(') ||
      line.trim().startsWith('elseif Wherigo.NoCaseEquals(')) {
    if (lineBefore.endsWith('= input'))
      lineBefore = lineBefore.trim().replaceAll(' = input', '').replaceAll(' ', '');
    return [line.trim()
        .replaceAll('if ', '')
        .replaceAll('elseif ', '')
        .replaceAll('Wherigo.NoCaseEquals', '')
        .replaceAll(lineBefore + ',', '')
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll('"', '')
        .replaceAll('then', '')
        .replaceAll('else', '')
        .replaceAll(' ', '')];
  }
}

bool _SectionEnd(String line){
  if (line.trim().startsWith('if input == ') ||
      line.trim().startsWith('elseif input == ') ||
      line.trim().startsWith('if _Urwigo.Hash(') ||
      line.trim().startsWith('elseif _Urwigo.Hash(') ||
      line.trim().startsWith('if Wherigo.NoCaseEquals(') ||
      line.trim().startsWith('elseif Wherigo.NoCaseEquals('))
    return true;
  else
    return false;
}

bool _FunctionEnd(String line1, String line2) {
 return (line1.trim() == 'end' && line2.trimLeft().startsWith('function'));
}


ActionData _handleLine(String line, String dtable, String obfuscator) {
  if (line.startsWith('_Urwigo') ||
      line.startsWith('Callback') ||
      line.startsWith('Wherigo') ||
      line.startsWith('Buttons') ||
      line.startsWith('end') ||
      line == ']]' ||
      line.startsWith('if action') ||
      line.startsWith('{') ||
      line.startsWith('}'))
    return null;
  else
    if (line.startsWith('Text = '))
//      if (line.replaceAll('Text = ', '').startsWith(obfuscator))
        return ActionData('txt', getTextData(line, obfuscator, dtable));
//      else
//        return ActionData('txt', line);
    else
    if (line.startsWith('Media = '))
      return ActionData('img', line.trimLeft().replaceAll('Media = ', ''));
    else
    if (line.startsWith('if '))
      return ActionData('cse', line.trimLeft());
    if (line.startsWith('elseif '))
      return ActionData('cse', line.trimLeft());
    if (line.startsWith('else'))
      return ActionData('cse', line.trimLeft());
    else
      return ActionData('act', line.trimLeft());
}


