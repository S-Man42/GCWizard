import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bundeswehr_talkingboard/bundeswehr_code/widget/bundeswehr_code.dart';

class BundeswehrTalkingBoardObfuscationRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'bundeswehr_talkingboard_code';

  @override
  List<String> searchKeys = [
    'bundeswehr_talkingboard',
        'bundeswehr_talkingboard_code',
  ];

  @override
  Widget tool = BundeswehrTalkingBoardObfuscation();
}