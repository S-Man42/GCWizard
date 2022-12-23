import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/images_and_files/visual_cryptography/widget/visual_cryptography.dart';

class VisualCryptographyRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.IMAGES_AND_FILES, ToolCategory.CRYPTOGRAPHY = [
    ToolCategory.IMAGES_AND_FILES, ToolCategory.CRYPTOGRAPHY
  ];

  @override
  String i18nPrefix = 'visual_cryptography';

  @override
  List<String> searchKeys = [
    'visualcryptography', 'images'
  ];

  @override
  Widget tool = VisualCryptography();
}