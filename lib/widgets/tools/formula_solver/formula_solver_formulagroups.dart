import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/persistence/formula_solver/json_provider.dart';
import 'package:gc_wizard/persistence/formula_solver/model.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_delete_alertdialog.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_text_export.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/tools/formula_solver/formula_solver_formulas.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';

class FormulaSolverFormulaGroups extends StatefulWidget {
  @override
  FormulaSolverFormulaGroupsState createState() => FormulaSolverFormulaGroupsState();
}

class FormulaSolverFormulaGroupsState extends State<FormulaSolverFormulaGroups> {
  var _newGroupController;
  var _editGroupController;
  var _currentNewName = '';
  var _currentEditedName = '';
  var _currentEditId;

  @override
  void initState() {
    super.initState();
    _newGroupController = TextEditingController(text: _currentNewName);
    _editGroupController = TextEditingController(text: _currentEditedName);

    refreshFormulas();
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
          text: i18n(context, 'formulasolver_groups_newgroup'),
          trailing: GCWIconButton(
            size: IconButtonSize.SMALL,
            iconData: Icons.content_paste,
            onPressed: () {
              _importFromClipboard();
            },
          )
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
                _addNewGroup();
                setState(() {
                });
              },
            )
          ],
        ),
        _buildGroupList(context)
      ],
    );
  }

  String _createImportGroupName(String currentName) {
    var baseName = '[${i18n(context, 'common_import')}] $currentName';

    var existingNames = formulaGroups.map((f) => f.name).toList();

    int i = 1;
    var name = baseName;
    while (existingNames.contains(name))
      name = baseName + ' (${i++})';

    return name;
  }

  _importFromClipboard() {
    Clipboard.getData('text/plain').then((data) {
      try {
        var group = FormulaGroup.fromJson(jsonDecode(data.text));
        group.name = _createImportGroupName(group.name);

        setState(() {
          insertGroup(group);
        });
        showToast(i18n(context, 'formulasolver_groups_imported'));
      } catch(e) {
        showToast(i18n(context, 'formulasolver_groups_importerror'));
      }
    });
  }

  _addNewGroup() {
    if (_currentNewName.length > 0) {
      var group = FormulaGroup(_currentNewName);
      insertGroup(group);

      _newGroupController.clear();
      _currentNewName = '';
    }
  }

  _updateGroup() {
    updateFormulaGroups();
  }

  _removeGroup(FormulaGroup group) {
    deleteGroup(group.id);
  }

  _exportGroup(FormulaGroup group) {
    showGCWDialog(context, i18n(context, 'formulasolver_groups_exportgroup'),
      GCWTextExport(text: jsonEncode(group.toMap()).toString()),
      [GCWDialogButton(
        text: 'OK',
      )],
      cancelButton: false
    );
  }

  _buildGroupList(BuildContext context) {
    var odd = true;
    var rows = formulaGroups.map((group) {
      var formulaTool = GCWToolWidget(
        tool: FormulaSolverFormulas(group: group),
        toolName: '${group.name} - ${i18n(context, 'formulasolver_formulas')}'
      );

      Future _navigateToSubPage(context) async {
        Navigator.push(context, NoAnimationMaterialPageRoute(
          builder: (context) => formulaTool)
        ).whenComplete(() {
          setState(() {});
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
                    child: Column(
                      children: <Widget>[
                        GCWText (
                          text: '${group.name}'
                        ),
                        Container(
                          child: GCWText(
                            text: '${group.formulas.length} ' + i18n(context, group.formulas.length == 1 ? 'formulasolver_formula' : 'formulasolver_formulas'),
                            style: gcwDescriptionTextStyle(),
                          ),
                          padding: EdgeInsets.only(left: 10),
                        )
                      ],
                    )
                  ),
              flex: 1,
            ),
            _currentEditId == group.id
              ? GCWIconButton(
                  iconData: Icons.check,
                  onPressed: () {
                    group.name = _currentEditedName;
                    _updateGroup();

                    setState(() {
                      _currentEditId = null;
                      _editGroupController.clear();
                    });
                  },
                )
                : Container(),
            Container(
              width: DEFAULT_POPUPBUTTON_SIZE,
              height: DEFAULT_POPUPBUTTON_SIZE,
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
                offset: Offset(0, DEFAULT_POPUPBUTTON_SIZE),
                icon: Icon(Icons.settings, color: Colors.white),
                color: ThemeColors.accent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(roundedBorderRadius),
                ),
                onSelected: (value) {
                  switch (value) {
                    case 1:
                      setState(() {
                        _currentEditId = group.id;
                        _currentEditedName = group.name;
                        _editGroupController.text = group.name;
                      });
                      break;
                    case 2:
                      showDeleteAlertDialog(context, group.name, () {
                        _removeGroup(group);
                        setState(() {});
                      });
                      break;
                    case 3:
                      _exportGroup(group);
                      break;
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                      value: 1,
                      child: buildPopupItem(
                        context,
                        Icons.edit,
                        'formulasolver_formulas_editformula'
                      )
                  ),
                  PopupMenuItem(
                      value: 2,
                      child: buildPopupItem(
                        context,
                        Icons.delete,
                        'formulasolver_formulas_removeformula'
                      )
                  ),
                  PopupMenuItem(
                      value: 3,
                      child: buildPopupItem(
                        context,
                        Icons.forward,
                        'formulasolver_groups_exportgroup'
                      )
                  ),
                ],
              ),
            ),
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