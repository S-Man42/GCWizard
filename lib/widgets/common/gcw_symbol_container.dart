import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';

class GCWSymbolContainer extends StatefulWidget {
  final Image symbol;
  final Color backgroundColor;
  final Color borderColor;
  final bool showBackground;
  final bool showBorder;

  const GCWSymbolContainer(
      {Key key,
      @required this.symbol,
      this.backgroundColor,
      this.borderColor,
      this.showBackground: true,
      this.showBorder: true})
      : super(key: key);

  @override
  _GCWSymbolContainerState createState() => _GCWSymbolContainerState();
}

class _GCWSymbolContainerState extends State<GCWSymbolContainer> {
  @override
  Widget build(BuildContext context) {
    var backgroundColor;
    var borderColor;
    if (widget.showBackground) {
      backgroundColor = widget.backgroundColor ?? themeColors().iconImageBackground();
    }
    if (widget.showBorder) {
      borderColor = widget.borderColor ?? themeColors().mainFont();
    }

    return Container(
      child: widget.symbol,
      decoration: BoxDecoration(color: backgroundColor, border: Border.all(color: borderColor)),
      padding: EdgeInsets.all(2),
    );
  }
}
