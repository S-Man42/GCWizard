
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/urwigo_tools.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_dataobjects.dart';


Map<String, dynamic> getIdentifiersFromCartridge(String LUA, dtable, obfuscator){

  List<String> lines = LUA.split('\n');
  List<String> declaration = [];
  List<VariableData> Variables = [];
  Map<String, ObjectData> NameToObject = {};
  var out = Map<String, dynamic>();

    for (int i = 0; i < lines.length - 1; i++){

    if (RegExp(r'( = Wherigo.ZVariables)').hasMatch(lines[i])) {
      currentObjectSection = OBJECT_TYPE.VARIABLES;
      i++;
      do {
        declaration = lines[i].trim().replaceAll(',', '').replaceAll(' ', '').split('=');
        if (declaration.length == 2) {
          if (declaration[1].startsWith(obfuscator)) { // content is obfuscated
            Variables.add(
                VariableData(
                    declaration[0].trim(),
                    deobfuscateUrwigoText(
                        declaration[1]
                            .replaceAll(obfuscator, '')
                            .replaceAll('("', '')
                            .replaceAll('")', ''),
                        dtable)));
          }
          else
            Variables.add( // content not obfuscated
                VariableData(
                    declaration[0].trim(),
                    declaration[1].replaceAll('"', '')));
        }
        else // only one element
          Variables.add(
              VariableData(
                  declaration[0].trim(),
                  ''));

        i++;
      } while ((i < lines.length - 1) && (lines[i].trimLeft() != '}'));
    }
  };

  out.addAll({'content': Variables});
  out.addAll({'names': NameToObject});
  return out;
}
