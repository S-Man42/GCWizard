import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/base/gcw_text/gcw_text.dart';
import 'package:gc_wizard/common_widgets/gcw_integer_textfield/gcw_integer_textfield.dart';
import 'package:gc_wizard/common_widgets/gcw_sign_dropdownbutton/gcw_sign_dropdownbutton.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/tools/coords/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/utils/default_getter.dart';
import 'package:gc_wizard/tools/utils/textinputformatter/coords_integer_degrees_lat_textinputformatter/widget/coords_integer_degrees_lat_textinputformatter.dart';
import 'package:gc_wizard/tools/utils/textinputformatter/coords_integer_degrees_lon_textinputformatter/widget/coords_integer_degrees_lon_textinputformatter.dart';
import 'package:gc_wizard/tools/utils/textinputformatter/integer_minutesseconds_textinputformatter/widget/integer_minutesseconds_textinputformatter.dart';

class GCWCoordsDMS extends StatefulWidget {
  final Function onChanged;
  final BaseCoordinates coordinates;

  const GCWCoordsDMS({Key key, this.onChanged, this.coordinates}) : super(key: key);

  @override
  GCWCoordsDMSState createState() => GCWCoordsDMSState();
}

class GCWCoordsDMSState extends State<GCWCoordsDMS> {
  TextEditingController _LatDegreesController;
  TextEditingController _LatMinutesController;
  TextEditingController _LatSecondsController;
  TextEditingController _LatMilliSecondsController;
  TextEditingController _LonDegreesController;
  TextEditingController _LonMinutesController;
  TextEditingController _LonSecondsController;
  TextEditingController _LonMilliSecondsController;

  FocusNode _latMinutesFocusNode;
  FocusNode _latSecondsFocusNode;
  FocusNode _latMilliSecondsFocusNode;
  FocusNode _lonMinutesFocusNode;
  FocusNode _lonSecondsFocusNode;
  FocusNode _lonMilliSecondsFocusNode;

  int _currentLatSign = defaultHemiphereLatitude();
  int _currentLonSign = defaultHemiphereLongitude();

  String _currentLatDegrees = '';
  String _currentLatMinutes = '';
  String _currentLatSeconds = '';
  String _currentLatMilliSeconds = '';
  String _currentLonDegrees = '';
  String _currentLonMinutes = '';
  String _currentLonSeconds = '';
  String _currentLonMilliSeconds = '';

  @override
  void initState() {
    super.initState();
    _LatDegreesController = TextEditingController(text: _currentLatDegrees);
    _LatMinutesController = TextEditingController(text: _currentLatMinutes);
    _LatSecondsController = TextEditingController(text: _currentLatSeconds);
    _LatMilliSecondsController = TextEditingController(text: _currentLatMilliSeconds);

    _LonDegreesController = TextEditingController(text: _currentLonDegrees);
    _LonMinutesController = TextEditingController(text: _currentLonMinutes);
    _LonSecondsController = TextEditingController(text: _currentLonSeconds);
    _LonMilliSecondsController = TextEditingController(text: _currentLonMilliSeconds);

    _latMinutesFocusNode = FocusNode();
    _latSecondsFocusNode = FocusNode();
    _latMilliSecondsFocusNode = FocusNode();
    _lonMinutesFocusNode = FocusNode();
    _lonSecondsFocusNode = FocusNode();
    _lonMilliSecondsFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _LatDegreesController.dispose();
    _LatMinutesController.dispose();
    _LatSecondsController.dispose();
    _LatMilliSecondsController.dispose();
    _LonDegreesController.dispose();
    _LonMinutesController.dispose();
    _LonSecondsController.dispose();
    _LonMilliSecondsController.dispose();

    _latMinutesFocusNode.dispose();
    _latSecondsFocusNode.dispose();
    _latMilliSecondsFocusNode.dispose();
    _lonMinutesFocusNode.dispose();
    _lonSecondsFocusNode.dispose();
    _lonMilliSecondsFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.coordinates != null) {
      var dms = widget.coordinates is DMS ? widget.coordinates as DMS : DMS.fromLatLon(widget.coordinates.toLatLng());
      var lat = dms.latitude.formatParts(10);
      var lon = dms.longitude.formatParts(10);

      _currentLatDegrees = lat['degrees'];
      _currentLatMinutes = lat['minutes'];
      _currentLatSeconds = lat['seconds'].split('.')[0];
      _currentLatMilliSeconds = lat['seconds'].split('.')[1];
      _currentLatSign = widget.coordinates.isDefault() ? defaultHemiphereLatitude() : lat['sign']['value'];

      _currentLonDegrees = lon['degrees'];
      _currentLonMinutes = lon['minutes'];
      _currentLonSeconds = lon['seconds'].split('.')[0];
      _currentLonMilliSeconds = lon['seconds'].split('.')[1];
      _currentLonSign = widget.coordinates.isDefault() ? defaultHemiphereLongitude() : lon['sign']['value'];

      _LatDegreesController.text = _currentLatDegrees;
      _LatMinutesController.text = _currentLatMinutes;
      _LatSecondsController.text = _currentLatSeconds;
      _LatMilliSecondsController.text = _currentLatMilliSeconds;

      _LonDegreesController.text = _currentLonDegrees;
      _LonMinutesController.text = _currentLonMinutes;
      _LonSecondsController.text = _currentLonSeconds;
      _LonMilliSecondsController.text = _currentLonMilliSeconds;
    }

