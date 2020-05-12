import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/coords/converter/latlon.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_sign_dropdownbutton.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_textfield.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/coords_integer_degrees_lat_textinputformatter.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/coords_integer_degrees_lon_textinputformatter.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/integer_minutesseconds_textinputformatter.dart';
import 'package:latlong/latlong.dart';

class GCWCoordsDEG extends StatefulWidget {
  final Function onChanged;
  final LatLng coordinates;

  const GCWCoordsDEG({Key key, this.onChanged, this.coordinates}) : super(key: key);

  @override
  GCWCoordsDEGState createState() => GCWCoordsDEGState();
}

class GCWCoordsDEGState extends State<GCWCoordsDEG> {
  var _LatDegreesController;
  var _LatMinutesController;
  var _LatMilliMinutesController;

  var _LonDegreesController;
  var _LonMinutesController;
  var _LonMilliMinutesController;

  int _currentLatSign = defaultHemiphereLatitude();
  int _currentLonSign = defaultHemiphereLongitude();

  String _currentLatDegrees = '';
  String _currentLatMinutes = '';
  String _currentLatMilliMinutes = '';
  String _currentLonDegrees = '';
  String _currentLonMinutes = '';
  String _currentLonMilliMinutes = '';

  FocusNode _latMinutesFocusNode;
  FocusNode _latMilliMinutesFocusNode;
  FocusNode _lonMinutesFocusNode;
  FocusNode _lonMilliMinutesFocusNode;

