import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_mapview.dart';

class GCWCoordsOutput extends StatefulWidget {
  final String text;
  final List<MapPoint> points;
  final List<MapGeodetic> geodetics;
  final List<MapCircle> circles;

  const GCWCoordsOutput({Key key, this.text, this.points: const [], this.geodetics: const [], this.circles: const []}) : super(key: key);

  @override
  _GCWCoordsOutputState createState() => _GCWCoordsOutputState();
}

class _GCWCoordsOutputState extends State<GCWCoordsOutput> {

  @override
  Widget build(BuildContext context) {
    return Column (
      children: <Widget>[
        GCWDefaultOutput(
          text: widget.text
        ),
        Visibility (
          visible: widget.text != null && widget.text != '',
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
        ),
      ]
    );
  }
}
