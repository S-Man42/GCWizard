import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rsa/rsa_phi_calculator/widget/rsa_phi_calculator.dart';

class RSAPhiCalculatorRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'rsa_phi.calculator';

  @override
  List<String> searchKeys = [
    'rsa'
  ];

  @override
  Widget tool = RSAPhiCalculator();
}