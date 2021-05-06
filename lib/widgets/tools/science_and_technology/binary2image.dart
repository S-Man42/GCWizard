import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/binary2image.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_symbol_container.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';



class Binary2Image extends StatefulWidget {
  @override
  Binary2ImageState createState() => Binary2ImageState();
}

class Binary2ImageState extends State<Binary2Image> {
  var _currentInput = '';
  var _currentInputLast = '';
  Uint8List _outData;
  var _squareFormat = true;
  var _invers = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          onChanged: (value) {
            setState(() {
              _currentInput = value;
            });
          },
        ),
        GCWOnOffSwitch(
          title: 'Square format',
          value: _squareFormat,
          onChanged: (value) {
            setState(() {
              _squareFormat = value;
            });
          },
        ),
        GCWOnOffSwitch(
          title: 'Invers',
          value: _invers,
          onChanged: (value) {
            setState(() {
              _invers = value;
            });
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

  _buildOutput() {
    if (_currentInputLast != _currentInput) {
      _currentInputLast == _currentInput;
      binary2image(_currentInput, _squareFormat, _invers).then((value) {
//        setState(() {
          _outData = value;
//        });
      });
    }

    if (_outData == null)
      return null;

    return GCWSymbolContainer(
        symbol: Image.memory(_outData)
    );

  }


  _exportFile(BuildContext context, Uint8List data) async {
    // var fileType = getFileType(_outData);
    // var value = await saveByteDataToFile(
    //     data.buffer.asByteData(), DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + fileType, subDirectory: "hexstring_export");
    //
    // if (value != null) showExportedFileDialog(context, value['path'], fileType: fileType);
  }
}
