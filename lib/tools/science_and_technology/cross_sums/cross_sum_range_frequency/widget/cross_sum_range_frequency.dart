import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/science_and_technology/logic/cross_sum.dart';
import 'package:gc_wizard/tools/common/base/gcw_dialog/widget/gcw_dialog.dart';
import 'package:gc_wizard/tools/common/gcw_columned_multiline_output/widget/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/tools/common/gcw_default_output/widget/gcw_default_output.dart';
import 'package:gc_wizard/tools/common/gcw_integer_spinner/widget/gcw_integer_spinner.dart';
import 'package:gc_wizard/tools/common/gcw_submit_button/widget/gcw_submit_button.dart';
import 'package:gc_wizard/tools/common/gcw_text_divider/widget/gcw_text_divider.dart';
import 'package:gc_wizard/tools/common/gcw_twooptions_switch/widget/gcw_twooptions_switch.dart';

final _ALERT_MAX_RANGE = 25000;

class CrossSumRangeFrequency extends StatefulWidget {
  final CrossSumType type;

  CrossSumRangeFrequency({Key key, this.type: CrossSumType.NORMAL}) : super(key: key);

  @override
  CrossSumRangeFrequencyState createState() => CrossSumRangeFrequencyState();
}

class CrossSumRangeFrequencyState extends State<CrossSumRangeFrequency> {
  var _currentRangeStart = 0;
  var _currentRangeEnd = 100;

  var _currentSort = GCWSwitchPosition.left;
  Map<int, int> _currentFrequencies = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextDivider(text: i18n(context, 'crosssum_range_range')),
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
        GCWSubmitButton(
          onPressed: () {
            var rangeLength = (_currentRangeStart - _currentRangeEnd).abs() + 1;
            if (rangeLength.abs() > _ALERT_MAX_RANGE) {
              showGCWAlertDialog(
                context,
                i18n(context, 'crosssum_range_alert_input_title'),
                i18n(context, 'crosssum_range_alert_input_text', parameters: [rangeLength]),
                () {
                  _calculateFrequencies();
                },
              );
            } else {
              _calculateFrequencies();
            }
          },
        ),
        GCWTwoOptionsSwitch(
          title: i18n(context, 'common_sortby'),
          leftValue: i18n(context, 'crosssum_range_frequency_sortby_crosssum'),
          rightValue: i18n(context, 'crosssum_range_frequency_sortby_frequency'),
          value: _currentSort,
          onChanged: (value) {
            setState(() {
              _currentSort = value;
            });
          },
        ),
        GCWDefaultOutput(child: _calculateOutput())
      ],
    );
  }

  _calculateFrequencies() {
    setState(() {
      switch (widget.type) {
        case CrossSumType.NORMAL:
          _currentFrequencies = crossSumRangeFrequencies(_currentRangeStart, _currentRangeEnd);
          break;
        case CrossSumType.ITERATED:
          _currentFrequencies =
              crossSumRangeFrequencies(_currentRangeStart, _currentRangeEnd, type: CrossSumType.ITERATED);
          break;
      }
    });
  }

  Widget _calculateOutput() {
    var outputData = _currentFrequencies.entries.map((frequency) {
      return [frequency.key, frequency.value];
    }).toList();

    if (_currentSort == GCWSwitchPosition.left) {
      outputData.sort((a, b) => a[0].compareTo(b[0]));
    } else {
      outputData.sort((a, b) => b[1].compareTo(a[1]));
    }

    return GCWColumnedMultilineOutput(data: outputData);
  }
}
