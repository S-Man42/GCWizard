import 'package:gc_wizard/application/category_views/all_tools_view.dart';
import 'package:gc_wizard/application/navigation/no_animation_material_page_route.dart';
import 'package:gc_wizard/application/registry.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/gcw_web_statefulwidget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_multiple_output.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/braille/braille/widget/braille.dart';


class WebParameter {
  String title;
  Map<String, String> arguments;
  RouteSettings? settings;

  WebParameter({required this.title, required this.arguments, required this.settings});
}

NoAnimationMaterialPageRoute<GCWTool>? createRoute(BuildContext context, RouteSettings settings) {
  // print(settings);
  // print(context);
  var args = _parseUrl(settings);
  return (args == null) ? null : _createRoute(context, args);
}

List<Route<GCWTool>> createRoute2(BuildContext context, String route) {
  print('init: ' + route);
  var settings = RouteSettings(name: route + '?init='+ route);
  return  [MaterialPageRoute(
      builder: (context) => MainView(webParameter: _parseUrl(settings),),
      settings: null,
      ),
    // MaterialPageRoute(
    //   builder: (context) => Braille(),
    //   settings: null,
    // ),
  ];
  //var settings = RouteSettings(name: route);
  print(settings);
  print(context);
  var args = _parseUrl(settings);
  return [NoAnimationMaterialPageRoute(builder: (context) => MainView())];
}

WebParameter? createStartParameter(BuildContext context, String? route) {
  var settings = RouteSettings(name: route);
  return _parseUrl(settings);
}

// A Widget that accepts the necessary arguments via the constructor.
NoAnimationMaterialPageRoute<GCWTool>? _createRoute(BuildContext context, WebParameter arguments) {
  var gcwTool = _findGCWTool(arguments);
  if (gcwTool == null) return null;

  if (gcwTool.tool is GCWWebStatefulWidget) {
    try {
      (gcwTool.tool as GCWWebStatefulWidget).webQueryParameter = arguments.arguments;
    } catch (e) {}
  }

  // arguments settings only for view the path in the url
  return NoAnimationMaterialPageRoute<GCWTool>(builder: (context) => gcwTool, settings: arguments.settings);
}

GCWTool? _findGCWTool(WebParameter arguments) {
  if (arguments.title.isEmpty) return null;
  var name = arguments.title.toLowerCase();

  try {
    if (name == '?') return _toolNameList();

    return registeredTools.firstWhereOrNull((_tool) => _tool.id == name);
  } catch (e) {}

  return null;
}

WebParameter? _parseUrl(RouteSettings settings) {
  if (settings.name == null) return null;
  var uri = settings.name == '/?' ? Uri(pathSegments: ['?']) : Uri.parse(settings.name!);
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

GCWTool _toolNameList() {
  var toolList = registeredTools.map((_tool) => _tool.id + ((_tool.tool is GCWWebStatefulWidget) ? ' -> (with parameter)' : '')).toList();
  return GCWTool(
    id: 'tool_name_list',
    toolName: 'Tool name list',
    tool: Column(
      children: [
        GCWMultipleOutput(children: toolList),
      ]
    )
  );
}

// void sendWebResult(String json) {
//   // String address = 'http://sdklmfoqdd5qrtha.myfritz.net:7323/GCW_Unluac/';
//   // try {
//   //   var uri = Uri.parse(address);
//   //   var request = http.MultipartRequest('POST', uri)
//   //     ..fields['return']=json;
//   //   request.send();
//   //
//   // } catch (exception) {
//   //   //SocketException: Connection timed out (OS Error: Connection timed out, errno = 110), address = 192.168.178.93, port = 57582
//   // };
// }

