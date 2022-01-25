
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

Map<String, dynamic> getTimersFromCartridge(String LUA, dtable, obfuscator){
  RegExp re = RegExp(r'( = Wherigo.ZTimer)');
  List<String> lines = LUA.split('\n');

  List<TimerData> Timers = [];
  Map<String, ObjectData> NameToObject = {};
  var out = Map<String, dynamic>();

  bool sectionTimer = true;
  bool sectionDescription = true;

  String LUAname = '';
  String id = '';
  String name = '';
  String description = '';
  String visible = '';
  String type = '';
  String duration = '';

  for (int i = 0; i < lines.length; i++){

    if (re.hasMatch(lines[i])) {
      LUAname = '';
      id = '';
      name = '';
      description = '';
      visible = '';
      type = '';
      duration = '';

      LUAname = getLUAName(lines[i]);

      i++; id = getLineData(lines[i], LUAname, 'Id', obfuscator, dtable);
      i++; name = getLineData(lines[i], LUAname, 'Name', obfuscator, dtable);

      description = '';
      sectionTimer = true;
      sectionDescription = true;

      do {
        i++;
        description = description + lines[i];
        if (i + 1 > lines.length - 1 || lines[i + 1].startsWith(LUAname + '.Visible'))
          sectionDescription = false;
      } while (sectionDescription);
      description = getLineData(description, LUAname, 'Description', obfuscator, dtable);

      do {
          if (lines[i].startsWith(LUAname + '.Visible'))
            visible = getLineData(
                lines[i], LUAname, 'Visible', obfuscator, dtable);

          if (lines[i].startsWith(LUAname + '.Duration'))
            duration = getLineData(
                lines[i], LUAname, 'Duration', obfuscator, dtable);

          if (lines[i].startsWith(LUAname + '.Type')) {
            type = getLineData(
                lines[i], LUAname, 'Type', obfuscator, dtable);
            sectionTimer = false;
          }

          i++;
      } while (sectionTimer && i < lines.length - 1);

      Timers.add(TimerData(
        LUAname,
        id,
        name,
        description,
        visible,
        duration,
        type,
      ));

      NameToObject[LUAname] = ObjectData(id, 0, name, '', OBJECT_TYPE.TIMER);
      i--;
    }
  };

  out.addAll({'content': Timers});
  out.addAll({'names': NameToObject});
  return out;
}
