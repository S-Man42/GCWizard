import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/hashes/hash_breaker/widget/hash_breaker.dart';

class HashBreakerRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.GENERAL_CODEBREAKERS = [
    ToolCategory.GENERAL_CODEBREAKERS
  ];

  @override
  String i18nPrefix = 'hashes_hashbreaker';

  @override
  List<String> searchKeys = [
    'codebreaker',
    'hashes',
    'hashbreaker',
  ];

  @override
  Widget tool = HashBreaker();
}