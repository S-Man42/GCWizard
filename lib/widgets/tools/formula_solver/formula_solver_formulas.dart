import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
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
import 'package:gc_wizard/utils/common_utils.dart';
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
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';

import 'gcw_formula_replace_dialog.dart';

class FormulaSolverFormulas extends StatefulWidget {
  final FormulaGroup group;
  final bool noFormulaColors;

  const FormulaSolverFormulas({Key key, this.group, bool this.noFormulaColors = false}) : super(key: key);

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
        helpSearchString: 'formulasolver_values',
        defaultLanguageToolName:
            '${widget.group.name} - ${i18n(context, 'formulasolver_values', useDefaultLanguage: true)}');

    Future _navigateToSubPage(context) async {
      Navigator.push(context, NoAnimationMaterialPageRoute(builder: (context) => formulaTool)).whenComplete(() {
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
        GCWTextDivider(text: i18n(context, 'formulasolver_formulas_newformula')),
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
    while (existingNames.contains(name)) name = baseName + ' (${i++})';

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
    Navigator.push(
        context,
        NoAnimationMaterialPageRoute(
            builder: (context) => GCWTool(
                tool: VariableCoordinate(formula: formula),
                toolName: '${formula.name} - ${i18n(context, 'coords_variablecoordinate_title')}',
                helpSearchString: 'coords_variablecoordinate_title',
                i18nPrefix:
                    '${formula.name} - ${i18n(context, 'coords_variablecoordinate_title', useDefaultLanguage: true)}')));
  }

  _buildGroupList(BuildContext context) {
    Map<String, String> values = {};
    widget.group.values.forEach((value) {
      values.putIfAbsent(value.key, () => value.value);
    });

    var odd = true;

    var formulaResults = <String, String>{};

    var rows = widget.group.formulas
        .asMap()
        .map((index, formula) {
          //TODO: In fact, this is for the recursive formulas... An therefore, this is part of
          // the logic. It needs to be moved from the frontend part
          var formulaToParse = substitution(formula.formula, formulaResults, caseSensitive: false);
          var calculated = formulaParser.parse(formulaToParse, values);

          var formulaResult = calculated['result'];
          if (calculated['state'] != STATE_OK) formulaResult = '($formulaResult)';

          formulaResults.putIfAbsent('{${index + 1}}', () => formulaResult);

          Widget output;

          var _foundCoordinate = parseStandardFormats(calculated['result'], wholeString: true);
          if (_foundCoordinate != null && _foundCoordinate.length > 0)
            _foundCoordinates.putIfAbsent(index + 1, () => _foundCoordinate);

          var row = Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _currentEditId == formula.id
                      ? Padding(
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
                      : Column(children: <Widget>[
                          Row(
                            children: [
                              Container(
                                child: GCWText(text: (index + 1).toString() + '.'),
                                padding: EdgeInsets.only(right: 4 * DEFAULT_MARGIN),
                              ),
                              Flexible(
                                child: _buildFormulaText(formula.formula, values, formula.id),
                              )
                            ],
                          ),
                          Row(
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
                                child: GCWText(text: calculated['result']),
                              )
                            ],
                          )
                        ]),
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
                    iconData: Icons.more_vert,
                    menuItemBuilder: (context) => [
                          GCWPopupMenuItem(
                              child: iconedGCWPopupMenuItem(context, Icons.edit, 'formulasolver_formulas_editformula'),
                              action: (index) => setState(() {
                                    _currentEditId = formula.id;
                                    _currentEditedFormula = formula.formula;
                                    _editFormulaController.text = formula.formula;
                                  })),
                          GCWPopupMenuItem(
                              child:
                                  iconedGCWPopupMenuItem(context, Icons.edit, 'formulasolver_formulas_modifyformula'),
                              action: (index) => setState(() {
                                    showFormulaReplaceDialog(context, [formula], onOkPressed: (value) {
                                      if (value.first == null ||
                                          value.first.formula == null ||
                                          formula.formula == value.first.formula) return;

                                      formula.formula = value.first.formula;
                                      _updateFormula(formula);
                                      setState(() {});
                                    });
                                  })),
                          GCWPopupMenuItem(
                              child:
                                  iconedGCWPopupMenuItem(context, Icons.delete, 'formulasolver_formulas_removeformula'),
                              action: (index) => showDeleteAlertDialog(
                                    context,
                                    formula.formula,
                                    () {
                                      _removeFormula(formula);
                                      setState(() {});
                                    },
                                  )),
                          GCWPopupMenuItem(
                            child: iconedGCWPopupMenuItem(
                                context, Icons.content_copy, 'formulasolver_formulas_copyformula'),
                            action: (index) => insertIntoGCWClipboard(context, formula.formula),
                          ),
                          GCWPopupMenuItem(
                              child: iconedGCWPopupMenuItem(
                                  context, Icons.content_copy, 'formulasolver_formulas_copyresult'),
                              action: (index) => insertIntoGCWClipboard(context, calculated['result'])),
                          GCWPopupMenuItem(
                              child: iconedGCWPopupMenuItem(
                                context,
                                Icons.forward,
                                'formulasolver_formulas_openinvarcoords',
                              ),
                              action: (index) {
                                var varCoordsFormula = _exportToVariableCoordinate(formula);
                                _openInVariableCoordinate(varCoordsFormula);
                              }),
                          if (_foundCoordinate != null)
                            GCWPopupMenuItem(
                                child: iconedGCWPopupMenuItem(
                                  context,
                                  Icons.my_location,
                                  'formulasolver_formulas_showonmap',
                                ),
                                action: (index) {
                                  if (_foundCoordinate == null) return;

                                  _showFormulaResultOnMap([
                                    GCWMapPoint(
                                        point: _foundCoordinate['coordinate'],
                                        markerText: i18n(context, 'formulasolver_formulas_showonmap_coordinatetext'),
                                        coordinateFormat: {'format': _foundCoordinate['format']})
                                  ]);
                                })
                        ])
              ],
            ),
          );

          if (odd) {
            output = Container(color: _themeColors.outputListOddRows(), child: row);
          } else {
            output = Container(child: row);
          }
          odd = !odd;

          return MapEntry(index, output);
        })
        .values
        .toList();

    if (rows.length > 0) {
      rows.insert(
          0,
          GCWTextDivider(
              text: i18n(context, 'formulasolver_formulas_currentformulas'),
              trailing: GCWPopupMenu(
                  iconData: Icons.more_vert,
                  size: IconButtonSize.SMALL,
                  menuItemBuilder: (context) => [
                        GCWPopupMenuItem(
                            child: iconedGCWPopupMenuItem(context, Icons.edit, 'formulasolver_formulas_modifyformulas'),
                            action: (index) => setState(() {
                                  showFormulaReplaceDialog(context, widget.group.formulas, onOkPressed: (value) {
                                    if (value == null) return;

                                    for (int i = 0; i < widget.group.formulas.length; i++) {
                                      if (value[i] == null) continue;
                                      if (value[i].formula == null) continue;

                                      if (widget.group.formulas[i].formula != value[i].formula) {
                                        var formula = widget.group.formulas[i];
                                        formula.formula = value[i].formula;
                                        _updateFormula(formula);
                                      }
                                    }
                                    setState(() {});
                                  });
                                })),
                        GCWPopupMenuItem(
                            child:
                                iconedGCWPopupMenuItem(context, Icons.delete, 'formulasolver_formulas_removeformulas'),
                            action: (index) => showDeleteAlertDialog(
                                  context,
                                  i18n(context, 'formulasolver_formulas_allformulas'),
                                  () {
                                    var formulasToRemove = List.from(widget.group.formulas);
                                    formulasToRemove.forEach((formula) => _removeFormula(formula));
                                    setState(() {});
                                  },
                                )),
                        if (_foundCoordinates.length > 0)
                          GCWPopupMenuItem(
                              child: iconedGCWPopupMenuItem(
                                context,
                                Icons.my_location,
                                'formulasolver_formulas_showonmap',
                              ),
                              action: (index) {
                                _showFormulaResultOnMap(_foundCoordinates.entries.map((coordinate) {
                                  return GCWMapPoint(
                                      point: coordinate.value['coordinate'],
                                      markerText: i18n(context, 'formulasolver_formulas_showonmap_coordinatetext') +
                                          ' ${coordinate.key}',
                                      coordinateFormat: {'format': coordinate.value['format']});
                                }).toList());
                              })
                      ])));
    }

    return Column(children: rows);
  }

  _showFormulaResultOnMap(coordinates) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GCWTool(
                tool: GCWMapView(
                  points: coordinates,
                ),
                i18nPrefix: 'coords_map_view',
                autoScroll: false,
                suppressToolMargin: true)));
  }

  Widget _buildFormulaText(String formula, Map<String, String> values, int formulaIndex) {
    if (widget.noFormulaColors)
      return GCWText(text: formula);

    return SelectableText.rich(TextSpan(
      children:
          _buildTextSpans(formula,
              formulaColors(formula, values, formulaIndex )
          )
    ));
  }

  static String formulaColors(String formula, Map<String, String> values, int formulaIndex) {
    if (formula == null) return null;

    final opposideBracket =  { '[': ']', '(': ')', '{': '}' };
    final opposideBracket2 = switchMapKeyValue(opposideBracket);
    var result = "";
    var brackets = <String>[];
    var operators = { '+', '-', '*', '/', '^', '%' };
    var containsBrackets = formula.contains('[') || formula.contains(']');
    var checkedFormulaResult = "";
    var keys = <String>[];
    var functions = <String>[];
    var _allCharacters = allCharacters();

    var operatorsRegEx = operators.map((op) => r'\' + op).join();

    if (values != null) {
      keys = values.keys.map((key) {
        return ((key == null) || (key.length == 0)) ? null : key;
      }).toList();
    }
    keys.addAll(FormulaParser.constants.keys);
    keys = keys.map((key) {return key.toUpperCase();}).toList();
    keys.sort((a, b) => b.length.compareTo(a.length));

    functions.addAll(FormulaParser.functions);
    functions = functions.map((function) {return function.toUpperCase();}).toList();
    functions.sort((a, b) => b.length.compareTo(a.length));

    formula = FormulaParser.normalizeMathematicalSymbols(formula);
    formula = formula.toUpperCase();
    formula.split('').forEach((e) {
      // checked
      if (checkedFormulaResult.length > 0) {
        result += checkedFormulaResult[0];
        checkedFormulaResult = checkedFormulaResult.substring(1);

        if (opposideBracket.containsKey(e)) brackets.add(e);
        if (opposideBracket2.containsKey(e)) {
          var validBracket = (brackets.length > 0) && (brackets[brackets.length - 1] == opposideBracket2[e]);
          if (validBracket) brackets.removeAt(brackets.length - 1);
        }

      } else {
          // numbers
        if (int.tryParse(e) != null)
          result +=
          _calculated(formula, result, brackets, containsBrackets) ? 'g' : 't';

          // spaces
        else if (e == ' ')
          result += ((result.isEmpty) ? "s" : result[result.length - 1]);

          // formula reference
        else if (e == '{') {
          brackets.add(e);
          var _result = _validFormulaReference(formula.substring(result.length), result, formulaIndex);

            result += _result[0];
            checkedFormulaResult = _result.substring(1);

          //open brackets
        } else if (opposideBracket.containsKey(e)) {
          brackets.add(e);
          result += (formula.indexOf(opposideBracket[e], result.length) > 0) ? 'b' : 'B';

          // close brackets
        } else if (opposideBracket2.containsKey(e)) {
          var validBracket = (brackets.isNotEmpty) && (brackets[brackets.length - 1] == opposideBracket2[e]);
          //validBracket = validBracket && ((result.length == 0) || formula[result.length - 1] != opposideBracket2[e]);
          result += validBracket ? "b" : "B";
          if (validBracket) brackets.removeAt(brackets.length - 1);

          // operators
        } else if (operators.contains(e)) {
          var _result = _validOperator(formula.substring(result.length), operatorsRegEx);
          var firstOperatorValid = _validFirstOperator(formula.substring(0, result.length+1), result);
          if (_result.startsWith('b') && firstOperatorValid)
            result += _calculated(formula, result, brackets, containsBrackets) ? 'b' : 't';
          else {
            _result = _buildResultString('B', firstOperatorValid ? _result.length : 1);
            result += _result[0];
            checkedFormulaResult = _result.substring(1);
          }

        //formulas, constans variables
        } else if (_calculated(formula, result, brackets, containsBrackets)) {
          var valid = false;
          var handled = false;
          // check functions
          for (String function in functions) {
            if (formula.substring(result.length).startsWith(function)) {
              var _result = _validFunction(formula.substring(result.length), function);
              if (_result.isNotEmpty) {
                result += _result[0];
                checkedFormulaResult = _result.substring(1);
                handled = true;
                break;
              } else {
                var _result = _invalidFunction(formula.substring(result.length));
                if (_result.isNotEmpty) {
                  result += _result[0];
                  checkedFormulaResult = _result.substring(1);
                  handled = true;
                  break;
                }
              }

            }
          }

          // non function
          if (!handled) {
            // constant or variable
            for (String key in keys) {
              if (formula.substring(result.length).startsWith(key)) {
                valid = true;
                checkedFormulaResult = _buildResultString('r', key.length - 1);
                break;
              }
            }

            if (!valid && !_allCharacters.contains(e))
              result += 't';
            else
              result += valid ? 'r' : 'R';
          }
        } else
          result += 't';
      }
    });

    // opposideBracket.forEach((openBracket, closeBracket) {
    //   _checkBrackets(formula, result, openBracket, closeBracket);
    // });

    for (int i = result.length - 2; i >= 0; i--)
      if (result[i] == 's') result = result.substring(0, i) + result[i + 1] + result.substring(i + 1);

    return result;
  }

  static bool _calculated(String formula, String result, List<String> brackets, bool containsBrackets) {
    if (!containsBrackets) return true;

    return (brackets.contains('[') && (formula.substring(result.length).contains(']')));
  }

  static String _validFunction(String formula, String function) {
    var regex = RegExp(r'^(.+)[\s]*[(][\s]*[\S]+[\s]*[)]');
    var matches = regex.allMatches(formula);
    if (matches.length > 0) return _buildResultString('b', function.length);

    return '';
  }

  static String _invalidFunction(String formula) {
    var regex = RegExp(r'^(.+)[\s]*[(][\s]*[)]');
    var match = regex.firstMatch(formula);
    if (match != null) return _buildResultString('B', match.end);

    return '';
  }

  static String _validOperator(String formula, String operators) {
    var ignoreBrackets = r'((\(\s*\))|(\[\s*\]))';
    var regex = RegExp('^[$operators][\s]*$ignoreBrackets[\s]*[\-]*[\s]*[^$operators]');
    var match = regex.firstMatch(formula);
    if (match != null) return _buildResultString('b', match.end - 1);

    regex = RegExp('^[$operators][\s]*[\-]*[\s]*');
    match = regex.firstMatch(formula);
    return _buildResultString('B', (match != null) ? match.end + 1 : 1);
  }

  static bool _validFirstOperator(String formula, String result) {
    if (formula[formula.length -1] == '-') return true;
    formula = formula.trim();

    return formula.length > 1;
  }

  static String _validFormulaReference(String formula, String result, int formulaId) {
    RegExp regex = new RegExp(r'[{](\d)[}]');
    var match = regex.firstMatch(formula);
    if (match != null) {
      if (int.tryParse(match.group(1)) < formulaId)
        return _buildResultString('b' , match.end);
      else
        return 'b' + _buildResultString('B' , match.end - 2) + 'b';
    }

    var bracketIndex = formula.indexOf('}');
    return _buildResultString('B', (bracketIndex >= 0) ? bracketIndex +1 : 1);
  }

  static String _checkBrackets(String formula, String result, String startBracket, endBracket) {
    RegExp regex = new RegExp(r'\$startBracket.+?\$endBracket');
    regex.allMatches(formula).forEach((match) {
      if (!_validBracket(result.substring(match.start, match.end)))
        result = _replaceRange(result, match.start, match.end, "B");
    });
    return result;
  }

  static String _replaceRange(String result, int start, int end, String value) {
    var replacement = '';
    for( var i = start; i<= end; i++)
      replacement += value;
    result.replaceRange(start, end, replacement);

    return result;
  }

  static bool _validBracket(String result) {
    var regex = RegExp(r'[RGB]');
    var matches = regex.allMatches(result);
    return (matches.length == 0) ;
  }

  static String _buildResultString(String s, int count) {
    var result = '';
    for (var i = 0; i < count; i++)
      result += s;
    return result;
  }

  List<InlineSpan> _buildTextSpans(String formula, String formulaColors) {
    var list = <TextSpan>[];
    var startIndex = 0;
    var gcwStyle = gcwTextStyle();

    for (int i = 0; i < formula.length; i++) {
      if ((i == formula.length - 1) || (formulaColors[i + 1] != formulaColors[i])) {
        TextStyle textStyle;
        switch (formulaColors[i]) {
          case 'g':
            textStyle =  TextStyle(color: Colors.green);
            break;
          case 'r':
            textStyle = TextStyle(color: Colors.orange);
            break;
         case 'b':
            textStyle = TextStyle(color: Colors.blue);
            break;
          case 'R':
          case 'B':
            textStyle = TextStyle(color: Colors.red, fontWeight: FontWeight.bold);
            break;
          default:
            textStyle = TextStyle();
        }
        var text = formula.substring(startIndex, i+1);
        var textSpan = TextSpan(text: text, style: TextStyle(
            fontSize: gcwStyle.fontSize,
            fontFamily: gcwStyle.fontFamily,
            color: (textStyle.color == null) ? gcwStyle.color : textStyle.color,
            fontWeight: (textStyle.fontWeight == null) ? gcwStyle.fontWeight : textStyle.fontWeight,
          )
        );
        list.add(textSpan);

        startIndex = i + 1;
      }
    }
    return list;
  }
}
