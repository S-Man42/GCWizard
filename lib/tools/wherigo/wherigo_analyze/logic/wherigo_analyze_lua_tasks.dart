part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze.dart';

bool _insideSectionTask(String currentLine) {
  if (RegExp(r'( Wherigo.ZTask)').hasMatch(currentLine) || RegExp(r'(.ZVariables =)').hasMatch(currentLine)) {
    return false;
  }
  return true;
}

void _analyzeAndExtractTaskSectionData(List<String> lines) {
  for (int i = 0; i < lines.length; i++) {
    lines[i] = lines[i].trim();

    if (lines[i].startsWith(LUAname + '.Id'))
      id = getLineData(lines[i], LUAname, 'Id', obfuscatorFunction, obfuscatorTable);

    if (lines[i].startsWith(LUAname + '.Name'))
      name = getLineData(lines[i], LUAname, 'Name', obfuscatorFunction, obfuscatorTable);

    if (lines[i].startsWith(LUAname + '.Description')) {
      description = '';
      sectionDescription = true;

      do {
        description = description + lines[i];
        if (i > lines.length - 2 || lines[i + 1].trim().startsWith(LUAname + '.Visible'))
          sectionDescription = false;
        i++;
        lines[i] = lines[i].trim();
      } while (sectionDescription);
      description = description.replaceAll('[[', '').replaceAll(']]', '').replaceAll('<BR>', '\n');
      description = getLineData(description, LUAname, 'Description', obfuscatorFunction, obfuscatorTable);
    }

    if (lines[i].startsWith(LUAname + '.Visible'))
      visible = getLineData(lines[i], LUAname, 'Visible', obfuscatorFunction, obfuscatorTable);

    if (lines[i].startsWith(LUAname + '.Media'))
      media = getLineData(lines[i], LUAname, 'Media', obfuscatorFunction, obfuscatorTable).trim();

    if (lines[i].startsWith(LUAname + '.Icon'))
      icon = getLineData(lines[i], LUAname, 'Icon', obfuscatorFunction, obfuscatorTable);

    if (lines[i].startsWith(LUAname + '.Active'))
      active = getLineData(lines[i], LUAname, 'Active', obfuscatorFunction, obfuscatorTable);

    if (lines[i].startsWith(LUAname + '.CorrectState'))
      correctstate = getLineData(lines[i], LUAname, 'CorrectState', obfuscatorFunction, obfuscatorTable);

    if (lines[i].startsWith(LUAname + '.Complete'))
      complete = getLineData(lines[i], LUAname, 'Complete', obfuscatorFunction, obfuscatorTable);
  }
}
