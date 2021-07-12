import 'dart:typed_data';

import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/images_and_files/image_processing.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_slider.dart';
import 'package:gc_wizard/widgets/common/gcw_async_executer.dart';
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
  Uint8List _currentImage;

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
            imageData: _originalData == null ? null : GCWImageViewData(_imageBytes()),
            onBeforeFullscreen: _adjustToFullScreenWidget,
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

  // _adjustToFullScreen() {
  //   var image = _adjustColor(img.decodeImage(_originalData));
  //   return img.encodePng(image);
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

  // _adjustColor(img.Image image) {
  //   if (_currentEdgeDetection > 0.0) image = img.sobel(image, amount: _currentEdgeDetection);
  //
  //   final pixels = image.getBytes();
  //   for (var i = 0, len = pixels.length; i < len; i += 4) {
  //     var pixel = RGBPixel(pixels[i].toDouble(), pixels[i + 1].toDouble(), pixels[i + 2].toDouble());
  //
  //     if (_currentInvert) pixel = invert(pixel);
  //
  //     if (_currentGrayscale) pixel = grayscale(pixel);
  //
  //     if (_currentRed != 0.0 || _currentGreen != 0.0 || _currentBlue != 0.0)
  //       pixel = colorOffset(pixel, _currentRed, _currentGreen, _currentBlue);
  //
  //     if (_currentBrightness != 0.0) pixel = brightness(pixel, _currentBrightness);
  //
  //     if (_currentExposure != 1.0)
  //       pixel = exposure(pixel, _currentExposure > 1.0 ? 3 * (_currentExposure - 1) + 1 : _currentExposure);
  //
  //     if (_currentSaturation != 0.0 || _currentHue != 0.0) pixel = saturation(pixel, _currentSaturation, _currentHue);
  //
  //     if (_currentContrast != 0.0) pixel = contrast(pixel, _currentContrast);
  //
  //     if (_currentGamma != 1.0) pixel = gamma(pixel, _currentGamma);
  //
  //     pixels[i] = pixel.red.round().clamp(0, 255);
  //     pixels[i + 1] = pixel.green.round().clamp(0, 255);
  //     pixels[i + 2] = pixel.blue.round().clamp(0, 255);
  //   }
  //
  //   return image;
  // }


  Future<GCWAsyncExecuterParameters> _buildJobDataAdjustColor() async {
    return GCWAsyncExecuterParameters(
        Tuple7<img.Image, bool, bool, double, double, double, Tuple7>
          (img.decodeImage(_originalData),
            _currentInvert,
            _currentGrayscale,
            _currentEdgeDetection,
            _currentRed,
            _currentGreen,
            Tuple7<double, double, double, double, double, double, double>
              (_currentBlue,
                _currentSaturation,
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
        invert_: jobData.parameters.item2,
        grayscale_: jobData.parameters.item3,
        edgeDetection_: jobData.parameters.item4,
        red_: jobData.parameters.item5,
        green_: jobData.parameters.item6,
        blue_: jobData.parameters.item7.item1,
        saturation_: jobData.parameters.item7.item2,
        contrast_: jobData.parameters.item7.item3,
        gamma_: jobData.parameters.item7.item4,
        exposure_: jobData.parameters.item7.item5,
        hue_: jobData.parameters.item7.item6,
        brightness_: jobData.parameters.item7.item7
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
        invert_: _currentInvert,
        grayscale_: _currentGrayscale,
        edgeDetection_: _currentEdgeDetection,
        red_: _currentRed,
        green_: _currentGreen,
        blue_: _currentBlue,
        saturation_: _currentSaturation,
        contrast_: _currentContrast,
        gamma_: _currentGamma,
        exposure_: _currentExposure,
        hue_: _currentHue,
        brightness_: _currentBrightness
    );
  }

  img.Image __adjustColor(img.Image image, {
    bool invert_: false,
    bool grayscale_: false,
    double edgeDetection_: 0.0,
    double red_: 0.0,
    double green_: 0.0,
    double blue_: 0.0,
    double saturation_: 0.0,
    double contrast_: 0.0,
    double gamma_: 0.0,
    double exposure_: 1.0,
    double hue_: 0.0,
    double brightness_: 0.0,
  }) {
    if (edgeDetection_ > 0.0) image = img.sobel(image, amount: edgeDetection_);

    final pixels = image.getBytes();
    for (var i = 0, len = pixels.length; i < len; i += 4) {
      var pixel = RGBPixel(pixels[i].toDouble(), pixels[i + 1].toDouble(), pixels[i + 2].toDouble());

      if (invert_) pixel = invert(pixel);

      if (grayscale_) pixel = grayscale(pixel);

      if (red_ != 0.0 || green_ != 0.0 || blue_ != 0.0)
        pixel = colorOffset(pixel, red_, green_, blue_);

      if (brightness_ != 0.0) pixel = brightness(pixel, brightness_);

      if (exposure_ != 1.0)
        pixel = exposure(pixel, exposure_ > 1.0 ? 3 * (exposure_ - 1) + 1 : exposure_);

      if (saturation_ != 0.0 || hue_ != 0.0) pixel = saturation(pixel, saturation_, hue_);

      if (contrast_ != 0.0) pixel = contrast(pixel, contrast_);

      if (gamma_ != 1.0) pixel = gamma(pixel, gamma_);

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
