import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/coord/gcw_coords/coord_format_inputs/gcw_coords_formatselector/gcw_coords_formatselector.dart';
import 'package:gc_wizard/common_widgets/gcw_text_divider/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/units/gcw_unit_dropdownbutton/gcw_unit_dropdownbutton.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/tools/coords/utils/default_getter.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/length.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/unit_category.dart';

class GCWCoordsOutputFormatDistance extends StatefulWidget {
  final coordFormat;
  final Function onChanged;

  const GCWCoordsOutputFormatDistance({Key key, this.coordFormat, this.onChanged}) : super(key: key);

  @override
  GCWCoordsOutputFormatDistanceState createState() => GCWCoordsOutputFormatDistanceState();
}

class GCWCoordsOutputFormatDistanceState extends State<GCWCoordsOutputFormatDistance> {
  var _currentCoordFormat = defaultCoordFormat();
  Length _currentLengthUnit = UNITCATEGORY_LENGTH.defaultUnit;

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
            child: GCWUnitDropDownButton(
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
    widget.onChanged({'coordFormat': _currentCoordFormat, 'unit': _currentLengthUnit});
  }
}
