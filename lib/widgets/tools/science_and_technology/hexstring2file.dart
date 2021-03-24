import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/hexstring2file.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_symbol_container.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:gc_wizard/widgets/common/gcw_text_export.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:path/path.dart';

class HexString2File extends StatefulWidget {
  @override
  HexString2FileState createState() => HexString2FileState();
}

class HexString2FileState extends State<HexString2File> {
  var _currentInput = '';

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
        GCWDefaultOutput(child: _buildOutput())
      ],
    );
  }

  _buildOutput() {
    var bytes = hexstring2file(_currentInput);

    if (bytes == null)
      return Container();

    var mimitye = getMimeType(getFileType(bytes));
    if (mimitye == MIMETYPE.IMAGE) {
      try {
        return GCWSymbolContainer(
            symbol: Image.memory(bytes)
        );
      } catch (e) {
        return Container();
      }
    }
    else if (mimitye == MIMETYPE.TEXT) {
      return GCWDefaultOutput(
          child: intListToString(bytes)
      );
    }
    else if (mimitye == MIMETYPE.ARCHIV) {

      if (getFileType(bytes).endsWith('.zip')) {
        var fileNames = 'zip-file\n';
        try {
          InputStream input = new InputStream(bytes.buffer.asByteData());
          // Decode the Zip file
          final archive = ZipDecoder().decodeBuffer(input);
          fileNames = archive
              .map((zipfile) {
                return ('-> ' + zipfile.name);
              })
            .join('\n');

        } catch (e) {}


        return GCWDefaultOutput(
            child: fileNames
        );
      }
      else if (getFileType(bytes).endsWith('.zip')) {
        var fileNames = 'zip-file\n';
        try {
          InputStream input = new InputStream(bytes.buffer.asByteData());
          // Decode the Zip file
          final archive = ZipDecoder().decodeBuffer(input);
          fileNames = archive
              .map((zipfile) {
            return ('-> ' + zipfile.name);
          })
              .join('\n');

        } catch (e) {}


        return GCWDefaultOutput(
            child: fileNames
        );
      }
      else
        return GCWDefaultOutput(
            child: getFileType(bytes)
        );
    };
  }


//exportFile(text, exportLabel, mode, context);
    // return await saveByteDataToFile(
    //     data, widget.symbolKey + '_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '.png');


}
