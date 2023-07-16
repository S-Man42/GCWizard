import 'dart:ui';

import 'package:gc_wizard/application/category_views/all_tools_view.dart';
import 'package:gc_wizard/application/navigation/no_animation_material_page_route.dart';
import 'package:gc_wizard/application/registry.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/clipboard/gcw_clipboard.dart';
import 'package:gc_wizard/common_widgets/gcw_expandable.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/common_widgets/gcw_textselectioncontrols.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/gcw_web_statefulwidget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_code_textfield.dart';
import 'package:tuple/tuple.dart';

part 'package:gc_wizard/application/webapi/deeplinks/deeplinks_toolinfo.dart';
part 'package:gc_wizard/application/webapi/deeplinks/deeplinks_toolinfo_codecolorscheme.dart';

const String _questionmark = '/?';
const String _initRoute = 'initRoute';

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
        webParameter: _parseUrl(RouteSettings(name: route), initRoute: true)?.arguments)
    ),
  ];
}

NoAnimationMaterialPageRoute<GCWTool>? createStartDeepLinkRoute(BuildContext context, Map<String, String> arguments) {

  var webparameter = WebParameter(title: arguments[_initRoute] ?? '', arguments: arguments, settings: null);
  return _createRoute(context, webparameter);
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
  return _buildRoute(context, gcwTool);
}

NoAnimationMaterialPageRoute<GCWTool> _buildRoute(BuildContext context, GCWTool gcwTool) {
  // arguments settings only for view the path in the url , settings: arguments.settings
  return NoAnimationMaterialPageRoute<GCWTool>(builder: (context) => gcwTool);
}

GCWTool? _findGCWTool(BuildContext context, WebParameter arguments) {
  if (arguments.title.isEmpty) return null;
  var name = arguments.title.toLowerCase();

  try {
    // if name == /? open tool overview
    if (name == _questionmark) return _toolNameList(context);

    var tool = registeredTools.firstWhereOrNull((_tool) => _toolId(_tool) == name);
    // if name == toolname/? open tool info
    if ((arguments.arguments[_questionmark] == _questionmark) && tool != null) {
      return _infoTool(context, tool);
    }

    return tool;
  } catch (e) {}

  return null;
}

WebParameter? _parseUrl(RouteSettings settings, {bool initRoute = false}) {
  if (settings.name == null) return null;
  Uri? uri;
  try {
    uri = settings.name == _questionmark ? Uri(pathSegments: [_questionmark]) : Uri.parse(settings.name!);
  } catch (e) {
    return null;
  }
  if (uri.pathSegments.isEmpty) return null;
  var title = uri.pathSegments[0];

  var parameter = uri.queryParameters;
  // tool info ?
  if ((uri.pathSegments.length > 1) && (uri.pathSegments[1].isEmpty && settings.name!.endsWith(_questionmark))) {
    parameter = {_questionmark: _questionmark};
  }

  if (initRoute) {
    parameter = Map<String, String>.from(parameter);
    parameter.addAll({_initRoute : title });
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
  var apiToolList = List<GCWTool>.from(registeredTools.where((element) => element.tool is GCWWebStatefulWidget));
  var toolList = List<GCWTool>.from(registeredTools.where((element) => element.tool is! GCWSelection));

  for (var element in apiToolList) {toolList.remove(element);}

  apiToolList.sort((a, b) => _toolId(a).compareTo(_toolId(b)));
  toolList.sort((a, b) => _toolId(a).compareTo(_toolId(b)));
  apiToolList.addAll(toolList);

  return GCWTool(
    suppressHelpButton: true,
    id: 'webapi_deeplink_toolsapi_title',
    toolName: i18n(context, 'webapi_deeplink_toolsapi_title') + ': ' + i18n(context, 'webapi_deeplink_toolsapi_toolpaths'),
    tool: _buildItems(context, apiToolList),
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
  return FutureBuilder<Tuple2<String, String>>(
      future: _toolInfoTextShort(context, tool),
      builder: (BuildContext context, AsyncSnapshot<Tuple2<String, String>> snapshot) {
        return _buildRowWidget(context,
            tool,
            snapshot.data?.item2 ?? '',
            'https://test.gcwizard.net/#/' +  (snapshot.data?.item1 ?? '')
        );
      }
  );
}

String _toolId(GCWTool tool) {
  return (tool.id_prefix ?? '') + tool.id;
}

Future<Tuple2<String, String>> _toolInfoTextShort(BuildContext context, GCWTool tool) async {
  var id = _toolId(tool);
  var info = id;
  return Tuple2<String, String>(id, info);
}

bool _hasAPISpecification(GCWTool tool) {
  return  (tool.tool is GCWWebStatefulWidget) && (tool.tool as GCWWebStatefulWidget).apiSpecification != null;
}

InkWell _buildRowWidget(BuildContext context, GCWTool tool, String id, String copyText) {
  return InkWell(
      child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row (
                    children: [
                      if (_hasAPISpecification(tool))
                        Icon(Icons.check, color: themeColors().secondary()),
                      Container(width: DOUBLE_DEFAULT_MARGIN),
                      SelectableText(
                        '/' + id,
                        textAlign: TextAlign.left,
                        style: gcwTextStyle(),
                        selectionControls: GCWTextSelectionControls(),
                      )
                    ],
                  )
                ),
            ),
            Expanded(
              flex: 2,
              child: GCWText(text: toolName(context, tool)),
            ),
            _hasAPISpecification(tool)
                ? GCWIconButton(
              iconColor: themeColors().mainFont(),
              size: IconButtonSize.SMALL,
              icon: Icons.question_mark,
              onPressed: () {
                var route = _createRoute(context,
                    WebParameter(title: _toolId(tool), arguments: { _questionmark : _questionmark}, settings: null));
                if (route != null) {
                  Navigator.push(context, route);
                }
              },
            )
            : Container(width: 40.0,),
            copyText.isNotEmpty
              ? GCWIconButton(
                iconColor: themeColors().mainFont(),
                size: IconButtonSize.SMALL,
                icon: Icons.content_copy,
                onPressed: () {
                  insertIntoGCWClipboard(context, copyText);
                },
              )
              : Container()
          ],
    ),
    onTap: () {
        Navigator.of(context).push(_buildRoute(context, tool));
      }
  );
}

