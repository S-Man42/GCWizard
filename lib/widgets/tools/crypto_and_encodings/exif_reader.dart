import 'dart:typed_data';

import 'package:exif/exif.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/exif_reader.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_output.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';
import 'package:latlong/latlong.dart';

class ExifReader extends StatefulWidget {
  ExifReader({Key key}) : super(key: key);

  @override
  _ExifReaderState createState() => _ExifReaderState();
}

class _ExifReaderState extends State<ExifReader> {
  Map<String, List<List<dynamic>>> tableTags;
  PlatformFile file;
  LatLng point;
  Thumbnail thumbnail;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      GCWButton(
        text: i18n(context, 'open_file'),
        onPressed: () async {
          await readFile();
        },
      ),
      GCWText(
        text: file == null ? "" : file.path,
      ),
      ..._buildOutput(tableTags)
    ]);
  }

  Future<void> readFile() async {
    List<PlatformFile> files = await openFileExplorer(
      allowedExtensions: ['jpg', 'jpeg', 'tiff'],
    );
    if (files != null) {
      PlatformFile _file = files.first;

      Map<String, IfdTag> data = await parseExif(_file);

      Thumbnail _thumbnail = completeThumbnail(data);
      LatLng _point = completeGPSData(data);
      var _tableTags = buildTablesExif(data);

      setState(() {
        file = _file;
        tableTags = _tableTags;
        point = _point; // GPS Point
        thumbnail = _thumbnail; // Thumbnail
      });
    } else {
      // User canceled the picker
    }
  }

  static void _sortTags(List tags) {
    tags.sort((a, b) {
      return a[0].toLowerCase().compareTo(b[0].toLowerCase());
    });
  }

  List _buildOutput(Map tableTags) {
    List<Widget> widgets = [];

    decorateFile(widgets, file);
    decorateThumbnail(widgets);
    decorateGps(widgets);
    decorateExifSections(widgets, tableTags);
    return widgets;
  }

  ///
  /// Add Thumbnail section
  ///
  void decorateThumbnail(List<Widget> widgets) {
    if (thumbnail != null && thumbnail.bytes.length > 0) {
      widgets.add(GCWOutput(
        title: i18n(context, "exif_section_thumbnail"),
        child: Image.memory(thumbnail.bytes),
      ));
    }
  }

  ///
  /// Add GPS section
  ///
  void decorateGps(List<Widget> widgets) {
    if (point == null) return;

    var _currentCoordsFormat = defaultCoordFormat();
    // Map<String, String> _currentOutputFormat = {'format': keyCoordsDMM};
    List<String> _currentOutput = [
      formatCoordOutput(point, {'format': keyCoordsDMM}, defaultEllipsoid()),
    ];

    widgets.add(
      GCWCoordsOutput(
        outputs: _currentOutput,
        points: [
          GCWMapPoint(point: point, coordinateFormat: _currentCoordsFormat),
        ],
      ),
    );
  }

  ///
  /// EXIF tags grouped by section
  ///
  void decorateExifSections(List<Widget> widgets, Map<String, List<List<dynamic>>> _tableTags) {
    if (_tableTags != null) {
      _tableTags.forEach((section, tags) {
        _sortTags(tags);

        widgets.add(GCWOutput(
            title: i18n(context, "exif_section_" + section) ?? section ?? '',
            // suppressCopyButton: false,
            child: Column(
              children: columnedMultiLineOutput(
                null,
                tags == null ? [] : tags,
                // copyColumn: 1,
              ),
            )));
      });
    }
  }

  ///
  /// Section file
  ///
  void decorateFile(List<Widget> widgets, PlatformFile file) {
    if (file != null) {
      widgets.add(GCWOutput(
          title: i18n(context, "exif_section_file"),
          child: Column(
              children: columnedMultiLineOutput(
            null,
            [
              ["name", file.name],
              ["path", file.path],
              ["size", file.size],
              ["extension", file.extension]
            ],
          ))));
    }
  }
}

class Thumbnail {
  Uint8List bytes;
  Thumbnail(this.bytes);
}
