
import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_dataobjects.dart';



Map<String, dynamic> getMediaFromCartridge(String LUA, dtable, obfuscator){
  List<String> lines = LUA.split('\n');
  List<MediaData> Medias = [];
  Map<String, ObjectData> NameToObject = {};
  var out = Map<String, dynamic>();



  for (int i = 0; i < lines.length; i++){

  };

  out.addAll({'content': Medias});
  out.addAll({'names': NameToObject});
  return out;
}
