
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';

class CharacterData{
  final String CharacterLUAName;
  final String CharacterID;
  final String CharacterName;
  final String CharacterDescription;
  final String CharacterVisible;
  final String CharacterMediaName;
  final String CharacterIconName;
  final String CharacterLocation;
  final String CharacterGender;
  final String CharacterType;

  CharacterData(
      this.CharacterLUAName,
      this.CharacterID,
      this.CharacterName,
      this.CharacterDescription,
      this.CharacterVisible,
      this.CharacterMediaName,
      this.CharacterIconName,
      this.CharacterLocation,
      this.CharacterGender,
      this.CharacterType);
}


List<CharacterData>getCharactersFromCartridge(String LUA, dtable, obfuscator){
  RegExp re = RegExp(r'( = Wherigo.ZCharacter)');
  List<String> lines = LUA.split('\n');
  String line = '';
  List<CharacterData> result = [];
  bool section = true;
  int j = 1;
  String LUAname = '';
  String id = '';
  String name = '';
  String description = '';
  String visible = '';
  String media = '';
  String icon = '';
  String location = '';
  String gender = '';
  String type = '';

  for (int i = 0; i < lines.length; i++){
    line = lines[i];
    if (re.hasMatch(line)) {
      LUAname = '';
      id = '';
      name = '';
      description = '';
      visible = '';
      media = '';
      icon = '';
      location = '';
      gender = '';
      type = '';

      LUAname = getLUAName(line);
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
          if (lines[i + 2 + j].startsWith(LUAname + '.Visible'))
            visible = getLineData(
                lines[i + 2 + j], LUAname, 'Visible', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.Media'))
            media = getLineData(
                lines[i + 2 + j], LUAname, 'Media', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.Icon'))
            icon = getLineData(
                lines[i + 2 + j], LUAname, 'Icon', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.ObjectLocation'))
            location = getLineData(
                lines[i + 2 + j], LUAname, 'ObjectLocation', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.Gender'))
            gender = getLineData(
                lines[i + 2 + j], LUAname, 'Gender', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.Type'))
            type = getLineData(
                lines[i + 2 + j], LUAname, 'Type', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.Type'))
            section = false;
          j = j + 1;
        }
      } while (section);

      result.add(CharacterData(
           LUAname ,
           id,
           name,
           description,
           visible,
           media,
           icon,
           location,
           gender,
           type
      ));
      i = i + 1 + j;
    }
  };

  return result;
}
