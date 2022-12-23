import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/wherigo_urwigo/urwigo_hashbreaker/widget/urwigo_hashbreaker.dart';

class UrwigoHashBreakerRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'urwigo_hashbreaker';

  @override
  List<String> searchKeys = [
    'wherigo',
    'urwigo',
    'hashes',
    'hashbreaker',
  ];

  @override
  Widget tool = UrwigoHashBreaker();
}