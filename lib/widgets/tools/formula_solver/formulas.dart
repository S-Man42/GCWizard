import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/database/formula_solver/database_provider.dart';
import 'package:gc_wizard/database/formula_solver/model.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/formula_solver/parser.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_delete_alertdialog.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/tools/formula_solver/values.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';

class Formulas extends StatefulWidget {
  final FormulaGroup group;

  const Formulas({Key key, this.group}) : super(key: key);

  @override
  FormulasState createState() => FormulasState();
}

class FormulasState extends State<Formulas> {
  FormulaSolverDbProvider dbProvider = FormulaSolverDbProvider();
  var formulaParser = FormulaParser();

  var _newFormulaController;
  var _editFormulaController;
  var _currentNewFormula = '';
  var _currentEditedFormula = '';
  var _currentEditId;

  List<Formula> _currentFormulas = [];
  Map<String, String> _currentValues = {};

  @override
  void initState() {
    super.initState();
    _newFormulaController = TextEditingController(text: _currentNewFormula);
    _editFormulaController = TextEditingController(text: _currentEditedFormula);

    dbProvider.getFormulasByGroup(widget.group).then((result) {
      setState(() {
        _currentFormulas = result;
      });
    });

    _getValues();
  }

  @override
  void dispose() {
    _newFormulaController.dispose();
    _editFormulaController.dispose();

    super.dispose();
  }

  _getValues() async {
    dbProvider.getFormulaValuesByGroup(widget.group).then((result) {
      setState(() {
        result.forEach((value) => _currentValues[value.key] = value.value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var formulaTool = GCWToolWidget(
      tool: FormulaValues(group: widget.group),
      toolName: '${widget.group.name} - ${i18n(context, 'formulasolver_values')}'
    );

    Future _navigateToSubPage(context) async {
      Navigator.push(context, NoAnimationMaterialPageRoute(
          builder: (context) => formulaTool)
      ).whenComplete(() {
        _getValues();
      });
    }

    return Column(
      children: <Widget>[
        GCWButton(
          text: i18n(context, 'formulasolver_formulas_values'),
          onPressed: () {
            _navigateToSubPage(context);
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'formulasolver_formulas_newformula')
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                child: GCWTextField(
                  hintText: i18n(context, 'formulasolver_formulas_newformula_hint'),
                  controller: _newFormulaController,
                  onChanged: (text) {
                    setState(() {
                      _currentNewFormula = text;
                    });
                  },
                ),
                padding: EdgeInsets.only(
                  right: 2,
                ),
              ),
            ),
            GCWIconButton(
              iconData: Icons.add,
              onPressed: () {
                _addNewFormula().whenComplete(() => setState(() {}));
              },
            )
          ],
        ),
        _buildGroupList(context)
      ],
    );
  }

  _addNewFormula() async {
    if (_currentNewFormula.length > 0) {
      var newFormula = Formula(_currentNewFormula, widget.group);
      newFormula.id = await dbProvider.insertFormula(newFormula);

      _currentFormulas.add(newFormula);
      _newFormulaController.clear();
      _currentNewFormula = '';
    }
  }

  _updateFormula(Formula formula) async {
    await dbProvider.updateFormula(formula);
  }

  _removeFormula(Formula formula) async {
    await dbProvider.deleteFormula(formula);
    _currentFormulas.remove(formula);
  }

  _buildGroupList(BuildContext context) {
    final double _BUTTON_SIZE = 40;

    var odd = true;
    var rows = _currentFormulas.map((formula) {
      var calculated = formulaParser.parse(formula.formula, _currentValues);

      Widget output;

      var row = Container(
        child: Row (
          children: <Widget>[
            Expanded(
              child: _currentEditId == formula.id
                ? Padding (
                    child: GCWTextField(
                      controller: _editFormulaController,
                      onChanged: (text) {
                        setState(() {
                          _currentEditedFormula = text;
                        });
                      },
                    ),
                    padding: EdgeInsets.only(
                      right: 2,
                    ),
                  )
                : Column(
                    children: <Widget>[
                      GCWText (
                        text: formula.formula
                      ),
                      Row (
                        children: <Widget>[
                          calculated['state'] == STATE_OK
                            ? Icon(
                                Icons.check,
                                color: ThemeColors.gray,
                              )
                            : Icon(
                                Icons.priority_high,
                                color: ThemeColors.accent,
                              ),
                          Flexible(
                            child:
                              GCWText (
                                text: calculated['result']
                              ),
                          )
                        ],
                      )

                    ]
                  ),
              flex: 1,
            ),
            _currentEditId == formula.id
              ? GCWIconButton(
                iconData: Icons.check,
                onPressed: () {
                  formula.formula = _currentEditedFormula;
                  _updateFormula(formula).whenComplete(() {
                    setState(() {
                      _currentEditId = null;
                      _editFormulaController.clear();
                    });
                  });
                },
              )
              : Container(),
            Container(
              width: _BUTTON_SIZE,
              height: _BUTTON_SIZE,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(roundedBorderRadius),
                  side:  BorderSide(
                    width: 1,
                    color: ThemeColors.accent,
                  ),
                ),
              ),
              child: PopupMenuButton(
                offset: Offset(0, _BUTTON_SIZE),
                icon: Icon(Icons.settings, color: Colors.white),
                color: ThemeColors.accent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(roundedBorderRadius),
                ),
                onSelected: (value) {
                  switch (value) {
                    case 1:
                      setState(() {
                        _currentEditId = formula.id;
                        _currentEditedFormula = formula.formula;
                        _editFormulaController.text = formula.formula;
                      });
                      break;
                    case 2:
                      showDeleteAlertDialog(context, formula.formula, () {
                        _removeFormula(formula).whenComplete(() => setState(() {}));
                      },);
                      break;
                    case 3:
                      Clipboard.setData(ClipboardData(text: formula.formula));
                      break;
                    case 4:
                      Clipboard.setData(ClipboardData(text: calculated['result']));
                      break;
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: _buildPopupItem(
                      Icons.edit,
                      'formulasolver_formulas_editformula'
                    )
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: _buildPopupItem(
                      Icons.delete,
                      'formulasolver_formulas_removeformula'
                    )
                  ),
                  PopupMenuItem(
                    value: 3,
                    child: _buildPopupItem(
                      Icons.content_copy,
                      'formulasolver_formulas_copyformula'
                    )
                  ),
                  PopupMenuItem(
                    value: 4,
                    child: _buildPopupItem(
                      Icons.content_copy,
                      'formulasolver_formulas_copyresult',
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      );

      if (odd) {
        output = Container(
          color: ThemeColors.oddRows,
          child: row
        );
      } else {
        output = Container(
            child: row
        );
      }
      odd = !odd;

      return output;
    }).toList();

    if (rows.length > 0) {
      rows.insert(0,
        GCWTextDivider(
          text: i18n(context, 'formulasolver_formulas_currentformulas')
        )
      );
    }

    return Column(
        children: rows
    );
  }

  _buildPopupItem(IconData icon, String i18nKey) {
    var color = Colors.black;

    return  Row(
      children: [
        Container(
          child: Icon(icon, color: color),
          padding: EdgeInsets.only(
            right: 10
          ),
        ),
        Text(
          i18n(context, i18nKey),
          style: TextStyle(
            color: color
          )
        )
      ],
    );
  }
}