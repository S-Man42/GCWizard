part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze.dart';

bool _OnGetInputSectionEnd(String line) {
  if (line.trim().startsWith('if input == ') ||
      line.trim().startsWith('if input >= ') ||
      line.trim().startsWith('if input <= ') ||
      line.trim().startsWith('elseif input == ') ||
      line.trim().startsWith('elseif input >= ') ||
      line.trim().startsWith('elseif input <= ') ||
      line.trim().startsWith('if _Urwigo.Hash(') ||
      line.trim().startsWith('if (_Urwigo.Hash(') ||
      line.trim().startsWith('elseif _Urwigo.Hash(') ||
      line.trim().startsWith('elseif (_Urwigo.Hash(') ||
      line.trim().startsWith('if Wherigo.NoCaseEquals(') ||
      line.trim().startsWith('elseif Wherigo.NoCaseEquals(') ||
      line.trim().startsWith('if ' + answerVariable + ' == ') ||
      line.trim().startsWith('elseif ' + answerVariable + ' == '))
    return true;
  else
    return false;
}

bool _OnGetInputFunctionEnd(String line1, String line2) {
  return (line1.trimLeft().startsWith('end') &&
      (line2.trimLeft().startsWith('function') || line2.trimLeft().startsWith('return')));
}

bool _insideSectionInput(String currentLine) {
  if (RegExp(r'( Wherigo.ZInput\()').hasMatch(currentLine) ||
      RegExp(r'(function)').hasMatch(currentLine) ||
      RegExp(r'(:OnProximity)').hasMatch(currentLine) ||
      RegExp(r'(:OnStart)').hasMatch(currentLine)) {
    return false;
  }
  return true;
}

void _analyzeAndExtractInputSectionData(List<String> lines) {
  for (int i = 0; i < lines.length; i++) {
    lines[i] = lines[i].trim();

    if (lines[i].startsWith(LUAname + '.Id')) {
      id = getLineData(lines[i], LUAname, 'Id', obfuscatorFunction, obfuscatorTable);
    }

    if (lines[i].startsWith(LUAname + '.Name')) {
      name = getLineData(lines[i], LUAname, 'Name', obfuscatorFunction, obfuscatorTable);
    }

    if (lines[i].startsWith(LUAname + '.Description')) {
      description = '';
      sectionDescription = true;
      //i++; lines[i] = lines[i].trim();
      do {
        description = description + lines[i];
        i++;
        lines[i] = lines[i].trim();
        if (i > lines.length - 1 || lines[i].startsWith(LUAname + '.Visible')) sectionDescription = false;
      } while (sectionDescription);
      description = getLineData(description, LUAname, 'Description', obfuscatorFunction, obfuscatorTable);
    }

    if (lines[i].startsWith(LUAname + '.Media')) {
      media = getLineData(lines[i], LUAname, 'Media', obfuscatorFunction, obfuscatorTable);
    }

    if (lines[i].startsWith(LUAname + '.Visible')) {
      visible = getLineData(lines[i], LUAname, 'Visible', obfuscatorFunction, obfuscatorTable);
    }

    if (lines[i].startsWith(LUAname + '.Icon')) {
      icon = getLineData(lines[i], LUAname, 'Icon', obfuscatorFunction, obfuscatorTable);
    }

    if (lines[i].startsWith(LUAname + '.InputType')) {
      inputType = getLineData(lines[i], LUAname, 'InputType', obfuscatorFunction, obfuscatorTable);
    }

    if (lines[i].startsWith(LUAname + '.InputVariableId')) {
      variableID = getLineData(lines[i], LUAname, 'InputVariableId', obfuscatorFunction, obfuscatorTable);
    }

    if (lines[i].startsWith(LUAname + '.Text')) {
      if (RegExp(r'( Wherigo.ZInput)').hasMatch(lines[i + 1].trim()) ||
          lines[i + 1].trim().startsWith(LUAname + '.Media') ||
          RegExp(r'(.Commands)').hasMatch(lines[i + 1].trim()) ||
          lines[i + 1].trim().startsWith(LUAname + '.Visible') ||
          lines[i + 1].trim().startsWith('function') ||
          RegExp(r'(:OnProximity)').hasMatch(lines[i + 1].trim())) {
        // single Line
        text = getLineData(lines[i], LUAname, 'Text', obfuscatorFunction, obfuscatorTable);
      } else {
        // multi Lines of Text
        text = '';
        sectionText = true;
        do {
          i++;
          lines[i] = lines[i].trim();
          text = text + lines[i];
          if (RegExp(r'( Wherigo.ZInput\()').hasMatch(lines[i + 1].trim()) ||
              RegExp(r'(:OnProximity)').hasMatch(lines[i + 1].trim()) ||
              lines[i + 1].trim().startsWith(LUAname + '.Media') ||
              lines[i + 1].trim().startsWith('function') ||
              lines[i + 1].trim().startsWith(LUAname + '.Visible')) sectionText = false;
        } while (sectionText);
        text = normalizeWIGText(text.replaceAll(']]', '').replaceAll('<BR>', '\n'));
      }
    }

    if (lines[i].startsWith(LUAname + '.Choices')) {
      listChoices = [];
      if (lines[i + 1].trim().startsWith(LUAname + '.InputType') ||
          lines[i + 1].trim().startsWith(LUAname + '.Text')) {
        listChoices.addAll(getChoicesSingleLine(lines[i], LUAname, obfuscatorFunction, obfuscatorTable));
      } else {
        i++;
        lines[i] = lines[i].trim();
        sectionChoices = true;
        do {
          if (lines[i].startsWith('"')) {
            listChoices.add(lines[i].trimLeft().replaceAll('",', '').replaceAll('"', ''));
            i++;
            lines[i] = lines[i].trim();
          } else {
            sectionChoices = false;
          }
        } while (sectionChoices);
      }
    }
  }
}
