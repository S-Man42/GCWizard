import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class GCWDropDownButton extends StatefulWidget {
  final Function onChanged;
  final items;
  final value;
  final DropdownButtonBuilder selectedItemBuilder;

  const GCWDropDownButton({
    Key key,
    this.value,
    this.items,
    this.onChanged,
    this.selectedItemBuilder
  }) : super(key: key);

  @override
  _GCWDropDownButtonState createState() => _GCWDropDownButtonState();
}

class _GCWDropDownButtonState extends State<GCWDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
      height: 39,
      margin: EdgeInsets.symmetric(vertical: DEFAULT_MARGIN),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(roundedBorderRadius),
        border: Border.all(
          color: ThemeColors.accent, style: BorderStyle.solid, width: 1.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          icon: Icon(
            Icons.arrow_drop_down,
            size: 30,
            color: ThemeColors.accent,
          ),
          value: widget.value ?? widget.items[0].value,
          items: widget.items,
          onChanged: widget.onChanged,
          style: TextStyle(fontSize: defaultFontSize()),
          selectedItemBuilder: widget.selectedItemBuilder,
        )
      )
    );
  }
}
