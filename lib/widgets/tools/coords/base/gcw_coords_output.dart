import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_mapview.dart';
import 'package:gc_wizard/logic/tools/coords/export/export.dart' as coodinatesExport;

class GCWCoordsOutput extends StatefulWidget {
  final List<dynamic> outputs;
  final List<MapPoint> points;
  final List<MapGeodetic> geodetics;
  final List<MapCircle> circles;
  final bool mapButtonTop;
  final Function onExportCoordinates;

  const GCWCoordsOutput({
    Key key,
    this.outputs,
    this.points: const [],
    this.geodetics: const [],
    this.circles: const [],
    this.mapButtonTop: false,
    this.onExportCoordinates
  }) : super(key: key);

  @override
  _GCWCoordsOutputState createState() => _GCWCoordsOutputState();

  Future<bool> exportCoordinates(BuildContext context, String name, List<MapPoint> points, {bool kmlFormat = false}) async {
    //var value = await exportCoordinates(name, points, kmlFormat : kmlFormat);
    Map<String, dynamic> value;
    var startOutput = false;
    var kmlFormat = false;


    showGCWDialog(
        context,
        i18n(context, 'coords_export_saved'),
        i18n(context, 'coords_export_saved'),
        [
          /*GCWDialogButton(
            text: i18n(context, 'GPX'),
            onPressed: () async {
              value = await coodinatesExport.exportCoordinates(name, points);
              //startOutput = true;
              //kmlFormat = false;
            },
          ),*/
          GCWDialogButton(
            text: i18n(context, 'KML'),
            onPressed: () async {
              value = await coodinatesExport.exportCoordinates(
                  name, points, kmlFormat: true);
              //startOutput = true;
              //kmlFormat = true;
            },
          )
        ]);
  }
        /*
          startOutput ?
            value == null ?
              showToast(i18n(context, 'coords_export_nowritepermission'));
              return false;
            :

            showFilePath(Map<String, dynamic> value)
            showGCWDialog(
              context,
              i18n(context, 'coords_export_saved'),
                Column(
                children: [
                  GCWText(
                    text: i18n(context, 'coords_export_savedpath', parameters: [value['path']]),
                      style: gcwTextStyle().copyWith(color: themeColors().dialogText()),
            ),
            ],
            ),
            [
            GCWDialogButton(
            text: i18n(context, 'common_ok'),
            )
            ],
            cancelButton: false
            );
              :
          Container()

           */




}

/*
    if (value == null) {
      showToast(i18n(context, 'coords_export_nowritepermission'));
      return false;
    }

    showFilePath(Map<String, dynamic> value)
    showGCWDialog(
      context,
      i18n(context, 'coords_export_saved'),
      Column(
        children: [
          GCWText(
            text: i18n(context, 'coords_export_savedpath', parameters: [value['path']]),
            style: gcwTextStyle().copyWith(color: themeColors().dialogText()),
          ),
        ],
      ),
      [
        GCWDialogButton(
          text: i18n(context, 'common_ok'),
        )
      ],
      cancelButton: false
    );
}*/

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

    var _button = Visibility (
      visible: widget.outputs != null && widget.outputs.length > 0 && widget.points.length > 0,
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

    return GCWMultipleOutput(
      children: _children,
      showExportButton: true,
      onExportCoordinates: () {
        widget.onExportCoordinates();
      },
    );
  }
}
