import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/formula_solver/parser.dart';
import 'package:gc_wizard/persistence/formula_solver/json_provider.dart';
import 'package:gc_wizard/persistence/formula_solver/model.dart';
import 'package:gc_wizard/persistence/utils.dart';
import 'package:gc_wizard/persistence/variable_coordinate/json_provider.dart' as var_coords_provider;
import 'package:gc_wizard/persistence/variable_coordinate/model.dart' as var_coords_model;
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_delete_alertdialog.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/tools/coords/variable_coordinate/variable_coordinate.dart';
import 'package:gc_wizard/widgets/tools/formula_solver/formula_solver_values.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';

class FormulaSolverFormulas extends StatefulWidget {
  final FormulaGroup group;

  const FormulaSolverFormulas({Key key, this.group}) : super(key: key);

  @override
  FormulaSolverFormulasState createState() => FormulaSolverFormulasState();
}

class FormulaSolverFormulasState extends State<FormulaSolverFormulas> {
  var formulaParser = FormulaParser();

  var _newFormulaController;
  var _editFormulaController;
  var _currentNewFormula = '';
  var _currentEditedFormula = '';
  var _currentEditId;

  @override
  void initState() {
    super.initState();
    _newFormulaController = TextEditingController(text: _currentNewFormula);
    _editFormulaController = TextEditingController(text: _currentEditedFormula);

    refreshFormulas();
  }

  @override
  void dispose() {
    _newFormulaController.dispose();
    _editFormulaController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var formulaTool = GCWToolWidget(
      tool: FormulaSolverFormulaValues(group: widget.group),
      toolName: '${widget.group.name} - ${i18n(context, 'formulasolver_values')}'
    );

    Future _navigateToSubPage(context) async {
      Navigator.push(context, NoAnimationMaterialPageRoute(
        builder: (context) => formulaTool)
      )
      .whenComplete(() {
        setState(() {});
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
      var newFormula = Formula(_currentNewFormula);
      insertFormula(newFormula, widget.group);

      _newFormulaController.clear();
      _currentNewFormula = '';
    }
  }

  _updateFormula(Formula formula) {
    updateFormula(formula, widget.group);
  }

  _removeFormula(Formula formula) {
    deleteFormula(formula.id, widget.group);
  }

  _createVariableCoordinateName() {
    var baseName = '[${i18n(context, 'formulasolver_title')}] ${widget.group.name}';

    var existingNames = var_coords_model.formulas.map((f) => f.name).toList();

    int i = 1;
    var name = baseName;
    while (existingNames.contains(name))
      name = baseName + ' (${i++})';

    return name;
  }

  var_coords_model.Formula _exportToVariableCoordinate(Formula formula) {
    var_coords_provider.refreshFormulas();

    var_coords_model.Formula varCoordsFormula = var_coords_model.Formula(_createVariableCoordinateName());
    varCoordsFormula.formula = formula.formula;
    var_coords_provider.insertFormula(varCoordsFormula);

    for (var value in widget.group.values) {
      var formulaValue = FormulaValue(value.key, value.value);
      var_coords_provider.insertFormulaValue(formulaValue, varCoordsFormula);
//      var_coords_provider.insertFormulaValue(value, varCoordsFormula);
    }

    return varCoordsFormula;
  }

  _openInVariableCoordinate(var_coords_model.Formula formula) {
    Navigator.push(context, NoAnimationMaterialPageRoute(
      builder: (context) => GCWToolWidget(
        tool: VariableCoordinate(formula: formula),
        toolName: '${formula.name} - ${i18n(context, 'coords_variablecoordinate_title')}'
      )
    ));
  }

  _buildGroupList(BuildContext context) {
    Map<String, String> values = {};
    widget.group.values.forEach((value) {
      values.putIfAbsent(value.key, () => value.value);
    });

    final double _BUTTON_SIZE = 40;

    var odd = true;
    var rows = widget.group.formulas.map((formula) {
      var calculated = formulaParser.parse(formula.formula, values);

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
                  _updateFormula(formula);

                  setState(() {
                    _currentEditId = null;
                    _editFormulaController.clear();
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
                        _removeFormula(formula);

                        setState(() {});
                      },);
                      break;
                    case 3:
                      Clipboard.setData(ClipboardData(text: formula.formula));
                      break;
                    case 4:
                      Clipboard.setData(ClipboardData(text: calculated['result']));
                      break;
                    case 5:
                      var varCoordsFormula = _exportToVariableCoordinate(formula);
                      _openInVariableCoordinate(varCoordsFormula);
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
                  PopupMenuItem(
                    value: 5,
                    child: _buildPopupItem(
                      Icons.forward,
                      'formulasolver_formulas_openinvarcoords',
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