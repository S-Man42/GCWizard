import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/gcw_toolbar.dart';

class GCWEncryptButtonBar extends StatefulWidget {
  final Function onPressedEncode;
  final Function onPressedDecode;

  const GCWEncryptButtonBar({
    Key key,
    this.onPressedEncode,
    this.onPressedDecode,
  }) : super(key: key);

  @override
  _GCWEncryptButtonBarState createState() => _GCWEncryptButtonBarState();
}

class _GCWEncryptButtonBarState extends State<GCWEncryptButtonBar> {

  @override
  Widget build(BuildContext context) {
    return GCWToolBar(
      children: [
        GCWButton(
          text: i18n(context, 'common_encrypt'),
          onPressed: widget.onPressedEncode
        ),
        GCWButton(
          text: i18n(context, 'common_decrypt'),
          onPressed: widget.onPressedDecode,
        ),
      ]
    );
  }
}
