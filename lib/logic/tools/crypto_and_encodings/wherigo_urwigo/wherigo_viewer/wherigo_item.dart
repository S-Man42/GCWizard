import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_dataobjects.dart';
import 'package:latlong2/latlong.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_zone.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:prefs/prefs.dart';

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
  final String ItemContainer;
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
      this.ItemContainer,
      this.ItemLocked,
      this.ItemOpened);
}



Map<String, dynamic> getItemsFromCartridge(String LUA, dtable, obfuscator){

  List<String> lines = LUA.split('\n');
  List<ItemData> Items = [];
  Map<String, ObjectData> NameToObject = {};
  var out = Map<String, dynamic>();
  bool sectionItem = true;
  bool sectionDescription = true;
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
    if (RegExp(r'( = Wherigo.ZItem)').hasMatch(lines[i])) {
      currentObjectSection = OBJECT_TYPE.ITEM;
      LUAname = '';
      container = '';
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

      LUAname = getLUAName(lines[i]);
      container = getContainer(lines[i]);

      sectionItem = true;
      do {
        i++;
        if (lines[i].trim().startsWith(LUAname + 'Container =')) {
          container = getContainer(lines[i]);
        }

        if (lines[i].trim().startsWith(LUAname + '.Id')) {
          id = getLineData(lines[i], LUAname, 'Id', obfuscator, dtable);
        }

        if (lines[i].trim().startsWith(LUAname + '.Name')) {
          name = getLineData(lines[i], LUAname, 'Name', obfuscator, dtable);
        }

        if (lines[i].trim().startsWith(LUAname + '.Description')) {
          description = '';
          sectionDescription = true;
          do {
            description = description + lines[i];
            if (i > lines.length - 2 || lines[i + 1].startsWith(LUAname + '.Visible')) {
              sectionDescription = false;
            }
            i++;
          } while (sectionDescription);
          description = description.replaceAll('[[', '').replaceAll(']]', '').replaceAll('<BR>', '\n');
          description = getLineData(description, LUAname, 'Description', obfuscator, dtable).trim();
        }

        if (lines[i].trim().startsWith(LUAname + '.Visible'))
          visible = getLineData(
              lines[i], LUAname, 'Visible', obfuscator, dtable);

        if (lines[i].trim().startsWith(LUAname + '.Media'))
          media = getLineData(
              lines[i], LUAname, 'Media', obfuscator, dtable).trim();

        if (lines[i].trim().startsWith(LUAname + '.Icon'))
          icon = getLineData(
              lines[i], LUAname, 'Icon', obfuscator, dtable);

        if (lines[i].trim().startsWith(LUAname + '.Locked'))
          locked = getLineData(
              lines[i], LUAname, 'Locked', obfuscator, dtable);

        if (lines[i].trim().startsWith(LUAname + '.Opened')) {
          opened = getLineData(
              lines[i], LUAname, 'Opened', obfuscator, dtable);
        }

        if (lines[i].trim().startsWith(LUAname + '.ObjectLocation')) {
          location = lines[i].trim().replaceAll(LUAname + '.ObjectLocation', '').replaceAll(' ', '').replaceAll('=', '');
          if (location.endsWith('INVALID_ZONEPOINT'))
            location = '';
          else if (location.startsWith('ZonePoint')) {
            location = location
                .replaceAll('ZonePoint(', '')
                .replaceAll(')', '')
                .replaceAll(' ', '');
            zonePoint = ZonePoint(double.parse(location.split(',')[0]),
                double.parse(location.split(',')[1]),
                double.parse(location.split(',')[2]));
            location = 'ZonePoint';
          }
          else
          location = getLineData(
              lines[i], LUAname, 'ObjectLocation', obfuscator,
              dtable);
        }

        if (RegExp(r'( = Wherigo.ZItem)').hasMatch(lines[i]) ||
            RegExp(r'( = Wherigo.ZTask)').hasMatch(lines[i]))
          sectionItem = false;

      } while (sectionItem);

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

      NameToObject[LUAname] = ObjectData(id, 0, name, media, OBJECT_TYPE.ITEM);
      i--;
    } // end if
  }; // end for

  out.addAll({'content': Items});
  out.addAll({'names': NameToObject});
  return out;
}

