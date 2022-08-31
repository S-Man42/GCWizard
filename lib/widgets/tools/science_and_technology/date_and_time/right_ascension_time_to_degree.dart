import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/date_and_time/right_ascension_time_to_degree.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_datetime_picker.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_paste_button.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_toolbar.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/coords_integer_degrees_lat_textinputformatter.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/integer_minutesseconds_textinputformatter.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_sign_dropdownbutton.dart';


class RightAscensionTimeToDegree extends StatefulWidget {
  @override
  RightAscensionTimeToDegreeState createState() => RightAscensionTimeToDegreeState();
}

class RightAscensionTimeToDegreeState extends State<RightAscensionTimeToDegree> {

  static const keyCoordsHMS = 'coords_hms';

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

  var _currentRightAscension = RightAscension(1, 0 ,0 , 0.0);
  var _currentEncryptFormat = keyCoordsHMS;

  var _currentDecSign = 1;
  String _currentDecDegrees = '';
  String _currentDecMilliDegrees = '';

  TextEditingController _DmmDegreesController;
  TextEditingController _DmmMinutesController;
  TextEditingController _DmmMilliMinutesController;
  int _currentDmmSign = 1;
  String _currentDmmDegrees = '1';
  String _currentDmmMinutes = '0';
  String _currentDmmMilliMinutes = '0';
  FocusNode _dmmMinutesFocusNode;
  FocusNode _dmmMilliMinutesFocusNode;

  TextEditingController _DmsDegreesController;
  TextEditingController _DmsMinutesController;
  TextEditingController _DmsSecondsController;
  TextEditingController _DmsMilliSecondsController;
  int _currentDmsSign = 1;
  String _currentDmsDegrees = '1';
  String _currentDmsMinutes = '0';
  String _currentDmsSeconds = '0';
  String _currentDmsMilliSeconds = '0';
  FocusNode _dmsMinutesFocusNode;
  FocusNode _dmsSecondsFocusNode;
  FocusNode _dmsMilliSecondsFocusNode;

  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();
    _hoursController = TextEditingController(text: _currentRightAscension.hours.toString());
    _minutesController = TextEditingController(text: _currentRightAscension.minutes.toString());
    _secondsController = TextEditingController(text: _currentRightAscension.seconds.truncate().toString());
    _mSecondsController = TextEditingController(text: _currentRightAscension.seconds.toString().split('.')[1]);

    _decDegreesController = TextEditingController(text: _currentDecDegrees);
    _decMilliDegreesController = TextEditingController(text: _currentDecMilliDegrees);

    _DmmDegreesController = TextEditingController(text: _currentDmmDegrees.toString());
    _DmmMinutesController = TextEditingController(text: _currentDmmMinutes.toString());
    _DmmMilliMinutesController = TextEditingController(text: _currentDmmMilliMinutes.toString());
    _dmmMinutesFocusNode = FocusNode();
    _dmmMilliMinutesFocusNode = FocusNode();

    _DmsDegreesController = TextEditingController(text: _currentDmsDegrees.toString());
    _DmsMinutesController = TextEditingController(text: _currentDmsMinutes.toString());
    _DmsSecondsController = TextEditingController(text: _currentDmsSeconds.toString());
    _DmsMilliSecondsController = TextEditingController(text: _currentDmsMilliSeconds.toString());
    _dmsMinutesFocusNode = FocusNode();
    _dmsSecondsFocusNode = FocusNode();
    _dmsMilliSecondsFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _hoursController?.dispose();
    _minutesController?.dispose();
    _secondsController?.dispose();
    _mSecondsController?.dispose();

    _decDegreesController?.dispose();
    _decMilliDegreesController?.dispose();

    _hoursFocusNode?.dispose();
    _minutesFocusNode?.dispose();
    _secondsFocusNode?.dispose();
    _mSecondsFocusNode?.dispose();

    _decMilliDegreesFocusNode?.dispose();

    _DmmDegreesController?.dispose();
    _DmmMinutesController?.dispose();
    _DmmMilliMinutesController?.dispose();
    _dmmMinutesFocusNode?.dispose();
    _dmmMilliMinutesFocusNode?.dispose();

