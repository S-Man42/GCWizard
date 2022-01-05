
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_zone.dart';

class ItemData{
  final String ItemLUAName;
  final String ItemID;
  final String ItemName;
  final String ItemDescription;
  final String ItemVisible;
  final String ItemMedia;
  final String ItemIcon;
  final String ItemLocation;
  final ZonePoint ItemZonepoint;
  final String itemContainer;
  final String ItemLocked;
  final String ItemOpened;

  ItemData(
      this.ItemLUAName,
      this.ItemID,
      this.ItemName,
      this.ItemDescription,
      this.ItemVisible,
      this.ItemMedia,
      this.ItemIcon,
      this.ItemLocation,
      this.ItemZonepoint,
      this.itemContainer,
      this.ItemLocked,
      this.ItemOpened);
}



Map<String, dynamic> getItemsFromCartridge(String LUA, dtable, obfuscator){
  RegExp re = RegExp(r'( = Wherigo.ZItem)');
  List<String> lines = LUA.split('\n');
  String line = '';
  List<ItemData> Items = [];
  Map<String, ObjectData> NameToObject = {};
  var out = Map<String, dynamic>();
  bool section = true;
  int j = 1;
  String LUAname = '';
  String id = '';
  String name = '';
  String description = '';
  String visible = '';
  String media = '';
  String icon = '';
  String location = '';
  ZonePoint zonePoint = ZonePoint(0.0, 0.0, 0.0);
  String locked = '';
  String opened = '';
  String container = '';

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
      location = '';
      zonePoint = ZonePoint(0.0, 0.0, 0.0);
      locked = '';
      opened = '';
      container = '';

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
      description = description.replaceAll('[[', '').replaceAll(']]', '').replaceAll('<BR>', '\n');
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
          if (lines[i + 2 + j].startsWith(LUAname + '.Locked'))
            locked = getLineData(
                lines[i + 2 + j], LUAname, 'Locked', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.Opened'))
            opened = getLineData(
                lines[i + 2 + j], LUAname, 'Opened', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.ObjectLocation'))
            location = getLineData(
                lines[i + 2 + j], LUAname, 'ObjectLocation', obfuscator,
                dtable);
          if (location.endsWith('INVALID_ZONEPOINT'))
            location = '';
          if (location.startsWith('ZonePoint')){
            location = location.replaceAll('Zonepoint(', '')..replaceAll(')', '').replaceAll(' ', '');
            zonePoint = ZonePoint(double.parse(location.split(',')[0]), double.parse(location.split(',')[1]), double.parse(location.split(',')[2]));
          }
          if (lines[i + 2 + j].startsWith(LUAname + '.Opened'))
            section = false;
          j = j + 1;
        }
      } while (section);
      j--;

      Items.add(ItemData(
          LUAname,
          id,
          name,
          description,
          visible,
          media,
          icon,
          location,
          zonePoint,
          container,
          locked,
          opened));
      i = i + 2 + j;
    }
  };

  out.addAll({'content': Items});
  out.addAll({'names': NameToObject});
  return out;
}

