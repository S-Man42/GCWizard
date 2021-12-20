import 'dart:ffi';

import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';

class ZonePoint{
  final String Longitude;
  final String Latitude;
  final String Altitude;

  ZonePoint(
      this.Longitude,
      this.Latitude,
      this.Altitude);
}

class ZoneData{
  final String ZoneLUAName;
  final String ZoneID;
  final String ZoneName;
  final String ZoneDescription;
  final String ZoneVisible;
  final String ZoneMediaName;
  final String ZoneIconName;
  final String ZoneActive;
  final String ZoneDistanceRange;
  final String ZoneShowObjects;
  final String ZoneProximityRange;
  final String ZoneOriginalPoint;
  final String ZoneDistanceRangeUOM;
  final String ZoneProximityRangeUOM;
  final String ZoneOutOfRange;
  final List<ZonePoint> ZonePoints;

  ZoneData(
      this.ZoneLUAName,
      this.ZoneID,
      this.ZoneName,
      this.ZoneDescription,
      this.ZoneVisible,
      this.ZoneMediaName,
      this.ZoneIconName,
      this.ZoneActive,
      this.ZoneDistanceRange,
      this.ZoneShowObjects,
      this.ZoneProximityRange,
      this.ZoneOriginalPoint,
      this.ZoneDistanceRangeUOM,
      this.ZoneProximityRangeUOM,
      this.ZoneOutOfRange,
      this.ZonePoints);
}


List<ZoneData>getZonesFromCartridge(String LUA, dtable, obfuscator){
  RegExp re = RegExp(r' = Wherigo.Zone\(');
  List<String> lines = LUA.split('\n');
  String line = '';
  List<ZoneData> result = [];
  List<ZonePoint> points = [];
  bool section = true;
  int j = 1;
  int k = 1;
  String LUAname = '';
  String id = '';
  String name = '';
  String description = '';
  String visible = '';
  String media = '';
  String icon = '';
  String active = '';
  String distanceRange;
  String showObjects;
  String proximityRange;
  String originalPoint;
  String distanceRangeUOM;
  String proximityRangeUOM;
  String outOfRange;

  for (int i = 0; i < lines.length; i++){
    line = lines[i];
    if (re.hasMatch(line)) {
      points = [];
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
      description = getLineData(description, LUAname, 'Description', obfuscator, dtable);

      section = true;
      do {
        if ((i + 2 + j) < lines.length - 1) {
          if (lines[i + 2 + j].startsWith(LUAname + '.Visible'))
            visible = getLineData(lines[i + 2 + j], LUAname, 'Visible', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.Media'))
            media = getLineData(lines[i + 2 + j], LUAname, 'Media', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.Icon'))
            icon = getLineData(lines[i + 2 + j], LUAname, 'Icon', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.Active'))
            active = getLineData(lines[i + 2 + j], LUAname, 'Active', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.DistanceRange'))
            distanceRange = getLineData(lines[i + 2 + j], LUAname, 'DistanceRange', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.ShowObjects'))
            showObjects = getLineData(lines[i + 2 + j], LUAname, 'ShowObjects', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.ProximityRange'))
            proximityRange = getLineData(lines[i + 2 + j], LUAname, 'ProximityRange', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.OriginalPoint'))
            originalPoint = getLineData(lines[i + 2 + j], LUAname, 'OriginalPoint', obfuscator, dtable).replaceAll('ZonePoint', '').replaceAll('(', '').replaceAll(')', '');
          if (lines[i + 2 + j].startsWith(LUAname + '.DistanceRangeUOM'))
            distanceRangeUOM = getLineData(lines[i + 2 + j], LUAname, 'DistanceRangeUOM', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.ProximityRangeUOM'))
            proximityRangeUOM = getLineData(lines[i + 2 + j], LUAname, 'ProximityRangeUOM', obfuscator, dtable);
          if (lines[i + 2 + j].startsWith(LUAname + '.OutOfRange'))
            outOfRange = getLineData(lines[i + 2 + j], LUAname, 'OutOfRange', obfuscator, dtable);


          if (lines[i + 2 + j].startsWith(LUAname + '.Points = ')) {
            k = 1;
            do {
              while (lines[i + 2 + j + k].trimLeft().startsWith('ZonePoint')) {
                points.add(_getPoint(lines[i + 2 + j + k]));
                k++;
              }
            } while (lines[i + 2 + j + k].trimLeft().startsWith('ZonePoint'));
            j = j + k;
          }
          if (lines[i + 2 + j].startsWith(LUAname + '.InRangeName'))
            section = false;
          j = j + 1;
        }
      } while (section);

      result.add(ZoneData(
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
          points,
      ));
      i = i + 2 + j;
    }
  };
  return result;
}

ZonePoint _getPoint(String line){
  List<String> data = line.trimLeft().replaceAll('ZonePoint', '').replaceAll('(', '').replaceAll(')', '').replaceAll(' ', '').split(',');
  return ZonePoint(data[0], data[1], data[2]);
}


