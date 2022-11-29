import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textselectioncontrols.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class GCWOutputText extends StatefulWidget {
  final String text;
  final Alignment align;
  final bool isMonotype;
  final TextStyle style;
  final bool suppressCopyButton;
  final dynamic copyText;

  const GCWOutputText(
      {Key key,
      this.text,
      this.align: Alignment.centerLeft,
      this.isMonotype: false,
      this.style,
      this.suppressCopyButton: false,
      this.copyText})
      : super(key: key);

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
                selectionControls: GCWTextSelectionControls(),
              )),
        ),
        widget.text != null && widget.text.length > 0 && !widget.suppressCopyButton
            ? GCWIconButton(
                iconColor: widget.style != null ? widget.style.color : themeColors().mainFont(),
                size: IconButtonSize.SMALL,
                icon: Icons.content_copy,
                onPressed: () {
                  var copyText = widget.copyText != null ? widget.copyText.toString() : widget.text;
                  insertIntoGCWClipboard(context, copyText);
                },
              )
            : Container()
      ],
    );
  }
}
