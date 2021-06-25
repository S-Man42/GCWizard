import 'dart:typed_data';

import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_slider.dart';
import 'package:gc_wizard/widgets/common/gcw_async_executer.dart';
import 'package:gc_wizard/widgets/common/gcw_imageview.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';
import 'package:image/image.dart' as img;

class ImageColorCorrections extends StatefulWidget {
  @override
  ImageColorCorrectionsState createState() => ImageColorCorrectionsState();
}

class ImageColorCorrectionsState extends State<ImageColorCorrections> {
  int _PREVIEW_HEIGHT = 100;

  Uint8List _originalData;
  Uint8List _currentImage;

  img.Image _currentPreview;
  img.Image _originalPreview;

  var _currentSaturation = 1.0;
  var _currentContrast = 1.0;
  var _currentBrightness = 1.0;
  var _currentExposure = 0.0;
  var _currentGamma = 1.0;
  var _currentHue = 0.0;
  var _currentBlacks = 0.0;
  var _currentWhites = 0.0;
  var _currentMids = 0.0;
  var _currentRed = 0.0;
  var _currentGreen = 0.0;
  var _currentBlue = 0.0;

  var _currentInvert = false;
  var _currentEdgeDetection = 0.0;

  _currentDataInit() {
    img.Image image = img.decodeImage(_originalData);

    if (image.height > _PREVIEW_HEIGHT) {
      img.Image resized = img.copyResize(image, height: _PREVIEW_HEIGHT);
      return resized;
    } else {
      return image;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWButton(
          text: i18n(context, 'common_exportfile_openfile'),
          onPressed: () {
            setState(() {
              openFileExplorer(allowedExtensions: supportedImageTypes).then((file) {
                if (file != null) {
                  _originalData = file.bytes;

                  _originalPreview = _currentDataInit();
                  _currentPreview = img.Image.from(_originalPreview);

                  setState(() {});
                }
              });
            });
          },
        ),
        if (_currentPreview != null)
          GCWImageView(
            imageData: _originalData == null ? null : GCWImageViewData(_imageBytes()),
            onBeforeFullscreenAsync: _adjustToFullScreenWidget
          ),
            Expanded(
            child:
        SingleChildScrollView(
          child: Column(
            children: [
              GCWOnOffSwitch(
                  title: 'Invert',
                  value: _currentInvert,
                  onChanged: (value) {
                    setState(() {
                      _currentInvert = value;
                    });
                  }
              ),
              GCWSlider(
                  title: 'Saturation',
                  value: _currentSaturation,
                  min: 0.0,
                  max: 1.0,
                  onChanged: (value) {
                    setState(() {
                      _currentSaturation = value;
                    });
                  }
              ),
              GCWSlider(
                  title: 'Contrast',
                  value: _currentContrast,
                  min: 0.0,
                  max: 1.0,
                  onChanged: (value) {
                    setState(() {
                      _currentContrast = value;
                    });
                  }
              ),
              GCWSlider(
                  title: 'Brightness',
                  value: _currentBrightness,
                  min: 0.0,
                  max: 1.0,
                  onChanged: (value) {
                    setState(() {
                      _currentBrightness = value;
                    });
                  }
              ),
              GCWSlider(
                  title: 'Gamma',
                  value: _currentGamma,
                  min: 0.0,
                  max: 1.0,
                  onChanged: (value) {
                    setState(() {
                      _currentGamma = value;
                    });
                  }
              ),
              GCWSlider(
                  title: 'Hue',
                  value: _currentHue,
                  min: 0.0,
                  max: 360.0,
                  onChanged: (value) {
                    setState(() {
                      _currentHue = value;
                    });
                  }
              ),
              GCWSlider(
                  title: 'Blacks',
                  value: _currentBlacks,
                  min: 0.0,
                  max: 1000.0,
                  onChanged: (value) {
                    setState(() {
                      _currentBlacks = value;
                    });
                  }
              ),
              GCWSlider(
                  title: 'Whites',
                  value: _currentWhites,
                  min: 0.0,
                  max: 1000.0,
                  onChanged: (value) {
                    setState(() {
                      _currentWhites = value;
                    });
                  }
              ),
              GCWSlider(
                  title: 'Mids',
                  value: _currentMids,
                  min: 0.0,
                  max: 1000.0,
                  onChanged: (value) {
                    setState(() {
                      _currentMids = value;
                    });
                  }
              ),
              GCWSlider(
                  title: 'Red',
                  value: _currentRed,
                  min: -255.0,
                  max: 255.0,
                  onChanged: (value) {
                    setState(() {
                      _currentRed = value;
                    });
                  }
              ),
              GCWSlider(
                  title: 'Green',
                  value: _currentGreen,
                  min: -255.0,
                  max: 255.0,
                  onChanged: (value) {
                    setState(() {
                      _currentGreen = value;
                    });
                  }
              ),
              GCWSlider(
                  title: 'Blue',
                  value: _currentBlue,
                  min: -255.0,
                  max: 255.0,
                  onChanged: (value) {
                    setState(() {
                      _currentBlue = value;
                    });
                  }
              ),
              GCWSlider(
                  title: 'Edges',
                  value: _currentEdgeDetection,
                  min: 0.0,
                  max: 1.0,
                  onChanged: (value) {
                    setState(() {
                      _currentEdgeDetection = value;
                    });
                  }
              ),
              GCWSlider(
                  title: 'Exposure',
                  value: _currentExposure,
                  min: 0.0,
                  max: 1.0,
                  onChanged: (value) {
                    setState(() {
                      _currentExposure = value;
                    });
                  }
              ),
            ],
          ),
        ))
      ],
    );
  }

  // _adjustToFullScreen(MemoryImage imageProvider) {
  //   var image = _adjustColor(img.decodeImage(_originalData));
  //   return MemoryImage(img.encodePng(image));
  // }

  Future<MemoryImage> _adjustToFullScreenWidget(MemoryImage imageProvider) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            child: GCWAsyncExecuter(
              isolatedFunction: _adjustColorAsync,
              parameter: _buildJobDataAdjustColor(),
              onReady: (data) => _saveOutputAdjustColor(data),
              isOverlay: true,
            ),
            height: 220,
            width: 150,
          ),
        );
      },
    );
    return MemoryImage(_currentImage);
  }

  Future<GCWAsyncExecuterParameters> _buildJobDataAdjustColor() async {
    return GCWAsyncExecuterParameters(
        Tuple7<img.Image, bool, double, double, double, double, Tuple6>
        (img.decodeImage(_originalData),
          _currentInvert,
          _currentEdgeDetection,
          _currentRed,
          _currentGreen,
          _currentBlue,
            Tuple6<double, double, double, double, double, double>
              (_currentSaturation,
                _currentContrast,
                _currentGamma,
                _currentExposure,
                _currentHue,
                _currentBrightness
            )
        )
    );
  }


  Future<img.Image> _adjustColorAsync(dynamic jobData) {
    if (jobData == null) {
      jobData.sendAsyncPort.send(null);
      return null;
    }

    var output = __adjustColor(
        jobData.parameters.item1,
        invert: jobData.parameters.item2,
        edgeDetection: jobData.parameters.item3,
        red: jobData.parameters.item4,
        green: jobData.parameters.item5,
        blue: jobData.parameters.item6,
        saturation: jobData.parameters.item7.item1,
        contrast: jobData.parameters.item7.item2,
        gamma: jobData.parameters.item7.item3,
        exposure: jobData.parameters.item7.item4,
        hue: jobData.parameters.item7.item5,
        brightness: jobData.parameters.item7.item6
    );

    if (jobData.sendAsyncPort != null) jobData.sendAsyncPort.send(output);

    return Future.value(output);
  }

  _saveOutputAdjustColor(img.Image output) {
    if (output != null)
    _currentImage = img.encodePng(output); //MemoryImage(

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   setState(() {});
    // });
  }

  img.Image _adjustColor(img.Image image) {
    return __adjustColor(
        image,
        invert: _currentInvert,
        edgeDetection: _currentEdgeDetection,
        red: _currentRed,
        green: _currentGreen,
        blue: _currentBlue,
        saturation: _currentSaturation,
        contrast: _currentContrast,
        gamma: _currentGamma,
        exposure: _currentExposure,
        hue: _currentHue,
        brightness: _currentBrightness
    );
  }

  img.Image __adjustColor(img.Image image, {
    bool invert: false,
    double edgeDetection: 0.0,
    double red: 0.0,
    double green: 0.0,
    double blue: 0.0,
    double saturation: 0.0,
    double contrast: 0.0,
    double gamma: 0.0,
    double exposure: 0.0,
    double hue: 0.0,
    double brightness: 0.0,
  }) {
    if (invert)
      image = img.invert(image);

    if (edgeDetection > 0.0)
      image = img.sobel(image, amount: edgeDetection);

    if (red != 0.0 || green != 0.0 || blue != 0.0)
      image = img.colorOffset(image, red: red.toInt(), green: green.toInt(), blue: blue.toInt());

    return img.adjustColor(image,
        saturation: saturation,
        contrast: contrast,
      gamma: gamma,
      exposure: exposure,
      hue: hue,
      brightness: brightness,
      // blacks: _currentBlacks.toInt(),
      // whites: _currentWhites.toInt(),
      // mids: _currentMids.toInt()
    );
  }

  Uint8List _imageBytes() {
    _currentPreview = _adjustColor(img.Image.from(_originalPreview));
    return img.encodePng(_currentPreview);
  }
}
