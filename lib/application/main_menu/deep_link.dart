import 'dart:ui';

import 'package:gc_wizard/application/category_views/all_tools_view.dart';
import 'package:gc_wizard/application/navigation/no_animation_material_page_route.dart';
import 'package:gc_wizard/application/registry.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
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
  print(settings);
  var args = _parseUrl(settings);
  return (args == null) ? null : _createRoute(context, args);
}

List<Route<GCWTool>> startMainView(BuildContext context, String route) {
  print('main: ' + route);
  return  [
    NoAnimationMaterialPageRoute<GCWTool>(builder: (context) => MainView(
        webParameter: _parseUrl(RouteSettings(name: route), initRoute: true)?.arguments)
    ),
  ];
}

NoAnimationMaterialPageRoute<GCWTool>? createStartDeepLinkRoute(BuildContext context, Map<String, String> arguments) {
  print('createStartDeepLinkRoute');
  var webparamter = WebParameter(title: arguments['initRoute'] ?? '', arguments: arguments, settings: null);
  return _createRoute(context, webparamter);
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
  return _buildRoute(context, gcwTool, arguments.settings);
}

NoAnimationMaterialPageRoute<GCWTool> _buildRoute(BuildContext context, GCWTool gcwTool, RouteSettings? settings) {
  // arguments settings only for view the path in the url , settings: arguments.settings
  return NoAnimationMaterialPageRoute<GCWTool>(builder: (context) => gcwTool, settings: RouteSettings(name: ''));
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

WebParameter? _parseUrl(RouteSettings settings, {bool initRoute = false}) {
  if (settings.name == null) return null;
  var uri = settings.name == '/?' ? Uri(pathSegments: ['?']) : Uri.parse(settings.name!);
  if (uri.pathSegments.isEmpty) return null;
  var title = uri.pathSegments[0];

  var parameter = uri.queryParameters;
  if (initRoute) {
    parameter = Map<String, String>.from(parameter);
    parameter.addAll({'initRoute': title });
  }
  return WebParameter(title: title, arguments: parameter, settings: settings);

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
  var toolList = List<GCWTool>.from(registeredTools.where((element) => element.tool is! GCWSelection));
  toolList.sort((a, b) => a.id.compareTo(b.id));

  return GCWTool(
    suppressHelpButton: true,
    id: 'tool_name_list',
    toolName: 'Tool name list',
      tool: _buildItems(context, toolList),
    // )
  );

}

Widget _buildItems(BuildContext context, List<GCWTool> toolList) {
  return SizedBox(
    height: maxScreenHeight(context),
    child: ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse
        },
      ),
      child: FutureBuilder<List<Widget>>(
        future: _buildRows(context, toolList),
        builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
          return ListView(
            primary: true,
            physics: const AlwaysScrollableScrollPhysics(),
            children: snapshot.data ?? []
          );
        }
      )
    )
  );
}

Future<List<Widget>> _buildRows(BuildContext context, List<GCWTool> toolList) async {
  return Future.value(toolList.map((tool) => _buildRow(context, tool)).toList());
}

Widget _buildRow(BuildContext context, GCWTool tool) {
  return FutureBuilder<String>(
      future: _toolInfo(tool),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return GCWOutputText(
            text: snapshot.data ?? '',
            copyText: 'https://test.gcwizard.net/#/' + tool.id
        );
      }
  );
}

Future<String> _toolInfo(GCWTool tool) async {
  var info = tool.id;
  if (tool.tool is GCWWebStatefulWidget) {
    info += ' -> (with parameter)';
    if ((tool.tool as GCWWebStatefulWidget).parameterInfo != null) {
      info += '\nparameter info:\n'+ (tool.tool as GCWWebStatefulWidget).parameterInfo!;
    }
  }
 return info;
}

