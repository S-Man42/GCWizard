import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science/periodic_table.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class PeriodicTable extends StatefulWidget {
  @override
  PeriodicTableState createState() => PeriodicTableState();
}

class PeriodicTableState extends State<PeriodicTable> {
  var _newCategory = true;
  var _currentCategory = PeriodicTableCategory.ELEMENT_NAME;
  var _currentValueCategoryValue;
  var _currentValueCategoryListItems = [];
  var _currentSortingOrder = GCWSwitchPosition.left;

  var _categories = <PeriodicTableCategory, String>{};
  var _elementNames = {};
  var _chemicalSymbols = {};
  var _atomicNumbers = {};
  List<int> _iupacGroups;
  List<int> _mainGroups;
  List<int> _subGroups;
  List<int> _periods;
  List<String> _iupacGroupNames;
  List<String> _statesOfMatter;

  final _valueCategories = [
    PeriodicTableCategory.MASS,
    PeriodicTableCategory.MELTING_POINT,
    PeriodicTableCategory.BOILING_POINT,
    PeriodicTableCategory.ELECTRONEGATIVITY,
    PeriodicTableCategory.DESITY,
    PeriodicTableCategory.IS_SYNTHETIC,
    PeriodicTableCategory.IS_RADIOACTIVE,
    PeriodicTableCategory.HALF_LIFE,
    PeriodicTableCategory.MOST_COMMON_ISOTOP,
  ];

  final _sortableCategories = [
    PeriodicTableCategory.IUPAC_GROUP,
    PeriodicTableCategory.IUPAC_GROUP_NAME,
    PeriodicTableCategory.MAIN_GROUP,
    PeriodicTableCategory.SUB_GROUP,
    PeriodicTableCategory.PERIOD,
    PeriodicTableCategory.STATE_OF_MATTER,
    PeriodicTableCategory.MASS,
    PeriodicTableCategory.MELTING_POINT,
    PeriodicTableCategory.BOILING_POINT,
    PeriodicTableCategory.ELECTRONEGATIVITY,
    PeriodicTableCategory.DESITY,
    PeriodicTableCategory.IS_SYNTHETIC,
    PeriodicTableCategory.IS_RADIOACTIVE,
    PeriodicTableCategory.HALF_LIFE,
    PeriodicTableCategory.MOST_COMMON_ISOTOP,
  ];

