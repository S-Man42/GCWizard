import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';

class GCWSubmitFlatButton extends StatefulWidget {
  final Function onPressed;

  const GCWSubmitFlatButton({Key key, this.onPressed}) : super(key: key);

  @override
  _GCWSubmitFlatButtonState createState() => _GCWSubmitFlatButtonState();
}

class _GCWSubmitFlatButtonState extends State<GCWSubmitFlatButton> {

  @override
  Widget build(BuildContext context) {
    return GCWButton(
      onPressed: widget.onPressed,
      text: i18n(context, 'common_submit_button_text')
    );
  }
}
