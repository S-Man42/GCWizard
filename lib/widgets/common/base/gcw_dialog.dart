import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

TextStyle _textStyle = TextStyle(
  fontFamily: gcwTextStyle().fontFamily,
  fontSize: defaultFontSize(),
  color: ThemeColors.darkgrey
);

TextStyle _boldTextStyle = TextStyle(
  fontFamily: _textStyle.fontFamily,
  fontSize: _textStyle.fontSize,
  color: _textStyle.color,
  fontWeight: FontWeight.bold
);

showGCWDialog(BuildContext context, String title, String text, List<GCWDialogButton> buttons, {cancelButton: true}) {
  if (cancelButton)
    buttons.insert(0, _cancelButton);

  AlertDialog dialog = AlertDialog(
    title: Text(title),
    content: Text(text),
    actions: buttons,
    backgroundColor: ThemeColors.accent,
    titleTextStyle: _boldTextStyle,
    contentTextStyle: _textStyle
  );

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return dialog;
    },
  );
}

showGCWAlertDialog(BuildContext context, String title, String text, Function onOKPressed) {
  GCWDialogButton _okButton = GCWDialogButton(
    text: i18n(context, 'common_ok'),
    onPressed: onOKPressed
  );

  showGCWDialog(context, title, text, [_okButton]);
}

class GCWDialogButton extends StatefulWidget {
  final String text;
  final isCancelButton;
  final Function onPressed;

  const GCWDialogButton({Key key, this.text, this.onPressed, this.isCancelButton: false}) : super(key: key);

  @override
  _GCWDialogButtonState createState() => _GCWDialogButtonState();
}

class _GCWDialogButtonState extends State<GCWDialogButton> {

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        widget.isCancelButton ? i18n(context, 'common_cancel') : widget.text,
        style: _boldTextStyle,
      ),
      onPressed: () {
        Navigator.of(context).pop();

        if (!widget.isCancelButton && widget.onPressed != null)
          widget.onPressed();
      },
    );
  }
}

final _cancelButton = GCWDialogButton(
  isCancelButton: true,
);