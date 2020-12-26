import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/export/export.dart' as coordinatesExport;
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_mapview.dart';


class GCWCoordsOutput extends StatefulWidget {
  final List<dynamic> outputs;
  final List<MapPoint> points;
  final List<MapGeodetic> geodetics;
  final List<MapCircle> circles;
  final bool mapButtonTop;

  const GCWCoordsOutput({
    Key key,
    this.outputs,
    this.points: const [],
    this.geodetics: const [],
    this.circles: const [],
    this.mapButtonTop: false
  }) : super(key: key);

  @override
  _GCWCoordsOutputState createState() => _GCWCoordsOutputState();
}


class _GCWCoordsOutputState extends State<GCWCoordsOutput> {

  @override
  Widget build(BuildContext context) {
    var children = widget.outputs.map((output) {
      return Container(
        child: GCWOutput(
          child: output,
        ),
        padding: EdgeInsets.only(bottom: 15),
      );
    }).toList();
    var _outputText = Column(
      children: children,
    );

    var _isNoOutput = widget.outputs == null || widget.outputs.length == 0 || widget.points.length == 0 ;
    var _button = Visibility (
      visible: !_isNoOutput,
      child: GCWButton (
        text: i18n(context, 'coords_show_on_map'),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => GCWTool (
            tool: GCWMapView(
              points: widget.points,
              geodetics: widget.geodetics,
              circles: widget.circles,
            ),
            toolName: i18n(context, 'coords_map_view_title'),
            autoScroll: false,
          )));
        },
      )
    );

    var _children = widget.mapButtonTop ? [_button, _outputText] : [_outputText, _button];
    return GCWMultipleOutput(
      children: _children,
      trailing: GCWIconButton(
        iconData: Icons.save,
        size: IconButtonSize.SMALL,
        color: _isNoOutput ? Colors.grey : null,
        onPressed: () { _isNoOutput ? null : _exportCoordinates(context, 'GC Wizard Export ' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()), widget.points, widget.geodetics, widget.circles);
        },
      )
    );
  }

  Future<bool> _exportCoordinates(BuildContext context, String name, List<MapPoint> points, List<MapGeodetic> geodetics, List<MapCircle> circles) async {
    showGCWDialog(
        context,
        i18n(context, 'coords_export_saved'),
          Text(i18n(context, 'coords_export_fileformat'),
        ),
        [
          GCWDialogButton(
            text: 'GPX',
            onPressed: () async {
              coordinatesExport.exportCoordinates(name, points, geodetics, circles).then((value) {
                _showExportedFileDialog(value, '.gpx');
              });
            },
          ),
          GCWDialogButton(
            text: 'KML',
            onPressed: () async {
              coordinatesExport.exportCoordinates(name, points, geodetics, circles, kmlFormat: true).then((value) {
                _showExportedFileDialog(value, '.kml');
              });
            },
          )
        ]
    );
  }

  _showExportedFileDialog(Map<String, dynamic> value, String type) {
    if (value != null)
      showExportedFileDialog(
          context,
          value['path'],
          fileType: type
      );
  }
}
