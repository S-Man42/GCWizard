
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';

class TaskData{
  final String TaskLUAName;
  final String TaskID;
  final String TaskName;
  final String TaskDescription;
  final String TaskVisible;
  final String TaskMedia;
  final String TaskIcon;
  final String TaskActive;
  final String TaskComplete;
  final String TaskCorrectstate;

  TaskData(
      this.TaskLUAName,
      this.TaskID,
      this.TaskName,
      this.TaskDescription,
      this.TaskVisible,
      this.TaskMedia,
      this.TaskIcon,
      this.TaskActive,
      this.TaskComplete,
      this.TaskCorrectstate);
}



List<TaskData>getTasksFromCartridge(String LUA, dtable, obfuscator){
  RegExp re = RegExp(r'( = Wherigo.ZTask)');
  List<String> lines = LUA.split('\n');
  String line = '';
  List<TaskData> result = [];
  bool section = true;
  int j = 1;
  String LUAname = '';
  String id = '';
  String name = '';
  String description = '';
  String visible = '';
  String media = '';
  String icon = '';
  String complete = '';
  String correctstate = '';
  String active = '';

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
      complete = '';
      correctstate = '';
      active = '';
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
          if (lines[i + 2 + j].startsWith(LUAname + '.Active'))
            active = getLineData(
                lines[i + 2 + j], LUAname, 'Active', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.CorrectState'))
            correctstate = getLineData(
                lines[i + 2 + j], LUAname, 'CorrectState', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.Complete'))
            complete = getLineData(
                lines[i + 2 + j], LUAname, 'Complete', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.CorrectState'))
            section = false;
          j = j + 1;
        }
      } while (section);

      result.add(TaskData(
          LUAname,
          id,
          name,
          description,
          visible,
          media,
          icon,
          active,
          complete,
          correctstate
      ));
      i = i + 2 + j;
    }
  };
  return result;
}
