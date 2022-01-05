
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


Map<String, dynamic> getMediaFromCartridge(String LUA, dtable, obfuscator){
  RegExp re = RegExp(r'( = Wherigo.ZMedia)');
  List<String> lines = LUA.split('\n');
  List<MediaData> Medias = [];
  Map<String, ObjectData> NameToObject = {};
  var out = Map<String, dynamic>();
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
      LUAname = '';
      id = '';
      name = '';
      description = '';
      type = '';
      medianame = '';
      alttext = '';

      LUAname = getLUAName(lines[i]);

      sectionMedia = true;
      do {
        i++;
        if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('Id')) {
          id = getLineData(lines[i], LUAname, 'Id', obfuscator, dtable);
        }

        else if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('Name')) {
          name = getLineData(lines[i], LUAname, 'Name', obfuscator, dtable);
        }

        else if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('Description')) {
          if (lines[i + 1].trim().replaceAll(LUAname + '.', '').startsWith('AltText')) {
            description = getLineData(lines[i], LUAname, 'Description', obfuscator, dtable);
          } else {
            sectionInner = true;
            description = lines[i].trim().replaceAll(LUAname + '.', '');
            i++;
            do {
              if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('AltText'))
                sectionInner = false;
              else
                description = description + lines[i];
              i++;
            } while (sectionInner);
          }
        }

        else if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('AltText')) {
          alttext = getLineData(lines[i], LUAname, 'AltText', obfuscator, dtable);
        }

        else if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('Resources')) {
          i++;
          sectionInner = true;
          do {
            if (lines[i].trimLeft().startsWith('Filename = ')) {
              medianame = getStructData(lines[i], 'Filename');
            }
            else if (lines[i].trimLeft().startsWith('Type = ')) {
              type = getStructData(lines[i], 'Type');
            }
            else if (lines[i].trimLeft().startsWith('Directives = ')) {
              sectionInner = false;
              sectionMedia = false;
            }
            i++;
          } while (sectionInner);
        }

      } while (sectionMedia && (i < lines.length - 1));
      //i = i + j;

      Medias.add(MediaData(
          LUAname,
          id,
          name,
          description,
          alttext,
          type,
          medianame,
      ));
    }
  };

  out.addAll({'content': Medias});
  out.addAll({'names': NameToObject});
  return out;
}
