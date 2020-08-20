import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/irrational_numbers/irrational_numbers.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class IrrationalNumbersDecimalRange extends StatefulWidget {
  final IrrationalNumber irrationalNumber;

  const IrrationalNumbersDecimalRange({Key key, this.irrationalNumber}) : super(key: key);

  @override
  IrrationalNumbersDecimalRangeState createState() => IrrationalNumbersDecimalRangeState();
}

class IrrationalNumbersDecimalRangeState extends State<IrrationalNumbersDecimalRange> {
  int _currentStart = 1;
  int _currentLength = 1;
  IrrationalNumberCalculator _calculator;

  @override
  void initState() {
    super.initState();
    _calculator = IrrationalNumberCalculator(irrationalNumber: widget.irrationalNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: i18n(context, 'irrationalnumbers_decimalrange_start'),
        ),
        GCWIntegerSpinner(
          value: 1,
          min: 1,
          max: widget.irrationalNumber.decimalPart.length,
          onChanged: (value) {
            setState(() {
              _currentStart = value;
            });
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'irrationalnumbers_decimalrange_length'),
        ),
        GCWIntegerSpinner(
          value: 1,
          min: -widget.irrationalNumber.decimalPart.length,
          max: widget.irrationalNumber.decimalPart.length,
          onChanged: (value) {
            setState(() {
              _currentLength = value;
            });
          },
        ),
        GCWDefaultOutput(
          child: _calculateOutput()
        )
      ],
    );
  }

  _calculateOutput() {
    if (_currentStart < 1)
      return '';

    try {
      return _calculator.decimalRange(_currentStart, _currentLength);
    } on FormatException catch(e) {
      return printErrorMessage(context, e.message);
    }
  }
}