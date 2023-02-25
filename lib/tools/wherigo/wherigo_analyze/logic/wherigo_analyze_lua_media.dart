part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze.dart';

bool _insideSectionMedia(String currentLine) {
  if (RegExp(r'(Wherigo.ZCharacter\()').hasMatch(currentLine) ||
      RegExp(r'(Wherigo.ZMedia\()').hasMatch(currentLine) ||
      RegExp(r'(Wherigo.ZItem\()').hasMatch(currentLine) ||
      RegExp(r'(Wherigo.ZTask\()').hasMatch(currentLine) ||
      RegExp(r'(.ZVariables =)').hasMatch(currentLine) ||
      RegExp(r'(Wherigo.ZTimer\()').hasMatch(currentLine) ||
      RegExp(r'(Wherigo.ZInput\()').hasMatch(currentLine) ||
      RegExp(r'(function)').hasMatch(currentLine) ||
      RegExp(r'(Wherigo.Zone\()').hasMatch(currentLine)) {
    return false;
  }
  return true;
}

WherigoMediaData _analyzeAndExtractMediaSectionData(List<String> lines) {
  String LUAname = '';
  String id = '';
  String name = '';
  String description = '';
  String alttext = '';
  String type = '';
  String medianame = '';

  for (int i = 0; i < lines.length; i++) {
    if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('Id')) {
      id = getLineData(lines[i], LUAname, 'Id', obfuscatorFunction, obfuscatorTable);
    } else if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('Name')) {
      name = getLineData(lines[i], LUAname, 'Name', obfuscatorFunction, obfuscatorTable);
    } else if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('Description')) {
      if (lines[i + 1].trim().replaceAll(LUAname + '.', '').startsWith('AltText')) {
        description = getLineData(lines[i], LUAname, 'Description', obfuscatorFunction, obfuscatorTable);
      } else {
        sectionInner = true;
        description = lines[i].trim().replaceAll(LUAname + '.', '');
        i++;
        lines[i] = lines[i].trim();
        do {
          if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('AltText'))
            sectionInner = false;
          else
            description = description + lines[i];
          i++;
          lines[i] = lines[i].trim();
        } while (sectionInner);
      }
      if (description.startsWith('WWB_multi')) description = removeWWB(description);
    } else if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('AltText')) {
      alttext = getLineData(lines[i], LUAname, 'AltText', obfuscatorFunction, obfuscatorTable);
    } else if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('Resources')) {
      i++;
      lines[i] = lines[i].trim();
      sectionInner = true;
      do {
        if (lines[i].trimLeft().startsWith('Filename = ')) {
          medianame = getStructData(lines[i], 'Filename');
        } else if (lines[i].trimLeft().startsWith('Type = ')) {
          type = getStructData(lines[i], 'Type');
        } else if (lines[i].trimLeft().startsWith('Directives = ')) {
          sectionInner = false;
          sectionMedia = false;
        }
        i++;
        lines[i] = lines[i].trim();
      } while (sectionInner);
    }
  }

  return WherigoMediaData(
    LUAname,
    id,
    name,
    description,
    alttext,
    type,
    medianame,
  );
}
