import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_export_dialog.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_mapview.dart';

class GCWCoordsOutput extends StatefulWidget {
  final List<dynamic> outputs;
  final List<GCWMapPoint> points;
  final List<GCWMapGeodetic> geodetics;
  final List<GCWMapCircle> circles;
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
        iconColor: _isNoOutput ? Colors.grey : null,
        onPressed: () { _isNoOutput ? null : _exportCoordinates(context, widget.points, widget.geodetics, widget.circles);
        },
      )
    );
  }

  Future<bool> _exportCoordinates(BuildContext context, List<GCWMapPoint> points, List<GCWMapGeodetic> geodetics, List<GCWMapCircle> circles) async {
    // showCoordinatesExportDialog(context, points, geodetics, circles);
  }
}