  @override
  void initState() {
    super.initState();
    _LatDegreesController = TextEditingController(text: _currentLatDegrees);
    _LatMinutesController = TextEditingController(text: _currentLatMinutes);
    _LatMilliMinutesController = TextEditingController(text: _currentLatMilliMinutes);

    _LonDegreesController = TextEditingController(text: _currentLonDegrees);
    _LonMinutesController = TextEditingController(text: _currentLonMinutes);
    _LonMilliMinutesController = TextEditingController(text: _currentLonMilliMinutes);

    _latMinutesFocusNode = FocusNode();
    _latMilliMinutesFocusNode = FocusNode();
    _lonMinutesFocusNode = FocusNode();
    _lonMilliMinutesFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _LatDegreesController.dispose();
    _LatMinutesController.dispose();
    _LatMilliMinutesController.dispose();
    _LonDegreesController.dispose();
    _LonMinutesController.dispose();
    _LonMilliMinutesController.dispose();

    _latMinutesFocusNode.dispose();
    _latMilliMinutesFocusNode.dispose();
    _lonMinutesFocusNode.dispose();
    _lonMilliMinutesFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (widget.coordinates != null) {
      var lat = formattedDEG(widget.coordinates.latitude, true, precision: 10);
      var lon = formattedDEG(widget.coordinates.longitude, false, precision: 10);

      _currentLatDegrees = lat['degrees'];
      _currentLatMinutes = lat['minutes'].split('.')[0];
      _currentLatMilliMinutes = lat['minutes'].split('.')[1];
      _currentLatSign = lat['sign']['value'];

      _currentLonDegrees = lon['degrees'];
      _currentLonMinutes = lon['minutes'].split('.')[0];
      _currentLonMilliMinutes = lon['minutes'].split('.')[1];
      _currentLonSign = lon['sign']['value'];

      _LatDegreesController = TextEditingController(text: _currentLatDegrees);
      _LatMinutesController = TextEditingController(text: _currentLatMinutes);
      _LatMilliMinutesController = TextEditingController(text: _currentLatMilliMinutes);

      _LonDegreesController = TextEditingController(text: _currentLonDegrees);
      _LonMinutesController = TextEditingController(text: _currentLonMinutes);
      _LonMilliMinutesController = TextEditingController(text: _currentLonMilliMinutes);
    }

    return Column (
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: GCWCoordsSignDropDownButton(
                itemList: ['N','S'],
                value: _currentLatSign,
                onChanged: (value) {
                  setState(() {
                    _currentLatSign = value;
                    _setCurrentValueAndEmitOnChange();
                  });
                }
              ),
            ),
            Expanded(
              flex: 6,
              child: GCWIntegerTextField(
                hintText: 'DD',
                textInputFormatter: CoordsIntegerDegreesLatTextInputFormatter(allowNegativeValues: false),
                controller: _LatDegreesController,
                onChanged: (ret) {
                  setState(() {
                    _currentLatDegrees = ret['text'];
                    _setCurrentValueAndEmitOnChange();

                    if (_currentLatDegrees.length == 2)
                      FocusScope.of(context).requestFocus(_latMinutesFocusNode);
                  });
                }
              ),
            ),
            Expanded(
              flex: 1,
              child: GCWText(
                align: Alignment.center,
                text: '°'
              ),
            ),
            Expanded (
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

                    if (_currentLatMinutes.length == 2)
                      FocusScope.of(context).requestFocus(_latMilliMinutesFocusNode);
                  });
                }
              ),
            ),
            Expanded(
              flex: 1,
              child: GCWText(
                  align: Alignment.center,
                  text: '.'
              ),
            ),
            Expanded (
              flex: 13,
              child: GCWIntegerTextField(
                hintText: 'MMM',
                min: 0,
                controller: _LatMilliMinutesController,
                focusNode: _latMilliMinutesFocusNode,
                onChanged: (ret) {
                  setState(() {
                    _currentLatMilliMinutes = ret['text'];
                    _setCurrentValueAndEmitOnChange();
                  });
                }
              ),
            ),
            Expanded(
              flex: 1,
              child: GCWText(
                align: Alignment.center,
                text: '\''
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: GCWCoordsSignDropDownButton(
                itemList: ['E','W'],
                value: _currentLonSign,
                onChanged: (value) {
                  setState(() {
                    _currentLonSign = value;
                    _setCurrentValueAndEmitOnChange();
                  });
                }
              ),
            ),
            Expanded(
              flex: 6,
              child: GCWIntegerTextField(
                hintText: 'DD',
                textInputFormatter: CoordsIntegerDegreesLonTextInputFormatter(),
                controller: _LonDegreesController,
                onChanged: (ret) {
                  setState(() {
                    _currentLonDegrees = ret['text'];
                    _setCurrentValueAndEmitOnChange();

                    if (_currentLonDegrees.length == 3)
                      FocusScope.of(context).requestFocus(_lonMinutesFocusNode);
                  });
                }
              ),
            ),
            Expanded(
              flex: 1,
              child: GCWText(
                  align: Alignment.center,
                  text: '°'
              ),
            ),
            Expanded (
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

                    if (_currentLonMinutes.length == 2)
                      FocusScope.of(context).requestFocus(_lonMilliMinutesFocusNode);
                  });
                }
              ),
            ),
            Expanded(
              flex: 1,
              child: GCWText(
                  align: Alignment.center,
                  text: '.'
              ),
            ),
            Expanded (
              flex: 13,
              child: GCWIntegerTextField(
                hintText: 'MMM',
                min: 0,
                controller: _LonMilliMinutesController,
                focusNode: _lonMilliMinutesFocusNode,
                onChanged: (ret) {
                  setState(() {
                    _currentLonMilliMinutes = ret['text'];
                    _setCurrentValueAndEmitOnChange();
                  });
                }
              ),
            ),
            Expanded(
              flex: 1,
              child: GCWText(
                align: Alignment.center,
                text: '\''
              ),
            ),
          ],
        )
      ]
    );
  }

  _setCurrentValueAndEmitOnChange() {
    int _degrees = ['', '-'].contains(_currentLatDegrees) ? 0 : int.parse(_currentLatDegrees);
    int _minutes = ['', '-'].contains(_currentLatMinutes) ? 0 : int.parse(_currentLatMinutes);
    double _minutesD = double.parse('$_minutes.$_currentLatMilliMinutes');
    DEG _currentLat = DEG(_currentLatSign, _degrees, _minutesD);

    _degrees = ['', '-'].contains(_currentLonDegrees) ? 0 : int.parse(_currentLonDegrees);
    _minutes = ['', '-'].contains(_currentLonMinutes) ? 0 : int.parse(_currentLonMinutes);
    _minutesD = double.parse('$_minutes.$_currentLonMilliMinutes');
    DEG _currentLon = DEG(_currentLonSign, _degrees, _minutesD);

    widget.onChanged(LatLng(latDEGToDEC(_currentLat), lonDEGToDEC(_currentLon)));
  }
}