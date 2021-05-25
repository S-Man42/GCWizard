import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart';
import 'package:tuple/tuple.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_gallery_checkbox.dart';
import 'package:gc_wizard/widgets/common/gcw_imageview.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/images_and_files/animated_image_morse_code.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_async_executer.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';
import 'package:intl/intl.dart';


class AnimatedImageMorseCode extends StatefulWidget {
  final PlatformFile platformFile;

  const AnimatedImageMorseCode({Key key, this.platformFile})
      : super(key: key);

  @override
  AnimatedImageMorseCodeState createState() => AnimatedImageMorseCodeState();
}

class AnimatedImageMorseCodeState extends State<AnimatedImageMorseCode> {
  Map<String, dynamic> _outData;
  var _marked = <bool>[];
  Map<String, dynamic> _outText;
  PlatformFile _platformFile;
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;
  bool _play = false;
  bool _filtered = true;
  var _allowedExtensions = ['.gif', '.png', '.webp'];

  Uint8List _highImage;
  Uint8List _lowImage;
  String _currentInput = '';
  int _currentDitDuration = 400;
  TextEditingController _currentDitDurationController;
  TextEditingController _currentInputController;
  Uint8List _encodeOutputImage;

  @override
  void initState() {
    super.initState();

    _currentInputController = TextEditingController(text: _currentInput);
    _currentDitDurationController = TextEditingController(text: _currentDitDuration.toString());
  }

