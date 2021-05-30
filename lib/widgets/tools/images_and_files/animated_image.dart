import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_divider.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_gallery.dart';
import 'package:gc_wizard/widgets/common/gcw_imageview.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/images_and_files/animated_image.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_async_executer.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart';
import 'package:intl/intl.dart';

class AnimatedImage extends StatefulWidget {
  final PlatformFile platformFile;

  const AnimatedImage({Key key, this.platformFile}) : super(key: key);

  @override
  AnimatedImageState createState() => AnimatedImageState();
}

class AnimatedImageState extends State<AnimatedImage> {
  Map<String, dynamic> _outData;
  PlatformFile _platformFile;
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;
  bool _play = false;
  static var allowedExtensions = ['gif', 'png', 'webp'];

  @override
  Widget build(BuildContext context) {
    if (widget.platformFile != null) {
      _platformFile = widget.platformFile;
      _analysePlatformFileAsync();
    }

    return Column(children: <Widget>[
      GCWButton(
          text: i18n(context, 'common_exportfile_openfile'),
          onPressed: () {
            setState(() {
              openFileExplorer(context, allowedExtensions: allowedExtensions).then((file) {
                if (file != null) {
                  _platformFile = file;
                  _analysePlatformFileAsync();
                }
                ;
              });
            });
          }),
      GCWText(
        text: _outData == null ? "" : _platformFile.name,
      ),
      GCWDefaultOutput(
          child: _buildOutput(),
          trailing: Row(children: <Widget>[
            GCWIconButton(
              iconData: Icons.play_arrow,
              size: IconButtonSize.SMALL,
              iconColor: _outData != null && !_play ? null : Colors.grey,
              onPressed: () {
                setState(() {
                  _play = (_outData != null);
                });
              },
            ),
            GCWIconButton(
              iconData: Icons.stop,
              size: IconButtonSize.SMALL,
              iconColor: _play ? null : Colors.grey,
              onPressed: () {
                setState(() {
                  _play = false;
                });
              },
            ),
            GCWIconButton(
              iconData: Icons.save,
              size: IconButtonSize.SMALL,
              iconColor: _outData == null ? Colors.grey : null,
              onPressed: () {
                _outData == null ? null : _exportFiles(context, _platformFile.name, _outData["images"]);
              },
            )
          ]))
    ]);
  }

  _buildOutput() {
    if (_outData == null) return null;

    var durations = <List<dynamic>>[];
    if (_outData["durations"] != null && _outData["durations"]?.length > 1) {
      var counter = 0;
      durations.addAll([
        [i18n(context, 'animated_image_table_index'), i18n(context, 'animated_image_table_duration')]
      ]);
      _outData["durations"].forEach((value) {
        counter++;
        durations.addAll([
          [counter, value]
        ]);
      });
    }
    ;

    return Column(children: <Widget>[
      _play
          ? Image.memory(_platformFile.bytes)
          : GCWGallery(imageData: _convertImageData(_outData["images"], _outData["durations"])),
      _buildDurationOutput(durations)
    ]);
  }

  Widget _buildDurationOutput(List<List<dynamic>> durations) {
    if (durations == null) return Container();

    return Column(children: <Widget>[
      GCWDivider(),
      GCWOutput(
        child: Column(children: columnedMultiLineOutput(context, durations, flexValues: [1, 2], hasHeader: true, copyAll: true)),
      )
    ]);
  }

  List<GCWImageViewData> _convertImageData(List<Uint8List> images, List<int> durations) {
    var list = <GCWImageViewData>[];

    if (images != null) {
      var imageCount = images.length;
      for (var i = 0; i < images.length; i++) {
        String description = (i + 1).toString() + '/$imageCount';
        if ((durations != null) && (i < durations.length)) {
          description += ': ' + durations[i].toString() + ' ms';
        }
        list.add(GCWImageViewData(images[i], description: description));
      }
      ;
    }
    ;
    return list;
  }

  _analysePlatformFileAsync() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            child: GCWAsyncExecuter(
              isolatedFunction: analyseImageAsync,
              parameter: _buildJobData(),
              onReady: (data) => _showOutput(data),
              isOverlay: true,
            ),
            height: 220,
            width: 150,
          ),
        );
      },
    );
  }

  Future<GCWAsyncExecuterParameters> _buildJobData() async {
    return GCWAsyncExecuterParameters(_platformFile.bytes);
  }

  _showOutput(Map<String, dynamic> output) {
    _outData = output;

    // restore image references (problem with sendPort, lose references)
    if (_outData != null) {
      List<Uint8List> images = _outData["images"];
      List<int> linkList = _outData["linkList"];
      for (int i = 0; i < images.length; i++) {
        images[i] = images[linkList[i]];
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  _exportFiles(BuildContext context, String fileName, List<Uint8List> data) async {
    createZipFile(fileName, data).then((bytes) async {
      var fileType = '.zip';
      var value = await saveByteDataToFile(bytes.buffer.asByteData(),
          'animatedimage_export_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + fileType);

      if (value != null) showExportedFileDialog(context, value['path'], fileType: fileType);
    });
  }
}
