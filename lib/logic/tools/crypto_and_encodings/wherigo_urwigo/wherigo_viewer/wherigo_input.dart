
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
      this.InputChoices);
}


List<InputData>getInputsFromCartridge(String LUA, dtable, obfuscator){
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
  List<String> choices = [];

  List<InputData> result = [];
  for (int i = 0; i < lines.length; i++){

    if (re.hasMatch(lines[i])) {
print(lines[i]);
      LUAname = '';
      id = '';
      name = '';
      description = '';
      visible = '';
      media = '';
      icon = '';
      inputType = '';
      text = '';
      choices = [];

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
      description = getLineData(description, LUAname, 'Description', obfuscator, dtable);

      section = true;
      do {
        if (i < lines.length - 1) {
          if (lines[i].startsWith(LUAname + '.Visible')) {
            visible = getLineData(
                lines[i], LUAname, 'Visible', obfuscator, dtable);
            print(visible);
          }

          if (lines[i].startsWith(LUAname + '.Media')){
            media = getLineData(
                lines[i], LUAname, 'Media', obfuscator, dtable);
            print(media);
          }

          if (lines[i].startsWith(LUAname + '.Icon')){
            icon = getLineData(
                lines[i], LUAname, 'Icon', obfuscator, dtable);
            print(icon);
          }

          if (lines[i].startsWith(LUAname + '.InputType')) {
            inputType = getLineData(
                lines[i], LUAname, 'InputType', obfuscator, dtable);
            print(inputType);
          }

          if (lines[i].startsWith(LUAname + '.Text')) {
            text = getLineData(
                lines[i], LUAname, 'Text', obfuscator, dtable);
          }

          if (lines[i].startsWith(LUAname + '.Choices')) {
            choices = [];
            if (lines[i].startsWith(LUAname + '.InputType')) {
              choices.addAll(getChoicesSingleLine(lines[i], LUAname, obfuscator, dtable));
            } else {
              i++;
              sectionChoices = true;
              do {
                if (lines[i].trimLeft().startsWith('"')) {
                  choices.add(lines[i ].trimLeft().replaceAll('"', '').replaceAll(',', ''));
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
      result.add(InputData(
        LUAname,
        id,
        name,
        description,
        visible,
        media,
        icon,
        inputType,
        text,
        choices
      ));
    }
  };
print(result);
  return result;
}
