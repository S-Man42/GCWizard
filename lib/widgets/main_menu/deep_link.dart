import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';


// A Widget that accepts the necessary arguments via the
// constructor.
NoAnimationMaterialPageRoute createRoute (BuildContext context, ScreenArguments arguments) {
  if (arguments?.title == null) return null;
  var name = arguments.title .replaceFirst('/', '').toLowerCase();

  var tool = registeredTools.firstWhere((tool) => tool.i18nPrefix == name);
  if (tool== null) return null;
  return NoAnimationMaterialPageRoute(builder: (context) => tool);
}

// You can pass any object to the arguments parameter.
// In this example, create a class that contains both
// a customizable title and message.
class ScreenArguments {
  String title;
  String message;

  ScreenArguments(RouteSettings setting) {
    title = setting.name;
    message = setting.arguments;
  }
}