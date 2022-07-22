import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/wherigo_urwigo/earwigo_text_deobfuscation/widget/earwigo_text_deobfuscation.dart';

class EarwigoTextDeobfuscationRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'earwigo_textdeobfuscation';

  @override
  List<String> searchKeys = [
    'wherigo', 'earwigo', 'urwigo_textdeobfuscation'
  ];

  @override
  Widget tool = EarwigoTextDeobfuscation();
}