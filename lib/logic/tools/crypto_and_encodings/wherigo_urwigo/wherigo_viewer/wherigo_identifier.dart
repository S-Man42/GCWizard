
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

    for (int i = 0; i < lines.length - 1; i++){

    if (re.hasMatch(lines[i])) {
      i++;
      do {
        declaration = lines[i].trim().replaceAll(',', '').replaceAll(' ', '').split('=');
        if (declaration.length == 2) {
          if (declaration[1].startsWith(obfuscator)) { // content is obfuscated
            Identifiers.add(
                IdentifierData(
                    declaration[0].trim(),
                    deobfuscateUrwigoText(
                        declaration[1]
                            .replaceAll(obfuscator, '')
                            .replaceAll('("', '')
                            .replaceAll('")', ''),
                        dtable)));
          }
          else
            Identifiers.add( // content not obfuscated
                IdentifierData(
                    declaration[0].trim(),
                    declaration[1].replaceAll('"', '')));
        }
        else // only one element
          Identifiers.add(
              IdentifierData(
                  declaration[0].trim(),
                  ''));

        i++;
      } while ((i < lines.length - 1) && (lines[i].trimLeft() != '}'));
    }
  };

  out.addAll({'content': Identifiers});
  out.addAll({'names': NameToObject});
  return out;
}
