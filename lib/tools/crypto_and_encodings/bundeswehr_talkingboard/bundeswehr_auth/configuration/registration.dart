import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bundeswehr_talkingboard/bundeswehr_auth/widget/bundeswehr_auth.dart';

class BundeswehrTalkingBoardAuthentificationRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'bundeswehr_talkingboard_auth';

  @override
  List<String> searchKeys = [
    'bundeswehr_talkingboard_auth',
        'bundeswehr_talkingboard',
  ];

  @override
  Widget tool = BundeswehrTalkingBoardAuthentification();
}