import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/images_and_files/animated_image_morse_code/widget/animated_image_morse_code.dart';

class AnimatedImageMorseCodeRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.IMAGES_AND_FILES = [
    ToolCategory.IMAGES_AND_FILES
  ];

  @override
  String i18nPrefix = 'animated_image_morse_code';

  @override
  List<String> searchKeys = [
    'animated_images_morse_code',
    'animated_images',
  ];

  @override
  Widget tool = AnimatedImageMorseCode();
}