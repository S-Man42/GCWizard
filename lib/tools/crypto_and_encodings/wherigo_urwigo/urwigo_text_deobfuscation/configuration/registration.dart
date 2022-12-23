import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/wherigo_urwigo/urwigo_text_deobfuscation/widget/urwigo_text_deobfuscation.dart';

class UrwigoTextDeobfuscationRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'urwigo_textdeobfuscation';

  @override
  List<String> searchKeys = [
    'wherigo', 'urwigo', 'urwigo_textdeobfuscation'
  ];

  @override
  Widget tool = UrwigoTextDeobfuscation();
}