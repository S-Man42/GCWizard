import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rsa/rsa_d_checker/widget/rsa_d_checker.dart';

class RSADCheckerRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'rsa_d.checker';

  @override
  List<String> searchKeys = [
    'rsa',
    'rsa_dchecker',
  ];

  @override
  Widget tool = RSADChecker();
}