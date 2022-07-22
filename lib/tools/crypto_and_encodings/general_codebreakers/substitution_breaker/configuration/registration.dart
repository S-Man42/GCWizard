import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/substitution_breaker/widget/substitution_breaker.dart';

class SubstitutionBreakerRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.GENERAL_CODEBREAKERS = [
    ToolCategory.GENERAL_CODEBREAKERS
  ];

  @override
  String i18nPrefix = 'substitutionbreaker';

  @override
  List<String> searchKeys = [
    'codebreaker',
    'substitutionbreaker',
  ];

  @override
  Widget tool = SubstitutionBreaker();
}