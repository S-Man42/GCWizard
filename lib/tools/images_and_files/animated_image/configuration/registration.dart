import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/images_and_files/animated_image/widget/animated_image.dart';

class AnimatedImageRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.IMAGES_AND_FILES = [
    ToolCategory.IMAGES_AND_FILES
  ];

  @override
  String i18nPrefix = 'animated_image';

  @override
  List<String> searchKeys = [
    'animated_images',
  ];

  @override
  Widget tool = AnimatedImage();
}