import 'dart:ui';

import 'package:gc_wizard/application/category_views/all_tools_view.dart';
import 'package:gc_wizard/application/navigation/no_animation_material_page_route.dart';
import 'package:gc_wizard/application/registry.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/gcw_toollist.dart';
import 'package:gc_wizard/common_widgets/gcw_web_statefulwidget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output_text.dart';


class WebParameter {
  String title;
  Map<String, String> arguments;
  RouteSettings? settings;

  WebParameter({required this.title, required this.arguments, required this.settings});
}

NoAnimationMaterialPageRoute<GCWTool>? createRoute(BuildContext context, RouteSettings settings) {
  var args = _parseUrl(settings);
  return (args == null) ? null : _createRoute(context, args);
}

List<Route<GCWTool>> startMainView(BuildContext context, String route) {
  return  [
    NoAnimationMaterialPageRoute<GCWTool>(builder: (context) => MainView(
        fullWebParameter: _parseUrl(RouteSettings(name: route))
    )),
  ];
}

NoAnimationMaterialPageRoute<GCWTool>? createStartDeepLinkRoute(BuildContext context, WebParameter arguments) {
  return _createRoute(context, arguments);
}

// A Widget that accepts the necessary arguments via the constructor.
NoAnimationMaterialPageRoute<GCWTool>? _createRoute(BuildContext context, WebParameter arguments) {
  var gcwTool = _findGCWTool(context, arguments);
  if (gcwTool == null) return null;

  if (gcwTool.tool is GCWWebStatefulWidget) {
    try {
      (gcwTool.tool as GCWWebStatefulWidget).webQueryParameter = arguments.arguments;
    } catch (e) {}
  }

  // arguments settings only for view the path in the url
  return NoAnimationMaterialPageRoute<GCWTool>(builder: (context) => gcwTool, settings: arguments.settings);
}

GCWTool? _findGCWTool(BuildContext context, WebParameter arguments) {
  if (arguments.title.isEmpty) return null;
  var name = arguments.title.toLowerCase();

  try {
    if (name == '?') return _toolNameList(context);

    return registeredTools.firstWhereOrNull((_tool) => _tool.id == name);
  } catch (e) {}

  return null;
}

WebParameter? _parseUrl(RouteSettings settings) {
  if (settings.name == null) return null;
  var uri = settings.name == '/?' ? Uri(pathSegments: ['?']) : Uri.parse(settings.name!);
  if (uri.pathSegments.isEmpty) return null;
  var title = uri.pathSegments[0];

  return WebParameter(title: title, arguments: uri.queryParameters, settings: settings);

  // MultiDecoder?input=Test%20String
  //Morse?input=Test%20String&modeencode=true
  //Morse?input=...%20---%20...
  //Morse?input=test&modeencode=true
  //alphabetvalues?input=Test
  //alphabetvalues?input=Test&modeencode=true&result=json
  //alphabetvalues?input=Test12&modeencode=true
  //alphabetvalues?input=1%202%203%204&modeencode=true
  //coords_formatconverter?fromformat=coords_utm
  //coords_formatconverter?fromformat=coords_utm?toformat=coords_utm ->Error
  //coords_formatconverter?input=N48%C2%B023.123%20E9%C2%B012.456&result=json     N48°23.123 E9°12.456
  //coords_formatconverter?input=N48%C2%B023.123%20E9%C2%B012.456&toformat=coords_utm&result=json
  //coords_formatconverter?input=N48%C2%B023.123%20E9%C2%B012.456&toformat=coords_all&result=json
  //rotation_general?input=test&parameter1=4&result=json

  // toolname?parameter1=xxx&parameter2=xxx
}

GCWTool _toolNameList(BuildContext context) {
  var toolList = registeredTools.map((_tool) => _tool.id + ((_tool.tool is GCWWebStatefulWidget) ? ' -> (with parameter)' : ''));
  return GCWTool(
    suppressHelpButton: true,
    id: 'tool_name_list',
    toolName: 'Tool name list',
      tool: ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse
        },
      ),
      child: _buildItems(context, toolList.toList()),
    )
  );

}

Widget _buildItems(BuildContext context, List<String> toolList) {
  return ListView.separated(
    shrinkWrap: true,
    physics: const AlwaysScrollableScrollPhysics(),
    itemCount: toolList.length,
    separatorBuilder: (BuildContext context, int index) => const Divider(),
    itemBuilder: (BuildContext context, int i) {
      return _buildRow(context, toolList.elementAt(i));
    },
  );
}

Widget _buildRow(BuildContext context, String id) {
  return GCWOutputText(text: id, copyText: 'https://test.gcwizard.net/#/' + id);
}


