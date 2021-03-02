import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/export/export.dart' as coordinatesExport;
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_map_geometries.dart';
import 'package:intl/intl.dart';

showCoordinatesExportDialog(BuildContext context, List<GCWMapPoint> points, List<GCWMapPolyline> polylines, {String json}) {
  var fileName = 'GC Wizard Export ' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());

  showGCWDialog(
    context,
    i18n(context, 'coords_export_saved'),
    Text(i18n(context, 'coords_export_fileformat')),
    [
      json != null  ?
        GCWDialogButton(
          text: 'JSON',
          onPressed: () async {
            coordinatesExport.exportCoordinates(fileName, null, null, json : json)
                .then((value) {
              _showExportedFileDialog(context, value, '.json');
            });
          },
        )
      : null,
      GCWDialogButton(
        text: 'GPX',
        onPressed: () async {
          coordinatesExport.exportCoordinates(fileName, points, polylines)
            .then((value) {
              _showExportedFileDialog(context, value, '.gpx');
            });
        },
      ),
      GCWDialogButton(
        text: 'KML',
        onPressed: () async {
          coordinatesExport.exportCoordinates(fileName, points, polylines, kmlFormat: true)
            .then((value) {
              _showExportedFileDialog(context, value, '.kml');
            });
        },
      )
    ]
  );
}

_showExportedFileDialog(BuildContext context, Map<String, dynamic> value, String type) {
  if (value != null)
    showExportedFileDialog(
      context,
      value['path'],
      fileType: type
    );
}