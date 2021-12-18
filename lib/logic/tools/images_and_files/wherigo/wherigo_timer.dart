
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

List<TimerData>getTimersFromCartridge(String LUA, dtable){
  RegExp re = RegExp(r'( = Wherigo.ZTimer)');
  List<String> lines = LUA.split('\n');
  String line = '';
  int index = 0;
  List<TimerData> result = [];
  TimerData item;
  for (int i = 0; i < lines.length; i++){
    line = lines[i];
    if (re.hasMatch(line)) {
      index = i;
      item = TimerData(
          lines[index],
          lines[index + 1],  //id
          lines[index + 2],  //name
          lines[index + 3],  //description
          lines[index + 4],  //visible
          lines[index + 5],   //duration
          lines[index + 6]);  //type
      result.add(item);
      i = i + 9;
    }
  };

  return result;
}
