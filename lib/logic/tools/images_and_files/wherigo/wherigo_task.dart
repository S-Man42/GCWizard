
class TaskData{
  final String TaskLUAName;
  final String TaskID;
  final String TaskName;
  final String TaskDescription;
  final String TaskMediaType;
  final String TaskMediaFilename;

  TaskData(
      this.TaskLUAName,
      this.TaskID,
      this.TaskName,
      this.TaskDescription,
      this.TaskMediaType,
      this.TaskMediaFilename);
}



List<TaskData>getTasksFromCartridge(String LUA, dtable){
  RegExp re = RegExp(r'( = Wherigo.ZTask)');
  List<String> lines = LUA.split('\n');
  String line = '';
  int index = 0;
  List<TaskData> result = [];
  TaskData item;

  for (int i = 0; i < lines.length; i++){
    line = lines[i];
    if (re.hasMatch(line)) {
      index = i;
      item = TaskData(
          lines[index],
          lines[index + 1],
          lines[index + 2],
          lines[index + 3],
          lines[index + 7],
          lines[index + 8]);
      result.add(item);
      i = i + 9;
    }
  };
  return result;
}
