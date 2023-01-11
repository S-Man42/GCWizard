import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_web_statefulwidget.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/multi_decoder.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';


// A Widget that accepts the necessary arguments via the
// constructor.
NoAnimationMaterialPageRoute createRoute (BuildContext context, ScreenArguments arguments) {
  if (arguments?.title == null) return null;
  var name = arguments.title.toLowerCase();
  List<GCWTool> tools;
  try {
    tools = registeredTools.where((tool) => tool.i18nPrefix == name).toList();
  } catch (e) {}
  if (tools == null || tools.isEmpty) return null;

  var gcwTool = tools.first;
  if (gcwTool.tool is GCWWebStatefulWidget) {
    try {
      (gcwTool.tool as GCWWebStatefulWidget).webQueryParameter = arguments.arguments;
    } catch (e) {}
  }
  // test MultiDecoder

  // arguments settings only for view the path in the url
  return NoAnimationMaterialPageRoute(builder: (context) => gcwTool, settings: arguments.settings);
}

// You can pass any object to the arguments parameter.
// In this example, create a class that contains both
// a customizable title and message.
class ScreenArguments {
  String title;
  Map<String, dynamic> arguments;
  RouteSettings settings;

  ScreenArguments(RouteSettings setting) {
    settings = setting;

    var uri = Uri.parse(setting.name);
    title = uri.pathSegments[0];
    arguments = uri.queryParameters;
  }
}