import 'package:flutter/material.dart';
import 'package:gc_wizard/database/formula_solver/database_provider.dart';
import 'package:gc_wizard/database/formula_solver/model.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_delete_alertdialog.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/tools/formula_solver/formulas.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';

class FormulaSolver extends StatefulWidget {
  @override
  FormulaSolverState createState() => FormulaSolverState();
}

class FormulaSolverState extends State<FormulaSolver> {
  FormulaSolverDbProvider dbProvider = FormulaSolverDbProvider();
  
  var _newGroupController;
  var _editGroupController;
  var _currentNewName = '';
  var _currentEditedName = '';
  var _currentEditId;

  Map<int, int> formulaCountsPerGroup = {};

  @override
  void initState() {
    super.initState();
    _newGroupController = TextEditingController(text: _currentNewName);
    _editGroupController = TextEditingController(text: _currentEditedName);

    dbProvider.getGroups().then((result) {
      setState(() {
        formulaGroups = result;
        _getFormulaCounts();
      });
    });
  }

  @override
  void dispose() {
    _newGroupController.dispose();
    _editGroupController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: i18n(context, 'formulasolver_groups_newgroup')
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                child: GCWTextField(
                  hintText: i18n(context, 'formulasolver_groups_newgroup_hint'),
                  controller: _newGroupController,
                  onChanged: (text) {
                    setState(() {
                      _currentNewName = text;
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
                _addNewGroup().whenComplete(() => setState(() {}));
              },
            )
          ],
        ),
        _buildGroupList(context)
      ],
    );
  }

  _addNewGroup() async {
    if (_currentNewName.length > 0) {
      var newGroup = FormulaGroup(_currentNewName);
      newGroup.id = await dbProvider.insertGroup(newGroup);

      formulaGroups.add(newGroup);
      formulaCountsPerGroup.putIfAbsent(newGroup.id, () => 0);
      _newGroupController.clear();
      _currentNewName = '';
    }
  }

  _updateGroup(FormulaGroup group) async {
    await dbProvider.updateGroup(group);
  }

  _removeGroup(FormulaGroup group) async {
    await dbProvider.deleteGroup(group);
    formulaCountsPerGroup.remove(group.id);
    formulaGroups.remove(group);
  }

  _getFormulaCounts() async {
    formulaCountsPerGroup.clear();
    dbProvider.getFormulas().then((result) {
      setState(() {
        result.forEach((formula) {
          formulaCountsPerGroup.putIfAbsent(formula.group.id, () => 0);
          formulaCountsPerGroup[formula.group.id]++;
        });
      });
    });
  }

  _buildGroupList(BuildContext context) {
    var odd = true;
    var rows = formulaGroups.map((group) {

      var formulaTool = GCWToolWidget(
        tool: Formulas(group: group),
        toolName: '${group.name} - ${i18n(context, 'formulasolver_formulas')}'
      );

      Future _navigateToSubPage(context) async {
        Navigator.push(context, NoAnimationMaterialPageRoute(
          builder: (context) => formulaTool)
        ).whenComplete(() {
          _getFormulaCounts();
        });
      }

      Widget output;

      var row = InkWell(
        child: Row (
          children: <Widget>[
            Expanded(
              child: _currentEditId == group.id
                ? Padding (
                    child: GCWTextField(
                      controller: _editGroupController,
                      autofocus: true,
                      onChanged: (text) {
                        setState(() {
                          _currentEditedName = text;
                        });
                      },
                    ),
                    padding: EdgeInsets.only(
                      right: 2,
                    ),
                  )
                : IgnorePointer(
                    child: GCWText (
                      text: '${group.name} (${formulaCountsPerGroup[group.id] ?? '?'})'
                    )
                  ),
              flex: 1,
            ),
            _currentEditId == group.id
              ? GCWIconButton(
                iconData: Icons.check,
                onPressed: () {
                  group.name = _currentEditedName;
                  _updateGroup(group).whenComplete(() {
                    setState(() {
                      _currentEditId = null;
                      _editGroupController.clear();
                    });
                  });
                },
              )
              : GCWIconButton(
                iconData: Icons.edit,
                onPressed: () {
                  setState(() {
                    _currentEditId = group.id;
                    _currentEditedName = group.name;
                    _editGroupController.text = group.name;
                  });
                },
              ),
            GCWIconButton(
              iconData: Icons.remove,
              onPressed: () {
                showDeleteAlertDialog(context, group.name, () {
                  _removeGroup(group).whenComplete(() => setState(() {}));
                },);
              },
            )
          ],
        ),
        onTap: () {
          _navigateToSubPage(context);
        }
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
          text: i18n(context, 'formulasolver_groups_currentgroups')
        )
      );
    }

    return Column(
      children: rows
    );
  }
}