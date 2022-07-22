import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/images_and_files/binary2image/widget/binary2image.dart';

class Binary2ImageRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.IMAGES_AND_FILES = [
    ToolCategory.IMAGES_AND_FILES
  ];

  @override
  String i18nPrefix = 'binary2image';

  @override
  List<String> searchKeys = [
    'binary',
    'barcodes',
    'images',
  ];

  @override
  Widget tool = Binary2Image();
}