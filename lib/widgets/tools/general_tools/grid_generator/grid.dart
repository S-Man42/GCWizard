import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/common/parser/variable_string_expander.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/tools/general_tools/grid_generator/grid_painter.dart';

class _GridConfiguration {
  final GridType type;
  final int width;
  final int height;
  final String enumeration;
  final String columnEnumeration;
  final String rowEnumeration;
  final GridEnumerationStart enumerationStart;
  final GridBoxEnumerationStartDirection enumerationStartDirection;
  final GridBoxEnumerationBehaviour enumerationBehaviour;

  const _GridConfiguration(
      this.type, 
      this.width, 
      this.height, 
      {
        this.enumeration, 
        this.columnEnumeration, 
        this.rowEnumeration, 
        this.enumerationStart, 
        this.enumerationStartDirection, 
        this.enumerationBehaviour
      }
  );
}

final _GRID_CONFIGURATIONS = {
  'grid_custom' : null,
  'grid_intersections_5x5' : _GridConfiguration(GridType.POINTS, 5, 5, 
    columnEnumeration: '12345',
    rowEnumeration: '12345'
  ),
  'grid_intersections_6x6' : _GridConfiguration(GridType.POINTS, 6, 6,
    columnEnumeration: '123456',
    rowEnumeration: '123456'
  ),
  'grid_intersections_7x7' : _GridConfiguration(GridType.POINTS, 7, 7,
    columnEnumeration: '1234567',
    rowEnumeration: '1,2,3,4,5-7'
  ),
  'grid_intersections_8x8' : _GridConfiguration(GridType.POINTS, 8, 8,
    columnEnumeration: '12345678',
    rowEnumeration: '12345678'
  ),
  'grid_intersections_9x9' : _GridConfiguration(GridType.POINTS, 9, 9,
    columnEnumeration: '123456789',
    rowEnumeration: '123456789'
  ),
  'grid_intersections_10x10' : _GridConfiguration(GridType.GRID, 10, 10,
    columnEnumeration: '1 2 3 4 5 6 7 8 9 10',
    rowEnumeration: '1 2 3 4 5 6 7 8 9 10'
  ),
  'grid_boxes_5x5' : _GridConfiguration(GridType.BOXES, 5, 5,
    enumeration: '1-25',
  ),
  'grid_boxes_6x6' : _GridConfiguration(GridType.BOXES, 6, 6,
    enumeration: '1-36',
  ),
  'grid_boxes_7x7' : _GridConfiguration(GridType.BOXES, 7, 7,
    enumeration: '1-49',
  ),
  'grid_boxes_8x8' : _GridConfiguration(GridType.BOXES, 8, 8,
    enumeration: '1-64'
  ),
  'grid_boxes_9x9' : _GridConfiguration(GridType.BOXES, 9, 9,
    enumeration: '1-81',
  ),
  'grid_boxes_10x10' : _GridConfiguration(GridType.BOXES, 10, 10,
    enumeration: '1-100',
  ),
  'grid_chessboard' : _GridConfiguration(GridType.BOXES, 8, 8,
    columnEnumeration: 'ABCDEFGH',
    rowEnumeration: '1-8'
  ),
  'grid_germanlotto' : _GridConfiguration(GridType.BOXES, 7, 7,
    enumeration: '1-49',
  ),
  'grid_germantoto6of45' : _GridConfiguration(GridType.BOXES, 7, 7,
    enumeration: '1-45',
  ),
  'grid_eurojackpot5of50' : _GridConfiguration(GridType.GRID, 10, 5,
    enumeration: '1-50'
  ),
};

class Grid extends StatefulWidget {
  @override
  GridState createState() => GridState();
}

class GridState extends State<Grid> {
  var _currentColor = GridPaintColor.RED;
  var _currentGridConfiguration = 'grid_boxes_10x10';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: GCWDropDownButton(
                value: _currentGridConfiguration,
                items: _GRID_CONFIGURATIONS.map((key, value) {
                  return MapEntry(key, 
                    GCWDropDownMenuItem(
                      value: key,
                      child: key
                    )                    
                  );
                }).values.toList(),
                onChanged: (value) {
                  setState(() {
                    _currentGridConfiguration = value;
                  });
                },
              ),
            )
          ],
        ),        
        Container(
          constraints: BoxConstraints(maxWidth: min(500, MediaQuery.of(context).size.height * 0.8)),
          child: GridPainter(
            tapColor: _currentColor,
            type: _GRID_CONFIGURATIONS[_currentGridConfiguration].type,
            countColumns: _GRID_CONFIGURATIONS[_currentGridConfiguration].width,
            countRows: _GRID_CONFIGURATIONS[_currentGridConfiguration].height,
            boxEnumeration: _getEnumeration(_GRID_CONFIGURATIONS[_currentGridConfiguration].enumeration),
            columnEnumeration: _getEnumeration(_GRID_CONFIGURATIONS[_currentGridConfiguration].columnEnumeration),
            rowEnumeration: _getEnumeration(_GRID_CONFIGURATIONS[_currentGridConfiguration].rowEnumeration),
            boxEnumerationStart: _GRID_CONFIGURATIONS[_currentGridConfiguration].enumerationStart,
            boxEnumerationStartDirection: _GRID_CONFIGURATIONS[_currentGridConfiguration].enumerationStartDirection,
            boxEnumerationBehaviour: _GRID_CONFIGURATIONS[_currentGridConfiguration].enumerationBehaviour,
          ),
          margin: EdgeInsets.symmetric(vertical: 20.0),
        ),
        Row(
          children: GridPaintColor.values.map((color) => _buildColorField(color)).toList()
        )
      ],
    );
  }

  List<String> _getEnumeration(String enumeration) {
    if (enumeration == null || enumeration.isEmpty)
      return <String>[];

    if (enumeration.contains(RegExp(r'[\,\-]')) && VARIABLESTRING.hasMatch(enumeration)) {
      var expanded = VariableStringExpander('x', {'x': enumeration}).run()
          .map((e) => e['text'].toString()).toList();

      expanded.sort((a, b) => int.tryParse(a).compareTo(int.tryParse(b)));
      return expanded;
    }

    if (enumeration.contains(RegExp(r'\s+'))) {
      return enumeration.split(RegExp(r'\s+')).toList();
    }

    return enumeration.split('').toList();
  }

  Expanded _buildColorField(GridPaintColor color) {
    return Expanded(
      child: InkWell(
        child: Container(
          height: 50,
          decoration: _getColorDecoration(color),
          margin : EdgeInsets.only(
            left:  GridPaintColor.values.indexOf(color) == 0 ? 0.0 : DEFAULT_MARGIN,
            right: GridPaintColor.values.indexOf(color) == GridPaintColor.values.length - 1 ? 0.0 : DEFAULT_MARGIN,
          ),
        ),
        onTap: () {
          setState(() {
            _currentColor = color;
          });
        },
      )
    );
  }

  BoxDecoration _getColorDecoration(GridPaintColor color) {
    return _currentColor == color
      ? BoxDecoration(
          color: GRID_COLORS[color]['color'],
          border: Border.all(color: themeColors().accent(), width: 5)
      )
          : BoxDecoration(
          color: GRID_COLORS[color]['color'],
          border: Border.all(color: themeColors().mainFont(), width: 1.0)
      );
  }
}
