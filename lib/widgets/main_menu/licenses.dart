import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/main_menu/gcw_mainmenuentry_stub.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class Licenses extends StatefulWidget {
  @override
  LicensesState createState() => LicensesState();
}

class LicensesState extends State<Licenses> {
  @override
  Widget build(BuildContext context) {

    var content = Column(
      children: [
        GCWTextDivider(
          text: i18n(context, 'licenses_usedlibraries')
        ),
        Column(
          children: columnedMultiLineOutput([
            ['base32', 'MIT License'],
            ['diacritic', 'BSD License'],
            ['flutter_map', 'BSD License'],
            ['flutter_map_marker_popup', 'BSD License'],
            ['fluttertoast', 'BSD License'],
            ['intl', 'MIT License'],
            ['location', 'MIT License'],
            ['mask_text_input_formatter', 'MIT License'],
            ['math_expressions', 'MIT License'],
            ['package_info', 'BSD License'],
            ['path', 'BSD License'],
            ['path_provider', 'BSD License'],
            ['permission_handler', 'MIT License'],
            ['pointycastle', 'MIT License'],
            ['prefs', 'Apache 3.0 License'],
            ['provider', 'MIT License'],
            ['qr_flutter', 'BSD 3-Clause "New" or "Revised" License'],
            ['touchable', 'GPL 3.0 License'],
            ['url_launcher', 'BSD License'],
          ]),
        ),

        GCWTextDivider(
          text: i18n(context, 'licenses_additionalcode')
        ),
        Column(
          children: columnedMultiLineOutput([
            ['moenk', 'Gauss-Krüger Code'],
            ['astronomie.info, jgiesen.de', 'Astronomy Functions'],
            ['flutter_hsvcolor_picker (minimized)', 'Color Picker'],
            ['Jens Guballa (guballa.de)', 'Universal Code Breaker'],
          ]),
        ),

        GCWTextDivider(
          text: i18n(context, 'licenses_symboltablesources')
        ),
        Column(
          children: columnedMultiLineOutput([
            ['myGeoTools', 'several'],
            ['Wikipedia', 'several'],
            ['www.breitkopf.de', 'Solmisation'],
          ]),
        ),
      ]
    );

    return GCWMainMenuEntryStub(
      content: content
    );
  }
}