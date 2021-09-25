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
          ['Malbolge Code', 'lscheffer.com, Matthias Ernst', 'CC0, Public Domain'],
          [
            'Chef Interpreter',
            'Wesley Janssen, Joost Rijneveld, Mathijs Vos',
            'CC0 1.0 Universal Public Domain Dedication'
          ],
          ['Cow Interpreter', 'Marco "Atomk" F.', 'MIT License'],
          ['Cow Generator', 'Frank Buss', null],
          ['Beatnik Interpreter', 'Hendrik Van Belleghem', 'Gnu Public License, Artistic License'],
          ['Whitespace Interpreter', 'Adam Papenhausen', 'MIT License'],
          ['Calendar conversions', 'Johannes Thomann, University of Zurich Asien-Orient-Institute', null],
          ['Color Picker', 'flutter_hsvcolor_picker (minimized)', 'Color Picker', null],
          ['Coordinate Measurement', 'David Vávra', 'Apache 2.0 License'],
          ['Gauss-Krüger Code', 'moenk', null],
          ['Geo3x3 Code', '@taisukef', 'CC0-1.0 License'],
          ['GeoHex Code', '@chsii (geohex4j), @sa2da (geohex.org)', 'MIT License'],
          ['Substitution Breaker', 'Jens Guballa (guballa.de)', 'MIT License'],
          ['Sudoku Solver', 'Peter Norvig (norvig.com), \'dartist\'', 'MIT License'],
          ['Vigenère Breaker', 'Jens Guballa (guballa.de)', null],
        ]),
      ),
      GCWTextDivider(text: i18n(context, 'licenses_symboltablesources')),
      Column(
        children: columnedMultiLineOutput(null, [
          ['myGeoTools', 'several'],
          ['Wikipedia', 'several'],
          ['www.steinerverlag.de', 'Eurythmy'],
          ['www.breitkopf.de', 'Solmisation'],
          ['game-icons.net (CC BY 3.0)\npixabay.com\nwww.clker.com (CC-0)', 'Geocache Attributes'],
          ['Edelcrantz Telegraph', 'Gerard Holzmann,\nhttps://archive.org/details/earlyhistoryofda0000holz\nSilvia Rubio Hernández\nVapriikki Case: Design and Evaluation of an Interactive Mixed-Reality Museum Exhibit\nhttps://trepo.tuni.fi/bitstream/handle/10024/102557/1513599679.pdf?sequence=1&isAllowed=y'],
          ['Murray Telegraph', 'Helmar Fischer,\nhttps://cms.sachsen.schule/typoecke2/typo-experimente/informationuebertragung-mit-dem-klappentelegraph/\nOmer Roucoux,\nhttp://virtual-library.culturalservices.net/webingres/bedfordshire/vlib/0.digitised_resources/dunstable_article_signalling_station.htm'],
          ['Preußischer optischer Telegraf', 'Wilfried Hahn,\nhttp://www.optischertelegraph23.de/'],
          ['Schilling Canstatt Telegraph', 'Volker Aschoff,\nPaul Schilling von Canstatt und die Geschichte des elektromagnetischen Telegraphen\nISBN 3-486-20691-5'],
        ]),
      ),
    ]);

    return GCWMainMenuEntryStub(content: content);
  }
}
