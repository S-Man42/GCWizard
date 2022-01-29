
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/urwigo_tools.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_dataobjects.dart';


Map<String, dynamic> getInputsFromCartridge(String LUA, dtable, obfuscator){

  List<String> lines = LUA.split('\n');

  bool section = true;
  bool sectionChoices = true;
  bool sectionText = true;
  String LUAname = '';
  String id = '';
  String variableID = '';
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

  ActionMessageElementData action;
  List<ActionMessageElementData> answerActions = [];

  bool sectionAnalysed = false;
  bool insideInputFunction = false;

  List<InputData> Inputs = [];
  List<InputData> resultInputs = [];
  Map<String, ObjectData> NameToObject = {};
  var out = Map<String, dynamic>();

  for (int i = 0; i < lines.length - 2; i++) {
    if (RegExp(r'( = Wherigo.ZInput)').hasMatch(lines[i])) {
      currentObjectSection = OBJECT_TYPE.INPUT;
      LUAname = '';
      id = '';
      variableID = '';
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

          if (lines[i].startsWith(LUAname + '.InputVariableId')) {
            variableID = getLineData(
                lines[i], LUAname, 'InputVariableId', obfuscator, dtable);
          }

          if (lines[i].startsWith(LUAname + '.Text')) {
            if (RegExp(r'( = Wherigo.ZInput)').hasMatch(lines[i + 1]) ||
                lines[i + 1].startsWith(LUAname + '.Media') ||
                RegExp(r'(:OnProximity)').hasMatch(lines[i + 1]))
              text = getLineData(
                  lines[i], LUAname, 'Text', obfuscator, dtable);
            else {
              text = '';
              sectionText = true;
              do {
                i++;
                text = text + lines[i];
                if (lines[i + 1].trim().startsWith('function'))
                  sectionText = false;
                if (RegExp(r'( = Wherigo.ZInput)').hasMatch(lines[i + 1]) ||
                    RegExp(r'(:OnProximity)').hasMatch(lines[i + 1]) ||
                    lines[i + 1].startsWith(LUAname + '.Media'))
                  sectionText = false;
              } while (sectionText);
              text = text.replaceAll(']]', '').replaceAll('<BR>', '\n');
            }
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
                      lines[i ]
                          .trimLeft()
                          .replaceAll('",', '')
                          .replaceAll('"', ''));
                  i++;
                } else {
                  sectionChoices = false;
                }
              } while (sectionChoices);
            }
          }

          if (RegExp(r'( = Wherigo.ZInput)').hasMatch(lines[i + 1]) ||
              RegExp(r'(:OnProximity)').hasMatch(lines[i + 1]))
            section = false;
        }
        i++;
      } while (section);
      i--;
      Inputs.add(InputData(
        LUAname,
        id,
        variableID,
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
          ':OnGetInput(input)', '').trim();
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
        answerList = _getAnswers(i, lines[i], lines[i - 1], obfuscator, dtable);
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
            answerActions.add(ActionMessageElementData(ACTIONMESSAGETYPE.BUTTON, deobfuscateUrwigoText(lines[i].trim().replaceAll(obfuscator + '("', '').replaceAll('")', ''), dtable)));
          else
            answerActions.add(ActionMessageElementData(ACTIONMESSAGETYPE.BUTTON, lines[i].trim().replaceAll(obfuscator + '("', '').replaceAll('")', '')));
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
            inputObject.InputLUAName.trim(),
            inputObject.InputID,
            inputObject.InputVariableID,
            inputObject.InputName,
            inputObject.InputDescription,
            inputObject.InputVisible,
            inputObject.InputMedia,
            inputObject.InputIcon,
            inputObject.InputType,
            inputObject.InputText,
            inputObject.InputChoices,
            Answers[inputObject.InputLUAName.trim()])
    );
  });

  out.addAll({'content': resultInputs});
  out.addAll({'names': NameToObject});
  return out;
}

