import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/urwigo_tools.dart';

String getLUAName(String line) {
  String result = '';
  int i = 0;
  while (line[i] != ' ') {
    result = result + line[i];
    i++;
  }
}

String getLineData(String line, LUAname, type, obfuscator, dtable){
  String result = line.replaceAll(LUAname + '.' + type + ' = ', '');
  if (result.startsWith(obfuscator)) {
    result = result.replaceAll(obfuscator,'').replaceAll('(', '').replaceAll('"', '').replaceAll(')', '');
    result = deobfuscateUrwigoText(result, dtable);
  } else {
    result = result.replaceAll('""', '""');
  }
  return result;
}

String getStructData(String line, type){
  return line.trimLeft().replaceAll(type + ' = ', '').replaceAll('"', '');
}

String getObfuscatorFunction(String source){
  String result = '';
  List<String> LUA = source.split('\n');
  for (int i = 0; i < LUA.length; i++){
    if (LUA[i].startsWith('function')) {
      result = LUA[i].substring(10);
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
