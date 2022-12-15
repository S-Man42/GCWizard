import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';


// A Widget that accepts the necessary arguments via the
// constructor.
NoAnimationMaterialPageRoute createRoute (BuildContext context, ScreenArguments arguments) {
  if (arguments?.title == null) return null;
  var name = arguments.title.toLowerCase();
  var tool = registeredTools.firstWhere((tool) => tool.i18nPrefix == name);

  if (tool == null) {
    switch (name) {
      case 'symboltables':
        if (arguments.arguments != null && !arguments.arguments.isNotEmpty)
          registeredTools.firstWhere((tool) => tool.i18nPrefix == arguments.arguments[0]);
        break;
      case 'format_converter': // coords converter

    }
  }

  if (tool== null) return null;

  // arguments settings only for view the path in the url
  return NoAnimationMaterialPageRoute(builder: (context) => tool, settings: arguments.settings);
}

// You can pass any object to the arguments parameter.
// In this example, create a class that contains both
// a customizable title and message.
class ScreenArguments {
  String title;
  List<MapEntry<String, String>> arguments;
  RouteSettings settings;


  ScreenArguments(RouteSettings setting) {
    var regExp = RegExp(r'^(\/)([^#?]+)\??([^\.]*)');
    var match = regExp.firstMatch(setting.name);

    settings = setting;

    if (match != null) {
      title = match.group(2);
      if (match.groupCount > 2) {
        regExp = RegExp(r'([\w]+)=([\w]+)\&?');
        var matches = regExp.allMatches(match.group(3));
        if (matches != null) {
          arguments = <MapEntry<String, String>>[];
          matches.forEach((match) {
            arguments.add(MapEntry<String, String>(match.group(1), match.group(2)));
          });
        }
      }
    }
  }
}