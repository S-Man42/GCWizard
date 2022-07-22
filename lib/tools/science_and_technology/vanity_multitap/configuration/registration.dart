import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/vanity_multitap/widget/vanity_multitap.dart';

class VanityMultitapRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'vanity_multitap';

  @override
  List<String> searchKeys = [
    'vanity',
    'vanitymultitap',
  ];

  @override
  Widget tool = VanityMultitap();
}