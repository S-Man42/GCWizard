import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/science_and_technology/logic/dna.dart';
import 'package:gc_wizard/tools/common/base/gcw_text/widget/gcw_text.dart';
import 'package:gc_wizard/tools/common/base/gcw_textfield/widget/gcw_textfield.dart';
import 'package:gc_wizard/tools/common/gcw_default_output/widget/gcw_default_output.dart';
import 'package:gc_wizard/tools/common/gcw_text_divider/widget/gcw_text_divider.dart';
import 'package:gc_wizard/tools/common/gcw_twooptions_switch/widget/gcw_twooptions_switch.dart';
import 'package:gc_wizard/tools/utils/common_widget_utils/widget/common_widget_utils.dart';

class DNAAminoAcidsTable extends StatefulWidget {
  @override
  DNAAminoAcidsTableState createState() => DNAAminoAcidsTableState();
}

class DNAAminoAcidsTableState extends State<DNAAminoAcidsTable> {
  @override
  Widget build(BuildContext context) {
    var acids = aminoAcids.map((acid) {
      var name;
      if (acid.name == null) {
        switch (acid.type) {
          case NucleobaseSequenceType.START:
            name = i18n(context, 'dna_start');
            break;
          case NucleobaseSequenceType.STOP:
            name = i18n(context, 'dna_stop');
            break;
          default:
            name = '';
        }
      } else {
        name = i18n(context, acid.name);
      }

      if (acid.symbolShort == 'M') name += '\n${i18n(context, 'dna_start')}';

      var sequences = acid.nucleobaseSequences;
      sequences.sort();

      return [
        name,
        acid.symbolLong == null ? '-' : acid.symbolLong,
        acid.symbolShort == null ? '-' : acid.symbolShort,
        sequences.join(', ')
      ];
    }).toList();

    acids.sort((a, b) => a[0].compareTo(b[0]));

    return Column(
      children: columnedMultiLineOutput(context, acids, flexValues: [3, 1, 1, 2]),
    );
  }
}
