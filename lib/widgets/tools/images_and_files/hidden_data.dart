
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/images_and_files/hidden_data.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_openfile.dart';
import 'package:gc_wizard/widgets/common/gcw_popup_menu.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/tools/images_and_files/exif_reader.dart';
import 'package:gc_wizard/widgets/tools/images_and_files/hex_viewer.dart';
import 'package:gc_wizard/widgets/tools/images_and_files/image_colorcorrections.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart';

class HiddenData extends StatefulWidget {
  final PlatformFile platformFile;

  const HiddenData({Key key, this.platformFile}) : super(key: key);

  @override
  HiddenDataState createState() => HiddenDataState();
}

class HiddenDataState extends State<HiddenData> {
  TextEditingController _hideController;

  PlatformFile _unHideFile;

  PlatformFile _publicFile;
  PlatformFile _secretFile;

  var _currentMode = GCWSwitchPosition.right;
  var _currentHideMode = GCWSwitchPosition.left;

  String _currentHideInput = '';

  @override
  void initState() {
    super.initState();

    _hideController = TextEditingController(text: _currentHideInput);
  }

  @override
  void dispose() {
    _hideController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_unHideFile == null && widget.platformFile != null) {
      _unHideFile = widget.platformFile;
    }

    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'hiddendata_hidedata'),
          rightValue: i18n(context, 'hiddendata_unhidedata'),
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        if (_currentMode == GCWSwitchPosition.right)
          _buildUnhideWidget(),
        if (_currentMode == GCWSwitchPosition.left)
          _buildHideWidget()
      ],
    );
  }

  _buildHideWidget() {
    return Column(
      children: [
        GCWOpenFile(
          title: i18n(context, 'hiddendata_openpublicfile'),
          expanded: _publicFile == null,
          onLoaded: (_openedFile) {
            if (_openedFile == null) {
              showToast(i18n(context, 'common_loadfile_exception_notloaded'));
              return;
            }

            setState(() {
              _publicFile = _openedFile;
            });
          },
        ),
        Container(
          child:GCWTwoOptionsSwitch(
            title: i18n(context, 'hiddendata_hide'),
            leftValue: i18n(context, 'hiddendata_hide_text'),
            rightValue: i18n(context, 'hiddendata_hide_file'),
            value: _currentHideMode,
            onChanged: (value) {
              setState(() {
                _currentHideMode = value;
              });
            },
          ),
          padding: EdgeInsets.symmetric(vertical: 30)
        ),
        if (_currentHideMode == GCWSwitchPosition.left)
          GCWTextField(
            controller: _hideController,
            onChanged: (text) {
              _currentHideInput = text;
            },
          ),
        if (_currentHideMode == GCWSwitchPosition.right)
          GCWOpenFile(
            title: i18n(context, 'hiddendata_opensecretfile'),
            expanded: _secretFile == null,
            onLoaded: (_openedFile) {
              if (_openedFile == null) {
                showToast(i18n(context, 'common_loadfile_exception_notloaded'));
                return;
              }

              setState(() {
                _secretFile = _openedFile;
              });
            },
          ),
        GCWButton(
          text: i18n(context, 'hiddendata_hideandsave'),
          onPressed: () {
            var data;
            if (_currentHideMode == GCWSwitchPosition.left) {
              data = mergeFiles([_publicFile.bytes, _currentHideInput]);
            } else {
              data = mergeFiles([_publicFile.bytes, _secretFile.bytes]);
            }

            _exportFile(context, PlatformFile(
              name: _publicFile.name,
              bytes: data
            ));
          },
        )
      ],
    );
  }

  _buildUnhideWidget() {
    return Column(
      children: [
        GCWOpenFile(
          expanded: _unHideFile == null,
          onLoaded: (_openedFile) {
            if (_openedFile == null) {
              showToast(i18n(context, 'common_loadfile_exception_notloaded'));
              return;
            }

            setState(() {
              _unHideFile = _openedFile;
            });
          },
        ),

        GCWDefaultOutput(
          child: _buildOutput(),
          suppressCopyButton: true,
        )
      ],
    );
  }

  _buildActionButton(PlatformFile file) {
    var actions = <GCWPopupMenuItem>[
      GCWPopupMenuItem(
        child: iconedGCWPopupMenuItem(context, Icons.save, 'hiddendata_savefile'),
        action: (index) => setState(() {
          _exportFile(context, file);
        }),
      ),
      GCWPopupMenuItem(
        child: iconedGCWPopupMenuItem(context, Icons.text_snippet_outlined, 'hexviewer_openinhexviewer'),
        action: (index) => setState(() {
          openInHexViewer(context, file.bytes);
        }),
      ),
    ];

    switch (file.fileClass) {
      case FileClass.IMAGE:
        actions.addAll([
          GCWPopupMenuItem(
            child: iconedGCWPopupMenuItem(context, Icons.info_outline, 'exif_openinmetadata'),
            action: (index) => setState(() {
              openInMetadataViewer(context, file.bytes);
            }),
          ),
          GCWPopupMenuItem(
              child: iconedGCWPopupMenuItem(context, Icons.brush, 'image_colorcorrections_openincolorcorrection'),
              action: (index) => setState(() {
                openInColorCorrections(context, file.bytes);
              }),
          )
        ]);
        break;
      default:
        break;
    }

    return GCWPopupMenu(
        iconData: Icons.open_in_new,
        size: IconButtonSize.SMALL,
        menuItemBuilder: (context) => actions,
    );
  }

  Widget _buildFileTree(List<PlatformFile> files, int level) {
    var children = files.map((PlatformFile file) {
      var hasChildren = file.children != null && file.children.isNotEmpty;

      var actionButton = _buildActionButton(file);

      return Column(
        children: [
          Row (
            children: [
              Container(
                child: actionButton == null ? Container() : actionButton,
                width: 42,
                padding: EdgeInsets.only(right: 10)
              ),
              Expanded(
                child: GCWText(
                    text: file.name,
                    style: gcwTextStyle().copyWith(
                        fontWeight: hasChildren ? FontWeight.bold : FontWeight.normal
                    )
                ),
                flex: 10
              )
            ],
          ),
          if (hasChildren)
            Container(
              child: _buildFileTree(file.children, level + 1),
              padding: EdgeInsets.only(left: (level + 1) * 10 * DEFAULT_MARGIN),
            )
        ],
      );
    }).toList();

    return Column(
      children: children,
    );
  }

  _buildOutput() {
    if (_unHideFile == null)
      return null;

    var _hiddenDataList = hiddenData(_unHideFile);
    if (_hiddenDataList == null || _hiddenDataList.isEmpty)
      return i18n(context, 'hiddendata_nohiddendatafound');

    return _buildFileTree(_hiddenDataList, 0);
  }

  _exportFile(BuildContext context, PlatformFile file) async {
    var value = await saveByteDataToFile(file.bytes.buffer.asByteData(), file.name);
    if (value != null) showExportedFileDialog(context, value['path'], fileType: file.fileType);
  }
}

openInHiddenData(BuildContext context, {Uint8List data, PlatformFile file}) {
  Navigator.push(
      context,
      NoAnimationMaterialPageRoute(
          builder: (context) => GCWTool(
              tool: HiddenData(platformFile: file ?? PlatformFile(bytes: data)),
              toolName: i18n(context, 'hiddendata_title'),
              i18nPrefix: '',
              autoScroll: false,
              helpLocales: ['de', 'en', 'fr'])));
}