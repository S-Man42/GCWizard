import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/cross_sum.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';

final _ALERT_MAX_OUTPUT = 200;
final _ALERT_MAX_RANGE = 25000;

class CrossSumRange extends StatefulWidget {
  final CrossSumType type;

  CrossSumRange({Key key, this.type: CrossSumType.NORMAL}) : super(key: key);

  @override
  CrossSumRangeState createState() => CrossSumRangeState();
}

class CrossSumRangeState extends State<CrossSumRange> {
  var _currentCrossSum = 1;
  var _currentRangeStart = 0;
  var _currentRangeEnd = 100;

  var _currentOutput = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: i18n(context, 'crosssum_range_expected')
        ),
        GCWIntegerSpinner(
          value: _currentCrossSum,
          min: widget.type == CrossSumType.ITERATED ? -9 : null,
          max: widget.type == CrossSumType.ITERATED ? 9 : null,
          onChanged: (value) {
            setState(() {
              _currentCrossSum = value;
            });
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'crosssum_range_range')
        ),
        GCWIntegerSpinner(
          value: _currentRangeStart,
          onChanged: (value) {
            setState(() {
              _currentRangeStart = value;
            });
          },
        ),
        GCWIntegerSpinner(
          value: _currentRangeEnd,
          onChanged: (value) {
            setState(() {
              _currentRangeEnd = value;
            });
          },
        ),
        GCWSubmitFlatButton(
          onPressed: () {
            var rangeLength = (_currentRangeStart - _currentRangeEnd).abs() + 1;
            if (rangeLength.abs() > _ALERT_MAX_RANGE) {
              showGCWAlertDialog(
                context,
                i18n(context, 'crosssum_range_alert_input_title'),
                i18n(context, 'crosssum_range_alert_input_text', parameters: [rangeLength]),
                () {
                  _calculateOutput();
                },
              );
            } else {
              _calculateOutput();
            }
          },
        ),
        GCWDefaultOutput(
          child: _currentOutput
        )
      ],
    );
  }

  _calculateOutput() {
    setState(() {
      _currentOutput = '';
    });

    var output;
    switch (widget.type) {
      case CrossSumType.NORMAL:
        output = crossSumRange(_currentRangeStart, _currentRangeEnd, _currentCrossSum);
        break;
      case CrossSumType.ITERATED:
        output = crossSumRange(_currentRangeStart, _currentRangeEnd, _currentCrossSum, type: CrossSumType.ITERATED);
        break;
    }

    if (output.length > _ALERT_MAX_OUTPUT) {
      showGCWAlertDialog(
        context,
        i18n(context, 'crosssum_range_alert_result_title'),
        i18n(context, 'crosssum_range_alert_result_text', parameters: [output.length]),
        () {
          setState(() {
            _currentOutput = output.join('\n');
          });
        },
      );
    } else {
      setState(() {
        _currentOutput = output.join('\n');
      });
    }
  }
}