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
    var content = Column(children: [
      GCWTextDivider(text: i18n(context, 'licenses_usedflutterlibraries')),
      Column(
        children: columnedMultiLineOutput(null, [
          ['auto_size_text', 'MIT License'],
          ['base32', 'MIT License'],
          ['diacritic', 'BSD License'],
          ['flutter_map', 'BSD License'],
          ['flutter_map_marker_popup', 'BSD License'],
          ['flutter_map_tappable_polyline', 'GPL 3.0 License'],
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
          ['share_extend', 'MIT License'],
          ['touchable', 'GPL 3.0 License'],
          ['uuid', 'MIT License'],
          ['url_launcher', 'BSD License'],
        ]),
      ),
      GCWTextDivider(text: i18n(context, 'licenses_additionalcode')),
      Column(
        children: columnedMultiLineOutput(null, [
          ['astronomie.info, jgiesen.de', 'Astronomy Functions', null],
          [
            'Wesley Janssen, Joost Rijneveld, Mathijs Vos',
            'Chef Interpreter',
            'CC0 1.0 Universal Public Domain Dedication'
          ],
          ['flutter_hsvcolor_picker (minimized)', 'Color Picker', null],
          ['David Vávra', 'Coordinate Measurement', 'Apache 2.0 License'],
          ['moenk', 'Gauss-Krüger Code', null],
          ['@chsii (geohex4j), @sa2da (geohex.org)', 'GeoHex Code', 'MIT License'],
          ['lscheffer.com, Matthias Ernst', 'Malbolge Code', 'CC0, Public Domain'],
          ['Jens Guballa (guballa.de)', 'Substitution Breaker', 'MIT License'],
          ['Jens Guballa (guballa.de)', 'Vigenère Breaker', null],
        ]),
      ),
      GCWTextDivider(text: i18n(context, 'licenses_symboltablesources')),
      Column(
        children: columnedMultiLineOutput(null, [
          ['myGeoTools', 'several'],
          ['Wikipedia', 'several'],
          ['www.steinerverlag.de', 'Eurythmy'],
          ['www.breitkopf.de', 'Solmisation'],
        ]),
      ),
    ]);

    return GCWMainMenuEntryStub(content: content);
  }
}
