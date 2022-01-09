
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



Map<String, dynamic> getTasksFromCartridge(String LUA, dtable, obfuscator){
  RegExp re = RegExp(r'( = Wherigo.ZTask)');
  List<String> lines = LUA.split('\n');
  List<TaskData> Tasks = [];
  Map<String, ObjectData> NameToObject = {};
  var out = Map<String, dynamic>();
  bool sectionTask = true;
  bool sectionDescription = true;

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

    if (re.hasMatch(lines[i])) {
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

      LUAname = getLUAName(lines[i]);

      i++; id = getLineData(lines[i], LUAname, 'Id', obfuscator, dtable);
      i++; name = getLineData(lines[i], LUAname, 'Name', obfuscator, dtable);

      sectionTask = true;

      description = '';
      sectionDescription = true;

      do {
        i++;
        description = description + lines[i];
        if (i > lines.length - 1 || lines[i].startsWith(LUAname + '.Visible'))
          sectionDescription = false;
      } while (sectionDescription);
      description = description.replaceAll('[[', '').replaceAll(']]', '').replaceAll('<BR>', '\n');
      description = getLineData(description, LUAname, 'Description', obfuscator, dtable);

      do {

          if (lines[i].startsWith(LUAname + '.Visible'))
            visible = getLineData(
                lines[i], LUAname, 'Visible', obfuscator, dtable);

          if (lines[i].startsWith(LUAname + '.Media'))
            media = getLineData(
                lines[i], LUAname, 'Media', obfuscator, dtable);

          if (lines[i].startsWith(LUAname + '.Icon'))
            icon = getLineData(
                lines[i], LUAname, 'Icon', obfuscator, dtable);

          if (lines[i].startsWith(LUAname + '.Active'))
            active = getLineData(
                lines[i], LUAname, 'Active', obfuscator, dtable);

          if (lines[i].startsWith(LUAname + '.CorrectState'))
            correctstate = getLineData(
                lines[i], LUAname, 'CorrectState', obfuscator, dtable);

          if (lines[i].startsWith(LUAname + '.Complete'))
            complete = getLineData(
                lines[i], LUAname, 'Complete', obfuscator, dtable);

          if (lines[i].startsWith(LUAname + '.CorrectState'))
            sectionTask = false;

          i++;
      } while (sectionTask && (i < lines.length - 1));

      i--;

      Tasks.add(TaskData(
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
      NameToObject[LUAname] = ObjectData(id, name, media, OBJECT_TYPE.TASK);

    } // end if task


  }; // for

  out.addAll({'content': Tasks});
  out.addAll({'names': NameToObject});
  return out;
}
