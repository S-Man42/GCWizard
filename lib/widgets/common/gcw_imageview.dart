import 'dart:typed_data';

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
import 'package:gc_wizard/widgets/tools/images_and_files/image_colorcorrections.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart' as local;
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

enum GCWImageViewButtons { ALL, SAVE, VIEW_IN_TOOLS }

class GCWImageViewData {
  final Uint8List bytes;
  final String description;
  final bool marked;

  const GCWImageViewData(this.bytes, {this.description, this.marked});
}

class GCWImageView extends StatefulWidget {
  final GCWImageViewData imageData;
  final bool toolBarRight;
  final String extension;
  final String fileName;
  final Set<GCWImageViewButtons> suppressedButtons;
  final int maxHeightInPreview;
  final Function onBeforeLoadBigImage;

  const GCWImageView(
      {Key key,
      @required this.imageData,
      this.toolBarRight: true,
      this.extension,
      this.fileName,
      this.suppressedButtons,
      this.maxHeightInPreview,
      this.onBeforeLoadBigImage})
      : super(key: key);

  @override
  _GCWImageViewState createState() => _GCWImageViewState();
}

class _GCWImageViewState extends State<GCWImageView> {
  MemoryImage _image;
  MemoryImage _previewImage;

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

  _resizeImage() {
    img.Image image = img.decodeImage(widget.imageData.bytes);
    if (image.height > widget.maxHeightInPreview) {
      img.Image resized = img.copyResize(image, height: widget.maxHeightInPreview);

      return MemoryImage(img.encodePng(resized));
    } else {
      return MemoryImage(widget.imageData.bytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      if (widget.imageData != null) _image = MemoryImage(widget.imageData.bytes);

      if (widget.maxHeightInPreview == null)
        _previewImage = MemoryImage(widget.imageData.bytes);
      else {
        _previewImage = _resizeImage();
      }
    } catch (e) {
      _image = null;
    }

    return Column(children: <Widget>[
      if (_image != null)
        widget.toolBarRight
            ? Row(
                children: [
                  Expanded(child: _createPhotoView()),
                  if (_hasToolButtons())
                    Column(
                      children: _createToolbar(),
                    )
                ],
              )
            : Column(
                children: [
                  if (_hasToolButtons())
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
            right: widget.toolBarRight
                ? (_hasToolButtons() ? 5 * DEFAULT_MARGIN : DOUBLE_DEFAULT_MARGIN)
                : DOUBLE_DEFAULT_MARGIN,
          ),
          height: 250.0,
          child: ClipRect(
            child: PhotoView(
              scaleStateController: _scaleStateController,
              imageProvider: _previewImage,
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

  bool _hasToolButtons() {
    return widget.suppressedButtons == null || !widget.suppressedButtons.contains(GCWImageViewButtons.ALL);
  }

  _openInFullScreen(Uint8List imgData) {
    Navigator.push(
        context,
        NoAnimationMaterialPageRoute(
            builder: (context) => GCWTool(
                  tool: GCWImageViewFullScreen(
                    imageData: imgData,
                  ),
                  autoScroll: false,
                  toolName: i18n(context, 'imageview_fullscreen_title'),
                  defaultLanguageToolName: i18n(context, 'imageview_fullscreen_title', useDefaultLanguage: true),
                  suppressHelpButton: true,
                )));
  }

  _createToolbar() {
    var iconSize = widget.toolBarRight ? IconButtonSize.NORMAL : IconButtonSize.SMALL;

    return [
      GCWIconButton(
          iconData: Icons.zoom_out_map,
          size: iconSize,
          onPressed: () {
            if (widget.onBeforeLoadBigImage != null) {
              widget.onBeforeLoadBigImage().then((imgData) {
                _openInFullScreen(imgData);
              });
            } else {
              _openInFullScreen(widget.imageData.bytes);
            }
          }),
      GCWIconButton(
          iconData: Icons.fit_screen,
          size: iconSize,
          onPressed: () {
            _scaleStateController.scaleState = PhotoViewScaleState.initial;
          }),
      if (widget.suppressedButtons == null || widget.suppressedButtons.length == 1)
        widget.toolBarRight
            ? Container(height: widget.suppressedButtons != null && widget.suppressedButtons.length == 1 ? 108 : 60)
            : Expanded(
                child: Container(),
              ),
      if (widget.suppressedButtons == null || !widget.suppressedButtons.contains(GCWImageViewButtons.SAVE))
        GCWIconButton(
            iconData: Icons.save,
            size: iconSize,
            onPressed: () {
              var imgData;
              if (widget.onBeforeLoadBigImage != null) {
                widget.onBeforeLoadBigImage().then((imgData) {
                  _exportFile(context, imgData);
                });
              } else {
                imgData = widget.imageData.bytes;
                _exportFile(context, imgData);
              }
            }),
      if (widget.suppressedButtons == null || !widget.suppressedButtons.contains(GCWImageViewButtons.VIEW_IN_TOOLS))
        GCWPopupMenu(
            iconData: Icons.open_in_new,
            size: iconSize,
            menuItemBuilder: (context) => [
                  GCWPopupMenuItem(
                    child: iconedGCWPopupMenuItem(context, Icons.info_outline, 'imageview_openinmetadata'),
                    action: (index) => setState(() {
                      if (widget.onBeforeLoadBigImage != null) {
                        widget.onBeforeLoadBigImage().then((imgData) {
                          _openInMetadataViewer(imgData);
                        });
                      } else {
                        _openInMetadataViewer(widget.imageData.bytes);
                      }
                    }),
                    //action: (index) => _openInMetadataViewer,
                  ),
                  GCWPopupMenuItem(
                      child: iconedGCWPopupMenuItem(context, Icons.brush, 'imageview_openincolorcorrection'),
                      action: (index) => setState(() {
                            if (widget.onBeforeLoadBigImage != null) {
                              widget.onBeforeLoadBigImage().then((imgData) {
                                _openInColorCorrections(imgData);
                              });
                            } else {
                              _openInColorCorrections(widget.imageData.bytes);
                            }
                          })),
                ])
    ];
  }

  _openInMetadataViewer(Uint8List imgData) {
    local.PlatformFile file = local.PlatformFile(bytes: imgData);
    Navigator.push(
        context,
        NoAnimationMaterialPageRoute(
            builder: (context) => GCWTool(
                tool: ExifReader(file: file),
                toolName: i18n(context, 'exif_title'),
                i18nPrefix: '',
                helpLocales: ['de', 'en', 'fr'])));
  }

  _openInColorCorrections(Uint8List imgData) {
    Navigator.push(
        context,
        NoAnimationMaterialPageRoute(
            builder: (context) => GCWTool(
                tool: ImageColorCorrections(imageData: imgData),
                toolName: i18n(context, 'image_colorcorrections_title'),
                i18nPrefix: '',
                autoScroll: false,
                helpLocales: ['de', 'en', 'fr'])));
  }

  _exportFile(BuildContext context, Uint8List data) async {
    String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    String outputFilename = 'imageview_export_${timestamp}.png';

    var value = await saveByteDataToFile(data.buffer.asByteData(), outputFilename);

    if (value != null) showExportedFileDialog(context, value['path'], fileType: '.png');
  }
}