    return Column(children: <Widget>[
      Row(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: GCWSignDropDownButton(
                itemList: ['N', 'S'],
                value: _currentLatSign,
                onChanged: (value) {
                  setState(() {
                    _currentLatSign = value;
                    _setCurrentValueAndEmitOnChange();
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
                        _setCurrentValueAndEmitOnChange();

                        if (_currentLatDegrees.length == 2) FocusScope.of(context).requestFocus(_latMinutesFocusNode);
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
                controller: _LatMinutesController,
                focusNode: _latMinutesFocusNode,
                onChanged: (ret) {
                  setState(() {
                    _currentLatMinutes = ret['text'];
                    _setCurrentValueAndEmitOnChange();

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
                    _setCurrentValueAndEmitOnChange();

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
                    _setCurrentValueAndEmitOnChange();
                  });
                }),
          ),
          Expanded(
            flex: 1,
            child: GCWText(align: Alignment.center, text: '"'),
          ),
        ],
      ),
      Row(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: GCWSignDropDownButton(
                itemList: ['E', 'W'],
                value: _currentLonSign,
                onChanged: (value) {
                  setState(() {
                    _currentLonSign = value;
                    _setCurrentValueAndEmitOnChange();
                  });
                }),
          ),
          Expanded(
              flex: 6,
              child: Container(
                child: GCWIntegerTextField(
                    hintText: 'DD',
                    textInputFormatter: CoordsIntegerDegreesLonTextInputFormatter(),
                    controller: _LonDegreesController,
                    onChanged: (ret) {
                      setState(() {
                        _currentLonDegrees = ret['text'];
                        _setCurrentValueAndEmitOnChange();

                        if (_currentLonDegrees.length == 3) FocusScope.of(context).requestFocus(_lonMinutesFocusNode);
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
                controller: _LonMinutesController,
                focusNode: _lonMinutesFocusNode,
                onChanged: (ret) {
                  setState(() {
                    _currentLonMinutes = ret['text'];
                    _setCurrentValueAndEmitOnChange();

                    if (_currentLonMinutes.length == 2) FocusScope.of(context).requestFocus(_lonSecondsFocusNode);
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
                controller: _LonSecondsController,
                focusNode: _lonSecondsFocusNode,
                onChanged: (ret) {
                  setState(() {
                    _currentLonSeconds = ret['text'];
                    _setCurrentValueAndEmitOnChange();

                    if (_currentLonSeconds.length == 2) {
                      FocusScope.of(context).requestFocus(_lonMilliSecondsFocusNode);
                    }
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
                controller: _LonMilliSecondsController,
                focusNode: _lonMilliSecondsFocusNode,
                onChanged: (ret) {
                  setState(() {
                    _currentLonMilliSeconds = ret['text'];
                    _setCurrentValueAndEmitOnChange();
                  });
                }),
          ),
          Expanded(
            flex: 1,
            child: GCWText(align: Alignment.center, text: '"'),
          ),
        ],
      )
    ]);
  }

  _setCurrentValueAndEmitOnChange() {
    int _degrees = ['', '-'].contains(_currentLatDegrees) ? 0 : int.parse(_currentLatDegrees);
    int _minutes = ['', '-'].contains(_currentLatMinutes) ? 0 : int.parse(_currentLatMinutes);
    int _seconds = (['', '-'].contains(_currentLatSeconds) ? 0 : int.parse(_currentLatSeconds));
    double _secondsD = double.parse('$_seconds.$_currentLatMilliSeconds');
    var _currentLat = DMSLatitude(_currentLatSign, _degrees, _minutes, _secondsD);

    _degrees = ['', '-'].contains(_currentLonDegrees) ? 0 : int.parse(_currentLonDegrees);
    _minutes = ['', '-'].contains(_currentLonMinutes) ? 0 : int.parse(_currentLonMinutes);
    _seconds = (['', '-'].contains(_currentLonSeconds) ? 0 : int.parse(_currentLonSeconds));
    _secondsD = double.parse('$_seconds.$_currentLonMilliSeconds');
    var _currentLon = DMSLongitude(_currentLonSign, _degrees, _minutes, _secondsD);

    widget.onChanged(DMS(_currentLat, _currentLon));
  }
}
