import 'dart:ffi';

import 'package:gc_wizard/logic/tools/images_and_files/wherigo/wherigo_common.dart';

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
      this.ZonePoints);
}


List<ZoneData>getZonesFromCartridge(String LUA, dtable){
  RegExp re = RegExp(r'( = Wherigo.Zone)');
  List<String> lines = LUA.split('\n');
  String line = '';
  String LUAname = '';
  int index = 0;
  int j = 0;
  List<ZoneData> result = [];
  List<ZonePoint> points = [];
  ZoneData item;

  for (int i = 0; i < lines.length; i++){
    line = lines[i];
    if (re.hasMatch(line)) {
      LUAname = getLUAName(line);
      index = i;
      j = i + 14;
      while (lines[j].trim().startsWith('ZonePoint')) {
        points.add(_getPoint(lines[j]));
        j++;
      }
      item = ZoneData(
          LUAname,
          getLineData(lines[index + 1], LUAname, 'Id'),
          getLineData(lines[index + 2], LUAname, 'Name'),
          getLineData(lines[index + 3], LUAname, 'Description'),
          getLineData(lines[index + 4], LUAname, 'Visible'),
          getLineData(lines[index + 4], LUAname, 'Media'),
          getLineData(lines[index + 6], LUAname, 'Icon'),
          getLineData(lines[index + 12], LUAname, 'Active'),
          []);
      result.add(item);
      i = i + 9;
    }
  };

  return result;
}

ZonePoint _getPoint(String line){
  List<String> data = line.trimLeft().replaceAll('ZonePoint', '').replaceAll('(', '').replaceAll(')', '').replaceAll(' ', '').split(',');
  return ZonePoint(data[0], data[1], data[2]);
}


