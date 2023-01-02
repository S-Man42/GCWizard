import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/logic/teletypewriter.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/base/n_segment_display/widget/n_segment_display.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/segment_display_utils/widget/segment_display_utils.dart';
import 'package:gc_wizard/tools/utils/file_utils/widget/file_utils.dart';
import 'package:intl/intl.dart';

import 'base/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/gcw_exported_file_dialog/gcw_exported_file_dialog.dart';
import 'gcw_text_divider.dart';

class GCWPunchtapeSegmentDisplayOutput extends StatefulWidget {
  final bool upsideDownButton;
  final NSegmentDisplay Function(Map<String, bool>, bool, TeletypewriterCodebook) segmentFunction;
  final List<List<String>> segments;
  final bool readOnly;
  final Widget trailing;
  final TeletypewriterCodebook codeBook;

  const GCWPunchtapeSegmentDisplayOutput(
      {Key key,
      this.upsideDownButton: false,
      this.segmentFunction,
      this.segments,
      this.readOnly,
      this.trailing,
      this.codeBook})
      : super(key: key);

  @override
  _GCWPunchtapeSegmentDisplayOutputState createState() => _GCWPunchtapeSegmentDisplayOutputState();
}

class _GCWPunchtapeSegmentDisplayOutputState extends State<GCWPunchtapeSegmentDisplayOutput> {
  var _currentUpsideDown = false;
  List<NSegmentDisplay> _displays;

  @override
  void initState() {
    super.initState();

    _currentUpsideDown = widget.upsideDownButton;
  }

  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return Column(children: <Widget>[
      GCWTextDivider(
        text: i18n(context, 'segmentdisplay_displayoutput'),
        trailing: Row(
          children: <Widget>[
            widget.upsideDownButton
                ? Container(
                    child: GCWIconButton(
                      icon: Icons.rotate_left,
                      size: IconButtonSize.SMALL,
                      onPressed: () {
                        setState(() {
                          _currentUpsideDown = !_currentUpsideDown;
                        });
                      },
                    ),
                  )
                : Container(),
            Container(
              child: GCWIconButton(
                size: IconButtonSize.SMALL,
                icon: Icons.save,
                iconColor: (widget.segments == null) || (widget.segments.length == 0) ? themeColors().inActive() : null,
                onPressed: () async {
                  await buildPunchtapeSegmentDisplayImage(_displays, _currentUpsideDown).then((image) {
                    if (image != null)
                      image.toByteData(format: ui.ImageByteFormat.png).then((data) {
                        _exportFile(context, data.buffer.asUint8List());
                      });
                  });
                },
              ),
              padding: EdgeInsets.only(right: 10.0),
            ),
          ],
        ),
      ),
      _buildDigitalOutput(widget.segments)
    ]);
  }

  Widget _buildDigitalOutput(List<List<String>> segments) {
    var list = _currentUpsideDown ? segments.reversed : segments;

    _displays = list.where((character) => character != null).map((character) {
      var displayedSegments = Map<String, bool>.fromIterable(character, key: (e) => e, value: (e) => true);
      return widget.segmentFunction(displayedSegments, widget.readOnly, widget.codeBook);
    }).toList();

    var viewList = !_currentUpsideDown
        ? _displays
        : _displays.map((display) {
            return Transform.rotate(angle: _currentUpsideDown ? pi : 0, child: display);
          }).toList();
    return buildPunchtapeSegmentDisplayOutput(viewList);
  }
}

_exportFile(BuildContext context, Uint8List data) async {
  var value =
      await saveByteDataToFile(context, data, 'img_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '.png');

  if (value != null) showExportedFileDialog(context, fileType: FileType.PNG, contentWidget: Image.memory(data));
}
