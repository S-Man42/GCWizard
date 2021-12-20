import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/urwigo_tools.dart';

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
    result = result.replaceAll(obfuscator,'').replaceAll('(', '').replaceAll('"', '').replaceAll(')', '').replaceAll('\n', ' ');
    result = deobfuscateUrwigoText(result, dtable).replaceAll('<BR>', '\n');
  } else {
    result = result.replaceAll('"', '');
  }
  return result;
}

String getStructData(String analyseLine, String type){
  return analyseLine.trimLeft().replaceAll(type + ' = ', '').replaceAll('"', '').replaceAll(',', '');
}

String getTextData(String analyseLine, String obfuscator, String dtable){
  String result = analyseLine.trimLeft().replaceAll('Text = ', '');
  if (result.startsWith('(' + obfuscator)) {
    result = result.replaceAll('(' + obfuscator, obfuscator).replaceAll('),', ')');
    result = _getDetails(result, obfuscator, dtable);
  } else if (result.startsWith(obfuscator)) {
    result = result.replaceAll(obfuscator + '("','').replaceAll('"),', '');
    result = deobfuscateUrwigoText(result, dtable).replaceAll('<BR>', '\n');
  } else {
    result = result.replaceAll('"', '');
  }
  return result;
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
    result = result + deobfuscateUrwigoText(element, dtable).replaceAll('<BR>', '\n');
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

  return result;
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
