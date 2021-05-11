import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';
import 'package:image/image.dart' as imageData;
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/animated_gif.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_async_executer.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_symbol_container.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';


class AnimatedGif extends StatefulWidget {
  final PlatformFile platformFile;

  const AnimatedGif({Key key, this.platformFile})
      : super(key: key);

  @override
  AnimatedGifState createState() => AnimatedGifState();
}

class AnimatedGifState extends State<AnimatedGif> {
  Map<String, dynamic> _outData;
  PlatformFile _platformFile;
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;
  bool _play = false;

  @override
  Widget build(BuildContext context) {
    if (widget.platformFile != null) {
      _platformFile = widget.platformFile;
      _analysePlatformFileAsync();
      //_analystePlatformFile(_platformFile);
    }

    return Column(
      children: <Widget>[
        GCWButton(
          text: i18n(context, 'common_exportfile_openfile'),
          onPressed: () {
            setState(() {
              openFileExplorer().then((files) { //pickingType : FileType.image
                if (files != null && files.length > 0) {
                  getFileData(files.first).then((bytes) {
                    _platformFile = new PlatformFile(path: files.first.path, name: files.first.name, bytes: bytes);
                    //_analystePlatformFile(_platformFile);
                    _analysePlatformFileAsync();
                  });
                };
              });
            });
          }
        ),
        GCWText(
          text: _outData == null ? "" : _platformFile.name,
        ),
        GCWDefaultOutput(child: _buildOutput(),
          trailing: Row (
              children: <Widget>[
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
                    _outData == null ? null : _exportFiles(context,_platformFile.name, _outData["images"]);
                  },
                )
              ]
        )
        )
      ]
    );
  }

  _buildOutput() {

    if (_outData == null)
      return null;

    var durations = "";
    if (_outData["durations"] != null && _outData["durations"]?.length> 1)
      durations = _outData["durations"].map((value) => value.toString() + 'ms').join(", ");

    double height;
    if (_outData["animation"]?.width <= MediaQuery.of(context).size.width )
      height = _outData["animation"]?.height.toDouble();
    else
      height = MediaQuery.of(context).size.width * _outData["animation"]?.height / _outData["animation"]?.width;

      return Column(
      children: <Widget>[
         Container(
          child : _play ?
            Image.memory(_platformFile.bytes)
            :
            Swiper(
                itemCount:  _outData["animation"]?.numFrames,
                itemBuilder: (BuildContext context, int index) {
                  return Image.memory(_outData["images"][index]);
                },
                control: SwiperControl(),
                pagination: FractionPaginationBuilder(),
              ),

            height: height,
        ),
        durations != null
          ? GCWOutput(
              title: "durations",
              copyText: durations,
              child: GCWOutputText(text: durations)
            )
          : Container()
    ]);
  }

  _analystePlatformFile(PlatformFile platformFile) {
    analyseGif(platformFile.bytes).then((output) {
      setState(() {
        _outData = output;
      });
    });
  }

  _analysePlatformFileAsync() async {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: Container(
              child: GCWAsyncExecuter(
                isolatedFunction: analyseGifAsync,
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  _exportFiles(BuildContext context, String fileName, List<Uint8List> data) async {
    createZipFile(fileName, data).then((bytes) async {
      var fileType = '.zip';
      var value = await saveByteDataToFile(
          bytes.buffer.asByteData(), DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + fileType); //, subDirectory: "hexstring_export"

      if (value != null) showExportedFileDialog(context, value['path'], fileType: fileType);
    });
  }
}
