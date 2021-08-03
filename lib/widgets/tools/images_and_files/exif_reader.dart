import 'dart:io';
import 'dart:typed_data';

import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/logic/tools/images_and_files/exif_reader.dart';
import 'package:gc_wizard/logic/tools/images_and_files/hidden_data.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_imageview.dart';
import 'package:gc_wizard/widgets/common/gcw_openfile.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_output.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/tools/images_and_files/hexstring2file.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart' as local;
import 'package:image/image.dart' as Image;
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class ExifReader extends StatefulWidget {
  final local.PlatformFile file;

  ExifReader({Key key, this.file}) : super(key: key);

  @override
  _ExifReaderState createState() => _ExifReaderState();
}

class _ExifReaderState extends State<ExifReader> {
  Map<String, List<List<dynamic>>> tableTags;
  local.PlatformFile file;
  LatLng point;
  GCWImageViewData thumbnail;
  Image.Image image;

  @override
  initState() {
    super.initState();
    file = widget.file;
    _readFile(file);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GCWOpenFile(
          expanded: widget.file == null,
          supportedFileTypes: SUPPORTED_IMAGE_TYPES,
          onLoaded: (_file) {
            if (_file == null) return;

            _readFile(_file);
          },
        ),
        Container(),
        ..._buildOutput(tableTags)
      ],
    );
  }

  Future<void> _readFile(local.PlatformFile _file) async {
    if (_file == null) return;

    Map<String, IfdTag> tags = await parseExif(_file);
    GCWImageViewData _thumbnail;
    LatLng _point;
    Map _tableTags;
    Image.Image _image;

    try {
      if (tags != null) {
        _thumbnail = completeThumbnail(tags);
        _point = completeGPSData(tags);
        _tableTags = buildTablesExif(tags);
      }

      _image = await _completeImageMetadata(_file);

      setState(() {
        file = _file;
        tableTags = _tableTags;
        point = _point; // GPS Point
        thumbnail = _thumbnail; // Thumbnail
        image = _image;
      });
    } catch (e) {
      // An error occured, but keep it silently to not pollute UI
    }
  }

  List _buildOutput(Map _tableTags) {
    List<Widget> widgets = [];
    _decorateThumbnail(widgets);
    _decorateFile(widgets, file);
    _decorateImage(widgets, image);
    _decorateGps(widgets);
    _decorateExifSections(widgets, _tableTags);
    _decorateExtraData(widgets);
    return widgets;
  }

  ///
  /// Add Thumbnail section
  ///
  void _decorateThumbnail(List<Widget> widgets) {
    if (thumbnail != null && thumbnail.bytes.length > 0) {
      widgets.add(GCWOutput(
        title: i18n(context, "exif_section_thumbnail"),
        child: GCWImageView(imageData: thumbnail),
        //suppressCopyButton: false,
      ));
    }
  }

  ///
  /// Add GPS section
  ///
  void _decorateGps(List<Widget> widgets) {
    if (point == null) return;

    var _currentCoordsFormat = defaultCoordFormat();
    // Map<String, String> _currentOutputFormat = {'format': keyCoordsDMM};
    List<String> _currentOutput = [
      formatCoordOutput(point, {'format': keyCoordsDMM}, defaultEllipsoid()),
    ];

    widgets.add(
      GCWCoordsOutput(
        title: i18n(context, 'exif_gpscoordinates'),
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
  void _decorateExifSections(List<Widget> widgets, Map<String, List<List<dynamic>>> _tableTags) {
    if (_tableTags != null) {
      _tableTags.forEach((section, tags) {
        widgets.add(GCWOutput(
            title: i18n(context, "exif_section_" + section) ?? section ?? '',
            child: Column(
              children: columnedMultiLineOutput(
                context,
                tags == null ? [] : tags,
              ),
            )));
      });
    }
  }

  ///
  /// Section file
  ///
  void _decorateFile(List<Widget> widgets, local.PlatformFile platformFile) {
    if (platformFile != null) {
      File _file;
      if (platformFile.path != null) {
        _file = File(platformFile.path);
      }

      var lastModified;
      try {
        lastModified = formatDate(_file?.lastModifiedSync());
      } catch (e) {}

      var lastAccessed;
      try {
        lastAccessed = formatDate(_file?.lastAccessedSync());
      } catch (e) {}

      widgets.add(GCWOutput(
          title: i18n(context, "exif_section_file"),
          child: Column(
              children: columnedMultiLineOutput(
            context,
            [
              [i18n(context, 'exif_filename'), platformFile.name ?? ''],
              [i18n(context, 'exif_path'), platformFile.path ?? ''],
              [i18n(context, 'exif_filesize_bytes'), platformFile.bytes?.length ?? 0],
              [i18n(context, 'exif_filesize_kb'), (platformFile.bytes?.length / 1024).ceil() ?? 0],
              lastModified != null ? ["lastModified", formatDate(_file?.lastModifiedSync())] : null,
              lastAccessed != null ? ["lastAccessed", formatDate(_file?.lastAccessedSync())] : null,
              [i18n(context, 'exif_extension'), platformFile.extension ?? '']
            ],
          ))));
    }
  }

  void _decorateImage(List<Widget> widgets, Image.Image image) {
    if (image != null) {
      widgets.add(GCWOutput(
          title: i18n(context, "exif_section_image"),
          child: Column(
              children: columnedMultiLineOutput(
            context,
            [
              [i18n(context, 'exif_width'), image.width ?? ''],
              [i18n(context, 'exif_height'), image.height ?? ''],
              ['Blend Method', image.blendMethod ?? ''],
              ['Channels', image.channels ?? ''],
              ['ICC Color Profile', image.iccProfile ?? ''],
              // Only for frames within an animation
              // [i18n(context, 'exif_duration'), image.duration ?? ''],
              // ['Offset X', image.xOffset ?? ''],
              // ['Offset Y', image.yOffset ?? ''],
              // image.exif
            ],
          ))));
    }
  }

  Future<Image.Image> _completeImageMetadata(local.PlatformFile platformFile) async {
    Uint8List data = platformFile.bytes;
    Image.Image image;
    try {
      image = Image.decodeImage(data);
    } catch (e) {
      // Silent error
    }
    return image;
  }

  String formatDate(DateTime datetime) {
    String loc = Localizations.localeOf(context).toString();
    return (datetime == null) ? '' : DateFormat.yMd(loc).add_jms().format(datetime);
  }

  ///
  /// Section extra data
  ///
  void _decorateExtraData(List<Widget> widgets) {
    if (file == null) return;
    var _extraData = extraData(file.bytes);

      widgets.add(GCWOutput(
        title: i18n(context, "exif_section_extra_data"),
        child: hexDataOutput(context, _extraData),
        trailing: GCWIconButton(
          iconData: Icons.save,
          size: IconButtonSize.SMALL,
          iconColor: _extraData == null ? Colors.grey : null,
          onPressed: () {
            _extraData == null ? null : _exportFile(context, _extraData?.first);
          },
        ))
      );
  }

  _exportFile(BuildContext context, Uint8List data) async {
    var fileType = getFileType(data);
    var value = await saveByteDataToFile(data.buffer.asByteData(),
        "extra_data_" + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '.' + fileExtension(fileType));

    if (value != null) showExportedFileDialog(context, value['path'], fileType: fileType);
  }
}
