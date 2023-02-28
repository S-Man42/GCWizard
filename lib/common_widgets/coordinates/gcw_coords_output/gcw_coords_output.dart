import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/coordinates/gcw_coords_export_dialog.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/gcw_toolbar.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_multiple_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/map_view/logic/map_geometries.dart';
import 'package:gc_wizard/tools/coords/map_view/widget/gcw_mapview.dart';

class GCWCoordsOutput extends StatefulWidget {
  final List<BaseCoordinate> outputs;
  final List<String>? copyTexts;
  List<GCWMapPoint> points;
  List<GCWMapPolyline>? polylines;
  final bool? mapButtonTop;
  final String? title;

  GCWCoordsOutput(
      {Key? key, required this.outputs, this.copyTexts, required this.points, this.polylines, this.mapButtonTop = false, this.title})
      : super(key: key) {
    if (polylines == null) polylines = [];
  }

  @override
  _GCWCoordsOutputState createState() => _GCWCoordsOutputState();
}

class _GCWCoordsOutputState extends State<GCWCoordsOutput> {
  @override
  Widget build(BuildContext context) {
    var children = widget.outputs
        .where((BaseCoordinate element) => element.toLatLng() != null)
        .toList()
        .asMap()
        .map((index, output) {
          return MapEntry(
              index,
              Container(
                child: GCWOutput(
                  child: output.toString(),
                  copyText:
                      widget.copyTexts != null && widget.copyTexts!.length > index ? widget.copyTexts![index] : null,
                ),
                padding: EdgeInsets.only(bottom: 15),
              ));
        })
        .values
        .toList();
    var _outputText = Column(
      children: children,
    );

    var _hasOutput = widget.outputs.isNotEmpty && widget.points.isNotEmpty;
    var _button = Visibility(
        visible: _hasOutput,
        child: GCWToolBar(
          children: [
            GCWButton(
              text: i18n(context, 'coords_show_on_map'),
              onPressed: () {
                _openInMap();
              },
            ),
            GCWButton(
              text: i18n(context, 'coords_show_on_openmap'),
              onPressed: () {
                _openInMap(freeMap: true);
              },
            )
          ],
        ));

    var _children = widget.mapButtonTop! ? [_button, _outputText] : [_outputText, _button];

    return GCWMultipleOutput(
        title: widget.title,
        children: _children,
        trailing: GCWIconButton(
          icon: Icons.save,
          size: IconButtonSize.SMALL,
          iconColor: _hasOutput ? null : themeColors().inActive(),
          onPressed: () {
            if (_hasOutput)
              _exportCoordinates(context, widget.points, widget.polylines!);
          },
        ));
  }

  void _openInMap({bool freeMap = false}) {
    if (freeMap) {
      widget.points.forEach((point) {
        point.isEditable = true;
      });
    }

    Navigator.push(
        context,
        MaterialPageRoute<GCWTool>(
            builder: (context) => GCWTool(
                tool: GCWMapView(
                  points: List<GCWMapPoint>.from(widget.points),
                  polylines: List<GCWMapPolyline>.from(widget.polylines!),
                  isEditable: freeMap,
                ),
                id: freeMap ? 'coords_openmap' : 'coords_map_view',
                autoScroll: false,
                suppressToolMargin: true)));
  }

  Future<void> _exportCoordinates(
      BuildContext context, List<GCWMapPoint> points, List<GCWMapPolyline> polylines) async {
    showCoordinatesExportDialog(context, points, polylines);
  }
}
