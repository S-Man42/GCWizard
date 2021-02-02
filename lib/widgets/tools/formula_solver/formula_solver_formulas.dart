import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/parser/latlon.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution.dart';
import 'package:gc_wizard/logic/tools/formula_solver/parser.dart';
import 'package:gc_wizard/persistence/formula_solver/json_provider.dart';
import 'package:gc_wizard/persistence/formula_solver/model.dart';
import 'package:gc_wizard/persistence/variable_coordinate/json_provider.dart' as var_coords_provider;
import 'package:gc_wizard/persistence/variable_coordinate/model.dart' as var_coords_model;
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_delete_alertdialog.dart';
import 'package:gc_wizard/widgets/common/gcw_popup_menu.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_mapview.dart';
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

  Map<int, Map<String, dynamic>> _foundCoordinates = {};

  ThemeColors _themeColors;

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
    _themeColors = themeColors();
    _foundCoordinates = {};

    var formulaTool = GCWTool(
      tool: FormulaSolverFormulaValues(group: widget.group),
      toolName: '${widget.group.name} - ${i18n(context, 'formulasolver_values')}',
      i18nPrefix: 'formulasolver', // for calling the help of the formulasolver
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
    }

    return varCoordsFormula;
  }

  _openInVariableCoordinate(var_coords_model.Formula formula) {
    Navigator.push(context, NoAnimationMaterialPageRoute(
      builder: (context) => GCWTool(
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

    var odd = true;

    var formulaResults = <String, String>{};

    var rows = widget.group.formulas.asMap().map((index, formula) {
      //TODO: In fact, this is for the recursive formulas... An therefore, this is part of
      // the logic. It needs to be moved from the frontend part
      var formulaToParse = substitution(formula.formula, formulaResults, caseSensitive: false);
      var calculated = formulaParser.parse(formulaToParse, values);

      var formulaResult = calculated['result'];
      if (calculated['state'] != STATE_OK)
        formulaResult = '($formulaResult)';

      formulaResults.putIfAbsent('{${index + 1}}', () => formulaResult);

      Widget output;

      var _foundCoordinate = parseLatLon(calculated['result'], wholeString: true);
      if (_foundCoordinate != null)
        _foundCoordinates.putIfAbsent(index + 1, () => _foundCoordinate);

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
                      Row(
                        children: [
                          Container(
                            child: GCWText(
                              text: (index + 1).toString() + '.'
                            ),
                            padding: EdgeInsets.only(right: 4 * DEFAULT_MARGIN),
                          ),
                          Flexible(
                            child: GCWText (
                              text: formula.formula
                            ),
                          )
                        ],
                      ),
                      Row (
                        children: <Widget>[
                          calculated['state'] == STATE_OK
                            ? Icon(
                                Icons.check,
                                color: _themeColors.mainFont(),
                              )
                            : Icon(
                                Icons.priority_high,
                                color: _themeColors.accent(),
                              ),
                          Flexible(
                            child: GCWText (
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
            GCWPopupMenu(
              iconData: Icons.settings,
              menuItemBuilder: (context) => [
                GCWPopupMenuItem(
                  child: iconedGCWPopupMenuItem(
                    context,
                    Icons.edit,
                    'formulasolver_formulas_editformula'
                  ),
                  action: (index) => setState(() {
                    _currentEditId = formula.id;
                    _currentEditedFormula = formula.formula;
                    _editFormulaController.text = formula.formula;
                  })
                ),
                GCWPopupMenuItem(
                  child: iconedGCWPopupMenuItem(
                    context,
                    Icons.delete,
                    'formulasolver_formulas_removeformula'
                  ),
                  action: (index) => showDeleteAlertDialog(context, formula.formula, () {
                    _removeFormula(formula);
                    setState(() {});
                  },)
                ),
                GCWPopupMenuItem(
                  child: iconedGCWPopupMenuItem(
                    context,
                    Icons.content_copy,
                    'formulasolver_formulas_copyformula'
                  ),
                  action: (index) => Clipboard.setData(ClipboardData(text: formula.formula))
                ),
                GCWPopupMenuItem(
                  child: iconedGCWPopupMenuItem(
                    context,
                    Icons.content_copy,
                    'formulasolver_formulas_copyresult'
                  ),
                  action: (index) => Clipboard.setData(ClipboardData(text: calculated['result']))
                ),
                GCWPopupMenuItem(
                  child: iconedGCWPopupMenuItem(
                    context,
                    Icons.forward,
                    'formulasolver_formulas_openinvarcoords',
                  ),
                  action: (index) {
                    var varCoordsFormula = _exportToVariableCoordinate(formula);
                    _openInVariableCoordinate(varCoordsFormula);
                  }
                ),
                if (_foundCoordinate != null)
                  GCWPopupMenuItem(
                    child: iconedGCWPopupMenuItem(
                      context,
                      Icons.my_location,
                      'formulasolver_formulas_showonmap',
                    ),
                    action: (index) {
                      if (_foundCoordinate == null)
                        return;

                      _showFormulaResultOnMap([
                        GCWMapPoint(
                          point: _foundCoordinate['coordinate'],
                          markerText: i18n(context, 'formulasolver_formulas_showonmap_coordinatetext'),
                          coordinateFormat: {
                            'format': _foundCoordinate['format']
                          }
                        )
                      ]);
                    }
                  )
              ]
            )
          ],
        ),
      );

      if (odd) {
        output = Container(
          color: _themeColors.outputListOddRows(),
          child: row
        );
      } else {
        output = Container(
            child: row
        );
      }
      odd = !odd;

      return MapEntry(index, output);
    }).values.toList();

    if (rows.length > 0) {
      rows.insert(0,
        GCWTextDivider(
          text: i18n(context, 'formulasolver_formulas_currentformulas'),
          trailing: _foundCoordinates.length > 0 ? GCWIconButton(
            iconData: Icons.my_location,
            size: IconButtonSize.SMALL,
            onPressed: () {
              _showFormulaResultOnMap(
                _foundCoordinates.entries.map((coordinate) {
                  return GCWMapPoint(
                    point: coordinate.value['coordinate'],
                    markerText: i18n(context, 'formulasolver_formulas_showonmap_coordinatetext') + ' ${coordinate.key}',
                    coordinateFormat: {'format': coordinate.value['format']}
                  );
                }).toList()
              );
            },
          ) : Container()
        )
      );
    }

    return Column(
      children: rows
    );
  }

  _showFormulaResultOnMap(coordinates) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => GCWTool (
      tool: GCWMapView(
        points: coordinates,
      ),
      toolName: i18n(context, 'coords_map_view_title'),
      autoScroll: false,
    )));
  }
}