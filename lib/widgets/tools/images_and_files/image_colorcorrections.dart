import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_slider.dart';
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
            imageData: GCWImageViewData(_imageBytes()),
            onBeforeFullscreen: _adjustToFullScreen
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

  _adjustToFullScreen(MemoryImage imageProvider) {
    var image = _adjustColor(img.decodeImage(_originalData));
    return MemoryImage(img.encodePng(image));
  }

  _adjustColor(img.Image image) {
    if (_currentInvert)
      image = img.invert(image);

    if (_currentEdgeDetection > 0.0)
      image = img.sobel(image, amount: _currentEdgeDetection);

    if (_currentRed != 0.0 || _currentGreen != 0.0 || _currentBlue != 0.0)
      image = img.colorOffset(image, red: _currentRed.toInt(), green: _currentGreen.toInt(), blue: _currentBlue.toInt());

    return img.adjustColor(image,
        saturation: _currentSaturation,
        contrast: _currentContrast,
      gamma: _currentGamma,
      exposure: _currentExposure,
      hue: _currentHue,
      brightness: _currentBrightness,
      // blacks: _currentBlacks.toInt(),
      // whites: _currentWhites.toInt(),
      // mids: _currentMids.toInt()
    );
  }

  _imageBytes() {
    _currentPreview = _adjustColor(img.Image.from(_originalPreview));
    return img.encodePng(_currentPreview);
  }
}
