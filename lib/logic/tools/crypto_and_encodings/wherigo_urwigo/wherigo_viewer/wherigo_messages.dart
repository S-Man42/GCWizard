
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';

class MessageData{
  final List<List<MessageElementData>> MessageElement;

  MessageData(
      this.MessageElement,
      );
}

class MessageElementData{
  final String MessageType;
  final String MessageContent;

  MessageElementData(
    this.MessageType,
    this.MessageContent,
  );
}



List<List<MessageElementData>> getMessagesFromCartridge(String LUA, dtable, obfuscator){
  if (LUA == null || LUA == '') {
    return [];
  } else {
    List<String> lines = LUA.split('\n');
    List<MessageElementData> singleMessageDialog = [];
    List<List<MessageElementData>> result = [];
    bool section = true;
    int j = 1;
    String line = '';
    String text = '';
    bool urwigo = (lines[6].trim().startsWith('local dtable = "'));

    for (int i = 0; i < lines.length; i++){
      line = lines[i];

      if (line.trimLeft().startsWith('_Urwigo.MessageBox(') || line.trimLeft().startsWith('Wherigo.MessageBox(')) {
        if (urwigo && i <100)
          i = 190;
        else {
          singleMessageDialog = [];
          j = 1;
          do {
            if (lines[i + j].trimLeft().startsWith('Text')) {
              singleMessageDialog.add(MessageElementData(
                  'txt', getTextData(lines[i + j], obfuscator, dtable)));
            }

            else if (lines[i + j].trimLeft().startsWith('Media')) {
              singleMessageDialog.add(MessageElementData('img',
                  lines[i + j].trimLeft().replaceAll('Media = ', '')));
            }

            else if (lines[i + j].trimLeft().startsWith('Buttons')) {
              j++;
              do {
                singleMessageDialog.add(MessageElementData('btn',
                    getTextData('Text = ' + lines[i + j].trim(), obfuscator, dtable)));
                j++;
              } while (!lines[i + j].trimLeft().startsWith('}'));
            }
            j++;
          } while ((i + j < lines.length) && !lines[i + j].trimLeft().startsWith('})'));
          i = i + j;
          result.add(singleMessageDialog);
        }
      }

      else if (line.trimLeft().startsWith('_Urwigo.Dialog(') || line.trimLeft().startsWith('Wherigo.Dialog(')) {
        section = true;
        singleMessageDialog = [];
        j = 1;
        do {
          if (lines[i + j].trimLeft().startsWith('Text = ') ||
              lines[i + j].trimLeft().startsWith('Text = ' + obfuscator + '(') ||
              lines[i + j].trimLeft().startsWith('Text = (' + obfuscator + '(')) {
            singleMessageDialog.add(MessageElementData('txt', getTextData(lines[i + j], obfuscator, dtable)));
          } else if (lines[i + j].trimLeft().startsWith('Media')) {
            singleMessageDialog.add(MessageElementData('img',
                lines[i + j].trimLeft().replaceAll('Media = ', '')));
          } else if (lines[i + j].trimLeft().startsWith('Buttons')) {
            j++;
            do {
              singleMessageDialog.add(MessageElementData('btn',
                  getTextData('Text = ' + lines[i + j].trim(), obfuscator, dtable)));
              j++;
            } while (lines[i + j].trimLeft() != '}');
          }
          if (lines[i + j].trimLeft().startsWith('}, function(action)') ||
              lines[i + j].trimLeft().startsWith('}, nil)') ||
              lines[i + j].trimLeft().startsWith('})')) {
            section = false;
          }
          j = j + 1;
        } while (section && (i + j < lines.length));
        i = i + j;
        result.add(singleMessageDialog);
      }

      else if (line.trimLeft().startsWith('_Urwigo.OldDialog(')) {
        j = 1;
        section = true;
        singleMessageDialog = [];
        do {
          if (lines[i + j].trimLeft().startsWith('Text = ' + obfuscator + '(') ||
              lines[i + j].trimLeft().startsWith('Text = (' + obfuscator + '(')) {
            singleMessageDialog.add(MessageElementData('txt', getTextData(lines[i + j], obfuscator, dtable)));
          } else if (lines[i + j].trimLeft().startsWith('Media')) {
            singleMessageDialog.add(MessageElementData('img',
                lines[i + j].trimLeft().replaceAll('Media = ', '')));
          } else if (lines[i + j].trimLeft().startsWith('Buttons')) {
            j++;
            do {
              singleMessageDialog.add(MessageElementData('btn',
                  getTextData('Text = ' + lines[i + j].trim(), obfuscator, dtable)));
              j++;
            } while (lines[i + j].trimLeft() != '}');
          }
          if (lines[i + j].trimLeft().startsWith('})')) {
            section = false;
          }
          j = j + 1;
        } while (section);
        i = i + j;
        result.add(singleMessageDialog);
      }
    };
    return result;
  }
}
