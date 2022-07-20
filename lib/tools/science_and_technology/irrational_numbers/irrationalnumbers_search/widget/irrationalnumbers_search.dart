import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/logic/irrational_numbers.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/tools/common/gcw_default_output/widget/gcw_default_output.dart';
import 'package:gc_wizard/tools/common/gcw_integer_textfield/widget/gcw_integer_textfield.dart';

class IrrationalNumbersSearch extends StatefulWidget {
  final IrrationalNumber irrationalNumber;

  const IrrationalNumbersSearch({Key key, this.irrationalNumber}) : super(key: key);

  @override
  IrrationalNumbersSearchState createState() => IrrationalNumbersSearchState();
}

class IrrationalNumbersSearchState extends State<IrrationalNumbersSearch> {
  var _currentInput = defaultIntegerText;
  IrrationalNumberCalculator _calculator;

  var _controller;

  @override
  void initState() {
    super.initState();
    _calculator = IrrationalNumberCalculator(irrationalNumber: widget.irrationalNumber);
    _controller = TextEditingController(text: _currentInput['text']);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWIntegerTextField(
          controller: _controller,
          min: 0,
          onChanged: (ret) {
            setState(() {
              _currentInput = ret;
            });
          },
        ),
        GCWDefaultOutput(child: _calculateOutput())
      ],
    );
  }

  _calculateOutput() {
    if (_currentInput['text'].length == 0) return '';

    var value = _calculator.decimalOccurence(_currentInput['value'].toString());

    return value == null
        ? i18n(context, 'irrationalnumbers_nooccurrence', parameters: [widget.irrationalNumber.decimalPart.length])
        : value.toString();
  }
}
