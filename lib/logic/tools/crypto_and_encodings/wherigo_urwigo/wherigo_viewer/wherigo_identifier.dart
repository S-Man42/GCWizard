
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/urwigo_tools.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';

class IdentifierData{
  final String IdentifierLUAName;
  final String IdentifierName;

  IdentifierData(
      this.IdentifierLUAName,
      this.IdentifierName);
}

Map<String, dynamic> getIdentifiersFromCartridge(String LUA, dtable, obfuscator){
  RegExp re = RegExp(r'(.ZVariables)');
  List<String> lines = LUA.split('\n');
  List<String> declaration = [];
  List<IdentifierData> Identifiers = [];
  Map<String, ObjectData> NameToObject = {};
  var out = Map<String, dynamic>();

  int j = 1;

  for (int i = 0; i < lines.length; i++){
    if (re.hasMatch(lines[i])) {
      j = 1;
      do {
        declaration = lines[i + j].trim().replaceAll(',', '').replaceAll(obfuscator, '').replaceAll('("', '').replaceAll('")', '').split('=');
        if (declaration.length == 2)
          Identifiers.add(IdentifierData(declaration[0], deobfuscateUrwigoText(declaration[1], dtable)));
        else
          Identifiers.add(IdentifierData(declaration[0], ''));
        j++;
      } while(lines[i + j].trimLeft() != '}');
    }
  };

  out.addAll({'content': Identifiers});
  out.addAll({'names': NameToObject});
  return out;
}
