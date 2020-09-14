import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme_colors.dart';

class GCWDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: ThemeColors.lightGray,
      indent: 15,
      endIndent: 15
    );
  }
}
