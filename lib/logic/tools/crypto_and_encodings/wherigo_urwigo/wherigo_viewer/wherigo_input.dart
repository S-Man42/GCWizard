
class InputData{
  final String InputLUAName;
  final String InputID;
  final String InputName;
  final String InputDescription;
  final String InputVisible;
  final String InputMedia;
  final String InputIcon;
  final String InputType;
  final String InputText;
  final List<String> InputChoices;

  InputData(
      this.InputLUAName,
      this.InputID,
      this.InputName,
      this.InputDescription,
      this.InputVisible,
      this.InputMedia,
      this.InputIcon,
      this.InputType,
      this.InputText,
      this.InputChoices);
}


List<InputData>getInputsFromCartridge(String LUA, dtable, obfuscator){
  RegExp re = RegExp(r'( = Wherigo.ZInput)');
  List<String> lines = LUA.split('\n');
  String line = '';
  int index = 0;
  List<InputData> result = [];
  InputData item;
  for (int i = 0; i < lines.length; i++){
    line = lines[i];
    if (re.hasMatch(line)) {
      index = i;
      item = InputData(
          lines[index],
          lines[index + 1],
          lines[index + 2],
          lines[index + 3],
          lines[index + 4],
          lines[index + 5],
          lines[index + 6],
          lines[index + 7],
          lines[index + 8],
          []);
      result.add(item);
      i = i + 9;
    }
  };

  return result;
}
