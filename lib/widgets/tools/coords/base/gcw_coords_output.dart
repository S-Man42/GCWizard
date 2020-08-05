import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_mapview.dart';

class GCWCoordsOutput extends StatefulWidget {
  final List<String> outputs;
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
        child: GCWOutputText(
          text: output
        ),
        padding: EdgeInsets.only(bottom: 15),
      );
    }).toList();
    var _outputText = Column(
      children: children,
    );

    var _button = Visibility (
      visible: widget.outputs != null && widget.points.length > 0,
      child: GCWButton (
        text: i18n(context, 'coords_show_on_map'),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => GCWToolWidget(
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

    return GCWOutput(
      child: Column(
        children: _children,
      ),
    );
  }
}
