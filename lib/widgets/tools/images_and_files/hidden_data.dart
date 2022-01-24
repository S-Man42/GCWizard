import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/images_and_files/hidden_data.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_divider.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_files_output.dart';
import 'package:gc_wizard/widgets/common/gcw_openfile.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart';
import 'package:intl/intl.dart';

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
        _currentMode == GCWSwitchPosition.right ? _buildUnhideWidget() : _buildHideWidget()
      ],
    );
  }

  _buildHideWidget() {
    return Column(
      children: [
        GCWOpenFile(
          title: i18n(context, 'hiddendata_openpublicfile'),
          file: _publicFile,
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
        GCWTextDivider(text: i18n(context, 'hiddendata_opensecretfile')),
        GCWTwoOptionsSwitch(
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
        if (_currentHideMode == GCWSwitchPosition.left)
          GCWTextField(
            controller: _hideController,
            onChanged: (text) {
              _currentHideInput = text;
            },
          ),
        if (_currentHideMode == GCWSwitchPosition.right)
          GCWOpenFile(
            file: _secretFile,
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
        Container(height: 15),
        GCWDivider(),
        GCWButton(
          text: i18n(context, 'hiddendata_hideandsave'),
          onPressed: () {
            var data;
            if (_currentHideMode == GCWSwitchPosition.left) {
              data = mergeFiles([_publicFile.bytes, _currentHideInput]);
            } else {
              data = mergeFiles([_publicFile.bytes, _secretFile.bytes]);
            }

            _exportFile(context,
                PlatformFile(name: 'hidden_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()), bytes: data));
          },
        )
      ],
    );
  }

  _buildUnhideWidget() {
    return Column(
      children: [
        Container(), // fixes strange behaviour: First GCWOpenFile widget from hide/unhide affect each other
        GCWOpenFile(
          file: _unHideFile,
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

  _buildOutput() {
    if (_unHideFile == null) return null;

    var _hiddenDataList = hiddenData(_unHideFile);
    if (_hiddenDataList == null || _hiddenDataList.isEmpty) return i18n(context, 'hiddendata_nohiddendatafound');

    return GCWFilesOutput(files: _hiddenDataList);
  }

  _exportFile(BuildContext context, PlatformFile file) async {
    if (file.bytes == null) {
      showToast(i18n(context, 'hiddendata_datanotreadable'));
      return;
    }

    var fileName = file.name.replaceFirst(HIDDEN_FILE_IDENTIFIER, 'hidden_file');
    var ext = file.name.split('.');

    if (ext.length <= 1 || ext.last.length >= 5) fileName = fileName + '.' + fileExtension(file.fileType);

    var value = await saveByteDataToFile(context, file.bytes, fileName);
    if (value != null) showExportedFileDialog(context, fileType: file.fileType);
  }
}

openInHiddenData(BuildContext context, PlatformFile file) {
  Navigator.push(
      context,
      NoAnimationMaterialPageRoute(
          builder: (context) => GCWTool(
              tool: HiddenData(platformFile: file), toolName: i18n(context, 'hiddendata_title'), i18nPrefix: '')));
}
