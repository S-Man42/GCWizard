
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';

class MessageData{
  final String MessageText;

  MessageData(
      this.MessageText);
}



List<MessageData>getMessagesFromCartridge(String LUA, dtable, obfuscator){
  List<String> lines = LUA.split('\n');
  List<MessageData> result = [];
  bool section = true;
  int j = 1;
  String line = '';
  String text = '';

  for (int i = 0; i < lines.length; i++){
    line = lines[i];
    if (line.trimLeft().startsWith('_Urwigo.MessageBox(')) {
      text = getTextData(lines[i + 1], obfuscator, dtable);
      result.add(MessageData(text));
      i = i + 1;
    } else if (line.trimLeft().startsWith('_Urwigo.Dialog(')) {
      section = true;
      List<String> dialog = [];
      j = 1;
      do {
        if (lines[i + j].trimLeft().startsWith('Text = ' + obfuscator + '(')) {
          dialog.add(getTextData(lines[i + j], obfuscator, dtable)); dialog.add('');
        }
        if (lines[i + j].trimLeft().startsWith('}, function(action)')) {
          section = false;
        }
        j = j + 1;
      } while (section);
      text = dialog.join('\n');
      result.add(MessageData(text));
      i = i + j;
    } else if (line.trimLeft().startsWith('_Urwigo.OldDialog(')) {
      j = 1;
      section = true;
      List<String> dialog = [];
      do {
        if (lines[i + j].trimLeft().startsWith('Text = ' + obfuscator + '(')) {
          dialog.add(getTextData(lines[i + j], obfuscator, dtable)); dialog.add('');
        }
        if (lines[i + j].trimLeft().startsWith('})')) {
          section = false;
        }
        j = j + 1;
      } while (section);
      text = dialog.join('\n');
      result.add(MessageData(text));
      i = i + j;
    }
  };
  return result;
}
