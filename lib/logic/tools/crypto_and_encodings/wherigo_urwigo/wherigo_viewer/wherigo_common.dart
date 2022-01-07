import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/urwigo_tools.dart';
import 'package:gc_wizard/utils/common_utils.dart';

class ObjectData{
  final String ObjectID;
  final String ObjectName;
  final String ObjectMedia;

  ObjectData(
      this.ObjectID,
      this.ObjectName,
      this.ObjectMedia,
  );
}

enum ACTIONMESSAGETYPE {TEXT, IMAGE, BUTTON, COMMAND, CASE}

Map<ACTIONMESSAGETYPE, String> ACTIONMESSAGETYPE_TEXT = {
  ACTIONMESSAGETYPE.TEXT: 'txt',
  ACTIONMESSAGETYPE.IMAGE: 'img',
  ACTIONMESSAGETYPE.BUTTON: 'btn',
  ACTIONMESSAGETYPE.COMMAND: 'cmd',
  ACTIONMESSAGETYPE.CASE: 'cse',
};

Map TEXT_ACTIONMESSAGETYPE = switchMapKeyValue(ACTIONMESSAGETYPE_TEXT);


String getLUAName(String line) {
  String result = '';
  int i = 0;
  while (line[i] != ' ') {
    result = result + line[i];
    i++;
  }
  return result;
}

String getLineData(String analyseLine, String LUAname, String type, String obfuscator, String dtable){
  String result = analyseLine.replaceAll(LUAname + '.' + type + ' = ', '');
  if (result.startsWith(obfuscator)) {
    result = result.replaceAll(obfuscator + '("','').replaceAll('")', '');
    result = deobfuscateUrwigoText(result, dtable);
  } else {
    result = result.replaceAll('"', '');
  }
  return _normalizeText(result);
}


String getStructData(String analyseLine, String type){
  return analyseLine.trimLeft().replaceAll(type + ' = ', '').replaceAll('"', '').replaceAll(',', '');
}


String getTextData( String analyseLine, String obfuscator, String dtable){
  String result = analyseLine.trimLeft().replaceAll('Text = ', '').replaceAll('[[', '').replaceAll(']]', '');
  if (result.startsWith('(' + obfuscator)) {
    result = result.replaceAll('(' + obfuscator, obfuscator).replaceAll('),', ')');
    result = _getDetails(result, obfuscator, dtable);
  }

  else if (result.startsWith(obfuscator)) {
    if (_compositeText(result)) {
      result = _getCompositeText(result, obfuscator, dtable);
    } else {
      result = result.replaceAll(obfuscator + '("','').replaceAll('"),', '').replaceAll('")', '');
      result = deobfuscateUrwigoText(result, dtable);
    }
  }

  return _normalizeText(result);
}


String _getDetails(String line, String obfuscator, String dtable){
  String element = '';
  String result = '';
  int i = 0;
  bool section = true;
  do {
    i = obfuscator.length + 2;
    element = '';

    do {//get obfuscated string
      element = element + line[i];
      i = i + 1;
    } while(line[i ] + line[i + 1] != '")');
    result = result + deobfuscateUrwigoText(element, dtable);
    line = line.substring(i + 2);

    i = 0;
    if (line.length != 0) {
      do {// get something else in between
        if (line.substring(i).startsWith(obfuscator))
          section = false;
        i = i + 1;
      } while(section);
      result = result + line.substring(0, i - 1);
      line = line.substring(i);
    }

  } while(line.length != 0);

  return _normalizeText(result);
}

String getObfuscatorFunction(String source){
  String result = '';
  List<String> LUA = source.split('\n');
  for (int i = 0; i < LUA.length; i++){
    if (LUA[i].startsWith('function')) {
      result = LUA[i].substring(9);
      for (int j = result.length - 1; j > 0; j--) {
        if (result[j] == '(') {
          result = result.substring(0, j);
          j = 0;
        }
      }
      i = source.length;
    }
  }
  return result;
}

List<String> getChoicesSingleLine(String choicesLine, String LUAname, String obfuscator, String dtable){
  List<String> result = [];
  choicesLine.replaceAll(LUAname + '.Choices = {', '').replaceAll('"', '').replaceAll('}', '').split(',').forEach((element) {
    result.add(element.trim());
  });
  return result;
}

bool _compositeText(String text){
   RegExp expr = RegExp(r'"\) .. ');
   return (expr.hasMatch(text));
}

String _getCompositeText(String text, String obfuscator, String dtable){
  String hashText = '';
  String result = '';

  int i = obfuscator.length + 2;
  do {
    hashText = hashText + text[i];
    i++;
  } while ((text[i] + text[i + 1] != '")'));
  text = text.substring(i + 2);
  result = result + deobfuscateUrwigoText(hashText, dtable) + text;
  return _normalizeText(result);
}


String _normalizeText(String text){
  return text
      .replaceAll(String.fromCharCode(92) + '"', "'")
      .replaceAll('"', '')
      .replaceAll('&nbsp;', ' ')
      .replaceAll('<BR>', '\n')
      .replaceAll(String.fromCharCode(92) + 'n', '\n');
}
