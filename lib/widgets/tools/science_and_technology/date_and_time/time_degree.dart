import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/date_and_time/time_degree.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_toolbar.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/coords_integer_degrees_lat_textinputformatter.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_sign_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_paste_button.dart';

class TimeDegree extends StatefulWidget {
  @override
  TimeDegreeState createState() => TimeDegreeState();
}

class TimeDegreeState extends State<TimeDegree> {
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

  var _currentSign = 1;
  var _currentHours = '';
  var _currentMinutes = '';
  var _currentSeconds = '';
  var _currentMilliSeconds = '';

  var _currentDecSign = 1;
  String _currentDecDegrees = '';
  String _currentDecMilliDegrees = '';

  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();
    _hoursController = TextEditingController(text: _currentHours);
    _minutesController = TextEditingController(text: _currentMinutes);
    _secondsController = TextEditingController(text: _currentSeconds);
    _mSecondsController = TextEditingController(text: _currentMilliSeconds);

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
        GCWToolBar( children:[
          GCWCoordsSignDropDownButton(
            itemList: ['+', '-'],
            value: _currentSign,
            onChanged: (value) {
              setState(() {
                _currentSign = value;
                // _setCurrentValueAndEmitOnChange();
              });
            }),
          GCWIntegerTextField(
            hintText: 'h',
            controller: _hoursController,
            focusNode: _hoursFocusNode,
            onChanged: (ret) {
              setState(() {
                _currentHours = ret['text'];
                //if (ret['text'].length == 2) FocusScope.of(context).requestFocus(_minutesFocusNode);
              });
            }
          ),
          GCWText(text: ':', align: Alignment.center),
          GCWIntegerTextField(
            hintText: 'min',
            controller: _minutesController,
            focusNode: _minutesFocusNode,
            onChanged: (ret) {
              setState(() {
                _currentMinutes = ret['text'];
                if (ret['text'].length == 2) FocusScope.of(context).requestFocus(_secondsFocusNode);
              });
            }
          ),
          GCWText(text: ':', align: Alignment.center),
          GCWIntegerTextField(
            hintText: 'sec',
            controller: _secondsController,
            focusNode: _secondsFocusNode,
            onChanged: (ret) {
              setState(() {
                _currentSeconds = ret['text'];
                if (ret['text'].length == 2) FocusScope.of(context).requestFocus(_mSecondsFocusNode);
              });
            }
          ),
          GCWText(text: '.', align: Alignment.center),
          GCWIntegerTextField(
            hintText: 'msec',
            controller: _mSecondsController,
            focusNode: _mSecondsFocusNode,
            onChanged: (ret) {
              setState(() {
                _currentMilliSeconds = ret['text'];
              });
            }
          ),
        ],
          flexValues: [5,5,1,5,1,5,1,8],
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
                    //_setCurrentValueAndEmitOnChange();
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
                        //_setCurrentValueAndEmitOnChange();

                        //if (_currentDecDegrees.length == 2) FocusScope.of(context).requestFocus(_decMilliDegreesFocusNode);
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
                    //_setCurrentValueAndEmitOnChange();
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
      var _currentDeg = DEG(_currentDecSign * _degreesD);

      var entry = <String>['Right ascension', raDegree2Time(_currentDeg).toString()];
      output.add(entry);
    } else {
      int _hours = ['', '-'].contains(_currentHours) ? 0 : int.parse(_currentHours);
      int _minutes = ['', '-'].contains(_currentMinutes) ? 0 : int.parse(_currentMinutes);
      int _seconds = (['', '-'].contains(_currentSeconds) ? 0 : int.parse(_currentSeconds));
      double _secondsD = double.parse('$_seconds.$_currentMilliSeconds');

      var _equatorial =Equatorial(_currentSign, _hours, _minutes, _secondsD);

      var deg = raTime2Degree(_equatorial);
      var entry = <String>[i18n(context, 'common_unit_angle_deg_name'), deg.toString()];
      output.add(entry);
    }
    return columnedMultiLineOutput(context, output, flexValues: [1, 1]);
  }

  _parse(String input) {
    if(_currentMode == GCWSwitchPosition.left) {
      var deg = DEG.parse(input);
      if (deg == null) return;

      _currentDecDegrees = deg.degress.abs().floor().toString();
      _currentDecMilliDegrees = deg.degress.toString().split('.')[1];

      _currentDecSign = coordinateSign(deg.degress);
      _decDegreesController.text = _currentDecDegrees.toString();
      _decMilliDegreesController.text = _currentDecMilliDegrees.toString();
    } else {
      var equatorial = Equatorial.parse(input);
      if (equatorial == null) return;

      _currentSign = equatorial.sign;
      _currentHours = equatorial.hours.toString();
      _currentMinutes = equatorial.minutes.toString();
      _currentSeconds = equatorial.seconds.truncate().toString();
      var seconds =  _currentSeconds.split('.');
      _currentMilliSeconds = seconds.length < 2 ? '0' : seconds[1];

      _hoursController.text = _currentHours;
      _minutesController.text = _currentMinutes;
      _secondsController.text = _currentSeconds;
      _mSecondsController.text = _currentMilliSeconds;
    }
  }
}
