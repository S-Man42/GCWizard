import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_image_reader.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_session.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_imageview.dart';
import 'package:gc_wizard/widgets/common/gcw_openfile.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/gcw_file.dart';
import 'package:image/image.dart' as img;

class Piet extends StatefulWidget {
  final GCWFile file;

  const Piet({this.file});

  @override
  PietState createState() => PietState();
}

class PietState extends State<Piet> {
  GCWFile _originalData;
  String _currentInput = '';
  PietResult _currentOutput = null;
  PietSession _continueState = null;
  var _isStarted = false;

  @override
  void initState() {
    super.initState();

    if (widget.file != null && widget.file.bytes != null) {
      _originalData = widget.file;
    }
  }

  _resetInputs() {
    _currentInput = "";
    _currentOutput = null;
    setState(() {
    });
  }

  bool _validateData(Uint8List bytes) {
    return isImage(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWOpenFile(
          supportedFileTypes: SUPPORTED_IMAGE_TYPES,
          onLoaded: (GCWFile value) {
            if (value == null || !_validateData(value.bytes)) {
              showToast(i18n(context, 'common_loadfile_exception_notloaded'));
              return;
            }

            setState(() {
              _originalData = value;
              _resetInputs();
              _calcOutput(context);
            });
          },
        ), // Fixes a display issue

        GCWImageView(
          imageData: _originalData?.bytes == null ? null : GCWImageViewData(GCWFile(bytes: _originalData.bytes)),
          ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    if ((_originalData?.bytes == null) || (_currentOutput == null)) return GCWDefaultOutput();

    if (_currentOutput == null) return GCWDefaultOutput();

    return GCWOutput( child:
        _currentOutput.output + (_currentOutput.error ? '\n' + _currentOutput.errorText : ''),
    );
  }

  _calcOutput(BuildContext context) async {
    if (_isStarted) return;

    _isStarted = true;
    String _currentInput = '';
    _currentOutput = null;

    var imageReader = PietImageReader();
    var _pietPixels = imageReader.ReadImage(_originalData.bytes);

    var currentOutputFuture = interpreterPiet(_pietPixels, "5");

     _continueState = null;

    currentOutputFuture.then((output) {
      if (output.finished) {
        _currentOutput = output;
        _isStarted = false;
        this.setState(() {});
      } else {
        _continueState = output.state;
        _currentInput = "";
        _showDialogBox(context, output.output);
      }
    });
  }

  _showDialogBox(BuildContext context, String text) {
    showGCWDialog(
        context,
        text,
        Container(
          width: 300,
          height: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GCWTextField(
                autofocus: true,
                filled: true,
                onChanged: (text) {
                  _currentInput = text;
                },
              ),
            ],
          ),
        ),
        [
          GCWDialogButton(
            text: i18n(context, 'common_ok'),
            onPressed: () {
              _isStarted = false;
              if (_continueState != null) _continueState.inp = _currentInput + '\n';
              _calcOutput(context);
            },
          )
        ],
        cancelButton: false);
  }
}
