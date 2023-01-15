import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_web_statefulwidget.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/registry.dart';
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


  // arguments settings only for view the path in the url
  return NoAnimationMaterialPageRoute(builder: (context) => gcwTool, settings: arguments.settings);
}

void sendWebResult(String json) {
  String address = 'http://sdklmfoqdd5qrtha.myfritz.net:7323/GCW_Unluac/';
  try {
    var uri = Uri.parse(address);
    var request = http.MultipartRequest('POST', uri)
      ..fields['return']=json;
    request.send();

  } catch (exception) {
    //SocketException: Connection timed out (OS Error: Connection timed out, errno = 110), address = 192.168.178.93, port = 57582
  };
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
    arguments = uri.queryParameters;
  }
}