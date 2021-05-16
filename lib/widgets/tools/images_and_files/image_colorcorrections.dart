import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/gcw_imageview.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';

class ImageColorCorrections extends StatefulWidget {
  @override
  ImageColorCorrectionsState createState() => ImageColorCorrectionsState();
}

class ImageColorCorrectionsState extends State<ImageColorCorrections> {
  Uint8List _currentData;
  Uint8List _originalData;

  var _currentSaturation = 0.5;

  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;

  @override
  Widget build(BuildContext context) {
    var items = <Widget>[
      Slider(
        value: _currentSaturation,
        onChanged: (value) {
          setState(() {
            _currentSaturation = value;
          });
        }
      )
    ];

    return Column(
      children: <Widget>[
        GCWButton(
          text: i18n(context, 'common_exportfile_openfile'),
          onPressed: () {
            setState(() {
              openFileExplorer().then((files) {
                if (files != null && files.length > 0) {
                  getFileData(files.first).then((bytes) {
                    _currentData = bytes;
                    _originalData = bytes;
                    setState(() {});
                  });
                }
              });
            });
          },
        ),
        GCWImageView(
          imageData: GCWImageViewData(_currentData),
        ),
        /*
        ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (BuildContext context, int i) {
            return items[i];
          },
        )*/
      ],
    );
  }
}
