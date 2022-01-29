
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_dataobjects.dart';




List<List<ActionMessageElementData>> getMessagesFromCartridge(String LUA, dtable, obfuscator){
  if (LUA == null || LUA == '')
    return [];


  List<String> lines = LUA.split('\n');
  List<ActionMessageElementData> singleMessageDialog = [];
  List<List<ActionMessageElementData>> Messages = [];
  bool section = true;

  String line = '';

  for (int i = 0; i < lines.length - 1; i++){
    line = lines[i];

    if (line.trimLeft().startsWith('_Urwigo.MessageBox(') || line.trimLeft().startsWith('Wherigo.MessageBox(')) {
        singleMessageDialog = [];
        i++;
        do {
          if (lines[i].trimLeft().startsWith('Text')) {
            singleMessageDialog.add(
                ActionMessageElementData(
                    ACTIONMESSAGETYPE.TEXT,
                    getTextData(lines[i],obfuscator, dtable)));
          }

          else if (lines[i].trimLeft().startsWith('Media')) {
            singleMessageDialog.add(
                ActionMessageElementData(
                    ACTIONMESSAGETYPE.IMAGE,
                    lines[i].trimLeft().replaceAll('Media = ', '').replaceAll('"', '').replaceAll(',', '')));
          }

          else if (lines[i].trimLeft().startsWith('Buttons')) {
            i++;
            do {
              singleMessageDialog.add(
                  ActionMessageElementData(
                      ACTIONMESSAGETYPE.BUTTON,
                      getTextData('Text = ' + lines[i].trim(), obfuscator, dtable)));
              i++;
            } while (!lines[i].trimLeft().startsWith('}'));
          }
          i++;
        } while ((i < lines.length) && !lines[i].trimLeft().startsWith('})'));
        Messages.add(singleMessageDialog);
      }

    else if (line.trimLeft().startsWith('_Urwigo.Dialog(') || line.trimLeft().startsWith('Wherigo.Dialog(')) {
      section = true;
      singleMessageDialog = [];
      i++;
      do {
        if (lines[i].trimLeft().startsWith('Text = ') ||
            lines[i].trimLeft().startsWith('Text = ' + obfuscator + '(') ||
            lines[i].trimLeft().startsWith('Text = (' + obfuscator + '(')) {
          singleMessageDialog.add(
              ActionMessageElementData(
                  ACTIONMESSAGETYPE.TEXT,
                  getTextData(lines[i], obfuscator, dtable)));
        } else if (lines[i].trimLeft().startsWith('Media')) {
          singleMessageDialog.add(
              ActionMessageElementData(
                  ACTIONMESSAGETYPE.IMAGE,
                  lines[i].trimLeft().replaceAll('Media = ', '')));
        } else if (lines[i].trimLeft().startsWith('Buttons')) {
          i++;
          do {
            singleMessageDialog.add(
                ActionMessageElementData(
                    ACTIONMESSAGETYPE.BUTTON,
                    getTextData('Text = ' + lines[i].trim(), obfuscator, dtable)));
            i++;
          } while (lines[i].trimLeft() != '}');
        }
        if (lines[i].trimLeft().startsWith('}, function(action)') ||
            lines[i].trimLeft().startsWith('}, nil)') ||
            lines[i].trimLeft().startsWith('})')) {
          section = false;
        }
        i++;
      } while (section && (i < lines.length));
      Messages.add(singleMessageDialog);
    }

    else if (line.trimLeft().startsWith('_Urwigo.OldDialog(')) {
      i++;
      section = true;
      singleMessageDialog = [];
      do {
        if (lines[i].trimLeft().startsWith('Text = ' + obfuscator + '(') ||
            lines[i].trimLeft().startsWith('Text = (' + obfuscator + '(')) {
          singleMessageDialog.add(
              ActionMessageElementData(
                  ACTIONMESSAGETYPE.TEXT,
                  getTextData(lines[i], obfuscator, dtable)));
        } else if (lines[i].trimLeft().startsWith('Media')) {
          singleMessageDialog.add(
              ActionMessageElementData(
                  ACTIONMESSAGETYPE.IMAGE,
                  lines[i].trimLeft().replaceAll('Media = ', '')));
        } else if (lines[i].trimLeft().startsWith('Buttons')) {
          i++;
          do {
            singleMessageDialog.add(
                ActionMessageElementData(
                    ACTIONMESSAGETYPE.BUTTON,
                    getTextData('Text = ' + lines[i].trim(), obfuscator, dtable)));
            i++;
          } while (lines[i].trimLeft() != '}');
        }
        if (lines[i].trimLeft().startsWith('})')) {
          section = false;
        }
        i++;
      } while (section);
      Messages.add(singleMessageDialog);
    }
  };

  return Messages;

}
