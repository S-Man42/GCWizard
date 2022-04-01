import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/date_and_time/right_ascension_time_to_degree.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_datetime_picker.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_paste_button.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_toolbar.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/coords_integer_degrees_lat_textinputformatter.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_sign_dropdownbutton.dart';

class RightAscensionTimeToDegree extends StatefulWidget {
  @override
  RightAscensionTimeToDegreeState createState() => RightAscensionTimeToDegreeState();
}

class RightAscensionTimeToDegreeState extends State<RightAscensionTimeToDegree> {
  FocusNode _hoursFocusNode;
  FocusNode _minutesFocusNode;
  FocusNode _secondsFocusNode;
  FocusNode _mSecondsFocusNode;

  FocusNode _decMilliDegreesFocusNode;

  TextEditingController _hoursController;
  TextEditingController _minutesController;
  TextEditingController _secondsController;
  TextEditingController _mSecondsController;

  TextEditingController _decDegreesController;
  TextEditingController _decMilliDegreesController;

  var _currentDuration = Duration();

  var _currentDecSign = 1;
  String _currentDecDegrees = '';
  String _currentDecMilliDegrees = '';

  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();
    _hoursController = TextEditingController(text: _currentDuration.inHours.remainder(24).toString());
    _minutesController = TextEditingController(text: _currentDuration.inMinutes.remainder(60).toString());
    _secondsController = TextEditingController(text: _currentDuration.inSeconds.remainder(60).toString());
    _mSecondsController = TextEditingController(text: _currentDuration.inSeconds.remainder(1000).toString());

    _decDegreesController = TextEditingController(text: _currentDecDegrees);
    _decMilliDegreesController = TextEditingController(text: _currentDecMilliDegrees);
  }

  @override
  void dispose() {
    _hoursController.dispose();
    _minutesController.dispose();
    _secondsController.dispose();
    _mSecondsController.dispose();

    _decDegreesController.dispose();
    _decMilliDegreesController.dispose();

    _hoursFocusNode.dispose();
    _minutesFocusNode.dispose();
    _secondsFocusNode.dispose();
    _mSecondsFocusNode.dispose();

    _decMilliDegreesFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWTextDivider(
            trailing: GCWPasteButton(
              iconSize: IconButtonSize.SMALL,
              onSelected: (text) {
                setState(() {
                  _parse(text);
                });
              },
            )),
        _currentMode == GCWSwitchPosition.left
          ? _buildDegRow()
          : _buildHmsRow(),

        GCWMultipleOutput(children: _buildOutput())
      ],
    );
  }

  Widget _buildHmsRow() {
    return Column(children: [
        GCWToolBar( children:[
          GCWText(text: '+/-', align: Alignment.center),
          GCWText(text: 'h', align: Alignment.center),
          GCWText(text: ''),
          GCWText(text: 'min', align: Alignment.center),
          GCWText(text: ''),
          GCWText(text: 'sec', align: Alignment.center),
          GCWText(text: ''),
          GCWText(text: 'msec', align: Alignment.center)
        ],
          flexValues: [5,5,1,5,1,5,1,8],
        ),
        GCWDateTimePicker(
          config: {DateTimePickerConfig.SIGN, DateTimePickerConfig.TIME,
                  DateTimePickerConfig.SECOND_AS_INT, DateTimePickerConfig.TIME_MSEC},
          hoursController: _hoursController,
          minutesController: _minutesController,
          secondsController: _secondsController,
          mSecondsController: _mSecondsController,
          maxHours: null,
          duration: _currentDuration,
          onChanged: (value) {
            setState(() {
              _currentDuration = value['duration'];
            });
          },
        ),
       ]);
  }

  Widget _buildDegRow() {
    return Column(children: <Widget>[
      Row(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: GCWCoordsSignDropDownButton(
                itemList: ['+', '-'],
                value: _currentDecSign,
                onChanged: (value) {
                  setState(() {
                    _currentDecSign = value;
                  });
                }),
          ),
          Expanded(
              flex: 6,
              child: Container(
                child: GCWIntegerTextField(
                    hintText: 'DD',
                    textInputFormatter: CoordsIntegerDegreesLatTextInputFormatter(allowNegativeValues: false),
                    controller: _decDegreesController,
                    onChanged: (ret) {
                      setState(() {
                        _currentDecDegrees = ret['text'];
                      });
                    }),
                padding: EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN),
              )),
          Expanded(
            flex: 1,
            child: GCWText(align: Alignment.center, text: '.'),
          ),
          Expanded(
            flex: 20,
            child: GCWIntegerTextField(
                hintText: 'DDD',
                min: 0,
                controller: _decMilliDegreesController,
                focusNode: _decMilliDegreesFocusNode,
                onChanged: (ret) {
                  setState(() {
                    _currentDecMilliDegrees = ret['text'];
                  });
                }),
          ),
          Expanded(
            flex: 1,
            child: GCWText(align: Alignment.center, text: '°'),
          ),
        ],
      ),
    ]);
  }

  _buildOutput() {

    var output = <List<String>>[];
    if (_currentMode == GCWSwitchPosition.left) {
      int _degrees = ['', '-'].contains(_currentDecDegrees) ? 0 : int.parse(_currentDecDegrees);
      double _degreesD = double.parse('$_degrees.$_currentDecMilliDegrees');
      var _currentDeg = RaDeg(_currentDecSign * _degreesD);

      var entry = <String>[i18n(context, 'astronomy_position_rightascension'), raDegree2Time(_currentDeg).toString()];
      output.add(entry);
    } else {
      var sign = _currentDuration.isNegative ? -1 : 1;
      var duration = _currentDuration.abs();
      var hours = duration.inHours;
      var minutes = duration.inMinutes.remainder(60);
      var seconds = duration.inSeconds.remainder(60);
      var mseconds  = duration.inMilliseconds - _currentDuration.inSeconds * 1000;
      var _secondsD = double.parse('$seconds.$mseconds');

      var _rightAscension = RightAscension(sign, hours, minutes, _secondsD);

      var entry = <String>[i18n(context, 'common_unit_angle_deg_name'), raTime2Degree(_rightAscension).toString()];
      output.add(entry);
    }
    return columnedMultiLineOutput(context, output, flexValues: [1, 1]);
  }

  _parse(String input) {
    if(_currentMode == GCWSwitchPosition.left) {
      var deg = RaDeg.parse(input);
      if (deg == null) return;

      _currentDecDegrees = deg.degress.abs().truncate().toString();
      _currentDecMilliDegrees = separateDecimalPlaces(deg.degress).toString();

      _currentDecSign = coordinateSign(deg.degress);
      _decDegreesController.text = _currentDecDegrees.toString();
      _decMilliDegreesController.text = _currentDecMilliDegrees.toString();
    } else {
      var equatorial = RightAscension.parse(input);
      if (equatorial == null) return;
      var milliseconds = separateDecimalPlaces(equatorial.seconds);
      _currentDuration = Duration(
          hours: equatorial.hours,
          minutes: equatorial.minutes,
          seconds: equatorial.seconds.truncate(),
          milliseconds: milliseconds);

      _hoursController.text = equatorial.hours.toString();
      _minutesController.text = equatorial.minutes.toString();
      _secondsController.text = equatorial.seconds.truncate().toString();
      _mSecondsController.text = milliseconds.toString();
    }
  }
}
