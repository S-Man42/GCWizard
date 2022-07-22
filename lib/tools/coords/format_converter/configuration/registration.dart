import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/coords/format_converter/widget/format_converter.dart';

class FormatConverterRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.COORDINATES = [
    ToolCategory.COORDINATES
  ];

  @override
  String i18nPrefix = 'coords_formatconverter';

  @override
  List<String> searchKeys = [
    'coordinates',
        'coordinates_formatconverter',
  ];

  @override
  Widget tool = FormatConverter();
}