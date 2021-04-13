import 'dart:io';

import 'package:exif/exif.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/exif_reader.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';

class ExifReader extends StatefulWidget {
  ExifReader({Key key}) : super(key: key);

  @override
  _ExifReaderState createState() => _ExifReaderState();
}

class _ExifReaderState extends State<ExifReader> {
  Map<String, List<List<dynamic>>> tableTags;
  PlatformFile file;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      GCWButton(
        text: i18n(context, 'open_file'),
        onPressed: () async {
          await readFile();
        },
      ),
      GCWText(
        text: file == null ? "" : file.path,
      ),
      ...decorateTags(tableTags)
    ]);
  }

  Future<void> readFile() async {
    List<PlatformFile> files = await openFileExplorer(
      allowedExtensions: ['jpg', 'jpeg', 'tiff'],
    );
    if (files != null) {
      PlatformFile _file = files.first;

      print(_file.name);
      print(_file.bytes);
      print(_file.size);
      print(_file.extension);
      print(_file.path);

      Map<String, List<List<dynamic>>> _tableTags = await parseExif(_file.path);
      setState(() {
        file = _file;
        tableTags = _tableTags;
      });
    } else {
      // User canceled the picker
    }
  }
  static void _sortTags(List tags) {
    tags.sort((a, b) {
      return a[0].toLowerCase().compareTo(b[0].toLowerCase());
    });
  }

  List decorateTags(Map tableTags) {
    List<Widget> widgets = [];
    if (tableTags!=null) {
      tableTags.forEach((key, tags) {
        _sortTags(tags);
        widgets.add(GCWOutput(
            title: key ?? '',
            child: Column(
                children: columnedMultiLineOutput(
                  null,
                  tags == null ? [] : tags,
                ))));
      });
    }
    return widgets;
  }
}
