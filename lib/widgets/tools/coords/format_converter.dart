import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords_output.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords_outputformat.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/common/coords/utils.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';

class FormatConverter extends StatefulWidget {
  @override
  FormatConverterState createState() => FormatConverterState();
}

class FormatConverterState extends State<FormatConverter> {
  var _currentCoords = defaultCoordinate;

  var _currentCoordsFormat = defaultCoordFormat();

  var _currentOutputFormat = keyCoordsDEC;
  var _currentOutput = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWCoords(
          text: i18n(context, 'coords_formatconverter_coord'),
          coordsFormat: _currentCoordsFormat,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat = ret['coordsFormat'];
              _currentCoords = ret['value'];
            });
          },
        ),
        GCWCoordsOutputFormat(
          coordFormat: _currentOutputFormat,
          onChanged: (value) {
            setState(() {
              _currentOutputFormat = value;
            });
          },
        ),
        GCWSubmitFlatButton(
          onPressed: () {
            setState(() {
              _calculateOutput(context);
            });
          },
        ),
        GCWCoordsOutput(
          text: _currentOutput,
          points: [
            MapPoint(
              point: _currentCoords,
            ),
          ],
        ),
      ],
    );
  }

  _calculateOutput(BuildContext context) {
    _currentOutput = formatCoordOutput(_currentCoords, _currentOutputFormat, defaultEllipsoid());
  }
}