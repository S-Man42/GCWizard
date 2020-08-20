import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/astronomy/easter.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:intl/intl.dart';

class EasterDate extends StatefulWidget {
  @override
  EasterDateState createState() => EasterDateState();
}

class EasterDateState extends State<EasterDate> {
  int _currentYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: i18n(context, 'common_year'),
        ),
        GCWIntegerSpinner(
          value: _currentYear,
          min: 1583,
          max: 3042,
          onChanged: (value) {
            setState(() {
              _currentYear = value;
            });
          },
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    var date = gregorianEasterDate(_currentYear);

    return GCWDefaultOutput(
      text: DateFormat('yMd', Localizations.localeOf(context).toString()).format(date)
    );
  }
}