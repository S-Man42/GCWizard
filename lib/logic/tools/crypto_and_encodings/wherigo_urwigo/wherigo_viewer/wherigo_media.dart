
import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';

class MediaData {
  final String MediaLUAName;
  final String MediaID;
  final String MediaName;
  final String MediaDescription;
  final String MediaAltText;
  final String MediaType;
  final String MediaFilename;

  MediaData(
      this.MediaLUAName,
      this.MediaID,
      this.MediaName,
      this.MediaDescription,
      this.MediaAltText,
      this.MediaType,
      this.MediaFilename);
}


List<MediaData>getMediaFromCartridge(String LUA, dtable, obfuscator){
  RegExp re = RegExp(r'( = Wherigo.ZMedia)');
  List<String> lines = LUA.split('\n');
  List<MediaData> result = [];
  bool sectionMedia = true;
  bool sectionInner = true;
  int j = 1;
  String LUAname = '';
  String id = '';
  String name = '';
  String description = '';
  String type = '';
  String medianame = '';
  String alttext = '';

  for (int i = 0; i < lines.length; i++){
    if (re.hasMatch(lines[i])) {
      print((i+1).toString()+' '+lines[i]);
      LUAname = '';
      id = '';
      name = '';
      description = '';
      type = '';
      medianame = '';
      alttext = '';

      LUAname = getLUAName(lines[i]);

      sectionMedia = true;
      j = 1;
      do {
        if (lines[i + j].trim().replaceAll(LUAname + '.', '').startsWith('Id')) {
          id = getLineData(lines[i + j], LUAname, 'Id', obfuscator, dtable);
        }

        else if (lines[i + j].trim().replaceAll(LUAname + '.', '').startsWith('Name')) {
          name = getLineData(lines[i + j], LUAname, 'Name', obfuscator, dtable);
        }

        else if (lines[i + j].trim().replaceAll(LUAname + '.', '').startsWith('Description')) {
          if (lines[i + j + 1].trim().replaceAll(LUAname + '.', '').startsWith('AltText')) {
            description = getLineData(lines[i + j], LUAname, 'Description', obfuscator, dtable);
          } else {
            sectionInner = true;
            description = lines[i + j].trim().replaceAll(LUAname + '.', '');
            j++;
            do {
              if (lines[i + j].trim().replaceAll(LUAname + '.', '').startsWith('AltText'))
                sectionInner = false;
              else
                description = description + lines[i + j];
              j++;
            } while (sectionInner);
          }
        }

        else if (lines[i + j].trim().replaceAll(LUAname + '.', '').startsWith('AltText')) {
          alttext = getLineData(lines[i + j], LUAname, 'AltText', obfuscator, dtable);
        }

        else if (lines[i + j].trim().replaceAll(LUAname + '.', '').startsWith('Resources')) {
          j++;
          sectionInner = true;
          do {
            if (lines[i + j].trimLeft().startsWith('Filename = '))
              medianame = getStructData(lines[i + j], 'Filename');
            if (lines[i + j].trimLeft().startsWith('Type = '))
              type = getStructData(lines[i + j], 'Type');
            if (lines[i + j].trimLeft().startsWith('Directives = '))
              sectionInner = false;
            j++;
          } while (sectionInner);
        }

        else if (lines[i + j].trimLeft().startsWith('Directives ='))
          sectionMedia = false;
        j++;
      } while (sectionMedia && (i + j < lines.length));
      i = i + j;

      result.add(MediaData(
          LUAname,
          id,
          name,
          description,
          alttext,
          type,
          medianame,
      ));
      i = i + 2 + j;
    }
  };
  return result;
}
