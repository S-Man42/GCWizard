import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/primes/primes_integerfactorization/widget/primes_integerfactorization.dart';

class IntegerFactorizationRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'primes_integerfactorization';

  @override
  List<String> searchKeys = [
    'primes',
    'primes_integerfactorization',
  ];

  @override
  Widget tool = IntegerFactorization();
}