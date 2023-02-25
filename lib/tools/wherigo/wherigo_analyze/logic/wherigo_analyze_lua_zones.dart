part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze.dart';

bool _insideSectionZone(String currentLine) {
  if (RegExp(r'( Wherigo.ZCharacter\()').hasMatch(currentLine) ||
      RegExp(r'( Wherigo.ZItem\()').hasMatch(currentLine) ||
      RegExp(r'( Wherigo.ZTask\()').hasMatch(currentLine) ||
      RegExp(r'(.ZVariables =)').hasMatch(currentLine) ||
      RegExp(r'( Wherigo.ZTimer\()').hasMatch(currentLine) ||
      RegExp(r'( Wherigo.ZInput\()').hasMatch(currentLine) ||
      RegExp(r'(function)').hasMatch(currentLine) ||
      RegExp(r'( Wherigo.Zone\()').hasMatch(currentLine)) {
    return false;
  }
  return true;
}

void _analyzeAndExtractZoneSectionData(List<String> lines) {
  for (int i = 0; i < lines.length; i++) {
    lines[i] = lines[i].trim();
    if (lines[i].startsWith(LUAname + '.Id'))
      id = getLineData(lines[i], LUAname, 'Id', obfuscatorFunction, obfuscatorTable);

    if (lines[i].startsWith(LUAname + '.Name')) {
      name = getLineData(lines[i], LUAname, 'Name', obfuscatorFunction, obfuscatorTable);
    }

    if (lines[i].startsWith(LUAname + '.Description')) {
      description = '';
      sectionDescription = true;
      do {
        description = description + lines[i];
        i++;
        lines[i] = lines[i].trim();
        if (i > lines.length - 1 || lines[i].startsWith(LUAname + '.Visible')) sectionDescription = false;
      } while (sectionDescription);
      description = description.replaceAll('[[', '').replaceAll(']]', '').replaceAll('<BR>', '\n');
      description = getLineData(description, LUAname, 'Description', obfuscatorFunction, obfuscatorTable).trim();
      if (description.startsWith('WWB_multi')) description = removeWWB(description);
    }

    if (lines[i].startsWith(LUAname + '.Visible'))
      visible = getLineData(lines[i], LUAname, 'Visible', obfuscatorFunction, obfuscatorTable);

    if (lines[i].startsWith(LUAname + '.Media'))
      media = getLineData(lines[i], LUAname, 'Media', obfuscatorFunction, obfuscatorTable);

    if (lines[i].startsWith(LUAname + '.Icon'))
      icon = getLineData(lines[i], LUAname, 'Icon', obfuscatorFunction, obfuscatorTable);

    if (lines[i].startsWith(LUAname + '.Active'))
      active = getLineData(lines[i], LUAname, 'Active', obfuscatorFunction, obfuscatorTable);

    if (lines[i].startsWith(LUAname + '.DistanceRangeUOM ='))
      distanceRangeUOM = getLineData(lines[i], LUAname, 'DistanceRangeUOM', obfuscatorFunction, obfuscatorTable);

    if (lines[i].startsWith(LUAname + '.ProximityRangeUOM ='))
      proximityRangeUOM =
          getLineData(lines[i], LUAname, 'ProximityRangeUOM', obfuscatorFunction, obfuscatorTable);

    if (lines[i].startsWith(LUAname + '.DistanceRange ='))
      distanceRange = getLineData(lines[i], LUAname, 'DistanceRange', obfuscatorFunction, obfuscatorTable);

    if (lines[i].startsWith(LUAname + '.ShowObjects'))
      showObjects = getLineData(lines[i], LUAname, 'ShowObjects', obfuscatorFunction, obfuscatorTable);

    if (lines[i].startsWith(LUAname + '.ProximityRange ='))
      proximityRange = getLineData(lines[i], LUAname, 'ProximityRange', obfuscatorFunction, obfuscatorTable);

    if (lines[i].startsWith(LUAname + '.OriginalPoint')) {
      String point = getLineData(lines[i], LUAname, 'OriginalPoint', obfuscatorFunction, obfuscatorTable);
      List<String> pointdata =
      point.replaceAll('ZonePoint(', '').replaceAll(')', '').replaceAll(' ', '').split(',');
      originalPoint =
          WherigoZonePoint(double.parse(pointdata[0]), double.parse(pointdata[1]), double.parse(pointdata[2]));
    }

    if (lines[i].startsWith(LUAname + '.OutOfRangeName'))
      outOfRange = getLineData(lines[i], LUAname, 'OutOfRangeName', obfuscatorFunction, obfuscatorTable);

    if (lines[i].startsWith(LUAname + '.InRangeName'))
      inRange = getLineData(lines[i], LUAname, 'InRangeName', obfuscatorFunction, obfuscatorTable);

    if (lines[i].startsWith(LUAname + '.Points = ')) {
      i++;
      lines[i] = lines[i].trim();
      do {
        while (lines[i].trimLeft().startsWith('ZonePoint')) {
          points.add(_getPoint(lines[i]));
          i++;
          lines[i] = lines[i].trim();
        }
      } while (lines[i].trimLeft().startsWith('ZonePoint'));
    }
  }
}
