
class CharacterData{
  final String CharacterLUAName;
  final String CharacterID;
  final String CharacterName;
  final String CharacterDescription;
  final String CharacterVisible;
  final String CharacterMediaName;
  final String CharacterIconName;
  final String CharacterLocation;
  final String CharacterGender;
  final String CharacterType;

  CharacterData(
      this.CharacterLUAName,
      this.CharacterID,
      this.CharacterName,
      this.CharacterDescription,
      this.CharacterVisible,
      this.CharacterMediaName,
      this.CharacterIconName,
      this.CharacterLocation,
      this.CharacterGender,
      this.CharacterType);
}


List<CharacterData>getCharactersFromCartridge(String LUA, dtable){
  RegExp re = RegExp(r'( = Wherigo.ZCharacter)');
  List<String> lines = LUA.split('\n');
  String line = '';
  int index = 0;
  List<CharacterData> result = [];
  CharacterData item;
  for (int i = 0; i < lines.length; i++){
    line = lines[i];
    if (re.hasMatch(line)) {
      index = i;
      item = CharacterData(
          lines[index],
          lines[index + 1],
          lines[index + 2],
          lines[index + 3],
          lines[index + 4],
          lines[index + 5],
          lines[index + 6],
          lines[index + 7],
          lines[index + 7],
          lines[index + 8]);
      result.add(item);
      i = i + 9;
    }
  };

  return result;
}
