import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_outputformat.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class FormatOverview extends StatefulWidget {
  @override
  FormatOverviewState createState() => FormatOverviewState();
}

class FormatOverviewState extends State<FormatOverview> {
  var _currentCoords = defaultCoordinate;

  var _currentCoordsFormat = defaultCoordFormat();

  Map<String, String> _currentOutputFormat = {'format': keyCoordsDEC};
  Widget _currentOutput = GCWDefaultOutput();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWCoords(
          title: i18n(context, 'coords_formatconverter_coord'),
          coordsFormat: _currentCoordsFormat,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat = ret['coordsFormat'];
              _currentCoords = ret['value'];
            });
          },
        ),
        GCWSubmitButton(
          onPressed: () {
            setState(() {
              _calculateOutput(context);
            });
          },
        ),
        _currentOutput
      ],
    );
  }

  _calculateOutput(BuildContext context) {
    var children = <List<Widget>>[];
    var ellipsoid= defaultEllipsoid();

    allCoordFormats.forEach((coordFormat) {

      try { // exception, when we have a type with a undefinied subtype
        var outputFormat = Map<String, String>();
        outputFormat.addAll({'format': coordFormat.key});

        switch (coordFormat.key) {
          case keyCoordsLambert:
            outputFormat.addAll({'subtype': keyCoordsLambert93});
            break;
          case keyCoordsGaussKrueger:
            outputFormat.addAll({'subtype': keyCoordsGaussKruegerGK1});
            break;
          case keyCoordsSlippyMap:
            outputFormat.addAll({'subtype': '10'});
            break;
        }
        children.add(columnedMultiLineOutput(
            context, [[coordFormat.name, formatCoordOutput(_currentCoords, outputFormat, ellipsoid)]]));
      } catch(e){};
    });

    _currentOutput = GCWDefaultOutput(
      child: Column(children: columnedMultiLineOutput(context, [children]))
    );
  }
}