    _DmsDegreesController?.dispose();
    _DmsMinutesController?.dispose();
    _DmsSecondsController?.dispose();
    _DmsMilliSecondsController?.dispose();
    _dmsMinutesFocusNode?.dispose();
    _dmsSecondsFocusNode?.dispose();
    _dmsMilliSecondsFocusNode?.dispose();

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
          : _buildEncryptRow(),
        Container(height: 10),
        _buildOutput()
      ],
    );
  }

  Widget _buildEncryptRow() {
    return Column(children: [
      GCWDropDownButton(
        value: _currentEncryptFormat,
        onChanged: (newValue) {
          setState(() {
            _currentEncryptFormat = newValue;
            _updateControler();
          });
        },
        items: [
          GCWDropDownMenuItem(
            value: keyCoordsHMS,
            child: "HMS: h:min:sec.msec",
          ),
          GCWDropDownMenuItem(
            value: keyCoordsDMM,
            child: getCoordinateFormatByKey(keyCoordsDMM).name,
          ),
          GCWDropDownMenuItem(
            value: keyCoordsDMS,
            child: getCoordinateFormatByKey(keyCoordsDMS).name,
          ),
        ],
      ),
      Container(height: 10),
      _currentEncryptFormat == keyCoordsDMM
      ? _buildDmmPartRow()
      : _currentEncryptFormat == keyCoordsDMS
        ? _buildDmsPartRow()
        : _buildHmsRow()
    ]);
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
          duration: _currentRightAscension.toDuration(),
          onChanged: (value) {
            setState(() {
              _currentRightAscension = RightAscension.fromDuration(value['duration']);
            });
          },
        ),
       ]);
  }

  Widget _buildDmmPartRow() {
    return Column(children: [
      Row(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: GCWCoordsSignDropDownButton(
                itemList: ['+', '-'],
                value: _currentDmmSign,
                onChanged: (value) {
                  setState(() {
                    _currentDmmSign = value;
                    _setDmmRightAscension();
                  });
                }),
          ),
          Expanded(
              flex: 6,
              child: Container(
                child: GCWIntegerTextField(
                    hintText: 'DD',
                    textInputFormatter: CoordsIntegerDegreesLatTextInputFormatter(allowNegativeValues: false),
                    controller: _DmmDegreesController,
                    onChanged: (ret) {
                      setState(() {
                        _currentDmmDegrees = ret['text'];
                        _setDmmRightAscension();

                         if (_currentDmmDegrees.length == 2) FocusScope.of(context).requestFocus(_dmmMinutesFocusNode);
                      });
                    }),
                padding: EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN),
              )),
          Expanded(
            flex: 1,
            child: GCWText(align: Alignment.center, text: '°'),
          ),
          Expanded(
            flex: 6,
            child: GCWIntegerTextField(
                hintText: 'MM',
                textInputFormatter: IntegerMinutesSecondsTextInputFormatter(),
                controller: _DmmMinutesController,
                focusNode: _dmmMinutesFocusNode,
                onChanged: (ret) {
                  setState(() {
                    _currentDmmMinutes = ret['text'];
                    _setDmmRightAscension();

                     if (_currentDmmMinutes.length == 2) FocusScope.of(context).requestFocus(_dmmMilliMinutesFocusNode);
                  });
                }),
          ),
          Expanded(
            flex: 1,
            child: GCWText(align: Alignment.center, text: '.'),
          ),
          Expanded(
            flex: 13,
            child: GCWIntegerTextField(
                hintText: 'MMM',
                min: 0,
                controller: _DmmMilliMinutesController,
                focusNode: _dmmMilliMinutesFocusNode,
                onChanged: (ret) {
                  setState(() {
                    _currentDmmMilliMinutes = ret['text'];
                    _setDmmRightAscension();
                  });
                }),
          ),
          Expanded(
            flex: 1,
            child: GCWText(align: Alignment.center, text: '\''),
          ),
        ],
      ),
    ]);
  }

  void _setDmmRightAscension() {
    int _degrees = ['', '-'].contains(_currentDmmDegrees) ? 0 : int.parse(_currentDmmDegrees);
    int _minutes = ['', '-'].contains(_currentDmmMinutes) ? 0 : int.parse(_currentDmmMinutes);
    double _minutesD = double.parse('$_minutes.$_currentDmmMilliMinutes');

    _currentRightAscension = RightAscension.fromDMM(_currentDmmSign, _degrees, _minutesD);
  }

  Widget _buildDmsPartRow() {
    return Column(children: [
      Row(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: GCWCoordsSignDropDownButton(
                itemList: ['+', '-'],
                value: _currentDmsSign,
                onChanged: (value) {
                  setState(() {
                    _currentDmsSign = value;
                    _setDmsRightAscension();
                  });
                }),
          ),
          Expanded(
              flex: 6,
              child: Container(
                child: GCWIntegerTextField(
                    hintText: 'DD',
                    textInputFormatter: CoordsIntegerDegreesLatTextInputFormatter(),
                    controller: _DmsDegreesController,
                    onChanged: (ret) {
                      setState(() {
                        _currentDmsDegrees = ret['text'];
                        _setDmsRightAscension();

                        if (_currentDmsDegrees.length == 2) FocusScope.of(context).requestFocus(_dmsMinutesFocusNode);
                      });
                    }),
                padding: EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN),
              )),
          Expanded(
            flex: 1,
            child: GCWText(align: Alignment.center, text: '°'),
          ),
          Expanded(
            flex: 6,
            child: GCWIntegerTextField(
                hintText: 'MM',
                textInputFormatter: IntegerMinutesSecondsTextInputFormatter(),
                controller: _DmsMinutesController,
                focusNode: _dmsMinutesFocusNode,
                onChanged: (ret) {
                  setState(() {
                    _currentDmsMinutes = ret['text'];
                    _setDmsRightAscension();

                    if (_currentDmsMinutes.length == 2) FocusScope.of(context).requestFocus(_dmsSecondsFocusNode);
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
                controller: _DmsSecondsController,
                focusNode: _dmsSecondsFocusNode,
                onChanged: (ret) {
                  setState(() {
                    _currentDmsSeconds = ret['text'];
                    _setDmsRightAscension();

                    if (_currentDmsSeconds.length == 2) FocusScope.of(context).requestFocus(_dmsMilliSecondsFocusNode);
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
                controller: _DmsMilliSecondsController,
                focusNode: _dmsMilliSecondsFocusNode,
                onChanged: (ret) {
                  setState(() {
                    _currentDmsMilliSeconds = ret['text'];
                    _setDmsRightAscension();
                  });
                }),
          ),
          Expanded(
            flex: 1,
            child: GCWText(align: Alignment.center, text: '"'),
          ),
        ],
      ),
    ]);
  }


  void _setDmsRightAscension() {
    int _degrees = ['', '-'].contains(_currentDmsDegrees) ? 0 : int.parse(_currentDmsDegrees);
    int _minutes = ['', '-'].contains(_currentDmsMinutes) ? 0 : int.parse(_currentDmsMinutes);
    int _seconds = ['', '-'].contains(_currentDmsSeconds) ? 0 : int.parse(_currentDmsSeconds);
    double _secondsD = double.parse('$_seconds.$_currentDmsMilliSeconds');

    _currentRightAscension = RightAscension.fromDMS(_currentDmsSign, _degrees, _minutes, _secondsD);
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
          Container(height: 10),
        ],
      ),
    ]);
  }

  Widget _buildOutput() {
    var rows = <Widget>[];
    if (_currentMode == GCWSwitchPosition.left) {
      int _degrees = ['', '-'].contains(_currentDecDegrees) ? 0 : int.parse(_currentDecDegrees);
      double _degreesD = double.parse('$_degrees.$_currentDecMilliDegrees');
      var _currentDeg = RaDeg(_currentDecSign * _degreesD);
      var _time = raDegree2Time(_currentDeg);

      rows = columnedMultiLineOutput(context, [
        [i18n(context, 'astronomy_position_rightascension'), _time.toString()],
        [getCoordinateFormatByKey(keyCoordsDMM).name, _time.toDMMPartString()],
        [getCoordinateFormatByKey(keyCoordsDMS).name, _time.toDMSPartString()]
      ]);

    } else {
      rows = columnedMultiLineOutput(context, [
        [i18n(context, 'common_unit_angle_deg_name'), raTime2Degree(_currentRightAscension).toString()]
      ]);
    }
    return Column(children: rows);
  }

  _parse(String input) {
    if(_currentMode == GCWSwitchPosition.left) {
      var deg = RaDeg.parse(input);
      if (deg == null) {
        showToast(i18n(context, 'right_ascension_time_to_degree_clipboard_nodatafound'));
        return;
      }

      setState(() {
        _currentDecDegrees = deg.degress.abs().truncate().toString();
        _currentDecMilliDegrees = separateDecimalPlaces(deg.degress).toString();

        _currentDecSign = coordinateSign(deg.degress);
        _decDegreesController.text = _currentDecDegrees.toString();
        _decMilliDegreesController.text = _currentDecMilliDegrees.toString();
      });
    } else {
      var rightAscension = RightAscension.parse(input);
      if (rightAscension == null) {
        showToast(i18n(context, 'right_ascension_time_to_degree_clipboard_nodatafound'));
        return;
      }

      _currentRightAscension = rightAscension;
      setState(() {
        _updateControler();
      });
    }
  }

  void _updateControler() {
    _hoursController.text = _currentRightAscension?.hours?.abs().toString();
    _minutesController.text = _currentRightAscension?.minutes?.toString();
    _secondsController.text = _currentRightAscension?.seconds?.truncate().toString();
    _mSecondsController.text = _currentRightAscension?.milliseconds?.toString();

    var _dmm = _currentRightAscension.toDMMPart();
    _currentDmmSign = _dmm?.sign;
    _DmmDegreesController.text = _dmm?.degrees?.abs().toString();
    _DmmMinutesController.text = _dmm?.minutes?.truncate().toString();
    _DmmMilliMinutesController.text = commaSplit(_dmm?.minutes);

    var _dms = _currentRightAscension.toDMSPart();
    _currentDmsSign = _dms?.sign;
    _DmsDegreesController.text = _dms?.degrees?.abs().toString();
    _DmsMinutesController.text = _dms?.minutes?.toString();
    _DmsSecondsController.text = _dms?.seconds?.truncate().toString();
    _DmsMilliSecondsController.text = commaSplit(_dms?.seconds);
  }
}
