
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_dataobjects.dart';

Map<String, dynamic> getTasksFromCartridge(String LUA, dtable, obfuscator){

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

    if (RegExp(r'( = Wherigo.ZTask)').hasMatch(lines[i])) {
      currentObjectSection = OBJECT_TYPE.TASK;
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

      sectionTask = true;

      do {
        i++;

        if (lines[i].startsWith(LUAname + '.Id'))
          id = getLineData(lines[i], LUAname, 'Id', obfuscator, dtable);

        if (lines[i].startsWith(LUAname + '.Name'))
          name = getLineData(lines[i], LUAname, 'Name', obfuscator, dtable);

        if (lines[i].startsWith(LUAname + '.Description')) {
            description = '';
            sectionDescription = true;

            do {
              description = description + lines[i];
              if (i > lines.length - 2 || lines[i + 1].startsWith(LUAname + '.Visible'))
                sectionDescription = false;
              i++;
            } while (sectionDescription);
            description = description.replaceAll('[[', '').replaceAll(']]', '').replaceAll('<BR>', '\n');
            description = getLineData(description, LUAname, 'Description', obfuscator, dtable);
          }

          if (lines[i].startsWith(LUAname + '.Visible'))
            visible = getLineData(
                lines[i], LUAname, 'Visible', obfuscator, dtable);

          if (lines[i].startsWith(LUAname + '.Media'))
            media = getLineData(
                lines[i], LUAname, 'Media', obfuscator, dtable).trim();

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

          if (RegExp(r'( = Wherigo.ZTask)').hasMatch(lines[i]) ||
              RegExp(r'( = Wherigo.ZVariables)').hasMatch(lines[i]))
            sectionTask = false;

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
      NameToObject[LUAname] = ObjectData(id, 0, name, media, OBJECT_TYPE.TASK);

    } // end if task
  }; // for

  out.addAll({'content': Tasks});
  out.addAll({'names': NameToObject});
  return out;
}
