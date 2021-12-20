
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';

class AnswerData{
  final String AnswerQuestion;
  final String AnswerText;

  AnswerData(
      this.AnswerQuestion,
      this.AnswerText);
}



List<AnswerData>getAnswersFromCartridge(String LUA, dtable, obfuscator){
  List<String> lines = LUA.split('\n');
  String line = '';
  List<AnswerData> result = [];
  bool section = true;
  int j = 1;
  String question = '';
  String text = '';
  List<String> dialog = [];

  for (int i = 0; i < lines.length; i++){
    line = lines[i];
    j = 1;
    section = true;
    if (line.trimLeft().startsWith('_Urwigo.MessageBox({')) {
      text = getLineData(lines[i + j], '', 'Text', obfuscator, dtable);
    } else if (line.trimLeft().startsWith('_Urwigo.OldDialog({')) {
      do {
        if (lines[i + j].trimLeft().startsWith('Text = ' + obfuscator + '(')) {
          dialog.add(getLineData(lines[i + 1], '', 'Text', obfuscator, dtable));
          j = j + 1;
        }
        if (lines[i + j].trimLeft().startsWith('}, function(action)') || lines[i + j].trimLeft().startsWith('})')) {
          section = false;
        }
      } while (section);
      text = dialog.join('\n');
    }
    result.add(AnswerData(question, text));
    i = i + 1 + j;
  };
  return result;
}
