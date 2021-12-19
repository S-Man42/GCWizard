
class ItemData{
  final String ItemLUAName;
  final String ItemID;
  final String ItemName;
  final String ItemDescription;
  final String ItemMediaType;
  final String ItemMediaFilename;

  ItemData(
      this.ItemLUAName,
      this.ItemID,
      this.ItemName,
      this.ItemDescription,
      this.ItemMediaType,
      this.ItemMediaFilename);
}



List<ItemData>getItemsFromCartridge(String LUA, dtable, obfuscator){
  RegExp re = RegExp(r'( = Wherigo.ZItem)');
  List<String> lines = LUA.split('\n');
  String line = '';
  int index = 0;
  List<ItemData> result = [];
  ItemData item;

  for (int i = 0; i < lines.length; i++){
    line = lines[i];
    if (re.hasMatch(line)) {
      index = i;
      item = ItemData(
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

