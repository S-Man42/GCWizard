import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/right_ascension_to_degree/widget/right_ascension_to_degree.dart';

class RightAscensionToDegreeRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'right_ascension_to_degree';

  @override
  List<String> searchKeys = [
    'astronomy',
    'right_ascension_to_degree',
    'coordinates',
  ];

  @override
  Widget tool = RightAscensionToDegree();
}