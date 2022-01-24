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
          ['archive', 'Apache 2.0 License'],
          ['auto_size_text', 'MIT License'],
          ['base32', 'MIT License'],
          ['cached_network_image', 'MIT License'],
          ['diacritic', 'BSD-3-Clause License'],
          ['file_picker', 'MIT License'],
          ['file_picker_writable', 'MIT License'],
          ['encrypt', 'BSD-3-Clause License'],
          ['exif', 'MIT License'],
          ['flutter_map', 'BSD-3-Clause License'],
          ['flutter_map_marker_popup', 'BSD-3-Clause License'],
          ['flutter_map_tappable_polyline', 'MIT License'],
          ['fluttertoast', 'MIT License'],
          ['http', 'BSD-3-Clause License'],
          ['image', 'Apache 2.0 License'],
          ['intl', 'BSD-3-Clause License'],
          ['location', 'MIT License'],
          ['mask_text_input_formatter', 'MIT License'],
          ['math_expressions', 'MIT License'],
          ['package_info', 'BSD-3-Clause License'],
          ['path', 'BSD-3-Clause License'],
          ['path_provider', 'BSD-3-Clause License'],
          ['permission_handler', 'MIT License'],
          ['pointycastle', 'MIT License'],
          ['prefs', 'Apache 3.0 License'],
          ['provider', 'MIT License'],
          ['qr', 'BSD-3-Clause License'],
          ['r_scan', 'BSD-3-Clause License'],
          ['scrollable_positioned_list', 'BSD-3-Clause License'],
          ['touchable', 'GPL 3.0 License'],
          ['universal_html', 'Apache 2.0 License'],
          ['uuid', 'MIT License'],
          ['url_launcher', 'BSD-3-Clause License'],
        ]),
      ),
      GCWTextDivider(text: i18n(context, 'licenses_additionalcode')),
      Column(
        children: columnedMultiLineOutput(null, [
          ['Astronomy Functions', 'astronomie.info, jgiesen.de', null],
          ['Beatnik Interpreter', 'Hendrik Van Belleghem', 'Gnu Public License, Artistic License'],
          ['Calendar conversions', 'Johannes Thomann, University of Zurich Asia-Orient-Institute', null],
          ['Centroid Code', 'Andy Eschbacher (carto.com)', null],
          [
            'Chef Interpreter',
            'Wesley Janssen, Joost Rijneveld, Mathijs Vos',
            'CC0 1.0 Universal Public Domain Dedication'
          ],
          ['Color Picker', 'flutter_hsvcolor_picker (minimized)', null],
          ['Coordinate Measurement', 'David Vávra', 'Apache 2.0 License'],
          ['Cow Interpreter', 'Marco "Atomk" F.', 'MIT License'],
          ['Cow Generator', 'Frank Buss', null],
          ['DutchGrid Code', '@djvanderlaan', 'MIT License'],
          ['Gauss-Krüger Code', 'moenk', null],
          ['Geo3x3 Code', '@taisukef', 'CC0-1.0 License'],
          ['Geodetics Code', 'Charles Karney (GeographicLib)', 'MIT/X11 License'],
          ['GeoHex Code', '@chsii (geohex4j), @sa2da (geohex.org)', 'MIT License'],
          ['Malbolge Code', 'lscheffer.com, Matthias Ernst', 'CC0, Public Domain'],
          ['Substitution Breaker', 'Jens Guballa (guballa.de)', 'MIT License'],
          ['Sudoku Solver', 'Peter Norvig (norvig.com), \'dartist\'', 'MIT License'],
          ['Urwigo Tools', '@Krevo (WherigoTools)', 'MIT License'],
          ['Vigenère Breaker', 'Jens Guballa (guballa.de)', null],
          ['Whitespace Interpreter', 'Adam Papenhausen', 'MIT License'],
        ]),
      ),
      GCWTextDivider(text: i18n(context, 'licenses_symboltablesources')),
      Column(
        children: columnedMultiLineOutput(null, [
          ['several', 'myGeoTools'],
          ['several', 'Wikipedia'],
          [i18n(context, 'symboltables_cirth_erebor_title'), '(Personal Use)'],
          [i18n(context, 'symboltables_christmas_title'), 'StudioMIES (Personal Use)'],
          [i18n(context, 'symboltables_dragon_language_title'), '(Personal Use)'],
          [i18n(context, 'symboltables_eurythmy_title'), 'www.steinerverlag.de (Non-Commercial Use)'],
          [i18n(context, 'symboltables_face_it_title'), '(Personal Use)'],
          [i18n(context, 'symboltables_futurama_2_title'), 'Leandor Pardini (Online Web Fonts) (CC BY-SA 3.0)'],
          [
            i18n(context, 'symboltables_gc_attributes_ids_title'),
            'game-icons.net (CC BY 3.0)\npixabay.com\nwww.clker.com (CC-0)'
          ],
          [i18n(context, 'symboltables_iokharic_title'), '(Personal Use)'],
          [i18n(context, 'symboltables_kabouter_abc_title'), 'Pascalvanboxel, Egel (scoutpedia.nl) (CC BY-NC-SA 4.0)'],
          [i18n(context, 'symboltables_murray_title'), 'Japiejo (geocachingtoolbox.com)'],
          [i18n(context, 'symboltables_prosyl_title'), '(Personal Use)'],
          [i18n(context, 'telegraph_prussia_title'), 'Museumsstiftung Post und Telekommunikation (CC BY-SA)'],
          [i18n(context, 'symboltables_sanluca_title'), 'Leadermassimo (wikimafia.it) (CC BY-SA 4.0)'],
          [i18n(context, 'symboltables_solmisation_title'), 'www.breitkopf.de (Personal Use)'],
          [i18n(context, 'symboltables_vulcanian_title'), '(Personal Use)']
        ]),
      ),
      GCWTextDivider(text: i18n(context, 'licenses_telegraphs')),
      Column(
        children: columnedMultiLineOutput(null, [
          [
            i18n(context, 'telegraph_edelcrantz_title'),
            'Gerard Holzmann,\nSilvia Rubio Hernández\nAnders Lindeberg-Lindvet, Curator Tekniskamuseet Stockholm\nErika Tanhua-Piiroinen, Tampere University Finland'
          ],
          [
            i18n(context, 'telegraph_murray_title'),
            'Helmar Fischer,\nJohn Buckledee, Chairman, Dunstable and District Local History Society on behalf of Mrs Omer Roucoux'
          ],
          [i18n(context, 'telegraph_ohlsen_title'), 'Anne Solberg\nNorsk Teknisk Museum, Oslo'],
          [
            i18n(context, 'telegraph_prussia_title'),
            'Bilddatenbank der Museumsstiftung Post und Telekommunikation (CC BY-SA)'
          ],
          [i18n(context, 'telegraph_schillingcanstatt_title'), 'Volker Aschoff'],
        ]),
      ),
    ]);

    return GCWMainMenuEntryStub(content: content);
  }
}
