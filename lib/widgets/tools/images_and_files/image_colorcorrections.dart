import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/images_and_files/image_processing.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_slider.dart';
import 'package:gc_wizard/widgets/common/gcw_imageview.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';
import 'package:image/image.dart' as img;
import 'package:prefs/prefs.dart';

class ImageColorCorrections extends StatefulWidget {
  final Uint8List imageData;

  const ImageColorCorrections({this.imageData});

  @override
  ImageColorCorrectionsState createState() => ImageColorCorrectionsState();
}

class ImageColorCorrectionsState extends State<ImageColorCorrections> {
  Uint8List _originalData;

  img.Image _currentPreview;
  img.Image _originalPreview;

  var _currentSaturation = 0.0;
  var _currentContrast = 0.0;
  var _currentBrightness = 0.0;
  var _currentExposure = 1.0;
  var _currentGamma = 1.0;
  var _currentHue = 0.0;
  var _currentRed = 0.0;
  var _currentGreen = 0.0;
  var _currentBlue = 0.0;

  var _currentInvert = false;
  var _currentGrayscale = false;
  var _currentEdgeDetection = 0.0;

  _currentDataInit() {
    var previewHeight = Prefs.getInt('imagecolorcorrections_maxpreviewheight');

    img.Image image = img.decodeImage(_originalData);

    if (image.height > previewHeight) {
      img.Image resized = img.copyResize(image, height: previewHeight);
      return resized;
    } else {
      return image;
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.imageData != null) {
      _originalData = widget.imageData;

      _originalPreview = _currentDataInit();
      _currentPreview = img.Image.from(_originalPreview);
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
        Container(), // Fixes a display issue
        if (_currentPreview != null)
          GCWImageView(
            imageData: GCWImageViewData(_imageBytes()),
            onBeforeLoadBigImage: _adjustToFullScreen,
          ),
        if (_currentPreview != null)
          GCWTextDivider(
            text: i18n(context, 'image_colorcorrections_options'),
          ),
        if (_currentPreview != null)
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                GCWOnOffSwitch(
                    title: i18n(context, 'image_colorcorrections_invert'),
                    value: _currentInvert,
                    onChanged: (value) {
                      setState(() {
                        _currentInvert = value;
                      });
                    }),
                GCWOnOffSwitch(
                    title: i18n(context, 'image_colorcorrections_grayscale'),
                    value: _currentGrayscale,
                    onChanged: (value) {
                      setState(() {
                        _currentGrayscale = value;
                      });
                    }),
                GCWSlider(
                    title: i18n(context, 'image_colorcorrections_brightness'),
                    value: _currentBrightness,
                    min: -255,
                    max: 255,
                    onChanged: (value) {
                      setState(() {
                        _currentBrightness = value;
                      });
                    }),
                GCWSlider(
                    title: i18n(context, 'image_colorcorrections_exposure'),
                    value: _currentExposure,
                    min: 0.0,
                    max: 2.0,
                    onChanged: (value) {
                      setState(() {
                        _currentExposure = value;
                      });
                    }),
                GCWSlider(
                    title: i18n(context, 'image_colorcorrections_saturation'),
                    value: _currentSaturation,
                    min: -1.0,
                    max: 1.0,
                    onChanged: (value) {
                      setState(() {
                        _currentSaturation = value;
                      });
                    }),
                GCWSlider(
                    title: i18n(context, 'image_colorcorrections_contrast'),
                    value: _currentContrast,
                    min: -255,
                    max: 255,
                    onChanged: (value) {
                      setState(() {
                        _currentContrast = value;
                      });
                    }),
                GCWSlider(
                    title: i18n(context, 'image_colorcorrections_gamma'),
                    value: _currentGamma,
                    min: 0.01,
                    max: 6.99,
                    onChanged: (value) {
                      setState(() {
                        _currentGamma = value;
                      });
                    }),
                GCWSlider(
                    title: i18n(context, 'image_colorcorrections_hue'),
                    value: _currentHue,
                    min: -180.0,
                    max: 180.0,
                    onChanged: (value) {
                      setState(() {
                        _currentHue = value;
                      });
                    }),
                GCWSlider(
                    title: i18n(context, 'image_colorcorrections_red'),
                    value: _currentRed,
                    min: -255.0,
                    max: 255.0,
                    onChanged: (value) {
                      setState(() {
                        _currentRed = value;
                      });
                    }),
                GCWSlider(
                    title: i18n(context, 'image_colorcorrections_green'),
                    value: _currentGreen,
                    min: -255.0,
                    max: 255.0,
                    onChanged: (value) {
                      setState(() {
                        _currentGreen = value;
                      });
                    }),
                GCWSlider(
                    title: i18n(context, 'image_colorcorrections_blue'),
                    value: _currentBlue,
                    min: -255.0,
                    max: 255.0,
                    onChanged: (value) {
                      setState(() {
                        _currentBlue = value;
                      });
                    }),
                GCWSlider(
                    title: i18n(context, 'image_colorcorrections_edges'),
                    value: _currentEdgeDetection,
                    min: 0.0,
                    max: 1.0,
                    onChanged: (value) {
                      setState(() {
                        _currentEdgeDetection = value;
                      });
                    })
              ],
            ),
          ))
      ],
    );
  }

  _adjustToFullScreen() {
    var image = _adjustColor(img.decodeImage(_originalData));
    return img.encodePng(image);
  }

  _adjustColor(img.Image image) {
    if (_currentEdgeDetection > 0.0) image = img.sobel(image, amount: _currentEdgeDetection);

    final pixels = image.getBytes();
    for (var i = 0, len = pixels.length; i < len; i += 4) {
      var pixel = RGBPixel(pixels[i].toDouble(), pixels[i + 1].toDouble(), pixels[i + 2].toDouble());

      if (_currentInvert) pixel = invert(pixel);

      if (_currentGrayscale) pixel = grayscale(pixel);

      if (_currentRed != 0.0 || _currentGreen != 0.0 || _currentBlue != 0.0)
        pixel = colorOffset(pixel, _currentRed, _currentGreen, _currentBlue);

      if (_currentBrightness != 0.0) pixel = brightness(pixel, _currentBrightness);

      if (_currentExposure != 1.0)
        pixel = exposure(pixel, _currentExposure > 1.0 ? 3 * (_currentExposure - 1) + 1 : _currentExposure);

      if (_currentSaturation != 0.0 || _currentHue != 0.0) pixel = saturation(pixel, _currentSaturation, _currentHue);

      if (_currentContrast != 0.0) pixel = contrast(pixel, _currentContrast);

      if (_currentGamma != 1.0) pixel = gamma(pixel, _currentGamma);

      pixels[i] = pixel.red.round().clamp(0, 255);
      pixels[i + 1] = pixel.green.round().clamp(0, 255);
      pixels[i + 2] = pixel.blue.round().clamp(0, 255);
    }

    return image;
  }

  _imageBytes() {
    _currentPreview = _adjustColor(img.Image.from(_originalPreview));
    return img.encodePng(_currentPreview);
  }
}
