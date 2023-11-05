import 'package:flutter/material.dart';
import 'package:gc_wizard/application/main_menu/mainmenuentry_stub.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';


class Nightly extends StatefulWidget {
  const Nightly({Key? key}) : super(key: key);

  @override
  _NightlyState createState() => _NightlyState();
}

class _NightlyState extends State<Nightly> {
  @override
  Widget build(BuildContext context) {

    var content = const Column(
        children: [
          GCWTextDivider(text: 'nightly Tools'),
          GCWColumnedMultilineOutput(
          data: [
            ['Tool', 'Adventure Lab\nAnalyse von Lab Caches'],
            ['Tool', 'Weird Rotation\nrotiere Buchstaben einzeln'],
            ['Koordinate', 'What 3 Words\nUmwandeln in W33/Suche nach W3W'],
            ['Koordinate', 'GCX8K7RD\nDas dort genutzte Koordinatenformat'],
          ],
        flexValues: [3, 7],),
          GCWTextDivider(text: 'Previews'),
          GCWColumnedMultilineOutput(
            data: [
              ['Tool', 'Ballistics\nSchiefer Wurf'],
              ['Tool', 'Checkdigits\nVerschiedene Prüfziffern'],
              ['Tool', 'Triangle\nBerechnungen von Dreiecken'],
              ['Tool', 'Waveform\nAnalyse von WAV-Dateien'],
              ['Code', 'Leet Speak'],
              ['Code', 'Milesian numbers'],
              ['Code', 'Schiffe Versenken'],
              ['Code', 'Slash & Pipes'],
              ['Code', 'Upside-Down Text'],
              ['Symbol', 'Base16\nNotationen für Hexadezimalzahlen'],
              ['Symbol', 'Base16\nNotationen für Hexadezimalzahlen'],
              ['Symbol', 'BiBi-Binary\nNotationen für Hexadezimalzahlen'],
              ['Symbol', 'Cuxhaven-Hamburg\nTelegrafenzeichen'],
              ['Symbol', 'Maya Zahlen\nGlyphs für Maya-Zahlen'],
              ['Symbol', 'Steinheil\nTelegrafenzeichen'],
            ],
            flexValues: [3, 7],),
        ],
    );

    return MainMenuEntryStub(content: content);
  }
}
