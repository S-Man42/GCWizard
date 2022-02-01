
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_dataobjects.dart';

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

    if (RegExp(r'( = Wherigo.ZTimer)').hasMatch(lines[i])) {
      currentObjectSection = OBJECT_TYPE.TIMER;
      LUAname = '';
      id = '';
      name = '';
      description = '';
      visible = '';
      type = '';
      duration = '';

      LUAname = getLUAName(lines[i]);

      sectionTimer = true;
      do {
        i++;

        if (lines[i].trim().startsWith(LUAname + '.Id'))
          id = getLineData(lines[i], LUAname, 'Id', obfuscator, dtable);

        if (lines[i].trim().startsWith(LUAname + '.Name'))
          name = getLineData(lines[i], LUAname, 'Name', obfuscator, dtable);

        if (lines[i].trim().startsWith(LUAname + '.Description')) {
          description = '';
          sectionDescription = true;

          do {
            description = description + lines[i];
            i++;
            if (i > lines.length - 1 || lines[i].trim().startsWith(LUAname + '.Visible'))
              sectionDescription = false;
          } while (sectionDescription);
          description = getLineData(description, LUAname, 'Description', obfuscator, dtable);

        }

        if (lines[i].trim().startsWith(LUAname + '.Duration'))
          duration = getLineData(
              lines[i], LUAname, 'Duration', obfuscator, dtable).trim();

        if (lines[i].trim().startsWith(LUAname + '.Type')) {
          type = getLineData(
              lines[i], LUAname, 'Type', obfuscator, dtable).trim().toLowerCase();
        }

        if (lines[i].trim().startsWith(LUAname + '.Visible'))
          visible = getLineData(lines[i], LUAname, 'Visible', obfuscator, dtable).trim().toLowerCase();

        if (RegExp(r'( = Wherigo.ZTimer)').hasMatch(lines[i]) ||
            RegExp(r'( = Wherigo.ZInput)').hasMatch(lines[i]))
          sectionTimer = false;

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