  @override
  void initState() {
    super.initState();

    _categories = {
      PeriodicTableCategory.ELEMENT_NAME: 'periodictable_category_elementname',
      PeriodicTableCategory.CHEMICAL_SYMBOL: 'periodictable_category_chemicalsymbol',
      PeriodicTableCategory.ATOMIC_NUMBER: 'periodictable_category_atomicnumber',
      PeriodicTableCategory.IUPAC_GROUP: 'periodictable_category_iupacgroup',
      PeriodicTableCategory.IUPAC_GROUP_NAME: 'periodictable_category_iupacgroupname',
      PeriodicTableCategory.MAIN_GROUP: 'periodictable_category_maingroup',
      PeriodicTableCategory.SUB_GROUP: 'periodictable_category_subgroup',
      PeriodicTableCategory.PERIOD: 'periodictable_category_period',
      PeriodicTableCategory.STATE_OF_MATTER: 'periodictable_category_stateofmatter',

      PeriodicTableCategory.MASS: 'periodictable_category_mass',
      PeriodicTableCategory.MELTING_POINT: 'periodictable_category_meltingpoint',
      PeriodicTableCategory.BOILING_POINT: 'periodictable_category_boilingpoint',
      PeriodicTableCategory.ELECTRONEGATIVITY: 'periodictable_category_electronegativity',
      PeriodicTableCategory.DESITY: 'periodictable_category_density',
      PeriodicTableCategory.IS_SYNTHETIC: 'periodictable_category_issynthetic',
      PeriodicTableCategory.IS_RADIOACTIVE: 'periodictable_category_isradioactive',
      PeriodicTableCategory.HALF_LIFE: 'periodictable_category_halflife',
      PeriodicTableCategory.MOST_COMMON_ISOTOP: 'periodictable_category_mostcommonisotop',
    };

    allPeriodicTableElements.forEach((element) {
      _elementNames.putIfAbsent(element.atomicNumber, () => element.name);
      _chemicalSymbols.putIfAbsent(element.atomicNumber, () => element.chemicalSymbol);
      _atomicNumbers.putIfAbsent(element.atomicNumber, () => element.atomicNumber);
    });

    _iupacGroups = allPeriodicTableElements.map((element) => element.iupacGroup).toSet().toList();
    _iupacGroups.sort();

    _mainGroups = allPeriodicTableElements
      .where((element) => element.mainGroup != null)
      .map((element) => element.mainGroup).toSet().toList();
    _mainGroups.sort();

    _subGroups = allPeriodicTableElements
      .where((element) => element.subGroup != null)
      .map((element) => element.subGroup).toSet().toList();
    _subGroups.sort();

    _periods = allPeriodicTableElements.map((element) => element.period).toSet().toList();
    _periods.sort();

    _iupacGroupNames = allPeriodicTableElements
      .where((element) => element.iupacGroupName != null)
      .map((element) {
        switch (element.iupacGroupName) {
          case IUPACGroupName.ALKALI_METALS: return 'periodictable_category_iupacgroupname_alkalimetals';
          case IUPACGroupName.ALKALINE_EARTH_METALS: return 'periodictable_category_iupacgroupname_alkalineearthmetals';
          case IUPACGroupName.EARTH_METALS: return 'periodictable_category_iupacgroupname_earthmetals';
          case IUPACGroupName.TETRELS: return 'periodictable_category_iupacgroupname_tetrels';
          case IUPACGroupName.PNICTOGENS: return 'periodictable_category_iupacgroupname_pnictogens';
          case IUPACGroupName.CHALCOGENS: return 'periodictable_category_iupacgroupname_chalcogens';
          case IUPACGroupName.HALOGENS: return 'periodictable_category_iupacgroupname_halogens';
          case IUPACGroupName.NOBLE_GASES: return 'periodictable_category_iupacgroupname_noblegases';
          case IUPACGroupName.LANTHANIDES: return 'periodictable_category_iupacgroupname_lanthanides';
          case IUPACGroupName.ACTINIDES: return 'periodictable_category_iupacgroupname_actinides';
          default: return '';
        }
      })
      .toSet()
      .toList();
    _iupacGroupNames.sort();

    _statesOfMatter = allPeriodicTableElements
      .map((element) {
        switch (element.stateOfMatter) {
          case StateOfMatter.SOLID: return 'periodictable_category_stateofmatter_solid';
          case StateOfMatter.LIQUID: return 'periodictable_category_stateofmatter_liquid';
          case StateOfMatter.GAS: return 'periodictable_category_stateofmatter_gas';
          default: return '';
        }
      })
      .toSet()
      .toList();
    _statesOfMatter.sort();
  }

