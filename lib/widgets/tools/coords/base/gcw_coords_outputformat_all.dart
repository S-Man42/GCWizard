import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_formatselector_all.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';

class GCWCoordsOutputFormatAll extends StatefulWidget {
  final Map<String, String> coordFormat;
  final Function onChanged;

  const GCWCoordsOutputFormatAll({Key key, this.coordFormat, this.onChanged}) : super(key: key);

  @override
  GCWCoordsOutputFormatStateAll createState() => GCWCoordsOutputFormatStateAll();
}

class GCWCoordsOutputFormatStateAll extends State<GCWCoordsOutputFormatAll> {
  var _currentFormat = defaultCoordFormat();

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      GCWTextDivider(
        text: i18n(context, 'coords_output_format'),
      ),
      GCWCoordsFormatSelectorAll(
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
