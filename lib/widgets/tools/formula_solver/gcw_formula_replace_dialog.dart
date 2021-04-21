import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/persistence/formula_solver/model.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_checkbox.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/common/base/gcw_divider.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';

String output;

showFormulaReplaceDialog(BuildContext context, Formula formula,
    {Widget contentWidget, int dialogHeight, Function onOkPressed}) {
  showGCWDialog(
      context,
      i18n(context, 'formulasolver_formulas_modifyformula'),
      GCWFormulaReplace(formula: formula.formula),
      [
        GCWDialogButton(
            text: i18n(context, 'common_ok'),
            onPressed: () {
              if (onOkPressed != null) onOkPressed(output);
            })
      ],
      cancelButton: true);
}

class GCWFormulaReplace extends StatefulWidget {
  final String formula;

  const GCWFormulaReplace({Key key, this.formula}) : super(key: key);

  @override
  GCWFormulaReplaceState createState() => GCWFormulaReplaceState();
}

class GCWFormulaReplaceState extends State<GCWFormulaReplace> {
  bool _currentValueBracket = false;
  bool _currentValueMultiply = false;

  var textStyle = gcwTextStyle().copyWith(color: themeColors().dialogText());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GCWTextDivider(text: i18n(context, 'formulasolver_formulas_modifiedformula'), style: textStyle),
        GCWText(
          text: _buildNewFormula(widget.formula),
          style: textStyle,
        ),
        Container(
          child: GCWDivider(color: textStyle.color),
          padding: EdgeInsets.only(top: 6 * DEFAULT_MARGIN),
        ),
        GCWCheckBox(
          value: _currentValueBracket,
          title: i18n(context, 'formulasolver_formulas_outerbrackets') + ' ( ) ➔ [ ]',
          textStyle: textStyle,
          onChanged: (value) {
            setState(() {
              _currentValueBracket = value;
              _buildNewFormula(widget.formula);
            });
          },
          fillColor: MaterialStateColor.resolveWith(getFillColor),
          checkColor: themeColors().dialog(),
          hoverColor: themeColors().dialog(),
          overlayColor: MaterialStateColor.resolveWith(getOverlayColor),
        ),
        GCWCheckBox(
          value: _currentValueMultiply,
          title: 'x ➔ *',
          textStyle: textStyle,
          onChanged: (value) {
            setState(() {
              _currentValueMultiply = value;
              _buildNewFormula(widget.formula);
            });
          },
          fillColor: MaterialStateColor.resolveWith(getFillColor),
          checkColor: themeColors().dialog(),
          hoverColor: themeColors().dialog(),
          overlayColor: MaterialStateColor.resolveWith(getOverlayColor),
        )
      ],
    );
  }

  Color getOverlayColor(Set<MaterialState> states) {
    return themeColors().dialog();
  }

  Color getFillColor(Set<MaterialState> states) {
    return Colors.black;
  }

  String _buildNewFormula(String formula) {
    output = formula;

    if (output == null || output == "") return output;

    if (_currentValueBracket) {
      int ignoreBracket = 0;

      output = output.split('').map((e) {
        switch (e) {
          case '[':
          case '(':
            e = (ignoreBracket == 0) ? '[' : e;
            ignoreBracket += 1;
            break;
          case ']':
          case ')':
            ignoreBracket -= 1;
            e = (ignoreBracket == 0) ? ']' : e;
            break;
        }
        return e;
      }).join();
    }
    if (_currentValueMultiply) output = output.replaceAll(RegExp(r'[xX]'), '*');
    return output;
  }
}
