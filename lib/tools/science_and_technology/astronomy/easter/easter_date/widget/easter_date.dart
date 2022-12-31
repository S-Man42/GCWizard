import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/logic/easter.dart';
import 'package:gc_wizard/common_widgets/gcw_default_output/widget/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/gcw_integer_spinner/widget/gcw_integer_spinner.dart';
import 'package:gc_wizard/common_widgets/gcw_text_divider/widget/gcw_text_divider.dart';
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

    return GCWDefaultOutput(child: DateFormat('yMd', Localizations.localeOf(context).toString()).format(date));
  }
}
