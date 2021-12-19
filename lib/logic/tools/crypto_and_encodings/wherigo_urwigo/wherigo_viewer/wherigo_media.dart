
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';

class MediaData {
  final String MediaLUAName;
  final String MediaID;
  final String MediaName;
  final String MediaDescription;
  final String MediaType;
  final String MediaFilename;

  MediaData(
      this.MediaLUAName,
      this.MediaID,
      this.MediaName,
      this.MediaDescription,
      this.MediaType,
      this.MediaFilename);
}


List<MediaData>getMediaFromCartridge(String LUA, dtable, obfuscator){
  RegExp re = RegExp(r'( = Wherigo.ZMedia)');
  List<String> lines = LUA.split('\n');
  String line = '';
  List<MediaData> result = [];
  bool section = true;
  int j = 1;
  String LUAname = '';
  String id = '';
  String name = '';
  String description = '';
  String type = '';
  String media = '';

  for (int i = 0; i < lines.length; i++){
    line = lines[i];
    if (re.hasMatch(line)) {
print((i+1).toString()+' '+line);
      LUAname = getLUAName(line);
      id = getLineData(lines[i + 1], LUAname, 'Id', obfuscator, dtable);
print('    '+id);
      name = getLineData(lines[i + 2], LUAname, 'Name', obfuscator, dtable);
print('    '+name);

      description = '';
      section = true;
      j = 1;
      do {
        description = description + lines[i + 2 + j];
        j = j + 1;
        if ((i + 2 + j) > lines.length - 1 || lines[i + 2 + j].startsWith(LUAname + '.AltText'))
          section = false;
      } while (section);
      description = getLineData(description, LUAname, 'Description', obfuscator, dtable);
print('    '+description);
      section = true;
      do {
        print(lines[i + 2 + j]);
        if ((i + 2 + j) < lines.length - 1) {
          if (lines[i + 2 + j].trimLeft().startsWith('Filename = '))
            media = getStructData(lines[i + 2 + j], 'Filename');
          if (lines[i + 2 + j].trimLeft().startsWith('Type = '))
            type = getStructData(lines[i + 2 + j], 'Type');
          if (lines[i + 2 + j].trimLeft().startsWith('Directives ='))
            section = false;
          j = j + 1;
        }
      } while (section);

      result.add(MediaData(
          LUAname,
          id,
          name,
          description,
          type,
          media,
      ));
      print('element added');
      i = i + 2 + j;
    }
  };
  return result;
}
