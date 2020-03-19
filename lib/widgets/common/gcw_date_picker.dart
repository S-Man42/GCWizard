import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class GCWDatePicker extends StatefulWidget {
  final Function onChanged;
  final date;

  const GCWDatePicker({
    Key key,
    this.onChanged,
    this.date
  }) : super(key: key);

  @override
  GCWDatePickerState createState() => GCWDatePickerState();
}

class GCWDatePickerState extends State<GCWDatePicker> {
  var _currentYear;
  var _currentMonth;
  var _currentDay;

  var _monthFocusNode;
  var _dayFocusNode;

  @override
  void initState() {
    super.initState();

    DateTime date = widget.date ?? DateTime.now();
    _currentYear = date.year;
    _currentMonth = date.month;
    _currentDay = date.day;

    _monthFocusNode = FocusNode();
    _dayFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _monthFocusNode.dispose();
    _dayFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
    //  mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Padding(
            child: GCWIntegerSpinner(
              layout: SpinnerLayout.vertical,
              value: _currentYear,
              min: -5000,
              max: 5000,
              onChanged: (value) {
                setState(() {
                  _currentYear = value;
                  _setCurrentValueAndEmitOnChange();

                  if (_currentYear.toString().length == 4) {
                    FocusScope.of(context).requestFocus(_monthFocusNode);
                  }
                });
              },
            ),
            padding: EdgeInsets.only (
              right: 2
            )
          ),
        ),
        Expanded(
          child: Padding(
            child: GCWIntegerSpinner(
              focusNode: _monthFocusNode,
              layout: SpinnerLayout.vertical,
              value: _currentMonth,
              min: 1,
              max: 12,
              onChanged: (value) {
                setState(() {
                  _currentMonth = value;
                  _setCurrentValueAndEmitOnChange();

                  if (_currentMonth.toString().length == 2) {
                    FocusScope.of(context).requestFocus(_dayFocusNode);
                  }
                });
              },
            ),
            padding: EdgeInsets.only(
              left: 2,
              right: 2
            )
          )
        ),
        Expanded(
          child: Padding(
            child: GCWIntegerSpinner(
              focusNode: _dayFocusNode,
              layout: SpinnerLayout.vertical,
              value: _currentDay,
              min: 1,
              max: 31,
              onChanged: (value) {
                setState(() {
                  _currentDay = value;
                  _setCurrentValueAndEmitOnChange();
                });
              },
            ),
            padding: EdgeInsets.only(
              left: 2
            ),
          )
        )
      ],
    );
  }

  _setCurrentValueAndEmitOnChange() {
    widget.onChanged(DateTime(_currentYear, _currentMonth, _currentDay));
  }
}