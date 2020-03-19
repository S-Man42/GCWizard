import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/colors.dart';

class GCWDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: ThemeColors.gray,
      indent: 15,
      endIndent: 15
    );
  }
}
