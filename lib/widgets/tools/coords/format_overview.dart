import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/converter/slippy_map.dart';
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
    var children = <List<String>>[];
    var ellipsoid= defaultEllipsoid();

    allCoordFormats.forEach((coordFormat) {

      try { // exception, when we have a type with a undefinied subtype
        var outputFormat = Map<String, String>();
        String name = coordFormat.name;
        outputFormat.addAll({'format': coordFormat.key});

        switch (coordFormat.key) {
          case keyCoordsLambert:
            outputFormat.addAll({'subtype': getLambertKey()});
            name =  i18n(context, coordFormat.name);
            name += '\n' + i18n(context, coordFormat.subtypes
                .firstWhere((element) => element.key == getLambertKey()).name);
            break;
          case keyCoordsGaussKrueger:
            outputFormat.addAll({'subtype': getGaussKruegerTypKey()});
            name =  i18n(context, coordFormat.name);
            name += '\n' + i18n(context, coordFormat.subtypes
                .firstWhere((element) => element.key == getGaussKruegerTypKey()).name);
            break;
          case keyCoordsSlippyMap:
            outputFormat.addAll({'subtype': DefaultSlippyZoom.toString()});
            break;
        }

        children.add([name, formatCoordOutput(_currentCoords, outputFormat, ellipsoid)]);
      } catch(e){};
    });

    _currentOutput = GCWDefaultOutput(
      child: Column(children: columnedMultiLineOutput(context, children))
    );
  }
}
