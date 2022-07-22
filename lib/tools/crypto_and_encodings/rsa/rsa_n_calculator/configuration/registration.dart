import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rsa/rsa_n_calculator/widget/rsa_n_calculator.dart';

class RSANCalculatorRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'rsa_n.calculator';

  @override
  List<String> searchKeys = [
    'rsa',
    'rsa_ncalculator',
  ];

  @override
  Widget tool = RSANCalculator();
}