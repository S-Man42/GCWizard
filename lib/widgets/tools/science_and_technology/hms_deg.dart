import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/hms_deg.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_toolbar.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/coords_integer_degrees_lat_textinputformatter.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/coords_integer_degrees_lon_textinputformatter.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/integer_minutesseconds_textinputformatter.dart';

import '../coords/base/gcw_coords_sign_dropdownbutton.dart';

class HmsDeg extends StatefulWidget {
  @override
  HmsDegState createState() => HmsDegState();
}

class HmsDegState extends State<HmsDeg> {
  FocusNode _hoursFocusNode;
  FocusNode _minutesFocusNode;
  FocusNode _secondsFocusNode;
  FocusNode _mSecondsFocusNode;

  FocusNode _latMinutesFocusNode;
  FocusNode _latSecondsFocusNode;
  FocusNode _latMilliSecondsFocusNode;

  TextEditingController _hoursController;
  TextEditingController _minutesController;
  TextEditingController _secondsController;
  TextEditingController _mSecondsController;

  TextEditingController _LatDegreesController;
  TextEditingController _LatMinutesController;
  TextEditingController _LatSecondsController;
  TextEditingController _LatMilliSecondsController;

  var _currentSign = 1;
  var _currentHours = '';
  var _currentMinutes = '';
  var _currentSeconds = '';
  var _currentMilliSeconds = '';

  var _currentDmsSign = 1;
  String _currentLatDegrees = '';
  String _currentLatMinutes = '';
  String _currentLatSeconds = '';
  String _currentLatMilliSeconds = '';

  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();
    _hoursController = TextEditingController(text: _currentHours);
    _minutesController = TextEditingController(text: _currentMinutes);
    _secondsController = TextEditingController(text: _currentSeconds);
    _mSecondsController = TextEditingController(text: _currentMilliSeconds);

    _LatDegreesController = TextEditingController(text: _currentLatDegrees);
    _LatMinutesController = TextEditingController(text: _currentLatMinutes);
    _LatSecondsController = TextEditingController(text: _currentLatSeconds);
    _LatMilliSecondsController = TextEditingController(text: _currentLatMilliSeconds);

  }

  @override
  void dispose() {
    _hoursController.dispose();
    _minutesController.dispose();
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
        _buildHmsRow(),

        GCWDefaultOutput(child: _buildOutput())
      ],
    );
  }

  Widget _buildHmsRow() {
    return Column(children: [
        GCWToolBar( children:[
          GCWText(text: '+/-'),
          GCWText(text: 'h'),
          GCWText(text: 'min'),
          GCWText(text: 'sec'),
          GCWText(text: 'msec')
        ]),
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
                if (ret['text'].length == 2) FocusScope.of(context).requestFocus(_minutesFocusNode);
              });
            }
          ),
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
        ]),
      ]);
  }

  Widget _buildDegRow() {
    return Row(children: <Widget>[
        Expanded(
          flex: 6,
          child: GCWCoordsSignDropDownButton(
            itemList: ['N', 'S'],
            value: _currentDmsSign,
            onChanged: (value) {
              setState(() {
                _currentDmsSign = value;
                //_setCurrentValueAndEmitOnChange();
              });
            }),
        ),
        Expanded(
          flex: 6,
          child: Container(
            child: GCWIntegerTextField(
              hintText: 'DD',
              textInputFormatter: CoordsIntegerDegreesLatTextInputFormatter(),
              controller: _LatDegreesController,
              onChanged: (ret) {
              setState(() {
                _currentLatDegrees = ret['text'];
                // _setCurrentValueAndEmitOnChange();

                if (_currentLatDegrees.length == 2) FocusScope.of(context).requestFocus(_latMinutesFocusNode);
              });
            }),
            padding: EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN),
          )
        ),
        Expanded(
          flex: 1,
          child: GCWText(align: Alignment.center, text: '°'),
        ),
        Expanded(
          flex: 6,
          child: GCWIntegerTextField(
          hintText: 'MM',
          textInputFormatter: IntegerMinutesSecondsTextInputFormatter(),
          controller: _LatMinutesController,
          focusNode: _latMinutesFocusNode,
          onChanged: (ret) {
            setState(() {
              _currentLatMinutes = ret['text'];
              // _setCurrentValueAndEmitOnChange();

              if (_currentLatMinutes.length == 2) FocusScope.of(context).requestFocus(_latSecondsFocusNode);
            });
          }),
        ),
        Expanded(
          flex: 1,
          child: GCWText(align: Alignment.center, text: '\''),
        ),
        Expanded(
          flex: 6,
          child: GCWIntegerTextField(
          hintText: 'SS',
          textInputFormatter: IntegerMinutesSecondsTextInputFormatter(),
          controller: _LatSecondsController,
          focusNode: _latSecondsFocusNode,
          onChanged: (ret) {
          setState(() {
            _currentLatSeconds = ret['text'];
            // _setCurrentValueAndEmitOnChange();

            if (_currentLatSeconds.length == 2) FocusScope.of(context).requestFocus(_latMilliSecondsFocusNode);
            });
          }),
        ),
        Expanded(
          flex: 1,
          child: GCWText(align: Alignment.center, text: '.'),
        ),
        Expanded(
          flex: 6,
          child: GCWIntegerTextField(
          hintText: 'SSS',
          min: 0,
          controller: _LatMilliSecondsController,
          focusNode: _latMilliSecondsFocusNode,
          onChanged: (ret) {
          setState(() {
            _currentLatMilliSeconds = ret['text'];
            // _setCurrentValueAndEmitOnChange();
          });
          }),
        ),
        Expanded(
          flex: 1,
          child: GCWText(align: Alignment.center, text: '"'),
        ),
      ],
    );
  }

  _buildOutput() {
    int _hours = ['', '-'].contains(_currentHours) ? 0 : int.parse(_currentHours);
    int _minutes = ['', '-'].contains(_currentMinutes) ? 0 : int.parse(_currentMinutes);
    int _seconds = (['', '-'].contains(_currentSeconds) ? 0 : int.parse(_currentSeconds));
     double _mseconds = double.parse('0.$_currentMilliSeconds');
    // var _currentLat = DMSLatitude(_currentLatSign, _degrees, _minutes, _secondsD);

    var _equatorial =Equatorial(_currentSign, _hours, _minutes, _seconds, _mseconds);
    if (_currentMode == GCWSwitchPosition.left) {
      return raHms2Deg(_equatorial).toString();
    } else {
      return raHms2Deg(_equatorial).toString();
    }
  }
}
