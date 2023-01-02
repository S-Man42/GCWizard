import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/logic/irrational_numbers.dart';
import 'package:gc_wizard/common_widgets/gcw_default_output/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/gcw_integer_spinner/gcw_integer_spinner.dart';
import 'package:gc_wizard/tools/utils/common_widget_utils/widget/common_widget_utils.dart';

class IrrationalNumbersNthDecimal extends StatefulWidget {
  final IrrationalNumber irrationalNumber;

  const IrrationalNumbersNthDecimal({Key key, this.irrationalNumber}) : super(key: key);

  @override
  IrrationalNumbersNthDecimalState createState() => IrrationalNumbersNthDecimalState();
}

class IrrationalNumbersNthDecimalState extends State<IrrationalNumbersNthDecimal> {
  int _currentValue = 1;
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
        GCWIntegerSpinner(
          value: _currentValue,
          min: 1,
          max: widget.irrationalNumber.decimalPart.length,
          onChanged: (value) {
            setState(() {
              _currentValue = value;
            });
          },
        ),
        GCWDefaultOutput(child: _calculateOutput())
      ],
    );
  }

  _calculateOutput() {
    if (_currentValue < 1) return '';

    try {
      return _calculator.decimalAt(_currentValue);
    } on FormatException catch (e) {
      return printErrorMessage(context, e.message);
    }
  }
}
