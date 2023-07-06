import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/dialogs/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/common_widgets/gcw_toast.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/_common/logic/base.dart';
import 'package:gc_wizard/tools/images_and_files/hexstring2file/logic/hexstring2file.dart';
import 'package:gc_wizard/tools/images_and_files/hexstring2file/widget/hexstring2file.dart';
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

  Base64Output? _decodeBase64Data;
  Uint8List? _outData;

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
        if (widget.searchMultimedia && _currentMode == GCWSwitchPosition.right)
          GCWButton(
            text: i18n(context, 'common_start'),
            onPressed: () {
              setState(() {
                _decodeBase64Async();
              });
            },
          ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    var output = '';

    late Widget outputWidget;

    if (_currentMode == GCWSwitchPosition.left) {
      output = widget.encode(_currentInput);
      outputWidget = GCWDefaultOutput(child: output);
    } else {
      if (widget.searchMultimedia){
        if (_outData == null) return Container();

        outputWidget =
            GCWDefaultOutput(
                trailing: GCWIconButton(
                  icon: Icons.save,
                  size: IconButtonSize.SMALL,
                  onPressed: () {
                    _outData == null ? null : _exportFile(context, _outData!);
                  },
                ),
                child:hexDataOutput(context, <Uint8List>[_outData!])
            );
      } else {
        output = decode(_currentInput, widget.decode);
        outputWidget = GCWDefaultOutput(child: output);
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

  Future<GCWAsyncExecuterParameters?> _buildJobData() async {
    if (_currentInput.isEmpty) return null;
    return GCWAsyncExecuterParameters(_currentInput);
  }

  void _showOutput(Base64Output? output) {
    _decodeBase64Data = output;

    // restore image references (problem with sendPort, lose references)
    if (_decodeBase64Data != null) {
      _outData = hexstring2file(asciiToHexString(_decodeBase64Data!.plainText));

    } else {
      showToast(i18n(context, 'common_loadfile_exception_notloaded'));
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  void _decodeBase64Async() async {
    await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: SizedBox(
            height: 220,
            width: 150,
            child: GCWAsyncExecuter<Base64Output?>(
              isolatedFunction: decodeBase64Async,
              parameter: _buildJobData,
              onReady: (data) => _showOutput(data),
              isOverlay: true,
            ),
          ),
        );
      },
    );
  }
}
