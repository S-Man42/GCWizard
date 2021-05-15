import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/images_and_files/hexstring2file.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_symbol_container.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:intl/intl.dart';

class HexString2File extends StatefulWidget {
  final PlatformFile platformFile;

  const HexString2File({Key key, this.platformFile})
      : super(key: key);

  @override
  HexString2FileState createState() => HexString2FileState();
}

class HexString2FileState extends State<HexString2File> {
  var _currentInput = '';
  Uint8List _outData;
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  @override
  Widget build(BuildContext context) {
    if (widget.platformFile != null) {
      _currentMode = GCWSwitchPosition.left;
      _outData = widget.platformFile.bytes;
    }

    return Column(
      children: <Widget>[
        _currentMode == GCWSwitchPosition.left ?
          GCWButton(
            text: i18n(context, 'common_exportfile_openfile'),
            onPressed: () {
              setState(() {
                  openFileExplorer().then((files) {
                    if (files != null && files.length > 0) {
                      getFileData(files.first).then((bytes) {
                        _outData = bytes;
                        setState(() {});
                      });
                    }
                });
              },
            );
          })
        :
          GCWTextField(
            onChanged: (value) {
              setState(() {
                _currentInput = value;
              });
            },
          ),
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentInput = null;
              _outData = null;
              _currentMode = value;
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
    if (_currentMode == GCWSwitchPosition.right) {
      _outData = hexstring2file(_currentInput);

      if (_outData == null)
        return null;

      var mimeType = getMimeType(getFileType(_outData));

      switch (mimeType) {
        case MIMETYPE.IMAGE:
          try {
            return GCWSymbolContainer(
                symbol: Image.memory(_outData)
            );
          } catch (e) {
            return getFileType(_outData).replaceFirst('.', '') + '-' + i18n(context, 'hexstring2file_file');
          }

          return null;

        case MIMETYPE.TEXT:
          return String.fromCharCodes(_outData);

        case MIMETYPE.ARCHIV:
          String fileNames = '';
          String extension = getFileType(_outData);
          if (extension.endsWith('.zip')) {
            try {
              InputStream input = new InputStream(_outData.buffer.asByteData());
              // Decode the Zip file
              final archive = ZipDecoder().decodeBuffer(input);
              fileNames = archive
                  .map((file) {
                    if (file.isFile)
                      return ('-> ' + file.name);
                    else
                      return '';
                  })
                  .join('\n');
            } catch (e) {}

            return 'zip-' + i18n(context, 'hexstring2file_file') + ' -> ' + i18n(context, 'hexstring2file_content') + '\n' + fileNames;
          }
          else if (extension.endsWith('.tar')) {
            try {
              InputStream input = new InputStream(_outData.buffer.asByteData());
              // Decode the Zip file
              final archive = TarDecoder().decodeBuffer(input);
              fileNames = archive
                  .map((file) {
                    if (file.isFile)
                      return ('-> ' + file.name);
                    else
                      return '';
                  })
                  .join('\n');
            } catch (e) {}

            return 'tar-' + i18n(context, 'hexstring2file_file') + ' -> ' + i18n(context, 'hexstring2file_content') + '\n' + fileNames;
          }
          else {
            fileNames = extension.replaceFirst('.', '') + '-' + i18n(context, 'hexstring2file_file');
          }

          return fileNames;
        default:
          return getFileType(_outData).replaceFirst('.', '') + '-' + i18n(context, 'hexstring2file_file');
      }
    } else {
      if (_outData == null)
        return null;

      return file2hexstring(_outData);
    }
  }


  _exportFile(BuildContext context, Uint8List data) async {
    var fileType = getFileType(_outData);
    var value = await saveByteDataToFile(
        data.buffer.asByteData(), DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + fileType, subDirectory: "hexstring_export");

    if (value != null) showExportedFileDialog(context, value['path'], fileType: fileType);
  }
}
