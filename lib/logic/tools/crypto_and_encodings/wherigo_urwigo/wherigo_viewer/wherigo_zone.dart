import 'dart:ffi';

import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_dataobjects.dart';



Map<String, dynamic> getZonesFromCartridge(String LUA, dtable, obfuscator){

  List<String> lines = LUA.split('\n');

  List<ZoneData> Zones = [];
  Map<String, ObjectData> NameToObject = {};
  var out = Map<String, dynamic>();
  List<ZonePoint> points = [];
  bool sectionZone = true;
  bool sectionDescription = true;
  String LUAname = '';
  String id = '';
  String name = '';
  String description = '';
  String visible = '';
  String media = '';
  String icon = '';
  String active = '';
  String distanceRange = '';
  String showObjects = '';
  String proximityRange = '';
  ZonePoint originalPoint;
  String distanceRangeUOM = '';
  String proximityRangeUOM = '';
  String outOfRange = '';
  String inRange = '';


  for (int i = 0; i < lines.length; i++){
    if (RegExp(r'( = Wherigo.Zone\()').hasMatch(lines[i])) {
      currentObjectSection = OBJECT_TYPE.ZONE;
      points = [];
      LUAname = '';
      id = '';
      name = '';
      description = '';
      visible = '';
      media = '';
      icon = '';
      active = '';
      distanceRange = '';
      showObjects = '';
      proximityRange = '';
      originalPoint;
      distanceRangeUOM = '';
      proximityRangeUOM = '';
      outOfRange = '';
      inRange = '';

      LUAname = getLUAName(lines[i]);

      sectionZone = true;
      do {
        i++;
        if (lines[i].startsWith(LUAname + '.Id'))
          id = getLineData(lines[i], LUAname, 'Id', obfuscator, dtable);

        if (lines[i].startsWith(LUAname + '.Name'))
          name = getLineData(lines[i], LUAname, 'Name', obfuscator, dtable);

        if (lines[i].startsWith(LUAname + '.Description')){
          description = '';
          sectionDescription = true;
          do {
            description = description + lines[i];
            i++;
            if (i > lines.length - 1 || lines[i].startsWith(LUAname + '.Visible'))
              sectionDescription = false;
          } while (sectionDescription);
          description = description.replaceAll('[[', '').replaceAll(']]', '').replaceAll('<BR>', '\n');
          description = getLineData(description, LUAname, 'Description', obfuscator, dtable).trim();
          if (description.startsWith('WWB_multi'))
            description = removeWWB(description);
        }

        if (lines[i].startsWith(LUAname + '.Visible'))
            visible = getLineData(lines[i], LUAname, 'Visible', obfuscator, dtable);

        if (lines[i].startsWith(LUAname + '.Media'))
          media = getLineData(lines[i], LUAname, 'Media', obfuscator, dtable);

        if (lines[i].startsWith(LUAname + '.Icon'))
          icon = getLineData(lines[i], LUAname, 'Icon', obfuscator, dtable);

        if (lines[i].startsWith(LUAname + '.Active'))
          active = getLineData(lines[i], LUAname, 'Active', obfuscator, dtable);

        if (lines[i].startsWith(LUAname + '.DistanceRangeUOM ='))
          distanceRangeUOM = getLineData(lines[i], LUAname, 'DistanceRangeUOM', obfuscator, dtable);

        if (lines[i].startsWith(LUAname + '.ProximityRangeUOM ='))
          proximityRangeUOM = getLineData(lines[i], LUAname, 'ProximityRangeUOM', obfuscator, dtable);

        if (lines[i].startsWith(LUAname + '.DistanceRange ='))
          distanceRange = getLineData(lines[i], LUAname, 'DistanceRange', obfuscator, dtable);

        if (lines[i ].startsWith(LUAname + '.ShowObjects'))
          showObjects = getLineData(lines[i], LUAname, 'ShowObjects', obfuscator, dtable);

        if (lines[i].startsWith(LUAname + '.ProximityRange ='))
          proximityRange = getLineData(lines[i], LUAname, 'ProximityRange', obfuscator, dtable);

        if (lines[i].startsWith(LUAname + '.OriginalPoint')) {
          String point = getLineData(lines[i], LUAname, 'OriginalPoint', obfuscator, dtable);
          List<String> pointdata = point
              .replaceAll('ZonePoint(', '')
              .replaceAll(')', '')
              .replaceAll(' ', '')
              .split(',');
          originalPoint = ZonePoint(double.parse(pointdata[0]), double.parse(pointdata[1]), double.parse(pointdata[2]));
        }

        if (lines[i].startsWith(LUAname + '.OutOfRangeName'))
          outOfRange = getLineData(lines[i], LUAname, 'OutOfRangeName', obfuscator, dtable);

        if (lines[i].startsWith(LUAname + '.InRangeName'))
          inRange = getLineData(lines[i], LUAname, 'InRangeName', obfuscator, dtable);

        if (lines[i].startsWith(LUAname + '.Points = ')) {
          i++;
          do {
            while (lines[i].trimLeft().startsWith('ZonePoint')) {
              points.add(_getPoint(lines[i]));
              i++;
            }
          } while (lines[i].trimLeft().startsWith('ZonePoint'));
        }

        if (RegExp(r'( = Wherigo.Zone\()').hasMatch(lines[i]) ||
           i > lines.length - 2) {
          sectionZone = false;
        }
      } while (sectionZone);
      i--;

      Zones.add(ZoneData(
          LUAname,
          id,
          name,
          description,
          visible,
          media,
          icon,
          active,
          distanceRange,
          showObjects,
          proximityRange,
          originalPoint,
          distanceRangeUOM,
          proximityRangeUOM,
          outOfRange,
          inRange,
          points,
      ));
      NameToObject[LUAname] = ObjectData(id, 0, name, media, OBJECT_TYPE.ZONE);
    }
  };

  out.addAll({'content': Zones});
  out.addAll({'names': NameToObject});
  return out;
}

ZonePoint _getPoint(String line){
  List<String> data = line.trimLeft().replaceAll('ZonePoint(', '').replaceAll('),', '').replaceAll(')', '').replaceAll(' ', '').split(',');
  return ZonePoint(double.parse(data[0]), double.parse(data[1]), double.parse(data[2]));
}


