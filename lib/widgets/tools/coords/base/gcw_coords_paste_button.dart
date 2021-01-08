import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/parser/latlon.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_paste_button.dart';

class GCWCoordsPasteButton extends StatefulWidget {
  final Function onPasted;
  final IconButtonSize size;
  final Widget customIcon;
  final Color backgroundColor;

  const GCWCoordsPasteButton({Key key, this.onPasted, this.size, this.backgroundColor, this.customIcon}) : super(key: key);

  @override
  _GCWCoordsPasteButtonState createState() => _GCWCoordsPasteButtonState();
}

class _GCWCoordsPasteButtonState extends State<GCWCoordsPasteButton> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GCWPasteButton(
      size: widget.size,
      customIcon: widget.customIcon,
      backgroundColor: widget.backgroundColor,
      onSelected: _parseClipboardAndSetCoords,
    );
  }

  _parseClipboardAndSetCoords(text) {
    var parsed = parseLatLon(text);
    if (parsed == null || parsed['coordinate'] == null) {
      showToast(i18n(context, 'coords_common_clipboard_nocoordsfound'));
      widget.onPasted(null);
      return;
    }

    widget.onPasted(parsed);
  }
}
