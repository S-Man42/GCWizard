import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/roman_numbers/roman_numbers.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/periodic_table.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/periodic_table/periodic_table_data_view.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';

class PeriodicTable extends StatefulWidget {
  @override
  PeriodicTableState createState() => PeriodicTableState();
}

class PeriodicTableState extends State<PeriodicTable> {
  var _cellWidth;
  var _maxCellHeight;
  BorderSide _border = BorderSide(width: 1.0, color: Colors.black87);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _cellWidth = (MediaQuery.of(context).size.width - 20) / 19;
    _maxCellHeight = (MediaQuery.of(context).size.height - 100) / 11;

    return Column(children: _buildOutput());
  }

  Color _getColorByStateOfMatter(StateOfMatter stateOfMatter) {
    switch (stateOfMatter) {
      case StateOfMatter.GAS:
        return Color(0xFFFFCDD2);
      case StateOfMatter.LIQUID:
        return Color(0xFFBCFF9F);
      case StateOfMatter.SOLID:
        return Color(0xFF9DCBFF);
      case StateOfMatter.UNKNOWN:
        return Color(0xFFD9D9D9);
    }
  }

  Widget _buildElement(PeriodicTableElement element) {
    return element == null
        ? Container(width: _cellWidth)
        : InkWell(
            child: Container(
              height: min(defaultFontSize() * 2.5, _maxCellHeight),
              decoration: BoxDecoration(
                color: _getColorByStateOfMatter(element.stateOfMatter),
                border: Border(
                    top: _border,
                    left: _border,
                    right: element.iupacGroup == 18 || [1, 4, 12, 71, 103].contains(element.atomicNumber)
                        ? _border
                        : BorderSide.none,
                    bottom: element.period == 7 ? _border : BorderSide.none),
              ),
              child: Column(
                children: [
                  Expanded(
                      child: AutoSizeText(
                    element.atomicNumber.toString(),
                    style: gcwTextStyle().copyWith(color: Colors.black),
                    minFontSize: 6,
                    maxLines: 1,
                  )),
                  Expanded(
                      child: AutoSizeText(
                    element.chemicalSymbol,
                    style: gcwTextStyle().copyWith(color: Colors.black),
                    minFontSize: 6,
                    maxLines: 1,
                  ))
                ],
              ),
              width: _cellWidth,
            ),
            onTap: () {
              Navigator.of(context).push(NoAnimationMaterialPageRoute(
                  builder: (context) => GCWTool(
                      tool: PeriodicTableDataView(atomicNumber: element.atomicNumber),
                      i18nPrefix: 'periodictable_dataview',
                      missingHelpLocales: ['fr'])));
            },
          );
  }

  _buildGroupHeadlineElement(int iupacGroup) {
    var group = iupacGroupToMainSubGroup(iupacGroup);

    return Container(
      height: min(defaultFontSize() * 2.5, _maxCellHeight),
      child: Column(
        children: [
          Expanded(
              child: AutoSizeText(
            iupacGroup.toString(),
            style: gcwTextStyle().copyWith(fontWeight: FontWeight.bold),
            minFontSize: 6,
            maxLines: 1,
          )),
          Expanded(
              child: AutoSizeText(
            encodeRomanNumbers(group['value']),
            style: gcwTextStyle().copyWith(fontWeight: FontWeight.bold),
            minFontSize: 6,
            maxLines: 1,
          ))
        ],
      ),
      width: _cellWidth,
    );
  }

  _buildHeadlineElement(int period, int iupacGroup) {
    if (iupacGroup == 0 && period > 0) {
      return Container(
        width: _cellWidth,
        child: Text(
          period.toString(),
          style: gcwTextStyle().copyWith(fontWeight: FontWeight.bold),
        ),
      );
    }

    if ([1, 18].contains(iupacGroup) && period == 0) {
      return _buildGroupHeadlineElement(iupacGroup);
    }

    if ([2, 13, 14, 15, 16, 17].contains(iupacGroup) && period == 1) {
      return _buildGroupHeadlineElement(iupacGroup);
    }

    if ([3, 4, 5, 6, 7, 8, 9, 10, 11, 12].contains(iupacGroup) && period == 3) {
      return _buildGroupHeadlineElement(iupacGroup);
    }

    return null;
  }

  _buildOutput() {
    var periods = <Widget>[];

    for (int period = 0; period <= 7; period++) {
      var periodRow = <Widget>[];

      for (int iupacGroup = 0; iupacGroup <= 18; iupacGroup++) {
        var headlineElement = _buildHeadlineElement(period, iupacGroup);
        if (headlineElement != null) {
          periodRow.add(headlineElement);
          continue;
        }

        PeriodicTableElement element = _getElementAtPSECoordinate(iupacGroup, period);
        periodRow.add(_buildElement(element));
      }
      periods.add(Row(
        children: periodRow,
      ));
    }

    periods.add(Container(height: min(defaultFontSize() * 2.5, _maxCellHeight)));

    List<Widget> lanthanides = allPeriodicTableElements
        .where((element) => element.iupacGroupName == IUPACGroupName.LANTHANIDES)
        .map((element) => _buildElement(element))
        .toList();

    lanthanides.insert(
        0,
        Container(
            width: _cellWidth * 4,
            child: AutoSizeText(
              i18n(context, 'periodictable_attribute_iupacgroupname_lanthanides'),
              style: gcwTextStyle(),
              minFontSize: 6,
              maxLines: 1,
            )));

    periods.add(Row(
      children: lanthanides,
    ));

    List<Widget> actinides = allPeriodicTableElements
        .where((element) => element.iupacGroupName == IUPACGroupName.ACTINIDES)
        .map((element) => _buildElement(element))
        .toList();

    actinides.insert(
        0,
        Container(
            width: _cellWidth * 4,
            child: AutoSizeText(
              i18n(context, 'periodictable_attribute_iupacgroupname_actinides'),
              style: gcwTextStyle(),
              minFontSize: 6,
              maxLines: 1,
            )));

    periods.add(Row(
      children: actinides,
    ));

    return periods;
  }

  _getElementAtPSECoordinate(int iupacGroup, int period) {
    return allPeriodicTableElements
        .firstWhere((element) => element.iupacGroup == iupacGroup && element.period == period, orElse: () => null);
  }
}
