import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/coords/utils.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';

class GCWCoordsOutputFormat extends StatefulWidget {
  final coordFormat;
  final Function onChanged;

  const GCWCoordsOutputFormat({Key key, this.coordFormat, this.onChanged}) : super(key: key);

  @override
  GCWCoordsOutputFormatState createState() =>
      GCWCoordsOutputFormatState();
}

class GCWCoordsOutputFormatState
    extends State<GCWCoordsOutputFormat> {
  var _currentValue = defaultCoordFormat();

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          GCWTextDivider(
            text: i18n(context, 'coords_output_format')
          ),
          GCWCoordsDropDownButton(
            value: widget.coordFormat ?? _currentValue,
            itemList: allCoordFormats.map((coordFormat) {
              if (coordFormat.name == null)
                coordFormat = getCoordFormatByKey(coordFormat.key, context: context);
              return coordFormat;
            }).toList(),
            onChanged: (value) {
              setState(() {
                _currentValue = value;
                widget.onChanged(_currentValue);
              });
            },
          )
        ]
      );
  }
}