List<String> _getAnswers(int i, String line, String lineBefore, String obfuscator, String dtable){
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
  else if (RegExp(r'(_Urwigo.Hash)').hasMatch(line)) {
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
        .replaceAll('true', '')
        .replaceAll(' ', '')
        .split('or').forEach((element) {
      hashvalue = int.parse(element.replaceAll('\D+', ''));
      results.add(breakUrwigoHash(hashvalue).toString());
    });
    return results;
  }
  else if (line.trim().startsWith('if Wherigo.NoCaseEquals(') ||
      line.trim().startsWith('elseif Wherigo.NoCaseEquals(')) {
    if (lineBefore.trim().endsWith('= input'))
      lineBefore = lineBefore.trim().replaceAll(' = input', '').replaceAll(' ', '');
    line = line.trim()
        .replaceAll('if ', '')
        .replaceAll('elseif ', '')
        .replaceAll('Wherigo.NoCaseEquals', '')
        .replaceAll(lineBefore + ',', '')
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll('"', '')
        .replaceAll('then', '')
        .replaceAll('else', '')
        .replaceAll('input,', '')
        .replaceAll('Answer,', '')
        .trim();
    if (RegExp(r'(' + obfuscator + ')').hasMatch(line)) {
      return [
        deobfuscateUrwigoText(
            line.replaceAll(obfuscator, '').replaceAll('("', '').replaceAll(
                '")', ''), dtable)
      ];
    }else
      return [line];
  }
}

bool _SectionEnd(String line){
  if (line.trim().startsWith('if input == ') ||
      line.trim().startsWith('elseif input == ') ||
      line.trim().startsWith('if _Urwigo.Hash(') ||
      line.trim().startsWith('if (_Urwigo.Hash(') ||
      line.trim().startsWith('elseif _Urwigo.Hash(') ||
      line.trim().startsWith('elseif (_Urwigo.Hash(') ||
      line.trim().startsWith('if Wherigo.NoCaseEquals(') ||
      line.trim().startsWith('elseif Wherigo.NoCaseEquals('))
    return true;
  else
    return false;
}

bool _FunctionEnd(String line1, String line2) {
  return (line1.trim() == 'end' && (line2.trimLeft().startsWith('function') || line2.trimLeft().startsWith('return')));
}


ActionMessageElementData _handleLine(String line, String dtable, String obfuscator) {
  line = line.trim();
  if (line.startsWith('Wherigo.PlayAudio'))
    return ActionMessageElementData(
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

  else if (line.startsWith('Text = ')) {
    return ActionMessageElementData(
        ACTIONMESSAGETYPE.TEXT,
        getTextData(line, obfuscator, dtable));
  }
  else if (line.startsWith('Media = ')) {
    return ActionMessageElementData(
        ACTIONMESSAGETYPE.IMAGE,
        line.trimLeft().replaceAll('Media = ', '').replaceAll(',', ''));
  }
  else if (line.startsWith('if '))
      return ActionMessageElementData(
          ACTIONMESSAGETYPE.CASE,
          line.trimLeft());

  else if (line.startsWith('elseif '))
      return ActionMessageElementData(
          ACTIONMESSAGETYPE.CASE,
          line.trimLeft());

  else if (line.startsWith('else'))
      return ActionMessageElementData(
          ACTIONMESSAGETYPE.CASE,
          line.trimLeft());
  else {
    String actionLine = '';
    if (RegExp(r'(' + obfuscator + ')').hasMatch(line)) {
      List<String> actions = line.trim().split('=');
      if (actions.length == 2) {
        actionLine = actions[0].trim() + ' = ' +
                      deobfuscateUrwigoText(
                          (actions[1].indexOf('")') > 0)
                              ? actions[1].substring(0, actions[1].indexOf('")'))
                                .replaceAll(obfuscator, '')
                                .replaceAll('("', '')
                                .replaceAll('")', '')
                                .trim()
                              : actions[1]
                                .replaceAll(obfuscator, '')
                                .replaceAll('("', '')
                                .replaceAll('")', '')
                                .trim()
                          , dtable);
      } else {
        actionLine = deobfuscateUrwigoText(
                        actions[0].replaceAll(obfuscator, '').replaceAll('("', '').replaceAll('")', '').trim(),
                        dtable);
      }
    }
    else
      actionLine = line.trimLeft();
    actionLine = actionLine.replaceAll('<BR>', '\n').replaceAll(']],', '');
    return ActionMessageElementData(ACTIONMESSAGETYPE.COMMAND, actionLine);
  }
}
