import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/hexstring2file.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_symbol_container.dart';
import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:intl/intl.dart';

class HexString2File extends StatefulWidget {
  @override
  HexString2FileState createState() => HexString2FileState();
}

class HexString2FileState extends State<HexString2File> {
  var _currentInput = '';
  Uint8List _outData;

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

    _outData = hexstring2file(_currentInput);

    if (_outData == null)
      return null;

    var mimeType = getMimeType(getFileType(_outData));

    switch (mimeType)
    {
      case MIMETYPE.IMAGE:
        try {
          return GCWSymbolContainer(
              symbol: Image.memory(_outData)
          );
        } catch (e) {}

        return null;

      case MIMETYPE.TEXT:
        return String.fromCharCodes(_outData);

      case MIMETYPE.ARCHIV:
        String fileNames;
        String extension = getFileType(_outData);
        if (extension.endsWith('.zip')) {
          try {
            InputStream input = new InputStream(_outData.buffer.asByteData());
            // Decode the Zip file
            final archive = ZipDecoder().decodeBuffer(input);
            fileNames = archive
                .map((file) {
                  return ('-> ' + file.name);
                })
                .join('\n');
          } catch (e) {}

          return  'zip-file -> content\n' + fileNames;
        }
        else if (extension.endsWith('.tar')) {
          try {
            InputStream input = new InputStream(_outData.buffer.asByteData());
            // Decode the Zip file
            final archive = TarDecoder().decodeBuffer(input);
            fileNames = archive
                .map((file) {
                  return ('-> ' + file.name);
                })
                .join('\n');
          } catch (e) {}

          return  'tar-file -> content\n' + fileNames;
        }
        else {
          fileNames = extension.replaceFirst('.', '') + "-file";
        }

        return  fileNames;
      default:
        return getFileType(_outData).replaceFirst('.', '') + "-file";
    }
  }


  _exportFile(BuildContext context, Uint8List data) async {
    var fileType = getFileType(_outData);
    var value = await saveByteDataToFile(
        data.buffer.asByteData(), DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + fileType, subDirectory: "hexstring_export");

    if (value != null) showExportedFileDialog(context, value['path'], fileType: fileType);
  }
}
