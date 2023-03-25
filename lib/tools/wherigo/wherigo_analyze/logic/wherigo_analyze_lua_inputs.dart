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
      line.trim().startsWith('if ' + _answerVariable + ' == ') ||
      line.trim().startsWith('elseif ' + _answerVariable + ' == ')) {
    return true;
  } else {
    return false;
  }
}

bool _OnGetInputFunctionEnd(String line1, String line2) {
  return (line1.trimLeft().startsWith('end') &&
      (line2.trimLeft().startsWith('function') || line2.trimLeft().startsWith('return')));
}

bool _insideSectionInput(String currentLine) {
  if (RegExp(r'( Wherigo.ZInput\()').hasMatch(currentLine)) {
    return false;
  }
  return _notDoneWithInputs(currentLine);
}

bool _notDoneWithInputs(String currentLine) {
  if (RegExp(r'(function)').hasMatch(currentLine) ||
      RegExp(r'(:OnProximity)').hasMatch(currentLine) ||
      RegExp(r'(:OnStart)').hasMatch(currentLine)) {
    return false;
  }
  return true;
}

WherigoInputData _analyzeAndExtractInputSectionData(List<String> lines) {

  String LUAname = '';
  String id = '';
  String name = '';
  String description = '';
  String visible = '';
  String media = '';
  String icon = '';
  String variableID = '';
  String inputType = '';
  String text = '';
  List<String> listChoices = [];

  bool _sectionDescription = true;
  bool _sectionChoices = false;

  for (int i = 0; i < lines.length; i++) {
    lines[i] = lines[i].trim();
    print(lines[i]);

    if (RegExp(r'( Wherigo.ZInput\()').hasMatch(lines[i])) {
      LUAname = getLUAName(lines[i]);
      print('=====> '+LUAname);
    }

    if (lines[i].startsWith(LUAname + '.Id')) {
      id = getLineData(lines[i], LUAname, 'Id', _obfuscatorFunction, _obfuscatorTable);
      print('=====> '+lines[i]+'   '+id);
    }

    if (lines[i].startsWith(LUAname + '.Name')) {
      name = getLineData(lines[i], LUAname, 'Name', _obfuscatorFunction, _obfuscatorTable);
      print('=====> '+lines[i]+'   '+name);
    }

    if (lines[i].startsWith(LUAname + '.Description')) {
      description = '';
      _sectionDescription = true;

      do {
        description = description + lines[i];
        i++;
        lines[i] = lines[i].trim();
        if (i > lines.length - 1 || lines[i].startsWith(LUAname + '.Visible')) _sectionDescription = false;
      } while (_sectionDescription);
      i--;
      description = getLineData(description, LUAname, 'Description', _obfuscatorFunction, _obfuscatorTable);
      print('=====> '+lines[i]+'   '+description);
    }

    if (lines[i].startsWith(LUAname + '.Media')) {
      media = getLineData(lines[i], LUAname, 'Media', _obfuscatorFunction, _obfuscatorTable);
      print('=====> '+lines[i]+'   '+media);
    }

    if (lines[i].startsWith(LUAname + '.Visible')) {
      visible = getLineData(lines[i], LUAname, 'Visible', _obfuscatorFunction, _obfuscatorTable);
      print('=====> '+lines[i]+'   '+visible);
    }

    if (lines[i].startsWith(LUAname + '.Icon')) {
      icon = getLineData(lines[i], LUAname, 'Icon', _obfuscatorFunction, _obfuscatorTable);
      print('=====> '+lines[i]+'   '+icon);
    }

    if (lines[i].startsWith(LUAname + '.InputType')) {
     inputType = getLineData(lines[i], LUAname, 'InputType', _obfuscatorFunction, _obfuscatorTable);
     print('=====> '+lines[i]+'   '+inputType);
    }

    if (lines[i].startsWith(LUAname + '.InputVariableId')) {
      variableID = getLineData(lines[i], LUAname, 'InputVariableId', _obfuscatorFunction, _obfuscatorTable);
    }

    if (lines[i].startsWith(LUAname + '.Text')) {
      print('found text '+ lines[i]);
      print('check siln '+ lines[i+1]);
      if (_singleLine(lines[i + 1], LUAname)) {
        print('single line');
        text = getLineData(lines[i], LUAname, 'Text', _obfuscatorFunction, _obfuscatorTable);
      } else {
        // multi Lines of Text
        text = '';
        do {
          i++;
          lines[i] = lines[i].trim();
          text = text + lines[i];
        } while (_notEndOfInputText(lines[i + 1], LUAname));
        text = normalizeWIGText(text.replaceAll(']]', '').replaceAll('<BR>', '\n'));
      }
      print('=====> '+lines[i]+'   '+text);
    }

    if (lines[i].startsWith(LUAname + '.Choices')) {
      listChoices = [];
      if (lines[i + 1].trim().startsWith(LUAname + '.InputType') ||
          lines[i + 1].trim().startsWith(LUAname + '.Text')) {
        listChoices.addAll(getChoicesSingleLine(lines[i], LUAname, _obfuscatorFunction, _obfuscatorTable));
      } else {
        i++;
        lines[i] = lines[i].trim();
        _sectionChoices = true;
        do {
          if (lines[i].startsWith('"')) {
            listChoices.add(lines[i].trimLeft().replaceAll('",', '').replaceAll('"', ''));
            i++;
            lines[i] = lines[i].trim();
          } else {
            _sectionChoices = false;
          }
        } while (_sectionChoices);
      }
    }
  }
  print('=====> RESULT '+LUAname+' '+id+' '+variableID+' '+name+' '+description+' '+visible+' '+media+' '+icon+' '+inputType+' '+text);
  return WherigoInputData(
    LUAname,
    id,
    variableID,
    name,
    description,
    visible,
    media,
    icon,
    inputType,
    text,
    listChoices,
    [],
  );
}

bool _singleLine(String nextLine, String LUAname){
  print('  check singleLine '+nextLine);
  if (RegExp(r'( Wherigo.ZInput)').hasMatch(nextLine) ||
      nextLine.startsWith(LUAname + '.Media') ||
      RegExp(r'(.Commands)').hasMatch(nextLine.trim()) ||
      nextLine.startsWith(LUAname + '.Visible') ||
      nextLine.startsWith('function') ||
      RegExp(r'(:OnProximity)').hasMatch(nextLine.trim())) {
    return true;
  }
  return false;
}

bool _notEndOfInputText(String nextLine, String LUAname){
 if (RegExp(r'( Wherigo.ZInput)').hasMatch(nextLine) ||
      nextLine.startsWith(LUAname + '.Media') ||
      RegExp(r'(.Commands)').hasMatch(nextLine.trim()) ||
      nextLine.startsWith(LUAname + '.Visible') ||
      nextLine.startsWith('function') ||
      RegExp(r'(:OnProximity)').hasMatch(nextLine.trim())) {
    return false;
  }
  return true;
}
