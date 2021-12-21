
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
  int j = 1;
  int k = 1;
  String LUAname = '';
  String id = '';
  String name = '';
  String description = '';
  String visible = '';
  String media = '';
  String icon = '';
  String type = '';
  String text = '';
  List<String> choices = [];

  List<InputData> result = [];
  for (int i = 0; i < lines.length; i++){

    if (re.hasMatch(lines[i])) {
      LUAname = '';
      id = '';
      name = '';
      description = '';
      visible = '';
      media = '';
      icon = '';
      type = '';
      text = '';
      choices = [];

      LUAname = getLUAName(lines[i]);
      id = getLineData(lines[i + 1], LUAname, 'Id', obfuscator, dtable);
      name = getLineData(lines[i + 2], LUAname, 'Name', obfuscator, dtable);

      description = '';
      section = true;
      j = 1;
      do {
        description = description + lines[i + 2 + j];
        j = j + 1;
        if ((i + 2 + j) > lines.length - 1 || lines[i + 2 + j].startsWith(LUAname + '.Visible'))
          section = false;
      } while (section);
      description = getLineData(description, LUAname, 'Description', obfuscator, dtable);

      section = true;
      do {
        if ((i + 2 + j) < lines.length - 1) {
          if (lines[i + 2 + j].startsWith(LUAname + '.Visible')) {
            visible = getLineData(
                lines[i + 2 + j], LUAname, 'Visible', obfuscator, dtable);
          }
          if (lines[i + 2 + j].startsWith(LUAname + '.Media')){
            media = getLineData(
                lines[i + 2 + j], LUAname, 'Media', obfuscator, dtable);
          }
          if (lines[i + 2 + j].startsWith(LUAname + '.Icon')){
            icon = getLineData(
                lines[i + 2 + j], LUAname, 'Icon', obfuscator, dtable);
          }
          if (lines[i + 2 + j].startsWith(LUAname + '.InputType')) {
            type = getLineData(
                lines[i + 2 + j], LUAname, 'InputType', obfuscator, dtable);
          }
          if (lines[i + 2 + j].startsWith(LUAname + '.Text')) {
            text = getLineData(
                lines[i + 2 + j], LUAname, 'Text', obfuscator, dtable);
          }
          if (lines[i + 2 + j].startsWith(LUAname + '.Choices')) {

            choices = [];
            if (lines[i + 2 + j + 1].startsWith(LUAname + '.InputType')) {
              choices.addAll(getChoicesSingleLine(lines[i + 2 + j], LUAname, obfuscator, dtable));
            } else {
              k = 1;
              sectionChoices = true;
              do {
                if (lines[i + 2 + j + k].trimLeft().startsWith('"')) {
                  choices.add(lines[i + 2 + j + k].trimLeft().replaceAll('"', '').replaceAll(',', ''));
                  k++;
                } else {
                  sectionChoices = false;
                }
              } while (sectionChoices);
              j = j + k;
            }
          }
          if (lines[i + 2 + j].startsWith(LUAname + '.Text'))
            section = false;
          j = j + 1;
        }
      } while (section);

      result.add(InputData(
        LUAname,
        id,
        name,
        description,
        visible,
        media,
        icon,
        type,
        text,
        choices
      ));
      i = i + 1 + j;
    }
  };

  return result;
}
