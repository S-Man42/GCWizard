import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/images_and_files/stegano/widget/stegano.dart';

class SteganoRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.IMAGES_AND_FILES = [
    ToolCategory.IMAGES_AND_FILES
  ];

  @override
  String i18nPrefix = 'stegano';

  @override
  List<String> searchKeys = [
    'stegano',
  ];

  @override
  Widget tool = Stegano();
}