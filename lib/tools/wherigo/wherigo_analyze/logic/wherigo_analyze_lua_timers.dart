part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze.dart';

bool insideSectionTimer(String currentLine) {
  if (RegExp(r'( Wherigo.ZTimer\()').hasMatch(currentLine) || RegExp(r'( Wherigo.ZInput\()').hasMatch(currentLine)) {
    return false;
  }
  return true;
}

void analyzeAndExtractTimerSectionData(List<String> lines) {
  for (int i = 0; i < lines.length; i++) {
    lines[i] = lines[i].trim();

    if (lines[i].trim().startsWith(LUAname + '.Id'))
      id = getLineData(lines[i], LUAname, 'Id', obfuscatorFunction, obfuscatorTable);

    if (lines[i].trim().startsWith(LUAname + '.Name'))
      name = getLineData(lines[i], LUAname, 'Name', obfuscatorFunction, obfuscatorTable);

    if (lines[i].trim().startsWith(LUAname + '.Description')) {
      description = '';
      sectionDescription = true;

      do {
        description = description + lines[i];
        i++;
        lines[i] = lines[i].trim();
        if (i > lines.length - 1 || lines[i].trim().startsWith(LUAname + '.Visible')) sectionDescription = false;
      } while (sectionDescription);
      description = getLineData(description, LUAname, 'Description', obfuscatorFunction, obfuscatorTable);
    }

    if (lines[i].trim().startsWith(LUAname + '.Duration'))
      duration = getLineData(lines[i], LUAname, 'Duration', obfuscatorFunction, obfuscatorTable).trim();

    if (lines[i].trim().startsWith(LUAname + '.Type')) {
      type = getLineData(lines[i], LUAname, 'Type', obfuscatorFunction, obfuscatorTable).trim().toLowerCase();
    }

    if (lines[i].trim().startsWith(LUAname + '.Visible'))
      visible =
          getLineData(lines[i], LUAname, 'Visible', obfuscatorFunction, obfuscatorTable).trim().toLowerCase();}
}
