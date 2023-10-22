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

    var content = Column(
        children: [
          GCWTextDivider(text: 'nightly Tools'),
          GCWColumnedMultilineOutput(
          data: [
            ['Tool', 'Adventure Lab\nAnalyse von Lab Caches'],
            ['Koordinate', 'What 3 Words\nUmwandeln in W33/Suche nach W3W'],
            ['Koordinate', 'GCX8K7RD\nDas dort genutzte Koordinatenformat'],
          ],
        flexValues: [3, 7],),
          GCWTextDivider(text: 'Previews'),
          GCWColumnedMultilineOutput(
            data: [
              ['Tool', 'Checkdigits\nVerschiedene Prüfziffern'],
              ['Tool', 'Triangle\nBerechnungen von Dreiecken'],
              ['Tool', 'Waveform\nAnalyse von WAV-Dateien'],
              ['Code', 'Leet Speak\n'],
              ['Code', 'Milesian numbers\n'],
              ['Code', 'Schiffe Versenken\n'],
              ['Code', 'Slash & Pipes\n'],
              ['Symbol', 'Maya Zahlen\nGlyphs für Maya-Zahlen'],
              ['Symbol', 'Steinheil\nTelegrafenzeichen'],
              ['Symbol', 'Cuxhaven-Hamburg\nTelegrafenzeichen'],
            ],
            flexValues: [3, 7],),
        ],
    );

    return MainMenuEntryStub(content: content);
  }
}
