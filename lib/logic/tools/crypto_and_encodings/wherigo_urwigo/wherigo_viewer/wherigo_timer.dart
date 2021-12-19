
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
  String LUAname = '';

  for (int i = 0; i < lines.length; i++){
    line = lines[i];
    if (re.hasMatch(line)) {
      LUAname = getLUAName(line);
      result.add(TimerData(
        LUAname,
        getLineData(lines[i + 1], LUAname, 'Id', obfuscator, dtable),
        getLineData(lines[i + 2], LUAname, 'Name', obfuscator, dtable),
        getLineData(lines[i + 3], LUAname, 'Description', obfuscator, dtable),
        getLineData(lines[i + 4], LUAname, 'Visible', obfuscator, dtable),
        getLineData(lines[i + 5], LUAname, 'Duration', obfuscator, dtable),
        getLineData(lines[i + 6], LUAname, 'Type', obfuscator, dtable),
      ));
      i = i + 7;
    }
  };

  return result;
}
