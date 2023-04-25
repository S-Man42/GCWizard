import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/gcw_formula_list.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/tools/coords/variable_coordinate/persistence/json_provider.dart';
import 'package:gc_wizard/tools/coords/variable_coordinate/persistence/model.dart';
import 'package:gc_wizard/tools/coords/variable_coordinate/widget/variable_coordinate.dart';

class VariableCoordinateFormulas extends StatefulWidget {
  const VariableCoordinateFormulas({Key? key}) : super(key: key);

  @override
  VariableCoordinateFormulasState createState() => VariableCoordinateFormulasState();
}

class VariableCoordinateFormulasState extends State<VariableCoordinateFormulas> {

  @override
  void initState() {
    super.initState();

    refreshFormulas();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextDivider(text: i18n(context, 'coords_variablecoordinate_newformula')),
        GCWFormulaListEditor(
          formulaList: formulas,
          buildGCWTool: (id) => _buildNavigateGCWTool(id),
          onAddEntry: (name) => _addNewFormula(name),
          onListChanged: () => updateFormulas(),
          newEntryHintText: i18n(context, 'coords_variablecoordinate_newformula_hint'),
          middleWidget: GCWTextDivider(text: i18n(context, 'coords_variablecoordinate_currentformulas')),
        ),
      ],
    );
  }

  void _addNewFormula(String name) {
    if (name.isNotEmpty) {
      var formula = Formula(name);
      insertFormula(formula);
    }
  }

  GCWTool? _buildNavigateGCWTool(int id) {
    var entry = formulas.firstWhereOrNull((formula) => formula.id == id);

    if (entry != null) {
      return GCWTool(
          tool: VariableCoordinate(formula: entry),
          toolName: '${entry.name} - ${i18n(context, 'coords_variablecoordinate_title')}',
          helpSearchString: 'coords_variablecoordinate_title',
          defaultLanguageToolName:
          '${entry.name} - ${i18n(context, 'coords_variablecoordinate_title', useDefaultLanguage: true)}',
          id: 'coords_variablecoordinate');
    } else {
      return null;
    }
  }
}
