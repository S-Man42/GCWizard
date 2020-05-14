import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/parser/variable_latlon.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/utils/units/lengths.dart';
import 'package:gc_wizard/widgets/common/base/gcw_alertdialog.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_lengths_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_output.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_outputformat.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/coords_text_variablecoordinate_textinputformatter.dart';

class VariableCoordinate extends StatefulWidget {
  @override
  VariableCoordinateState createState() => VariableCoordinateState();
}

class VariableCoordinateState extends State<VariableCoordinate> {
  Widget _output;
  GCWSwitchPosition _currentCoordMode = GCWSwitchPosition.left;

  final MAX_COUNT_COORDINATES = 100;

  Length _currentLengthUnit = defaultLength;
  bool _currentProjectionMode = false;
  var _currentOutputFormat = defaultCoordFormat();

  var _fromController;
  var _toController;
  var _inputController;
  var _bearingController;
  var _distanceController;

  var _currentInput = '';
  var _currentFromInput = '';
  var _currentToInput = '';
  var _currentBearingInput = '';
  var _currentDistanceInput = '';

  Map<String, String> _currentSubstitutions = {};

  List<String> _currentOutput = [];
  List<MapPoint> _currentMapPoints = [];

  @override
  void initState() {
    super.initState();

    _inputController = TextEditingController(text: _currentInput);
    _fromController = TextEditingController(text: _currentFromInput);
    _toController = TextEditingController(text: _currentToInput);
    _bearingController = TextEditingController(text: _currentBearingInput);
    _distanceController = TextEditingController(text: _currentDistanceInput);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _fromController.dispose();
    _toController.dispose();
    _bearingController.dispose();
    _distanceController.dispose();

    super.dispose();
  }

  _addNewSubstitution() {
    if (_currentFromInput.length > 0) {
      _currentSubstitutions.putIfAbsent(_currentFromInput, () => _currentToInput);
      _fromController.clear();
      _toController.clear();
      _currentFromInput = '';
      _currentToInput = '';
    }
  }

