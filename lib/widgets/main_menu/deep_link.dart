import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';


// A Widget that accepts the necessary arguments via the
// constructor.
NoAnimationMaterialPageRoute createRoute (BuildContext context, ScreenArguments arguments) {
  if (arguments?.title == null) return null;
  var name = arguments.title.toLowerCase();

  var tool = registeredTools.firstWhere((tool) => tool.i18nPrefix == name);
  if (tool== null) return null;
  return NoAnimationMaterialPageRoute(builder: (context) => tool);
}

// You can pass any object to the arguments parameter.
// In this example, create a class that contains both
// a customizable title and message.
class ScreenArguments {
  String title;
  List<MapEntry<String, String>> arguments;

  ScreenArguments(RouteSettings setting) {
    var regExp = RegExp(r'^(\/)([^?#]+)\??([^#]+)');
    var match = regExp.firstMatch(setting.name);
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