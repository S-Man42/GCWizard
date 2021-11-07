import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/images_and_files/symbol_replacer.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_divider.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_async_executer.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_gallery.dart';
import 'package:gc_wizard/widgets/common/gcw_imageview.dart';
import 'package:gc_wizard/widgets/common/gcw_openfile.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart' as local;
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SymbolReplacer extends StatefulWidget {
  final local.PlatformFile platformFile;

  const SymbolReplacer({Key key, this.platformFile}) : super(key: key);

  @override
  SymbolReplacerState createState() => SymbolReplacerState();
}

class SymbolReplacerState extends State<SymbolReplacer> {
  SymbolImage _symbolImage;
  local.PlatformFile _platformFile;
  ItemScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ItemScrollController();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.platformFile != null) {
      _platformFile = widget.platformFile;
      //_analysePlatformFileAsync();
    }

    return Column(children: <Widget>[
      GCWOpenFile(
        supportedFileTypes: SUPPORTED_IMAGE_TYPES,
        onLoaded: (_file) {
          if (_file == null) {
            showToast(i18n(context, 'common_loadfile_exception_notloaded'));
            return;
          }

          if (_file != null) {
            setState(() {
              _platformFile = _file;
              _symbolImage = null;
              _analysePlatformFileAsync();
            });
          }
        },
      ),
      GCWDefaultOutput(
          child: _buildList(),
           trailing: Row(children: <Widget>[
             GCWIconButton(
               size: IconButtonSize.SMALL,
               iconData: Icons.zoom_in,
               onPressed: () {
                 setState(() {
                   // int newCountColumn = max(countColumns - 1, 1);
                   // mediaQueryData.orientation == Orientation.portrait
                   //     ? Prefs.setInt('symboltables_countcolumns_portrait', newCountColumn)
                   //     : Prefs.setInt('symboltables_countcolumns_landscape', newCountColumn);
                 });
               },
             ),
             GCWIconButton(
               size: IconButtonSize.SMALL,
               iconData: Icons.zoom_out,
               onPressed: () {
                 setState(() {
                   // int newCountColumn = countColumns + 1;
                   // mediaQueryData.orientation == Orientation.portrait
                   //     ? Prefs.setInt('symboltables_countcolumns_portrait', newCountColumn)
                   //     : Prefs.setInt('symboltables_countcolumns_landscape', newCountColumn);
                 });
               },
             ),
           ])
      ),
      _buildOutput()
    ]);
  }


  _analysePlatformFileAsync() {
    _symbolImage = replaceSymbols(_platformFile.bytes, 50, 100, symbolImage: _symbolImage);

  }

  Widget _buildList() {
    if (_symbolImage == null)
      return Container();

    var odd = false;

    var rows = _symbolImage.symbolGroups.map((entry) {
      odd = !odd;
      return _buildRow(entry, odd);
    }).toList();

    return Column(children: rows);
  }

  Widget _buildRow(SymbolGroup entry, bool odd) {
    Widget output;

    var row = Container(
        child: Column(children: <Widget>[
          Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Image.memory(entry.getImage())
                ),
              flex: 2,
            ),
            Icon(
              Icons.arrow_forward,
              color: themeColors().mainFont(),
            ),
            Expanded(
                child: Column(children: <Widget>[
                    GCWTextField(
                    // controller: _editValueController,
                    // inputFormatters: widget.valueInputFormatters,
                      autofocus: true,
                      onChanged: (text) {
                        setState(() {
                          entry.text = text;
                        });
                      },
                    ),

                    Row(children: <Widget>[
                        Expanded(child:
                          Text(entry.symbolList.length.toString() +' Symbol(s)')
                        ),
                      GCWIconButton(
                        iconData: Icons.remove,
                        onPressed: () {
                          setState(() {
                            entry.viewGroupImage = !entry.viewGroupImage;
                            //if (widget.onRemoveEntry != null) widget.onRemoveEntry(getEntryId(entry), context);
                          });
                        },
                      )
                    ],
                    ),
                ]),
                flex: 3),
            ],
          ),
          (entry.viewGroupImage != true)
            ? Container()
            : Container(
                margin: EdgeInsets.only(top: 10),
                height: 50,
                child: ScrollablePositionedList.builder(
                  itemScrollController: _scrollController,
                  itemCount: entry.symbolList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => InkWell(
                    child: Image.memory(entry.symbolList[index].getImage()),
                  )),
              )
          ]),
        );

    if (odd) {
      output = Container(color: themeColors().outputListOddRows(), child: row);
    } else {
      output = Container(child: row);
    }

    return output;
  }

  Widget _buildOutput() {
    if (_symbolImage == null)
      return Container();

    replaceSymbols(_platformFile.bytes, 50, 90, symbolImage: _symbolImage);
    var imageData = GCWImageViewData(local.PlatformFile(bytes: _symbolImage.getImage()));
    return Column(children: <Widget>[
      GCWDefaultOutput(child: GCWImageView(imageData: imageData)),
      GCWDefaultOutput(child: _symbolImage.getTextOutput())
    ]);
  }

  _exportFiles(BuildContext context, String fileName, List<Uint8List> data) async {
    createZipFile(fileName, '.' + fileExtension(FileType.PNG), data).then((bytes) async {
      var fileType = FileType.ZIP;
      var value = await saveByteDataToFile(context, bytes,
          'anim_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '.' + fileExtension(fileType));

      if (value != null) showExportedFileDialog(context, fileType: fileType);
    });
  }
}

