import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/main_menu/mainmenuentry_stub.dart';
import 'package:gc_wizard/application/registry.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/tools/tool_licenses/widget/tool_license_types.dart';
import 'package:gc_wizard/application/tools/widget/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/gcw_expandable.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';

class Licenses extends StatefulWidget {
  const Licenses({Key? key}) : super(key: key);

  @override
  _LicensesState createState() => _LicensesState();
}

Column _licenseContent(Map<String, List<ToolLicenseEntry>> licenses) {
  return Column(
    children: licenses.entries.map((entry) {
      return Column(
          children: [
            GCWTextDivider(text: entry.key),
            Container(
              padding: const EdgeInsets.only(left: DEFAULT_DESCRIPTION_MARGIN),
              child: GCWColumnedMultilineOutput(
                data: entry.value.map((ToolLicenseEntry license) {
                  return [
                    toolLicenseEntry(license.toRow())
                  ];
                }).toList(),
              ),
            )
          ]
      );
    }).toList()
  );
}

class _LicensesState extends State<Licenses> {
  @override
  Widget build(BuildContext context) {

    var tools = registeredTools
      .where((GCWTool tool) => tool.licenses != null && tool.licenses!.isNotEmpty)
      .toList();

    var _contentOfflineBook = SplayTreeMap<String, List<ToolLicenseEntry>>();
    var _contentOnlineBook = SplayTreeMap<String, List<ToolLicenseEntry>>();
    var _contentOfflineArticle = SplayTreeMap<String, List<ToolLicenseEntry>>();
    var _contentOnlineArticle = SplayTreeMap<String, List<ToolLicenseEntry>>();
    var _contentPortedCode = SplayTreeMap<String, List<ToolLicenseEntry>>();
    var _contentCodeLibrary = SplayTreeMap<String, List<ToolLicenseEntry>>();
    var _contentImage = SplayTreeMap<String, List<ToolLicenseEntry>>();
    var _contentFont = SplayTreeMap<String, List<ToolLicenseEntry>>();
    var _contentAPI = SplayTreeMap<String, List<ToolLicenseEntry>>();

    for (var tool in tools) {
      var name = toolName(context, tool);
      for (var license in tool.licenses!) {
        if (license is ToolLicenseOfflineBook) {
          if (_contentOfflineBook.containsKey(name)) {
            _contentOfflineBook[name]!.add(license);
          } else {
            _contentOfflineBook.putIfAbsent(name, () => [license]);
          }
          continue;
        }

        if (license is ToolLicenseOnlineBook) {
          if (_contentOnlineBook.containsKey(name)) {
            _contentOnlineBook[name]!.add(license);
          } else {
            _contentOnlineBook.putIfAbsent(name, () => [license]);
          }
          continue;
        }

        if (license is ToolLicenseOfflineArticle) {
          if (_contentOfflineArticle.containsKey(name)) {
            _contentOfflineArticle[name]!.add(license);
          } else {
            _contentOfflineArticle.putIfAbsent(name, () => [license]);
          }
          continue;
        }

        if (license is ToolLicenseOnlineArticle) {
          if (_contentOnlineArticle.containsKey(name)) {
            _contentOnlineArticle[name]!.add(license);
          } else {
            _contentOnlineArticle.putIfAbsent(name, () => [license]);
          }
          continue;
        }

        if (license is ToolLicenseCodeLibrary) {
          if (_contentCodeLibrary.containsKey(name)) {
            _contentCodeLibrary[name]!.add(license);
          } else {
            _contentCodeLibrary.putIfAbsent(name, () => [license]);
          }
          continue;
        }

        if (license is ToolLicensePortedCode) {
          if (_contentPortedCode.containsKey(name)) {
            _contentPortedCode[name]!.add(license);
          } else {
            _contentPortedCode.putIfAbsent(name, () => [license]);
          }
          continue;
        }

        if (license is ToolLicenseImage) {
          if (_contentImage.containsKey(name)) {
            _contentImage[name]!.add(license);
          } else {
            _contentImage.putIfAbsent(name, () => [license]);
          }
          continue;
        }

        if (license is ToolLicenseFont) {
          if (_contentFont.containsKey(name)) {
            _contentFont[name]!.add(license);
          } else {
            _contentFont.putIfAbsent(name, () => [license]);
          }
          continue;
        }

        if (license is ToolLicenseAPI) {
          if (_contentAPI.containsKey(name)) {
            _contentAPI[name]!.add(license);
          } else {
            _contentAPI.putIfAbsent(name, () => [license]);
          }
          continue;
        }
      }
    }

    var content = <Widget>[];
    if (_contentCodeLibrary.isNotEmpty) {
      var common = i18n(context, 'common_common');
      _contentCodeLibrary.putIfAbsent(common, () =>
          [
            ToolLicensePortedCode(context: context, author: 'loki3d.com', title: 'Flutter Library: archive',
              sourceUrl: 'https://web.archive.org/web/20240510080116/https://pub.dev/packages/archive',
              licenseType: ToolLicenseType.MIT,
              licenseUrl: 'https://web.archive.org/web/20240723102619/https://pub.dev/packages/archive/license'
            ),
            ToolLicensePortedCode(context: context, author: 'blue-fire.xyz', title: 'Flutter Library: audioplayers',
              sourceUrl: 'https://web.archive.org/web/20240531121621/https://pub.dev/packages/audioplayers',
              licenseType: ToolLicenseType.MIT,
              licenseUrl: 'https://web.archive.org/web/20240531121707/https://pub.dev/packages/audioplayers/license'
            ),
            ToolLicensePortedCode(context: context, author: 'simc.dev', title: 'Flutter Library: auto_size_text',
              sourceUrl: 'https://web.archive.org/web/20240626175457/https://pub.dev/packages/auto_size_text',
              licenseType: ToolLicenseType.MIT,
              licenseUrl: 'https://web.archive.org/web/20240617114646/https://pub.dev/packages/auto_size_text/license'
            ),
            ToolLicensePortedCode(context: context, author: 'baseflow.com', title: 'Flutter Library: cached_network_image',
              sourceUrl: 'https://web.archive.org/web/20240706134343/https://pub.dev/packages/cached_network_image',
              licenseType: ToolLicenseType.MIT,
              licenseUrl: 'https://web.archive.org/web/20240616042637/https://pub.dev/packages/cached_network_image/license'
            ),
            ToolLicensePortedCode(context: context, author: '@BertrandBev (GitHub)', title: 'Flutter Library: code_text_field',
              sourceUrl: 'https://web.archive.org/web/20230331140622/https://pub.dev/packages/code_text_field',
              licenseType: ToolLicenseType.MIT,
              licenseUrl: 'https://web.archive.org/web/20221203134431/https://pub.dev/packages/code_text_field/license'
            ),
            ToolLicensePortedCode(context: context, author: 'dart.dev', title: 'Flutter Library: collection',
              sourceUrl: 'https://web.archive.org/web/20240710230349/https://pub.dev/packages/collection',
              licenseType: ToolLicenseType.BSD3,
              licenseUrl: 'https://web.archive.org/web/20240512042724/https://pub.dev/packages/collection/license'
            ),
            ToolLicensePortedCode(context: context, author: 'fluttercommunity.dev', title: 'Flutter Library: device_info_plus',
              sourceUrl: 'https://web.archive.org/web/20240717112621/https://pub.dev/packages/device_info_plus',
              licenseType: ToolLicenseType.BSD3,
              licenseUrl: 'https://web.archive.org/web/20231227005521/https://pub.dev/packages/device_info_plus/license'
            ),
            ToolLicensePortedCode(context: context, author: 'agilord.com', title: 'Flutter Library: diacritic',
              sourceUrl: 'https://web.archive.org/web/20240402144558/https://pub.dev/packages/diacritic',
              licenseType: ToolLicenseType.BSD3,
              licenseUrl: 'https://web.archive.org/web/20231003194728/https://pub.dev/packages/diacritic/license'
            ),
            ToolLicensePortedCode(context: context, author: '@leocavalcante (GitHub)', title: 'Flutter Library: encrypt',
              sourceUrl: 'https://web.archive.org/web/20240621090542/https://pub.dev/packages/encrypt',
              licenseType: ToolLicenseType.BSD3,
              licenseUrl: 'https://web.archive.org/web/20220625065953/https://pub.dev/packages/encrypt/license'
            ),
            ToolLicensePortedCode(context: context, author: 'miguelruivo.com', title: 'Flutter Library: file_picker',
              sourceUrl: 'https://web.archive.org/web/20240627151130/https://pub.dev/packages/file_picker',
              licenseType: ToolLicenseType.MIT,
              licenseUrl: 'https://web.archive.org/web/20240512010848/https://pub.dev/packages/file_picker/license'
            ),
            ToolLicensePortedCode(context: context, author: 'codeux.design', title: 'Flutter Library: file_picker_writable',
              sourceUrl: 'https://web.archive.org/web/20240723104746/https://pub.dev/packages/file_picker_writable',
              licenseType: ToolLicenseType.MIT,
              licenseUrl: 'https://web.archive.org/web/20240723104942/https://pub.dev/packages/file_picker_writable/license'
            ),
            ToolLicensePortedCode(context: context, author: '@flutter (GitHub, Google Inc.)', title: 'Flutter',
              sourceUrl: 'https://github.com/S-Man42/flutter/tree/ed470fd1017fd904ad34530f732dee56ab536965',
              licenseType: ToolLicenseType.BSD3,
              licenseUrl: 'https://github.com/S-Man42/flutter/blob/ed470fd1017fd904ad34530f732dee56ab536965/LICENSE'
            ),
            ToolLicensePortedCode(context: context, author: '@GitTouch (GitHub)', title: 'Flutter Library: flutter_highlight',
              sourceUrl: 'https://web.archive.org/web/20240109182902/https://pub.dev/packages/flutter_highlight',
              licenseType: ToolLicenseType.MIT,
              licenseUrl: 'https://web.archive.org/web/20230208081256/https://pub.dev/packages/flutter_highlight/license'
            ),
            ToolLicensePortedCode(context: context, author: '@flutter (GitHub, Google Inc.)', title: 'Flutter Library: flutter_localizations',
              sourceUrl: 'https://web.archive.org/web/20240418002509/https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html',
              licenseType: ToolLicenseType.BSD3,
              licenseUrl: 'https://github.com/S-Man42/flutter/blob/ed470fd1017fd904ad34530f732dee56ab536965/LICENSE'
            ),
            ToolLicensePortedCode(context: context, author: 'fleaflet.dev', title: 'Flutter Library: flutter_map',
              sourceUrl: 'https://web.archive.org/web/20240606210131/https://pub.dev/packages/flutter_map',
              licenseType: ToolLicenseType.BSD3,
              licenseUrl: 'https://web.archive.org/web/20240606210131/https://pub.dev/packages/flutter_map/license'
            ),
            ToolLicensePortedCode(context: context, author: 'balanci.ng', title: 'Flutter Library: flutter_map_marker_popup',
              sourceUrl: 'https://web.archive.org/web/20240222173114/https://pub.dev/packages/flutter_map_marker_popup',
              licenseType: ToolLicenseType.BSD3,
              licenseUrl: 'https://web.archive.org/web/20240723144921/https://pub.dev/packages/flutter_map_marker_popup/license'
            ),
            ToolLicensePortedCode(context: context, author: 'ownweb.fr', title: 'Flutter Library: flutter_map_tappable_polyline',
              sourceUrl: 'https://web.archive.org/web/20230927164717/https://pub.dev/packages/flutter_map_tappable_polyline',
              licenseType: ToolLicenseType.MIT,
              licenseUrl: 'https://web.archive.org/web/20240723145110/https://pub.dev/packages/flutter_map_tappable_polyline/license'
            ),
            ToolLicensePortedCode(context: context, author: '@GitTouch (GitHub)', title: 'Flutter Library: highlight',
              sourceUrl: 'https://web.archive.org/web/20231103183350/https://pub.dev/packages/highlight',
              licenseType: ToolLicenseType.MIT,
              licenseUrl: 'https://web.archive.org/web/20240723145359/https://pub.dev/packages/highlight/license'
            ),
            ToolLicensePortedCode(context: context, author: 'dart.dev', title: 'Flutter Library: http',
              sourceUrl: 'https://web.archive.org/web/20240708062104/https://pub.dev/packages/http',
              licenseType: ToolLicenseType.BSD3,
              licenseUrl: 'https://web.archive.org/web/20240513101105/https://pub.dev/packages/http/license'
            ),
            ToolLicensePortedCode(context: context, author: 'dart.dev', title: 'Flutter Library: http_parser',
              sourceUrl: 'https://web.archive.org/web/20240714172550/https://pub.dev/packages/http_parser',
              licenseType: ToolLicenseType.BSD3,
              licenseUrl: 'https://web.archive.org/web/20230530135251/https://pub.dev/packages/http_parser/license'
            ),
            ToolLicensePortedCode(context: context, author: 'loki3d.com', title: 'Flutter Library: image',
              sourceUrl: 'https://web.archive.org/web/20240609215904/https://pub.dev/packages/image',
              licenseType: ToolLicenseType.MIT,
              licenseUrl: 'https://web.archive.org/web/20230202095625/https://pub.dev/packages/image/License'
            ),
            ToolLicensePortedCode(context: context, author: 'dart.dev', title: 'Flutter Library: intl',
              sourceUrl: 'https://web.archive.org/web/20240627151129/https://pub.dev/packages/intl',
              licenseType: ToolLicenseType.BSD3,
              licenseUrl: 'https://web.archive.org/web/20240606033135/https://pub.dev/packages/intl/license'
            ),
            ToolLicensePortedCode(context: context, author: 'defylogic.dev', title: 'Flutter Library: latlong2',
              sourceUrl: 'https://web.archive.org/web/20240517114556/https://pub.dev/packages/latlong2',
              licenseType: ToolLicenseType.APACHE2,
              licenseUrl: 'http://web.archive.org/web/20240725225604/https://pub.dev/packages/latlong2/license'
            ),
            ToolLicensePortedCode(context: context, author: 'bernos.dev', title: 'Flutter Library: location',
              sourceUrl: 'https://web.archive.org/web/20240716152026/https://pub.dev/packages/location',
              licenseType: ToolLicenseType.MIT,
              licenseUrl: 'https://web.archive.org/web/20240609105940/https://pub.dev/packages/location/license'
            ),
            ToolLicensePortedCode(context: context, author: '@siqwin (GitHub)', title: 'Flutter Library: mask_text_input_formatter',
              sourceUrl: 'http://web.archive.org/web/20240118011919/https://pub.dev/packages/mask_text_input_formatter',
              licenseType: ToolLicenseType.MIT,
              licenseUrl: 'http://web.archive.org/web/20240724134116/https://pub.dev/packages/mask_text_input_formatter/license'
            ),
            ToolLicensePortedCode(context: context, author: 'leonhardt.co.nz', title: 'Flutter Library: math_expressions',
              sourceUrl: 'http://web.archive.org/web/20240724134322/https://pub.dev/packages/math_expressions',
              licenseType: ToolLicenseType.MIT,
              licenseUrl: 'http://web.archive.org/web/20240724134612/https://pub.dev/packages/math_expressions/license'
            ),
            ToolLicensePortedCode(context: context, author: 'fluttercommunity.dev', title: 'Flutter Library: package_info_plus',
              sourceUrl: 'https://web.archive.org/web/20240525065942/https://pub.dev/packages/package_info_plus',
              licenseType: ToolLicenseType.BSD3,
              licenseUrl: 'https://web.archive.org/web/20240706192742/https://pub.dev/packages/package_info_plus/license'
            ),
            ToolLicensePortedCode(context: context, author: 'dart.dev', title: 'Flutter Library: path',
              sourceUrl: 'https://web.archive.org/web/20240615030026/https://pub.dev/packages/path',
              licenseType: ToolLicenseType.BSD3,
              licenseUrl: 'https://web.archive.org/web/20240615225506/https://pub.dev/packages/path/license'
            ),
            ToolLicensePortedCode(context: context, author: 'flutter.dev', title: 'Flutter Library: path_provider',
              sourceUrl: 'https://web.archive.org/web/20240608170145/https://pub.dev/packages/path_provider',
              licenseType: ToolLicenseType.BSD3,
              licenseUrl: 'https://web.archive.org/web/20231227010215/https://pub.dev/packages/path_provider/license'
            ),
            ToolLicensePortedCode(context: context, author: 'baseflow.com', title: 'Flutter Library: permission_handler',
              sourceUrl: 'https://web.archive.org/web/20240627151125/https://pub.dev/packages/permission_handler',
              licenseType: ToolLicenseType.MIT,
              licenseUrl: 'https://web.archive.org/web/20240616020712/https://pub.dev/packages/permission_handler/license'
            ),
            ToolLicensePortedCode(context: context, author: 'blue-fire.xyz', title: 'Flutter Library: photo_view',
              sourceUrl: 'https://web.archive.org/web/20240524134826/https://pub.dev/packages/photo_view',
              licenseType: ToolLicenseType.MIT,
              licenseUrl: 'https://web.archive.org/web/20240709210414/http://pub.dev/packages/photo_view/license'
            ),
            ToolLicensePortedCode(context: context, author: 'andrioussolutions.com', title: 'Flutter Library: prefs',
              sourceUrl: 'https://web.archive.org/web/20240211025140/https://pub.dev/packages/prefs',
              licenseType: ToolLicenseType.APACHE2,
              licenseUrl: 'https://web.archive.org/web/20240724135847/https://pub.dev/packages/prefs/license'
            ),
            ToolLicensePortedCode(context: context, author: 'dash-overflow.net', title: 'Flutter Library: provider',
              sourceUrl: 'https://web.archive.org/web/20240712231208/https://pub.dev/packages/provider',
              licenseType: ToolLicenseType.MIT,
              licenseUrl: 'https://web.archive.org/web/20240616125445/https://pub.dev/packages/provider/license'
            ),
            ToolLicensePortedCode(context: context, author: 'google.dev', title: 'Flutter Library: scrollable_positioned_list',
              sourceUrl: 'https://web.archive.org/web/20240713040313/https://pub.dev/packages/scrollable_positioned_list',
              licenseType: ToolLicenseType.BSD3,
              licenseUrl: 'https://web.archive.org/web/20240511195114/https://pub.dev/packages/scrollable_positioned_list/license'
            ),
            ToolLicensePortedCode(context: context, author: 'flutter.dev', title: 'Flutter Library: shared_preferences',
              sourceUrl: 'https://web.archive.org/web/20240608181609/https://pub.dev/packages/shared_preferences',
              licenseType: ToolLicenseType.BSD3,
              licenseUrl: 'https://web.archive.org/web/20240606110107/https://pub.dev/packages/shared_preferences/license'
            ),
            ToolLicensePortedCode(context: context, author: 'Ammar \'ammaratef45\' Hussein (GitHub)', title: 'Flutter Library: stack',
              sourceUrl: 'https://web.archive.org/web/20240301052612/https://pub.dev/packages/stack',
              licenseType: ToolLicenseType.MIT,
              licenseUrl: 'https://web.archive.org/web/20240511195114/https://pub.dev/packages/scrollable_positioned_list/license'
            ),
            ToolLicensePortedCode(context: context, author: 'Natesh \'nateshmbhat\' Bhat (GitHub)', title: 'Flutter Library: touchable',
              sourceUrl: 'https://web.archive.org/web/20231103182722/https://pub.dev/packages/touchable',
              licenseType: ToolLicenseType.MPL2,
              licenseUrl: 'https://web.archive.org/web/20240724144914/https://pub.dev/packages/touchable/license'
            ),
            ToolLicensePortedCode(context: context, author: 'dint.dev', title: 'Flutter Library: universal_html',
              sourceUrl: 'https://web.archive.org/web/20240215182450/https://pub.dev/packages/universal_html',
              licenseType: ToolLicenseType.APACHE2,
              licenseUrl: 'https://web.archive.org/web/20210620015603/https://pub.dev/packages/universal_html/license'
            ),
            ToolLicensePortedCode(context: context, author: '@syedecryptr (GitHub)', title: 'Flutter Library: unrar_file',
              sourceUrl: 'https://web.archive.org/web/20240724145340/https://pub.dev/packages/unrar_file',
              licenseType: ToolLicenseType.APACHE2,
              licenseUrl: 'https://web.archive.org/web/20240724145538/https://pub.dev/packages/unrar_file/license'
            ),
            ToolLicensePortedCode(context: context, author: 'flutter.dev', title: 'Flutter Library: url_launcher',
              sourceUrl: 'https://web.archive.org/web/20240711202509/https://pub.dev/packages/url_launcher',
              licenseType: ToolLicenseType.BSD3,
              licenseUrl: 'https://web.archive.org/web/20231227004216/https://pub.dev/packages/url_launcher/license'
            ),
            ToolLicensePortedCode(context: context, author: 'justkawal.dev', title: 'Flutter Library: utility',
              sourceUrl: 'https://web.archive.org/web/20240724150148/https://pub.dev/packages/utility',
              licenseType: ToolLicenseType.MIT,
              licenseUrl: 'https://web.archive.org/web/20240724150243/https://pub.dev/packages/utility/license'
            ),
            ToolLicensePortedCode(context: context, author: 'lukas-renggli.ch', title: 'Flutter Library: xml',
              sourceUrl: 'https://web.archive.org/web/20240530021526/https://pub.dev/packages/xml',
              licenseType: ToolLicenseType.MIT,
              licenseUrl: 'https://web.archive.org/web/20231227004048/https://pub.dev/packages/xml/license'
            ),
            ToolLicensePortedCode(context: context, author: '@flutter (GitHub, Google Inc.)', title: 'Flutter Library: flutter_test',
              sourceUrl: 'https://web.archive.org/web/20240723054155/https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html',
              licenseType: ToolLicenseType.BSD3,
              licenseUrl: 'https://github.com/S-Man42/flutter/blob/ed470fd1017fd904ad34530f732dee56ab536965/LICENSE'
            ),
            ToolLicensePortedCode(context: context, author: 'fluttercommunity.dev', title: 'Flutter Library: flutter_launcher_icons',
              sourceUrl: 'https://web.archive.org/web/20240713040303/https://pub.dev/packages/flutter_launcher_icons',
              licenseType: ToolLicenseType.MIT,
              licenseUrl: 'https://web.archive.org/web/20240220231946/https://pub.dev/packages/flutter_launcher_icons/license'
            ),
            ToolLicensePortedCode(context: context, author: 'flutter.dev', title: 'Flutter Library: flutter_lints',
              sourceUrl: 'https://web.archive.org/web/20240627151128/https://pub.dev/packages/flutter_lints',
              licenseType: ToolLicenseType.BSD3,
              licenseUrl: 'https://web.archive.org/web/20240510075912/https://pub.dev/packages/flutter_lints/license'
            ),
      ]);

      content.add(GCWExpandableTextDivider(
          expanded: false,
          text: i18n(context, 'toollicenses_codelibrary'),
          child: _licenseContent(_contentCodeLibrary)
      ));
    }
    if (_contentPortedCode.isNotEmpty) {
      content.add(GCWExpandableTextDivider(
          expanded: false,
          text: i18n(context, 'toollicenses_portedcode'),
          child: _licenseContent(_contentPortedCode)
      ));
    }
    if (_contentImage.isNotEmpty) {
      content.add(GCWExpandableTextDivider(
          expanded: false,
          text: i18n(context, 'toollicenses_image'),
          child: _licenseContent(_contentImage)
      ));
    }
    if (_contentFont.isNotEmpty) {
      content.add(GCWExpandableTextDivider(
          expanded: false,
          text: i18n(context, 'toollicenses_font'),
          child: _licenseContent(_contentFont)
      ));
    }
    if (_contentAPI.isNotEmpty) {
      content.add(GCWExpandableTextDivider(
          expanded: false,
          text: i18n(context, 'toollicenses_api'),
          child: _licenseContent(_contentAPI)
      ));
    }
    if (_contentOnlineArticle.isNotEmpty) {
      content.add(GCWExpandableTextDivider(
          expanded: false,
          text: i18n(context, 'toollicenses_onlinearticle'),
          child: _licenseContent(_contentOnlineArticle)
      ));
    }
    if (_contentOnlineBook.isNotEmpty) {
      content.add(GCWExpandableTextDivider(
          expanded: false,
          text: i18n(context, 'toollicenses_onlinebook'),
          child: _licenseContent(_contentOnlineBook)
      ));
    }
    if (_contentOfflineArticle.isNotEmpty) {
      content.add(GCWExpandableTextDivider(
          expanded: false,
          text: i18n(context, 'toollicenses_offlinearticle'),
          child: _licenseContent(_contentOfflineArticle)
      ));
    }
    if (_contentOfflineBook.isNotEmpty) {
      content.add(GCWExpandableTextDivider(
          expanded: false,
          text: i18n(context, 'toollicenses_offlinebook'),
          child: _licenseContent(_contentOfflineBook)
      ));
    }

    return MainMenuEntryStub(content: Column(
      children: content
    ));

    /*return Column(children: [
      GCWExpandableTextDivider(
          text: i18n(context, 'licenses_additionalcode'),
          child: GCWColumnedMultilineOutput(data: [

            # DONE # const ['Astronomy Functions', 'astronomie.info, jgiesen.de', 'Personal Permission'],
            # DONE # const ['Base58', 'Dark Launch', null],
            # DONE # const ['Base91', 'Joachim Henke', 'BSD-3-Clause License'],
            # DONE # const ['Base122', 'Kevin Alberston\nPatrick Favre-Bulle', 'MIT License\nApache License, Version 2.0'],
            # DONE # const ['Beatnik Interpreter', 'Hendrik Van Belleghem', 'Gnu Public License, Artistic License'],
            # DONE # const ['Calendar conversions','Johannes Thomann, University of Zurich Asia-Orient-Institute','Personal Permission'],
            const ['Centroid Code', 'Andy Eschbacher (carto.com)', 'Personal Permission'],
            # DONE # const ['Chef Interpreter','Wesley Janssen, Joost Rijneveld, Mathijs Vos','CC0 1.0 Universal Public Domain Dedication'],
            const ['Color Picker', 'flutter_hsvcolor_picker (minimized)', null],
            # DONE # const ['Coordinate Measurement', 'David Vávra', 'Apache 2.0 License'],
            # DONE # const ['Cow Interpreter', 'Marco "Atomk" F.', 'MIT License'],
            # DONE # const ['Cow Generator', 'Frank Buss', 'Personal Permission'],
            const ['DutchGrid Code', '@djvanderlaan', 'MIT License'],
            const ['Gauss-Krüger Code', 'moenk', 'Personal Permission'],
            # DONE # const ['GC Wizard Script Code', 'Herbert Schildt/James Holmes\nMcGrawHill', 'Personal Permission'],
            # DONE # const ['Geo3x3 Code', '@taisukef', 'CC0-1.0 License'],
            # DONE # ['Geodetics Code', 'Charles Karney\n(GeographicLib)', buildUrl('MIT/X11 License', 'https://github.com/geographiclib/geographiclib/blob/main/LICENSE.txt')],
            # DONE # ['Geodetics Code', 'MITRE\n(Geodetic Library)', buildUrl('Apache 2.0 License', 'https://github.com/mitre/geodetic_library/blob/main/LICENSE')],
            # DONE # ['Geodetics Code', 'Paul Kohut\n(GeoFormulas)', buildUrl('Apache 2.0 License', 'https://github.com/pkohut/GeoFormulas?tab=readme-ov-file#legal-stuff')],
            # DONE # const ['GeoHex Code', '@chsii (geohex4j), @sa2da (geohex.org)', 'MIT License'],
            # DONE # const ['Lambert Code', 'Charles Karney (GeographicLib)', 'MIT/X11 License'],
            # DONE # const ['Magic Eye Solver', 'piellardj.github.io\ngithub.com/machinewrapped', 'MIT License'],
            # DONE # const ['Malbolge Code', 'lscheffer.com, Matthias Ernst', 'CC0, Public Domain'],
            # DONE # const ['Substitution Breaker', 'Jens Guballa (guballa.de)', 'MIT License'],
            # DONE # const ['Sudoku Solver', 'Peter Norvig (norvig.com), \'dartist\'', 'MIT License'],
            # DONE # const ['Urwigo Tools', '@Krevo (WherigoTools)', 'MIT License'],
            # DONE # const ['Vigenère Breaker', 'Jens Guballa (guballa.de)', 'Personal Permission'],
            # DONE # const ['Whitespace Interpreter', 'Adam Papenhausen', 'MIT License'],
            # DONE # const ['Wherigo Analyzer', 'WFoundation\ngithub.com/WFoundation', ''],
          ], suppressCopyButtons: true,)),
      GCWExpandableTextDivider(
          text: i18n(context, 'licenses_used_apis'),
          suppressTopSpace: false,
          child: const GCWColumnedMultilineOutput(data: [
            # DONE ['Geohashing', 'http://geo.crox.net/djia/{yyyy-MM-dd}'],
          ])),
      GCWExpandableTextDivider(
          text: i18n(context, 'licenses_telegraphs'),
          suppressTopSpace: false,
          child: GCWColumnedMultilineOutput(data: [
            # DONE # [i18n(context, 'telegraph_edelcrantz_title'),'Gerard Holzmann,\nSilvia Rubio Hernández\nAnders Lindeberg-Lindvet, Curator Tekniskamuseet Stockholm\nErika Tanhua-Piiroinen, Tampere University Finland'],
            # DONE # [i18n(context, 'telegraph_murray_title'),'Helmar Fischer,\nJohn Buckledee, Chairman, Dunstable and District Local History Society on behalf of Mrs Omer Roucoux'],
            # DONE # [i18n(context, 'telegraph_ohlsen_title'), 'Anne Solberg\nNorsk Teknisk Museum, Oslo'],
            # DONE # [i18n(context, 'telegraph_pasley_title'), 'Wrixon, Fred B.: Geheimsprachen. Könemann, 2006. ISBN 978-3-8331-2562-1. Seite 450'            ],
            # DONE # [i18n(context, 'telegraph_popham_title'), 'Wrixon, Fred B.: Geheimsprachen. Könemann, 2006. ISBN 978-3-8331-2562-1. Seite 446'           ],
            # DONE # [i18n(context, 'telegraph_prussia_title'), 'Bilddatenbank der Museumsstiftung Post und Telekommunikation (CC BY-SA)'],
            # DONE # [i18n(context, 'telegraph_schillingcanstatt_title'), 'Volker Aschoff'],
          ])),
      GCWExpandableTextDivider(
          text: i18n(context, 'licenses_images'),
          suppressTopSpace: false,
          child: GCWColumnedMultilineOutput(
            # DONE # data: [[i18n(context, 'iau_constellation_title'), 'Torsten Bronger', 'GNU FDL, Version 1.2/CC BY-SA 3.0']],
          )),
      GCWExpandableTextDivider(
          text: i18n(context, 'licenses_usedflutterlibraries'),
          expanded: false,
          suppressTopSpace: false,
          child: const GCWColumnedMultilineOutput(data: [
            # DONE # ['archive', 'Apache 2.0 License'],
            # DONE # ['audioplayers', 'MIT License'],
            # DONE # ['auto_size_text', 'MIT License'],
            # DONE # ['base32', 'MIT License'],
            MANUALLY ['cached_network_image', 'MIT License'],
            # DONE # ['code_text_field', 'MIT License'],
            MANUALLY ['device_info_plus', 'BSD-3-Clause License'],
            # DONE # ['diacritic', 'BSD-3-Clause License'],
            # DONE # ['encrypt', 'BSD-3-Clause License'],
            # DONE # ['exif', 'MIT License'],
            MANUALLY ['file_picker', 'MIT License'],
            MANUALLY ['file_picker_writable', 'MIT License'],
            # DONE # ['flutter_highlight', 'MIT License'],
            MANUALLY ['flutter_localizations', 'BSD-3-Clause License'],
            # DONE # ['flutter_map', 'BSD-3-Clause License'],
            # DONE # ['flutter_map_marker_popup', 'BSD-3-Clause License'],
            # DONE # ['flutter_map_tappable_polyline', 'MIT License'],
            # DONE # ['highlight', 'MIT License'],
            # DONE # ['http', 'BSD-3-Clause License'],
            # DONE # ['http_parser', 'BSD-3-Clause License'],
            # DONE # ['image', 'Apache 2.0 License'],
            # DONE # ['intl', 'BSD-3-Clause License'],
            # DONE # ['latlong2', 'Apache 2.0 License'],
            MANUALLY ['location', 'MIT License'],
            MANUALLY ['mask_text_input_formatter', 'MIT License'],
            # DONE # ['math_expressions', 'MIT License'],
            MANUALLY ['package_info_plus', 'BSD-3-Clause License'],
            MANUALLY ['path', 'BSD-3-Clause License'],
            MANUALLY ['path_provider', 'BSD-3-Clause License'],
            MANUALLY ['permission_handler', 'MIT License'],
            MANUALLY ['photo_view', 'MIT License'],
            # DONE ['pointycastle', 'MIT License'],
            # DONE # ['prefs', 'Apache 3.0 License'],
            MANUALLY ['provider', 'MIT License'],
            # DONE # ['qr', 'BSD-3-Clause License'],
            # DONE # ['r_scan', 'BSD-3-Clause License'],
            MANUALLY ['scrollable_positioned_list', 'BSD-3-Clause License'],
            # DONE # ['stack', 'MIT License'],
            # DONE # ['touchable', 'GPL 3.0 License'],
            # DONE # ['tuple', 'BSD-2-Clause License'],
            MANUALLY ['universal_html', 'Apache 2.0 License'],
            MANUALLY ['unrar_file', 'Apache 2.0 License'],
            # DONE # ['uuid', 'MIT License'],
            MANUALLY ['url_launcher', 'BSD-3-Clause License'],
            MANUALLY ['utility', 'MIT License'],
            # DONE #['week_of_year', 'BSD-3-Clause License'],
            MANUALLY ['xml', 'MIT License'],
            MANUALLY ['xmp','MIT License'], // it used not in pubspec but directly embedded because of conflicts of internal dependencies
          ])),
      GCWExpandableTextDivider(
          text: i18n(context, 'licenses_fonts'),
          expanded: false,
          suppressTopSpace: false,
          child: const GCWColumnedMultilineOutput(data: [
            ['Courier Prime', 'Google Fonts', 'SIL OPEN FONT LICENSE Version 1.1'],
            ['Roboto', 'Google Fonts', 'Apache License, Version 2.0']
          ])),
      GCWExpandableTextDivider(
          text: i18n(context, 'licenses_symboltablesources'),
          expanded: false,
          suppressTopSpace: false,
          child: GCWColumnedMultilineOutput(data: [
            const ['several', 'myGeoTools'],
            const ['several', 'Wikipedia'],
            # PERMISSION REQUESTED [i18n(context, 'symboltables_alien_mushrooms_title'), '(Personal Use)'],
            # DONE [
              i18n(context, 'symboltables_base16_title'),
              'https://web.archive.org/web/20221224135846/https://patentimages.storage.googleapis.com/88/54/da/d88ca78fe93623/US3974444.pdf'
            ],
            # DONE [i18n(context, 'symboltables_base16_02_title'), 'https://dl.acm.org/doi/pdf/10.1145/364096.364107'],
            # CADAVER [i18n(context, 'symboltables_berber_title'), 'https://en.wikipedia.org/wiki/Tifinagh (Wiki Commons)'],
            # DONE [
              i18n(context, 'symboltables_bibibinary_title'),
              'https://en.wikipedia.org/wiki/Bibi-binary#/media/File:Table_de_correspondance_entre_le_Bibinaire_et_les_autres_notations.svg (CC BY-SA 4.0)'
            ],
            # DONE [
              i18n(context, 'symboltables_blue_monday_title'),
              'adopted from https://geocachen.be/geocaching/geocache-puzzels-oplossen/blue-monday-kleurencode/; (Personal Use)'
            ],
            # DONE [i18n(context, 'symboltables_cirth_erebor_title'), '(Personal Use)'],
            # DONE [i18n(context, 'symboltables_christmas_title'), 'StudioMIES (Personal Use)'],
            # DONE [i18n(context, 'symboltables_cosmic_title'), 'https://www.dafont.com/de/modern-cybertronic.font, http://www.pixelsagas.com (Personal Use)'],
            # DONE [i18n(context, 'symboltables_dragon_language_title'), '(Personal Use)'],
            # DONE [i18n(context, 'symboltables_eurythmy_title'), 'www.steinerverlag.de (Non-Commercial Use)'],
            # DONE [i18n(context, 'symboltables_face_it_title'), '(Personal Use)'],
            # DONE [i18n(context, 'symboltables_fantastic_title'),
              'nederlandse-fantasia.fandom.com/wiki/Fantastisch (CC BY-SA 3.0)'],
            # DONE [i18n(context, 'symboltables_futurama_2_title'), 'Leandor Pardini (onlinewebfonts.com) (CC BY-SA 3.0)'],
            # DONE [
              i18n(context, 'symboltables_gc_attributes_ids_title'),
              'game-icons.net (CC BY 3.0)\npixabay.com\nclker.com (CC-0)'
            ],
            # DONE [i18n(context, 'symboltables_geovlog_title'), 'GEOVLOGS.nl (Permitted via email)'],
            # DONE [i18n(context, 'symboltables_ice_lolly_ding_title'), 'Ice Lolly Ding (dafont.com) (by Michaela Peretti) (Free use)'],
            # DONE [i18n(context, 'symboltables_iokharic_title'), '(Personal Use)'],
            # DONE [
              i18n(context, 'symboltables_kabouter_abc_title'),
              'Pascalvanboxel, Egel (scoutpedia.nl) (CC BY-NC-SA 4.0)'
            ],
            # DONE [
              i18n(context, 'symboltables_kurrent_title'),
              'https://commons.wikimedia.org/wiki/File:Deutsche_Kurrentschrift.jpg (Public Domain)'
            ],
            # DONE [
              i18n(context, 'symboltables_matoran_title'),
              'Matoran is part of the Bionicle™ world. Bionicle™ is a trademark of the LEGO Group of companies which does not sponsor, authorize or endorse this tool. (Personal Use)'
            ],
            # DONE [
              i18n(context, 'symboltables_maya_numbers_glyphs_title'),
              'https://www.mayan-calendar.org/images/reference/mayan-numbers_mayan-number-system_720x570.gif (Reproductions of this educational item are allowed. www.unitycorps.org)'
            ],
            # DONE [i18n(context, 'symboltables_murray_title'), 'Japiejo (geocachingtoolbox.com)'],
            # DONE [
              i18n(context, 'symboltables_ninjargon_title'),
              'Ninjago™ is a trademark of the LEGO Group of companies which does not sponsor, authorize or endorse this tool. (Personal Use)'
            ],
            # DONE [i18n(context, 'symboltables_oak_island_money_pit_extended_title'), 'oakislandmystery.com (Personal Use)'],
            # DONE [i18n(context, 'symboltables_prosyl_title'), '(Personal Use)'],
            # DONE [i18n(context, 'symboltables_puzzle_2_title'), 'Roci (fontspace.com) (Personal Use)'],
            # DONE [i18n(context, 'telegraph_prussia_title'), 'Museumsstiftung Post und Telekommunikation (CC BY-SA)'],
            # DONE [i18n(context, 'symboltables_sanluca_title'), 'Leadermassimo (wikimafia.it) (CC BY-SA 4.0)'],
            # DONE [i18n(context, 'symboltables_solmisation_title'), 'www.breitkopf.de (Personal Use)'],
            # DONE [i18n(context, 'symboltables_sprykski_title'), '(Personal Use)'],
            # DONE [i18n(context, 'symboltables_tifinagh_title'), '(WikiCommons, CC BY-SA 4.0)'],
            # DONE [i18n(context, 'symboltables_tll_title'), 'GEOVLOGS.nl (Permitted via email)'],
            # DONE [i18n(context, 'symboltables_voynich_title'), 'VonHaarberg, (WikiCommons, CC BY-SA 4.0)'],
            # DONE [i18n(context, 'symboltables_steinheil_title'), '(WikiCommons, CC BY-SA 4.0)'],
            # DONE [i18n(context, 'symboltables_vulcanian_title'), '(Personal Use)'],
          ], flexValues: const [
            1,
            2
          ])),
    ]);*/
  }
}