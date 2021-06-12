import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/gcw_imageview.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';
import 'package:image/image.dart' as img;

enum _ImageType {JPEG, GIF, PNG, ICO, TARGA, READONLY_SUPPORT}

class ImageColorCorrections extends StatefulWidget {
  @override
  ImageColorCorrectionsState createState() => ImageColorCorrectionsState();
}

class ImageColorCorrectionsState extends State<ImageColorCorrections> {
  Uint8List _currentData;
  Uint8List _originalData;

  _ImageType _currentImageType;

  img.Image _currentImage;

  var _currentSaturation = 0.5;

  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;

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
                  _currentData = file.bytes;
                  _originalData = file.bytes;

                  _setImageType();

                  if (_currentImageType == null) {
                    _currentData = null;
                  } else {
                    _originalData = file.bytes;
                    _currentImage = img.decodeImage(_currentData);
                  }

                  setState(() {});

                }
              });
            });
          },
        ),
        if (_currentImage != null)
          GCWImageView(
            imageData: GCWImageViewData(_imageBytes()),
          ),
        Slider(
            value: _currentSaturation,
            onChanged: (value) {
              setState(() {
                _currentSaturation = value;
              });
            }
        )
      ],
    );
  }

  _setImageType() {
    var decoder = img.findDecoderForData(_currentData);

    if (decoder is img.JpegDecoder)
      _currentImageType = _ImageType.JPEG;
    else if (decoder is img.PngDecoder)
      _currentImageType = _ImageType.PNG;
    else if (decoder is img.GifDecoder)
      _currentImageType = _ImageType.GIF;
    else if (decoder is img.TgaDecoder)
      _currentImageType = _ImageType.TARGA;
    else if (decoder is img.IcoDecoder)
      _currentImageType = _ImageType.ICO;
    else if (decoder != null)
      _currentImageType = _ImageType.READONLY_SUPPORT;
    else
      _currentImageType = null;
  }

  _adjustColor() {
    // return _currentImage;
    print(_currentSaturation);

    _currentImage = img.adjustColor(img.decodeImage(_currentData),
        saturation: _currentSaturation
    );
    return _currentImage;
  }

  _imageBytes() {
    _adjustColor();

    switch (_currentImageType) {
      case _ImageType.JPEG: return img.encodeJpg(_currentImage);
      case _ImageType.PNG: return img.encodePng(_currentImage);
      case _ImageType.GIF: return img.encodeGif(_currentImage);
      case _ImageType.ICO: return img.encodeIco(_currentImage);
      case _ImageType.TARGA: return img.encodeTga(_currentImage);
      case _ImageType.READONLY_SUPPORT: return img.encodePng(_currentImage);
    }
  }
}
