
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';

class TimerData{
  final String TimerLUAName;
  final String TimerID;
  final String TimerName;
  final String TimerDescription;
  final String TimerVisible;
  final String TimerDuration;
  final String TimerType;

  TimerData(
      this.TimerLUAName,
      this.TimerID,
      this.TimerName,
      this.TimerDescription,
      this.TimerVisible,
      this.TimerDuration,
      this.TimerType);
}

List<TimerData>getTimersFromCartridge(String LUA, dtable, obfuscator){
  RegExp re = RegExp(r'( = Wherigo.ZTimer)');
  List<String> lines = LUA.split('\n');
  String line = '';
  List<TimerData> result = [];
    bool section = true;
  int j = 1;
  String LUAname = '';
  String id = '';
  String name = '';
  String description = '';
  String visible = '';
  String type = '';
  String duration = '';

  for (int i = 0; i < lines.length; i++){
    line = lines[i];
    if (re.hasMatch(line)) {
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
          if (lines[i + 2 + j].startsWith(LUAname + '.Duration'))
            duration = getLineData(
                lines[i + 2 + j], LUAname, 'Duration', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.Type'))
            type = getLineData(
                lines[i + 2 + j], LUAname, 'Type', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.Type'))
            section = false;
          j = j + 1;
        }
      } while (section);

      result.add(TimerData(
        LUAname,
        id,
        name,
        description,
        visible,
        duration,
        type,
      ));
      i = i + 2 + j;
    }
  };

  return result;
}
