import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords_formatselector.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/units/gcw_unit_dropdown.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coords_return_types.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/length.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/unit_category.dart';

class GCWCoordsOutputFormatDistanceValue {
  final CoordsFormatValue format;
  final Length lengthUnit;

  GCWCoordsOutputFormatDistanceValue(this.format, this.lengthUnit);
}

class GCWCoordsOutputFormatDistance extends StatefulWidget {
  final CoordsFormatValue coordFormat;
  final Function(GCWCoordsOutputFormatDistanceValue) onChanged;

  const GCWCoordsOutputFormatDistance({Key? key, required this.coordFormat, required this.onChanged}) : super(key: key);

  @override
  GCWCoordsOutputFormatDistanceState createState() => GCWCoordsOutputFormatDistanceState();
}

class GCWCoordsOutputFormatDistanceState extends State<GCWCoordsOutputFormatDistance> {
  var _currentCoordFormat = defaultCoordFormat();
  Length _currentLengthUnit = UNITCATEGORY_LENGTH.defaultUnit as Length;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      GCWTextDivider(text: i18n(context, 'coords_output_format')),
      Row(
        children: <Widget>[
          Expanded(
              flex: 3,
              child: Container(
                  child: GCWCoordsFormatSelector(
                    format: widget.coordFormat ?? _currentCoordFormat,
                    onChanged: (value) {
                      setState(() {
                        _currentCoordFormat = value;
                        _setCurrentValueAndEmitOnChange();
                      });
                    },
                  ),
                  padding: EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN))),
          Expanded(
            flex: 1,
            child: GCWUnitDropDown<Length>(
                unitList: allLengths(),
                value: _currentLengthUnit,
                onChanged: (Length value) {
                  setState(() {
                    _currentLengthUnit = value;
                    _setCurrentValueAndEmitOnChange();
                  });
                }),
          )
        ],
      )
    ]);
  }

  _setCurrentValueAndEmitOnChange() {
    widget.onChanged(GCWCoordsOutputFormatDistanceValue(_currentCoordFormat, _currentLengthUnit));
  }
}
