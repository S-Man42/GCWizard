import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/images_and_files/binary2image.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:intl/intl.dart';


class Binary2Image extends StatefulWidget {
  @override
  Binary2ImageState createState() => Binary2ImageState();
}

class Binary2ImageState extends State<Binary2Image> {
  var _currentInput = '';
  Uint8List _outData;
  var _squareFormat = false;
  var _invers = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          onChanged: (value) {
            _currentInput = value;
            _createOutput();
          },
        ),
        GCWOnOffSwitch(
          title: i18n(context, 'binary2image_squareFormat'),
          value: _squareFormat,
          onChanged: (value) {
            _squareFormat = value;
            _createOutput();
          },
        ),
        GCWOnOffSwitch(
          title: i18n(context, 'binary2image_invers'),
          value: _invers,
          onChanged: (value) {
            _invers = value;
            _createOutput();
          },
        ),
        GCWDefaultOutput(child: _buildOutput(),
          trailing: GCWIconButton(
            iconData: Icons.save,
            size: IconButtonSize.SMALL,
            iconColor: _outData == null ? Colors.grey : null,
            onPressed: () {
              _outData == null ? null : _exportFile(context, _outData);
            },
          )
        )
      ],
    );
  }

  _createOutput() {
    binary2image(_currentInput, _squareFormat, _invers).then((value) {
      setState(() {
        _outData = value;
      });
    });
  }

  _buildOutput() {
    return (_outData == null) ? null : Image.memory(_outData);
  }

  _exportFile(BuildContext context, Uint8List data) async {
    var value = await saveByteDataToFile(
        data.buffer.asByteData(), 'image_export' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '.png');

    if (value != null) showExportedFileDialog(context, value['path'], fileType: '.png', contentWidget: Image.memory(_outData));
  }
}
