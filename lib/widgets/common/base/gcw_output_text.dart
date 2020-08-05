import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class GCWOutputText extends StatefulWidget {
  final String text;
  final Alignment align;
  final bool isMonotype;
  final TextStyle style;

  const GCWOutputText({Key key, this.text, this.align: Alignment.centerLeft, this.isMonotype: false, this.style}) : super(key: key);

  @override
  _GCWOutputTextState createState() => _GCWOutputTextState();
}

class _GCWOutputTextState extends State<GCWOutputText> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: SelectableText(
              widget.text,
              textAlign: TextAlign.left,
              style: widget.style ?? (widget.isMonotype ? gcwMonotypeTextStyle() : gcwTextStyle()),
            )
          ),
        ),
        widget.text != null && widget.text.length > 0
          ? GCWIconButton(
              color: widget.style != null ? widget.style.color : Colors.white,
              size: IconButtonSize.SMALL,
              iconData: Icons.content_copy,
              onPressed: () {
                Clipboard.setData(ClipboardData(text: widget.text));
                insertIntoGCWClipboard(widget.text);

                showToast(i18n(context, 'common_clipboard_copied'));
              },
            )
          : Container()
      ],
    );
  }
}
