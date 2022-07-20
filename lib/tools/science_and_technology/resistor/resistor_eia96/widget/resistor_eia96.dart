import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/science_and_technology/logic/resistor.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/tools/common/base/gcw_dropdownbutton/widget/gcw_dropdownbutton.dart';
import 'package:gc_wizard/tools/common/gcw_default_output/widget/gcw_default_output.dart';
import 'package:gc_wizard/tools/common/gcw_integer_spinner/widget/gcw_integer_spinner.dart';

class ResistorEIA96 extends StatefulWidget {
  @override
  ResistorEIA96State createState() => ResistorEIA96State();
}

class ResistorEIA96State extends State<ResistorEIA96> {
  var _currentCode = 1;
  var _currentMultiplicator = 'A';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Expanded(
                child: GCWIntegerSpinner(
              value: _currentCode,
              min: 1,
              max: 96,
              onChanged: (value) {
                setState(() {
                  _currentCode = value;
                });
              },
            )),
            Expanded(
                child: GCWDropDownButton(
              value: _currentMultiplicator,
              items: {
                'Y': 'Y = 10' + stringToSuperscript('-2') + ' = 0.01',
                'X': 'X = 10' + stringToSuperscript('-1') + ' = 0.1',
                'A': 'A = 10' + stringToSuperscript('0') + ' = 1',
                'B': 'B = 10' + stringToSuperscript('1') + ' = 10',
                'C': 'C = 10' + stringToSuperscript('2') + ' = 100',
                'D': 'D = 10' + stringToSuperscript('3') + ' = 1 000',
                'E': 'E = 10' + stringToSuperscript('4') + ' = 10 000',
                'F': 'F = 10' + stringToSuperscript('5') + ' = 100 000',
              }.entries.map((entry) {
                return GCWDropDownMenuItem(
                  value: entry.key,
                  child: entry.value,
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _currentMultiplicator = value;
                });
              },
            ))
          ],
        ),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    var output = formatResistorValue(eia96(_currentCode, multiplicator: _currentMultiplicator));

    return GCWDefaultOutput(child: output, copyText: output.split(' ')[0]);
  }
}
