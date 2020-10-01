import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_dropdown_spinner.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';


class GCWABCSpinner extends StatefulWidget {
  final Function onChanged;
  final SpinnerLayout layout;
  final value;

  const GCWABCSpinner({Key key, this.value: 1, this.onChanged, this.layout: SpinnerLayout.HORIZONTAL}) : super(key: key);

  @override
  GCWABCSpinnerState createState() => GCWABCSpinnerState();
}

class GCWABCSpinnerState extends State<GCWABCSpinner> {
  var _currentValue;

  @override
  Widget build(BuildContext context) {
    return GCWDropDownSpinner(
      index: _currentValue ?? (widget.value != null ? widget.value - 1 : null) ?? 0,
      layout: widget.layout,
      items: alphabet_AZ.entries.map((entry) {
        return Text('${entry.key} (${entry.value})', style: gcwTextStyle(),);
      }).toList(),
      onChanged: (value) {
        setState(() {
          _currentValue = value;
          widget.onChanged(_currentValue + 1);
        });
      },
    );
  }
}