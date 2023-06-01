import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/dialogs/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/_common/logic/base.dart';
import 'package:gc_wizard/tools/images_and_files/hexstring2file/logic/hexstring2file.dart';
import 'package:gc_wizard/tools/images_and_files/hexstring2file/widget/hexstring2file.dart';
import 'package:gc_wizard/tools/science_and_technology/numeral_bases/logic/numeral_bases.dart';
import 'package:gc_wizard/utils/file_utils/file_utils.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/file_widget_utils.dart';

abstract class AbstractBase extends StatefulWidget {
  final String Function(String) encode;
  final String Function(String) decode;
  final bool searchMultimedia;

  const AbstractBase({Key? key, required this.encode, required this.decode, required this.searchMultimedia}) : super(key: key);

  @override
 _AbstractBaseState createState() => _AbstractBaseState();
}

class _AbstractBaseState extends State<AbstractBase> {
  late TextEditingController _inputController;

  String _currentInput = '';
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: _currentInput);
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _inputController,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    var output = '';
    Uint8List? _outData;

    late Widget outputWidget;

    if (_currentMode == GCWSwitchPosition.left) {
      output = widget.encode(_currentInput);
      outputWidget = GCWDefaultOutput(child: output);
    } else {
      output = decode(_currentInput, widget.decode);
      outputWidget = GCWDefaultOutput(child: output);
      if (widget.searchMultimedia){
        _outData = hexstring2file(_asciiToHexString(decode(_currentInput, widget.decode)));

        if (_outData == null) return outputWidget;

        outputWidget =
            GCWDefaultOutput(
                trailing: GCWIconButton(
                  icon: Icons.save,
                  size: IconButtonSize.SMALL,
                  onPressed: () {
                    _outData == null ? null : _exportFile(context, _outData);
                  },
                ),
                child:hexDataOutput(context, <Uint8List>[_outData])
            );
      }
    }

    return outputWidget;
  }

  Future<void> _exportFile(BuildContext context, Uint8List data) async {
    var fileType = getFileType(data);
    await saveByteDataToFile(context, data, buildFileNameWithDate('hex_', fileType)).then((value) {
      var content = fileClass(fileType) == FileClass.IMAGE ? imageContent(context, data) : null;
      if (value) showExportedFileDialog(context, contentWidget: content);
    });
  }

  String _asciiToHexString(String input){
    List<String> result = [];
    String hex = '';
    input.split('').forEach((char){
      hex = convertBase(char.codeUnitAt(0).toString(), 10, 16);
      if (hex.length == 1) {
        result.add('0' + hex);
      } else {
        result.add(hex);
      }
    });
    return result.join(' ');
  }
}
