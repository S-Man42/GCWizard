import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/persistence/formula_solver/model.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_checkbox.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/common/base/gcw_divider.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';

List<String> _output;

showFormulaReplaceDialog(BuildContext context, List<Formula> formulas,
    {Widget contentWidget, int dialogHeight, Function onOkPressed}) {
  showGCWDialog(
      context,
      i18n(context, 'formulasolver_formulas_modifyformula'),
      GCWFormulaReplace(formulas: formulas.map((formula) => formula.formula).toList()),
      [
        GCWDialogButton(
            text: i18n(context, 'common_ok'),
            onPressed: () {
              if (onOkPressed != null) onOkPressed(_output);
            })
      ],
      cancelButton: true);
}

class GCWFormulaReplace extends StatefulWidget {
  final List<String> formulas;

  const GCWFormulaReplace({Key key, this.formulas}) : super(key: key);

  @override
  GCWFormulaReplaceState createState() => GCWFormulaReplaceState();
}

class GCWFormulaReplaceState extends State<GCWFormulaReplace> {
  bool _currentValueBracket = false;
  bool _currentValueBraces = false;
  bool _currentValueMultiply = false;

  var textStyle = gcwTextStyle().copyWith(color: themeColors().dialogText());

  var _currentFormulaIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GCWTextDivider(
            text: i18n(context, 'formulasolver_formulas_modifiedformula'),
            style: textStyle,
            suppressTopSpace: true,
            trailing: widget.formulas == null || widget.formulas.length <= 1
                ? Container()
                : Row(
                    children: [
                      GCWIconButton(
                        iconData: Icons.arrow_back_ios,
                        size: IconButtonSize.SMALL,
                        iconColor: gcwDialogTextStyle().color,
                        onPressed: () {
                          setState(() {
                            _currentFormulaIndex = modulo(_currentFormulaIndex - 1, widget.formulas.length);
                          });
                        },
                      ),
                      GCWIconButton(
                        iconData: Icons.arrow_forward_ios,
                        size: IconButtonSize.SMALL,
                        iconColor: gcwDialogTextStyle().color,
                        onPressed: () {
                          setState(() {
                            _currentFormulaIndex = modulo(_currentFormulaIndex + 1, widget.formulas.length);
                          });
                        },
                      )
                    ],
                  )),
        GCWText(
          text: _buildNewFormula(widget.formulas)[_currentFormulaIndex],
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
              _buildNewFormula(widget.formulas);
            });
          },
          fillColor: MaterialStateColor.resolveWith(getFillColor),
          checkColor: themeColors().dialog(),
          hoverColor: themeColors().dialog(),
          overlayColor: MaterialStateColor.resolveWith(getOverlayColor),
        ),
        GCWCheckBox(
          value: _currentValueBraces,
          title: i18n(context, 'formulasolver_formulas_outerbrackets') + ' { } ➔ [ ]',
          textStyle: textStyle,
          onChanged: (value) {
            setState(() {
              _currentValueBraces = value;
              _buildNewFormula(widget.formulas);
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
              _buildNewFormula(widget.formulas);
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

  List<String> _buildNewFormula(List<String> formulas) {
    if (formulas == null || formulas.isEmpty) {
      return <String>[];
    }

    _output = List.from(formulas);

    if (_currentValueBracket) _output = _replaceBrackets (_output, '(' , ')');

    if (_currentValueBraces) _output = _replaceBrackets (_output, '{' , '}');

    if (_currentValueMultiply) {
      _output = _output.map((formula) => formula.replaceAll(RegExp(r'[xX]'), '*')).toList();
    }

    return _output;
  }

  List<String> _replaceBrackets(List<String> formulas, String openBracket, String closeBracket) {
    int ignoreBracket = 0;

    formulas = formulas.map((formula) {
      if (formula == null || formula.isEmpty) {
        return null;
      }

      return formula.split('').map((e) {
        if ((e == openBracket) || (e == '[')) {
          e = (ignoreBracket == 0) ? '[' : e;
          ignoreBracket += 1;
        } else if ((e == closeBracket) || (e == ']')) {
          ignoreBracket -= 1;
          e = (ignoreBracket == 0) ? ']' : e;
        }
        return e;
      }).join();
    }).toList();

    return formulas;
  }
}
