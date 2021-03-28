import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/reverse.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/periodic_table.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_list_textfield.dart';

class AtomicNumbersToText extends StatefulWidget {
  @override
  AtomicNumbersToTextState createState() => AtomicNumbersToTextState();
}

class AtomicNumbersToTextState extends State<AtomicNumbersToText> {
  String _output = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWIntegerListTextField(
          hintText: i18n(context, 'periodictable_atomicnumbers_hint'),
          onChanged: (String text) {
            setState(() {
              _output = atomicNumbersToText(text
                  .replaceAll(RegExp(r'[0-9 ]'), '')
                  .replaceAll(RegExp(r'\s+'), ' ')
                  .split(' ')
                  .map((number) => int.tryParse(number))
                  .toList());
            });
          },
        ),
        GCWDefaultOutput(child: _output)
      ],
    );
  }
}
