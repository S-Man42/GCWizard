import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/n_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/utils.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:intl/intl.dart';
import 'package:prefs/prefs.dart';

import 'base/gcw_iconbutton.dart';
import 'gcw_exported_file_dialog.dart';
import 'gcw_text_divider.dart';

class GCWDisplayOutput extends StatefulWidget {
  final bool upsideDownButton;
  final NSegmentDisplay Function(Map<String, bool>, bool) segmentFunction;
  final List<List<String>> segments;
  final bool readOnly;
  final Widget trailing;


  const GCWDisplayOutput({Key key, this.upsideDownButton: false, this.segmentFunction, this.segments, this.readOnly, this.trailing})
      : super(key: key);

  @override
  _GCWDisplayOutputState createState() => _GCWDisplayOutputState();
}

class _GCWDisplayOutputState extends State<GCWDisplayOutput> {
  var _currentUpsideDown = false;
  List<NSegmentDisplay> _displays;

  @override
  void initState() {
    super.initState();

    _currentUpsideDown = widget.upsideDownButton;
  }

  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    var countColumns = mediaQueryData.orientation == Orientation.portrait
        ? Prefs.get('symboltables_countcolumns_portrait')
        : Prefs.get('symboltables_countcolumns_landscape');

    return Column(children: <Widget>[
      GCWTextDivider(
        text: i18n(context, 'segmentdisplay_displayoutput'),
        trailing: Row(
          children: <Widget>[
            widget.upsideDownButton ?
            Container(
              child: GCWIconButton(
                iconData: Icons.rotate_left,
                size: IconButtonSize.SMALL,
                onPressed: () {
                  setState(() {
                    _currentUpsideDown = !_currentUpsideDown;
                  });
                },
              ),
              padding: EdgeInsets.only(right: 10.0),
            )
            : Container(),
            GCWIconButton(
              size: IconButtonSize.SMALL,
              iconData: Icons.zoom_in,
              onPressed: () {
                setState(() {
                  int newCountColumn = max(countColumns - 1, 1);
                  mediaQueryData.orientation == Orientation.portrait
                      ? Prefs.setInt('symboltables_countcolumns_portrait', newCountColumn)
                      : Prefs.setInt('symboltables_countcolumns_landscape', newCountColumn);
                });
              },
            ),
            GCWIconButton(
              size: IconButtonSize.SMALL,
              iconData: Icons.zoom_out,
              onPressed: () {
                setState(() {
                  int newCountColumn = countColumns + 1;

                  mediaQueryData.orientation == Orientation.portrait
                      ? Prefs.setInt('symboltables_countcolumns_portrait', newCountColumn)
                      : Prefs.setInt('symboltables_countcolumns_landscape', newCountColumn);
                });
              },
            ),
            Container(
              child: GCWIconButton(
                size: IconButtonSize.SMALL,
                iconData: Icons.save,
                iconColor:  (_displays == null) || (_displays.length == 0) ? Colors.grey : null,
                onPressed: ()  async {
                  await buildSegmentDisplayImage(countColumns, _displays).then((image) {
                    if (image != null) image.toByteData(format: ui.ImageByteFormat.png).then((data) {
                      _exportFile(context, data.buffer.asUint8List());
                    });
                  });
                },
              ),
              padding: EdgeInsets.only(right: 10.0),
            )
          ],
        ),
      ),
      _buildDigitalOutput(countColumns, widget.segments)
    ]);
  }

  Widget _buildDigitalOutput(int countColumns, List<List<String>> segments) {
    var list = _currentUpsideDown ? segments.reversed : segments;

    _displays = list.where((character) => character != null).map((character) {
      var displayedSegments = Map<String, bool>.fromIterable(character, key: (e) => e, value: (e) => true);
      return widget.segmentFunction(displayedSegments, widget.readOnly);

      /*return Transform.rotate(
          angle: _currentUpsideDown ? pi : 0,
          child: widget.segmentFunction(displayedSegments, widget.readOnly)
      ).child;*/

    }).toList();

    return buildSegmentDisplayOutput(countColumns, _displays);
  }
}

_exportFile(BuildContext context, Uint8List data) async {
  var value = await saveByteDataToFile(
      data, 'image_export_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '.png');

  if (value != null)
    showExportedFileDialog(context, value['path'], fileType: FileType.PNG, contentWidget: Image.memory(data));
}