  @override
  Widget build(BuildContext context) {
    if (_newCategory && !_valueCategories.contains(_currentCategory)) {
      _currentValueCategoryListItems = _buildValueCategoryItems(_currentCategory);
      _newCategory = false;
    }

    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: 'Category'
        ),
        GCWDropDownButton(
          value: _currentCategory,
          items: _categories.entries
            .map((category) {
              return DropdownMenuItem(
                value: category.key,
                child: Text(i18n(context, category.value)),
              );
            })
            .toList(),
          onChanged: (value) {
            setState(() {
              _newCategory = value != _currentCategory;
              _currentCategory = value;
            });
          },
        ),
        _valueCategories.contains(_currentCategory)
          ? Container()
          : GCWDropDownButton(
              value: _currentValueCategoryValue,
              items: _currentValueCategoryListItems,
              onChanged: (value) {
                setState(() {
                  _currentValueCategoryValue = value;
                });
              },
            ),
        _sortableCategories.contains(_currentCategory)
          ? GCWTwoOptionsSwitch(
              value: _currentSortingOrder,
              title: 'Sorting',
              leftValue: 'Ascending',
              rightValue: 'Descending',
              onChanged: (value) {
                setState(() {
                  _currentSortingOrder = value;
                });
              },
            )
          : Container(),
        _buildOutput()
      ],
    );
  }

  _buildValueCategoryItems(PeriodicTableCategory category) {
    var listItems = SplayTreeMap<dynamic, int>();

    switch (category) {
      case PeriodicTableCategory.ELEMENT_NAME: _elementNames.entries.forEach((entry) => listItems.putIfAbsent(i18n(context, entry.value), () => entry.key)); break;
      case PeriodicTableCategory.CHEMICAL_SYMBOL: _chemicalSymbols.entries.forEach((entry) => listItems.putIfAbsent(entry.value, () => entry.key)); break;
      case PeriodicTableCategory.ATOMIC_NUMBER: _atomicNumbers.entries.forEach((entry) => listItems.putIfAbsent(entry.value, () => entry.key)); break;
//      case PeriodicTableCategory.IUPAC_GROUP: listItems = _iupacGroups.map((iupacGroup) => iupacGroup.toString()).toList(); break;
//      case PeriodicTableCategory.IUPAC_GROUP_NAME: listItems = _iupacGroupNames.map((iupacGroupName) => i18n(context, iupacGroupName)).toList(); break;
//      case PeriodicTableCategory.MAIN_GROUP: listItems = _mainGroups.map((mainGroup) => mainGroup.toString()).toList(); break;
//      case PeriodicTableCategory.SUB_GROUP: listItems = _subGroups.map((subGroup) => subGroup.toString()).toList(); break;
//      case PeriodicTableCategory.PERIOD: listItems = _periods.map((period) => period.toString()).toList(); break;
//      case PeriodicTableCategory.STATE_OF_MATTER: listItems = _statesOfMatter.map((state) => i18n(context, state)).toList(); break;
      default: break;
    }

    _currentValueCategoryValue = listItems[listItems.firstKey()];

    return listItems.entries.map((entry) {
      return DropdownMenuItem(
        value: entry.value,
        child: Text(entry.key.toString()),
      );
    }).toList();
  }

  Widget _buildOutput() {
    var list;

    PeriodicTableElement pte;

    switch (_currentCategory) {
      case PeriodicTableCategory.ELEMENT_NAME:
      case PeriodicTableCategory.ATOMIC_NUMBER:
      case PeriodicTableCategory.CHEMICAL_SYMBOL:
        pte = allPeriodicTableElements.firstWhere((element) => element.atomicNumber == _currentValueCategoryValue);
        break;
      case PeriodicTableCategory.IUPAC_GROUP:
        break;
      case PeriodicTableCategory.IUPAC_GROUP_NAME:
        break;
      case PeriodicTableCategory.MAIN_GROUP:
        break;
      case PeriodicTableCategory.SUB_GROUP:
        break;
      case PeriodicTableCategory.PERIOD:
        break;
      case PeriodicTableCategory.STATE_OF_MATTER:
        break;
      case PeriodicTableCategory.MASS:
        break;
      case PeriodicTableCategory.MELTING_POINT:
        break;
      case PeriodicTableCategory.BOILING_POINT:
        break;
      case PeriodicTableCategory.ELECTRONEGATIVITY:
        break;
      case PeriodicTableCategory.DESITY:
        break;
      case PeriodicTableCategory.IS_SYNTHETIC:
        break;
      case PeriodicTableCategory.IS_RADIOACTIVE:
        break;
      case PeriodicTableCategory.HALF_LIFE:
        break;
      case PeriodicTableCategory.MOST_COMMON_ISOTOP:
        break;
    }

    var outputData = <String, dynamic>{};

    if (pte != null) {
      print('ZZZZZZ');
      outputData = {
        'periodictable_element_attribute_name' : i18n(context, pte.name),
        'periodictable_element_attribute_chemicalsymbol' : pte.chemicalSymbol,
        'periodictable_element_attribute_atomicnumber' : pte.atomicNumber,
        'periodictable_element_attribute_meltingpoint' : pte.meltingPoint,
      };
    }

    var rows = twoColumnMultiLineOutput(context, outputData);

    rows.insert(0,
      GCWTextDivider(
        text: i18n(context, 'common_output')
      )
    );

    return Column(
      children: rows
    );

  }
}