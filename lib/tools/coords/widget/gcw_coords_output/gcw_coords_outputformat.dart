import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/coords/widget/gcw_coords/coord_format_inputs/gcw_coords_formatselector/gcw_coords_formatselector.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/coords/utils/default_getter.dart';

class GCWCoordsOutputFormat extends StatefulWidget {
  final Map<String, String> coordFormat;
  final Function onChanged;

  const GCWCoordsOutputFormat({Key key, this.coordFormat, this.onChanged}) : super(key: key);

  @override
  GCWCoordsOutputFormatState createState() => GCWCoordsOutputFormatState();
}

class GCWCoordsOutputFormatState extends State<GCWCoordsOutputFormat> {
  var _currentFormat = defaultCoordFormat();

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      GCWTextDivider(
        text: i18n(context, 'coords_output_format'),
      ),
      GCWCoordsFormatSelector(
        format: widget.coordFormat ?? _currentFormat,
        onChanged: (value) {
          setState(() {
            _currentFormat = value;
            widget.onChanged(_currentFormat);
          });
        },
      )
    ]);
  }
}
