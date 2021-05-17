import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_imageview_fullscreen.dart';
import 'package:gc_wizard/widgets/common/gcw_popup_menu.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/tools/images_and_files/exif_reader.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

class GCWImageViewData {
  final Uint8List bytes;
  final String description;

  const GCWImageViewData(this.bytes, {this.description});
}

class GCWImageView extends StatefulWidget {
  final GCWImageViewData imageData;
  final bool toolBarRight;

  const GCWImageView({Key key, @required this.imageData, this.toolBarRight: true}) : super(key: key);

  @override
  _GCWImageViewState createState() => _GCWImageViewState();
}

class _GCWImageViewState extends State<GCWImageView> {
  MemoryImage _image;

  PhotoViewScaleStateController _scaleStateController;

  @override
  void initState() {
    super.initState();
    _scaleStateController = PhotoViewScaleStateController();
  }

  @override
  void dispose() {
    _scaleStateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      if (widget.imageData != null) _image = MemoryImage(widget.imageData.bytes);
    } catch (e) {
      _image = null;
    }

    return Column(children: <Widget>[
      if (_image != null)
        widget.toolBarRight
            ? Row(
                children: [
                  Expanded(child: _createPhotoView()),
                  Column(
                    children: _createToolbar(),
                  )
                ],
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: _createToolbar(),
                  ),
                  _createPhotoView(),
                ],
              )
    ]);
  }

  _createPhotoView() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: widget.toolBarRight ? DEFAULT_MARGIN : DOUBLE_DEFAULT_MARGIN,
            right: widget.toolBarRight ? 5 * DEFAULT_MARGIN : DOUBLE_DEFAULT_MARGIN,
          ),
          height: 250.0,
          child: ClipRect(
            child: PhotoView(
              scaleStateController: _scaleStateController,
              imageProvider: _image,
              minScale: PhotoViewComputedScale.contained * 0.25,
              initialScale: PhotoViewComputedScale.contained,
            ),
          ),
        ),
        if ((widget.imageData.description ?? '').trim().length > 0)
          Container(
              padding: EdgeInsets.only(top: 10),
              child: GCWText(
                text: widget.imageData.description.trim(),
                align: Alignment.center,
              ))
      ],
    );
  }

  _createToolbar() {
    var iconSize = widget.toolBarRight ? IconButtonSize.NORMAL : IconButtonSize.SMALL;

    return [
      GCWIconButton(
          iconData: Icons.zoom_out_map,
          size: iconSize,
          onPressed: () {
            Navigator.push(
                context,
                NoAnimationMaterialPageRoute(
                    builder: (context) => GCWTool(
                          tool: GCWImageViewFullScreen(
                            imageProvider: _image,
                          ),
                          autoScroll: false,
                          toolName: i18n(context, 'imageview_fullscreen_title'),
                          defaultLanguageToolName:
                              i18n(context, 'imageview_fullscreen_title', useDefaultLanguage: true),
                          suppressHelpButton: true,
                        )));
          }),
      GCWIconButton(
          iconData: Icons.fit_screen,
          size: iconSize,
          onPressed: () {
            _scaleStateController.scaleState = PhotoViewScaleState.initial;
          }),
      widget.toolBarRight
          ? Container(height: 60)
          : Expanded(
              child: Container(),
            ),
      GCWIconButton(
          iconData: Icons.save,
          size: iconSize,
          onPressed: () {
            _exportFile(context, widget.imageData.bytes);
          }),
      GCWPopupMenu(
          iconData: Icons.open_in_new,
          size: iconSize,
          menuItemBuilder: (context) => [
                GCWPopupMenuItem(
                  child: iconedGCWPopupMenuItem(context, Icons.info_outline, 'imageview_openinmetadata'),
                  action: (index) => setState(() {
                    _openInMetadataViewer();
                  }),
                  //action: (index) => _openInMetadataViewer,
                ),
                GCWPopupMenuItem(
                    child: iconedGCWPopupMenuItem(context, Icons.brush, 'imageview_openincolorcorrection'),
                    action: (index) => setState(() {
                          _openInColorCorrections();
                        })),
              ])
    ];
  }

  _openInMetadataViewer() {
    PlatformFile file = PlatformFile(bytes: widget.imageData.bytes);
    Navigator.push(
        context,
        NoAnimationMaterialPageRoute(
            builder: (context) => GCWTool(
                //tool: ImageMetadataViewer(),
                tool: ExifReader(file: file),
                toolName: i18n(context, 'exif_title'),
                i18nPrefix: '',
                missingHelpLocales: [])));
  }

  _openInColorCorrections() {
    // TODO
    // Navigator.push(
    //     context,
    //     NoAnimationMaterialPageRoute(
    //         builder: (context) => GCWTool(
    //             tool: ImageColorCorrections(),
    //             i18nPrefix: '',
    //             missingHelpLocales: [])));
  }

  _exportFile(BuildContext context, Uint8List data) async {
    var fileType = getFileType(data);
    var value = await saveByteDataToFile(data.buffer.asByteData(),
        'imageview_export_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + fileType);

    if (value != null) showExportedFileDialog(context, value['path'], fileType: fileType);
  }
}
