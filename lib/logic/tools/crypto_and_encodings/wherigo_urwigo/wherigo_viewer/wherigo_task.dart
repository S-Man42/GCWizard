
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

  TaskData(
      this.TaskLUAName,
      this.TaskID,
      this.TaskName,
      this.TaskDescription,
      this.TaskVisible,
      this.TaskMedia,
      this.TaskIcon,
      this.TaskActive);
}



List<TaskData>getTasksFromCartridge(String LUA, dtable, obfuscator){
  RegExp re = RegExp(r'( = Wherigo.ZTask)');
  List<String> lines = LUA.split('\n');
  String line = '';
  List<TaskData> result = [];
  String LUAname = '';

  for (int i = 0; i < lines.length; i++){
    line = lines[i];
    if (re.hasMatch(line)) {
      LUAname = getLUAName(line);
      result.add(TaskData(
          LUAname,
          getLineData(lines[i + 1], LUAname, 'Id', obfuscator, dtable),
          getLineData(lines[i + 2], LUAname, 'Name', obfuscator, dtable),
          getLineData(lines[i + 3], LUAname, 'Description', obfuscator, dtable),
          getLineData(lines[i + 4], LUAname, 'Visible', obfuscator, dtable),
          getLineData(lines[i + 5], LUAname, 'Media', obfuscator, dtable),
          getLineData(lines[i + 6], LUAname, 'Icon', obfuscator, dtable),
          getLineData(lines[i + 7], LUAname, 'Active', obfuscator, dtable)
      ));
      i = i + 8;
    }
  };
  return result;
}