  _removeSubstitution(String key) {
    _currentSubstitutions.remove(key);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _inputController,
          onChanged: (value) {
            _currentInput = value;
          },
        ),
        GCWOnOffSwitch(
          title: i18n(context, 'coords_variablecoordinate_projection'),
          value: _currentProjectionMode,
          onChanged: (value) {
            setState(() {
              _currentProjectionMode = value;
            });
          },
        ),
        _buildProjectionInput(),
        _buildVariablesInput(),
        _buildSubstitutionList(context),
        GCWCoordsOutputFormat(
          coordFormat: _currentOutputFormat,
          onChanged: (value) {
            _currentOutputFormat = value;
          },
        ),
        GCWSubmitFlatButton(
          onPressed: () {
            _calculateOutput(context);
          },
        ),
        _output ?? Container()
      ],
    );
  }

  _buildVariablesInput() {
    return Column(
      children: [
        GCWTextDivider(
          text: i18n(context, 'coords_variablecoordinate_variables'),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: GCWTextField(
                hintText: i18n(context, 'coords_variablecoordinate_variable'),
                controller: _fromController,
                onChanged: (text) {
                  setState(() {
                    _currentFromInput = text;
                  });
                },
              ),
              flex: 1
            ),
            Icon(
              Icons.arrow_forward,
              color: ThemeColors.gray,
            ),
            Expanded(
              child: GCWTextField(
                hintText: i18n(context, 'coords_variablecoordinate_possiblevalues'),
                controller: _toController,
                inputFormatters: [CoordsTextVariableCoordinateTextInputFormatter()],
                onChanged: (text) {
                  setState(() {
                    _currentToInput = text;
                  });
                },
              ),
              flex: 2,
            ),
            GCWIconButton(
              iconData: Icons.add,
              onPressed: () {
                setState(() {
                  _addNewSubstitution();
                });
              },
            )
          ],
        ),
      ],
    );
  }

  _buildProjectionInput() {
    return _currentProjectionMode
      ? Column(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: GCWTextField(
                    hintText: i18n(context, 'common_distance_hint'),
                    controller: _distanceController,
                    onChanged: (text) {
                      _currentDistanceInput = text;
                    },
                  )
                ),
                Expanded(
                  flex: 1,
                  child: GCWLengthsDropDownButton(
                    value: _currentLengthUnit,
                    onChanged: (Length value) {
                      _currentLengthUnit = value;
                    }
                  )
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: GCWTextField(
                    hintText: i18n(context, 'common_bearing_hint'),
                    controller: _bearingController,
                    onChanged: (text) {
                      _currentBearingInput = text;
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GCWText(
                      text: '°'
                  ),
                ),
              ]
            )
          ],
        )
      : Container();
  }

  _buildSubstitutionList(BuildContext context) {
    var odd = true;
    var rows = _currentSubstitutions.entries.map((entry) {
      Widget output;

      var row = Container(
        child: Row (
          children: <Widget>[
            Expanded(
              child: Container(
                child: GCWText (
                  text: entry.key
                ),
                margin: EdgeInsets.only(left: 10),
              ),
              flex: 1,
            ),
            Icon(
              Icons.arrow_forward,
              color: ThemeColors.gray,
            ),
            Expanded(
              child: Container(
                child: GCWText (
                  text: entry.value
                ),
                margin: EdgeInsets.only(left: 10),
              ),
              flex: 3
            ),
            GCWIconButton(
              iconData: Icons.remove,
              onPressed: () {
                setState(() {
                  _removeSubstitution(entry.key);
                });
              },
            )
          ],
        )
      );

      if (odd) {
        output = Container(
          color: ThemeColors.oddRows,
          child: row
        );
      } else {
        output = Container(
          child: row
        );
      }
      odd = !odd;

      return output;
    }).toList();

    return Container(
      child: Column(
        children: rows
      ),
      padding: EdgeInsets.only(
        top: 10
      ),
    );
  }

  _calculateOutput(BuildContext context) {
    _currentCoordMode = GCWSwitchPosition.left;

    var coords = parseVariableLatLon(_currentInput, _currentSubstitutions, projectionData: {
      'bearing': _currentBearingInput.length == 0 ? '0' : _currentBearingInput,
      'distance': _currentDistanceInput.length == 0 ? '0' : _currentDistanceInput,
      'lengthUnitInMeters': _currentLengthUnit.inMeters,
      'ellipsoid': defaultEllipsoid()
    });

    if (coords.length == 0) {
      setState(() {
        _currentOutput = [i18n(context, 'coords_variablecoordinate_nooutputs')];
        _currentMapPoints = [];
      });
      return;
    }

    if (coords.length > MAX_COUNT_COORDINATES) {
      showAlertDialog(context, i18n(context, 'coords_variablecoordinate_alert_title'), i18n(context, 'coords_variablecoordinate_alert_text', parameters: [coords.length]), () {
        setState(() {
          _buildOutput(coords);
        });
      },);
      return;
    }

    setState(() {
      _buildOutput(coords);
    });
  }

  _formatVariables(variables) {
    return variables.entries.map((variable) => variable.key.toUpperCase() + ': ' + variable.value.toString()).join(', ');
  }

  _buildOutput(List<Map<String, dynamic>> coords) {
    var leftPaddedCoords = coords
      .where((coord) => coord['leftPadDEGCoordinate'] != null)
      .map((coord) {
        return {'coordinate': coord['leftPadDEGCoordinate'], 'variables': coord['variables']};
      })
      .toList();

    var hasLeftPaddedCoords = leftPaddedCoords.length > 0;

    _currentOutput = (_currentCoordMode == GCWSwitchPosition.left ? coords : leftPaddedCoords).map((coord) {
      return formatCoordOutput(coord['coordinate'], _currentOutputFormat, defaultEllipsoid())
        + '\n' + _formatVariables(coord['variables']);
    }).toList();

    _currentMapPoints = (_currentCoordMode == GCWSwitchPosition.left ? coords : leftPaddedCoords).map((coord) {
      return MapPoint(
        point: coord['coordinate'],
        markerText: _formatVariables(coord['variables']),
        coordinateFormat: _currentOutputFormat
      );
    }).toList();

    _output = Column(
      children: [
        hasLeftPaddedCoords
          ? GCWTwoOptionsSwitch(
              title: i18n(context, 'coords_variablecoordinate_decleftpad'),
              leftValue: i18n(context, 'coords_variablecoordinate_decleftpad_left'),
              rightValue: i18n(context, 'coords_variablecoordinate_decleftpad_right'),
              value: _currentCoordMode,
              onChanged: (value) {
                setState(() {
                  print('A');
                  _currentCoordMode = value;
                  _buildOutput(coords);
                  print(_currentCoordMode);
                });
              },
            )
          : Container(),
        GCWCoordsOutput(
          mapButtonTop: true,
          outputs: _currentOutput,
          points: _currentMapPoints
        )
      ]
    );
  }
}