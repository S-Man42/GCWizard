import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/pantone_color_codes/widget/pantone_color_codes.dart';

class PantoneColorCodesRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'pantonecolorcodes';

  @override
  List<String> searchKeys = [
    'color',
    'pantonecolorcodes',
  ];

  @override
  Widget tool = PantoneColorCodes();
}