  @override
  void dispose() {
    _currentInputController.dispose();
    _currentDitDurationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.platformFile != null) {
      _platformFile = widget.platformFile;
      _analysePlatformFileAsync();
    }

    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.right ?
          _decodeWidgets()
        :
          _encodeWidgets()
      ]
    );
  }

  Widget _decodeWidgets() {
    return Column(
      children: <Widget>[
        GCWButton(
          text: i18n(context, 'common_exportfile_openfile'),
          onPressed: () {
            setState(() {
              openFileExplorer(context, allowedExtensions: _allowedExtensions).then((file) {
                if (file != null) {
                  _platformFile = file;
                  _outData = null;
                  _outText = null;
                  _analysePlatformFileAsync();
                };
              });
            });
          }
        ),
      GCWText(
        text: _outData == null ? "" : _platformFile.name,
      ),
      GCWDefaultOutput(child: _buildOutputDecode(),
        trailing: Row (
            children: <Widget>[
              GCWIconButton(
                iconData: _filtered ? Icons.filter_alt :Icons.filter_alt_outlined,
                size: IconButtonSize.SMALL,
                iconColor: _outData != null ? null : Colors.grey,
                onPressed: () {
                  setState(() {
                    _filtered = !_filtered;
                  });
                },
              ),
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

  Widget _buildOutputDecode() {
    if (_outData == null)
      return null;

    var durations = <List<dynamic>>[];
    if (_outData["durations"] != null && _outData["durations"]?.length > 1) {
      var counter = 0;
      durations.addAll([[i18n(context, 'animated_image_morse_code_table_index'), i18n(context, 'animated_image_morse_code_table_duration')]]);
      _outData["durations"].forEach((value) {
        counter++;
        durations.addAll([[counter, value]]);
      });
    };

    return Column(
        children: <Widget>[
          _play
              ?
          Image.memory(_platformFile.bytes)
              :
          _filtered
              ?
          GCWGalleryCheckbox(
            imageData: _convertImageDataFiltered(_outData["images"], _outData["durations"], _outData["imagesFiltered"]),
            onDoubleTap: (index) {
              setState(() {
                List<List<int>> imagesFiltered = _outData["imagesFiltered"];

                _marked[imagesFiltered[index].first] = !_marked[imagesFiltered[index].first];
                _markedListSetColumn (index, _marked[imagesFiltered[index].first], imagesFiltered);
                _outText = decodeMorseCode(_outData["durations"], _marked);
              });
            },
          )
              :
          GCWGalleryCheckbox(
            imageData: _convertImageData(_outData["images"], _outData["durations"], _outData["imagesFiltered"]),
            onDoubleTap: (index) {
              setState(() {
                if (_marked != null && index < _marked.length)
                  _marked[index] = !_marked[index];
                _outText = decodeMorseCode(_outData["durations"], _marked);
              });
            },
          ),

          _buildDurationOutput(durations)
        ]);
  }

  Widget _buildDurationOutput(List<List<dynamic>> durations) {
    if (durations == null)
      return Container();

    return Column(
        children: <Widget>[
          GCWDefaultOutput( child: GCWOutputText(text: _outText == null ? "" : _outText["text"])),
          GCWOutput(title: "Morse-Code", child: GCWOutputText(text: _outText == null ? "" : _outText["morse"])),
        ]);
  }

  Widget _encodeWidgets() {
    return Column(children: [
      Row(children: [
        Expanded(child: GCWTextDivider(text: "High Signal")),
        Expanded(child: GCWTextDivider(text: "Low Signal")),
      ]),
      Row(children: [
        Expanded(child:
          Column(children: [
            GCWButton(
              text: i18n(context, 'common_exportfile_openfile'),
              onPressed: () {
                openFileExplorer(context, allowedExtensions: _allowedExtensions).then((file) {
                  setState(() {
                    if (file != null) {
                      _highImage = file.bytes;
                    };
                  });
                });
              },
            ),
            ]),
          ),
        Expanded(child:
          Column(children: [
            GCWButton(
              text: i18n(context, 'common_exportfile_openfile'),
              onPressed: () {
                openFileExplorer(context, allowedExtensions: _allowedExtensions).then((file) {
                  setState(() {
                    if (file != null) {
                    _lowImage = file?.bytes;
                  };
                });
              });
            },
          ),
          ]),
        ),
      ]),
      Row(children: [
        Expanded(child: _highImage !=null ? Image.memory(_highImage) : Container()),
        Expanded(child: _lowImage !=null ? Image.memory(_lowImage) : Container()),
      ]),
      Row(children: <Widget>[
        Expanded(child: GCWText(text: 'Dot Duration' + ':'), flex: 1), //i18n(context, 'homophone_rotation')
        Expanded(
          child: GCWIntegerSpinner(
            controller: _currentDitDurationController,
            min: 0,
            max: 999999,
            onChanged: (value) {
              setState(() {
                _currentDitDuration = value;
              });
            },
          ),
          flex: 2),
      ]),
      GCWTextField(
        controller: _currentInputController,
        onChanged: (text) {
          setState(() {
            _currentInput = text;
          });
        },
      ),
      _buildEncodeSubmitButton(),
      GCWDefaultOutput(child: _buildOutputEncode(),
        trailing: Row (
          children: <Widget>[
            GCWIconButton(
              iconData: Icons.save,
              size: IconButtonSize.SMALL,
              iconColor: _encodeOutputImage == null ? Colors.grey : null,
              onPressed: () {
                _encodeOutputImage == null ? null : _exportFile(context, _encodeOutputImage);
              },
            )
          ]
        )
      )
    ]);
  }

  Widget _buildEncodeSubmitButton() {
    return GCWSubmitButton(onPressed: () async {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: Container(
              child: GCWAsyncExecuter(
                isolatedFunction: createImageAsync,
                parameter: _buildJobDataEncode(),
                onReady: (data) => _saveOutputEncode(data),
                isOverlay: true,
              ),
              height: 220,
              width: 150,
            ),
          );
        },
      );
    });
  }

  Widget _buildOutputEncode() {
    if (_encodeOutputImage == null)
      return null;

    return Column(
        children: <Widget>[
          Image.memory(_encodeOutputImage)
        ]
    );
  }

  _initMarkedList(List<Uint8List> images, List<List<int>> imagesFiltered) {
    if (_marked == null || _marked.length != images.length ) {
      _marked = List.filled(images.length, false);

      // first image default as high signal
      if (imagesFiltered.length == 2) {
        _markedListSetColumn(0, true, imagesFiltered);
      }
    }
  }

  _markedListSetColumn(int index, bool value, List<List<int>> imagesFiltered) {
    imagesFiltered[index].forEach((idx) {
      _marked[idx] = value;
    });
  }

  List<GCWImageViewData> _convertImageDataFiltered( List<Uint8List> images, List<int> durations, List<List<int>> imagesFiltered) {
    var list = <GCWImageViewData>[];

    if (images != null) {
      var imageCount = images.length;
      _initMarkedList(images, imagesFiltered);

      for (var i = 0; i < imagesFiltered.length; i++) {
        String description = imagesFiltered[i].length.toString() + '/$imageCount';

        var image = images[imagesFiltered[i].first];
        list.add(GCWImageViewData(image, description: description, marked: _marked[imagesFiltered[i].first]));
      };
      _outText = decodeMorseCode(durations, _marked);
    };
    return list;
  }

  List<GCWImageViewData> _convertImageData(List<Uint8List> images, List<int> durations, List<List<int>> imagesFiltered) {
    var list = <GCWImageViewData>[];

    if (images != null) {
      var imageCount = images.length;
      _initMarkedList(images, imagesFiltered);

      for (var i = 0; i < images.length; i++) {
        String description = (i+1).toString() + '/$imageCount';
        if ((durations != null) && (i < durations.length)) {
          description += ': ' + durations[i].toString() + ' ms';
        }
        list.add(GCWImageViewData(images[i], description: description, marked: _marked[i]));
      };
      _outText = decodeMorseCode(durations, _marked);
    };
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
                parameter: _buildJobDataDecode(),
                onReady: (data) => _saveOutputDecode(data),
                isOverlay: true,
              ),
              height: 220,
              width: 150,
            ),
          );
        },
      );
  }

  Future<GCWAsyncExecuterParameters> _buildJobDataDecode() async {
    return GCWAsyncExecuterParameters(_platformFile.bytes);
  }

  Future<GCWAsyncExecuterParameters> _buildJobDataEncode() async {
    return GCWAsyncExecuterParameters(Tuple4<Uint8List, Uint8List, String, int>(_highImage, _lowImage, _currentInput, _currentDitDuration));
  }

  _saveOutputDecode(Map<String, dynamic> output) {
    _outData = output;
    _marked = null;

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

  _saveOutputEncode(Uint8List output) {
    _encodeOutputImage = output;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  _exportFiles(BuildContext context, String fileName, List<Uint8List> data) async {
    createZipFile(fileName, data).then((bytes) async {
      var fileType = '.zip';
      var value = await saveByteDataToFile(
          bytes.buffer.asByteData(), 'animatedimage_export_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + fileType);

      if (value != null) showExportedFileDialog(context, value['path'], fileType: fileType);
    });
  }

  _exportFile(BuildContext context, Uint8List data) async {
    var fileType = getFileType(data);
    var value = await saveByteDataToFile(
        data.buffer.asByteData(), 'animatedimage_export_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + fileType);

    if (value != null) showExportedFileDialog(context, value['path'], fileType: fileType);
  }
}
