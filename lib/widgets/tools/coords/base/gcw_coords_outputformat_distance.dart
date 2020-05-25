import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/utils/units/lengths.dart';
import 'package:gc_wizard/widgets/common/gcw_lengths_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_dropdownbutton.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';

class GCWCoordsOutputFormatDistance extends StatefulWidget {
  final coordFormat;
  final Function onChanged;

  const GCWCoordsOutputFormatDistance({Key key, this.coordFormat, this.onChanged}) : super(key: key);

  @override
  GCWCoordsOutputFormatDistanceState createState() =>
      GCWCoordsOutputFormatDistanceState();
}

class GCWCoordsOutputFormatDistanceState
    extends State<GCWCoordsOutputFormatDistance> {
  var _currentCoordFormat = defaultCoordFormat();
  Length _currentLengthUnit = defaultLength;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: i18n(context, 'coords_output_format')
        ),
        Row(
          children: <Widget>[
            Expanded (
              flex: 3,
              child: Container(
                child: GCWCoordsDropDownButton(
                  value: widget.coordFormat ?? _currentCoordFormat,
                  itemList: allCoordFormats.map((coordFormat) {
                    if (coordFormat.name == null)
                      coordFormat = getCoordFormatByKey(coordFormat.key, context: context);
                    return coordFormat;
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentCoordFormat = value;
                      _setCurrentValueAndEmitOnChange();
                    });
                  },
                ),
                padding: EdgeInsets.only(right: 2 * DEFAULT_MARGIN)
              )
            ),
            Expanded(
              flex: 1,
              child: GCWLengthsDropDownButton(
                value: _currentLengthUnit,
                onChanged: (Length value) {
                  setState(() {
                    _currentLengthUnit = value;
                    _setCurrentValueAndEmitOnChange();
                  });
                }
              )
            )
          ],
        )
      ]
    );
  }

  _setCurrentValueAndEmitOnChange() {
    widget.onChanged({'coordFormat' : _currentCoordFormat, 'unit' : _currentLengthUnit});
  }
}
