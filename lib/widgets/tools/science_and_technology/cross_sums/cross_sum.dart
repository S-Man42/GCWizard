import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_crosstotal_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';

class CrossSum extends StatefulWidget {
  @override
  CrossSumState createState() => CrossSumState();
}

class CrossSumState extends State<CrossSum> {
  var _currentValue = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWIntegerSpinner(
          value: _currentValue,
          onChanged: (value) {
            setState(() {
              _currentValue = value;
            });
          },
        ),
        GCWCrosstotalOutput(
          text: _currentValue.toString(),
          values: [_currentValue],
          suppressSums: true
        )
      ],
    );
  }
}