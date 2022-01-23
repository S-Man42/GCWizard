
import 'dart:developer';

import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/urwigo_tools.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';

class InputData{
  final String InputLUAName;
  final String InputID;
  final String InputName;
  final String InputDescription;
  final String InputVisible;
  final String InputMedia;
  final String InputIcon;
  final String InputType;
  final String InputText;
  final List<String> InputChoices;
  final List<AnswerData> InputAnswers;

  InputData(
      this.InputLUAName,
      this.InputID,
      this.InputName,
      this.InputDescription,
      this.InputVisible,
      this.InputMedia,
      this.InputIcon,
      this.InputType,
      this.InputText,
      this.InputChoices,
      this.InputAnswers);
}

class AnswerData{
  final String AnswerAnswer;
  final List<ActionData> AnswerActions;

  AnswerData(
      this.AnswerAnswer,
      this.AnswerActions,
      );
}

class ActionData{
  final ACTIONMESSAGETYPE ActionType;
  final String ActionContent;

  ActionData(
      this.ActionType,
      this.ActionContent
      );
}

Map<String, dynamic> getInputsFromCartridge(String LUA, dtable, obfuscator){
  RegExp re = RegExp(r'( = Wherigo.ZInput)');
  List<String> lines = LUA.split('\n');

  bool section = true;
  bool sectionChoices = true;
  String LUAname = '';
  String id = '';
  String name = '';
  String description = '';
  String visible = '';
  String media = '';
  String icon = '';
  String inputType = '';
  String text = '';
  List<String> listChoices = [];

  String inputObject = '';

  List<String> answerList = [];
  Map<String, List<AnswerData>> Answers = {};

  ActionData action;
  List<ActionData> answerActions = [];

  bool sectionAnalysed = false;
  bool insideInputFunction = false;

  List<InputData> Inputs = [];
  List<InputData> resultInputs = [];
  Map<String, ObjectData> NameToObject = {};
  var out = Map<String, dynamic>();

  for (int i = 0; i < lines.length - 1; i++) {
    // get all ZInput-Objects
    if (re.hasMatch(lines[i])) {
      LUAname = '';
      id = '';
      name = '';
      description = '';
      visible = '';
      media = '';
      icon = '';
      inputType = '';
      text = '';
      listChoices = [];

      LUAname = getLUAName(lines[i]);

      i++;
      id = getLineData(lines[i], LUAname, 'Id', obfuscator, dtable);

      i++;
      name = getLineData(lines[i], LUAname, 'Name', obfuscator, dtable);

      description = '';
      section = true;
      i++;
      do {
        description = description + lines[i];
        i++;
        if (i > lines.length - 1 || lines[i].startsWith(LUAname + '.Visible'))
          section = false;
      } while (section);
      description =
          getLineData(description, LUAname, 'Description', obfuscator, dtable);

      section = true;
      do {
        if (i < lines.length - 1) {
          if (lines[i].startsWith(LUAname + '.Visible')) {
            visible = getLineData(
                lines[i], LUAname, 'Visible', obfuscator, dtable);
          }

          if (lines[i].startsWith(LUAname + '.Media')) {
            media = getLineData(
                lines[i], LUAname, 'Media', obfuscator, dtable);
          }

          if (lines[i].startsWith(LUAname + '.Icon')) {
            icon = getLineData(
                lines[i], LUAname, 'Icon', obfuscator, dtable);
          }

          if (lines[i].startsWith(LUAname + '.InputType')) {
            inputType = getLineData(
                lines[i], LUAname, 'InputType', obfuscator, dtable);
          }

          if (lines[i].startsWith(LUAname + '.Text')) {
            text = getLineData(
                lines[i], LUAname, 'Text', obfuscator, dtable);
          }

          if (lines[i].startsWith(LUAname + '.Choices')) {
            listChoices = [];
            if (lines[i + 1].startsWith(LUAname + '.InputType')) {
              listChoices.addAll(
                  getChoicesSingleLine(lines[i], LUAname, obfuscator, dtable));
            } else {
              i++;
              sectionChoices = true;
              do {
                if (lines[i].trimLeft().startsWith('"')) {
                  listChoices.add(
                      lines[i ].trimLeft().replaceAll('"', '').replaceAll(
                          ',', ''));
                  i++;
                } else {
                  sectionChoices = false;
                }
              } while (sectionChoices);
            }
          }

          if (lines[i].startsWith(LUAname + '.Text'))
            section = false;
        }
        i++;
      } while (section);
      i--;
      Inputs.add(InputData(
        LUAname,
        id,
        name,
        description,
        visible,
        media,
        icon,
        inputType,
        text,
        listChoices,
        [],
      ));
      NameToObject[LUAname] = ObjectData(id, 0, name, media, OBJECT_TYPE.INPUT);
    }

    // get all Answers - these are part of the function <InputObjcet>:OnGetInput(input)

    if (lines[i].trimRight().endsWith(':OnGetInput(input)')) {
      // function for getting all inputs for an input object found
      insideInputFunction = true;
      inputObject = '';
      answerActions = [];

      // getting name of function
      inputObject = lines[i].replaceAll('function ', '').replaceAll(
          ':OnGetInput(input)', '');
      Answers[inputObject] = [];
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
        i++;
        if (lines[i].trim() == 'end')
          sectionAnalysed = true;
      } while (!sectionAnalysed); // end of section
    } // end of NIL

    else if (_SectionEnd(lines[i])) { //
      if (insideInputFunction) {
        answerList.forEach((answer) {
          Answers[inputObject].add(
              AnswerData(
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
          Answers[inputObject].add(
              AnswerData(
                answer,
                answerActions,
              ));
        });
        answerActions = [];
        answerList = [];
      }
    }

    else if (lines[i].trimLeft().startsWith('Buttons')) {
      do {
        i++;
        if (!(lines[i].trim() == '}' || lines[i].trim() == '},')) {
          if (lines[i].trimLeft().startsWith(obfuscator))
            answerActions.add(ActionData(ACTIONMESSAGETYPE.BUTTON, deobfuscateUrwigoText(lines[i].trim().replaceAll(obfuscator + '("', '').replaceAll('")', ''), dtable)));
          else
            answerActions.add(ActionData(ACTIONMESSAGETYPE.BUTTON, lines[i].trim().replaceAll(obfuscator + '("', '').replaceAll('")', '')));
        }
      } while (!lines[i].trim().startsWith('}'));
    }

    else {
      action = _handleLine(lines[i].trimLeft(), dtable, obfuscator);
      if (action != null)
        answerActions.add(action);
    } // end if other line content

  };

  Inputs.forEach((inputObject) {
    resultInputs.add(
        InputData(
            inputObject.InputLUAName,
            inputObject.InputID,
            inputObject.InputName,
            inputObject.InputDescription,
            inputObject.InputVisible,
            inputObject.InputMedia,
            inputObject.InputIcon,
            inputObject.InputType,
            inputObject.InputText,
            inputObject.InputChoices,
            Answers[inputObject.InputLUAName])
    );
  });

  out.addAll({'content': resultInputs});
  out.addAll({'names': NameToObject});
  resultInputs.forEach((element) {
    element.InputAnswers.forEach((element) {
    });
  });
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
  return (line1.trim() == 'end' && (line2.trimLeft().startsWith('function') || line2.trimLeft().startsWith('return')));
}


ActionData _handleLine(String line, String dtable, String obfuscator) {
  line = line.trim();
  if (line.startsWith('Wherigo.PlayAudio'))
    return ActionData(
        ACTIONMESSAGETYPE.COMMAND,
        line.trim());

  else if (line.startsWith('_Urwigo') ||
      line.startsWith('Callback') ||
      line.startsWith('Wherigo') ||
      line.startsWith('Buttons') ||
      line.startsWith('end') ||
      line == ']]' ||
      line.startsWith('if action') ||
      line.startsWith('{') ||
      line.startsWith('}'))
    return null;

  else if (line.startsWith('Text = '))
      return ActionData(
          ACTIONMESSAGETYPE.TEXT,
          getTextData(line, obfuscator, dtable));

  else if (line.startsWith('Media = '))
      return ActionData(
          ACTIONMESSAGETYPE.IMAGE,
          line.trimLeft().replaceAll('Media = ', ''));

  else if (line.startsWith('if '))
      return ActionData(
          ACTIONMESSAGETYPE.CASE,
          line.trimLeft());

  else if (line.startsWith('elseif '))
      return ActionData(
          ACTIONMESSAGETYPE.CASE,
          line.trimLeft());

  else if (line.startsWith('else'))
      return ActionData(
          ACTIONMESSAGETYPE.CASE,
          line.trimLeft());
  else
      return ActionData(
          ACTIONMESSAGETYPE.COMMAND,
          line.trimLeft());
}
