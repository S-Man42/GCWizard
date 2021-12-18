
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
  String LUAname = '';
  int index = 0;
  List<MediaData> result = [];
  MediaData element;
  for (int i = 0; i < lines.length; i++){
    line = lines[i];
    if (re.hasMatch(line)) {
      index = i;
      LUAname = getLUAName(lines[index]);
      element = MediaData(
          LUAname,
          getLineData(lines[index + 1], LUAname, 'Id', obfuscator, dtable),
          getLineData(lines[index + 2], LUAname, 'Name', obfuscator, dtable),
          getLineData(lines[index + 3], LUAname, 'Description', obfuscator, dtable),
          getStructData(lines[index + 7], 'Type'),
          getStructData(lines[index + 8], 'Filename'));
      result.add(element);
      i = i + 9;
    }
  };

  return result;
}

