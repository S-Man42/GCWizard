import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_formatselector.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';

class GCWCoordsOutputFormat extends StatefulWidget {
  final Map<String, String> coordFormat;
  final Function onChanged;
  final Function onExportCoordinates;

  const GCWCoordsOutputFormat({Key key, this.coordFormat, this.onChanged, this.onExportCoordinates}) : super(key: key);

  @override
  GCWCoordsOutputFormatState createState() =>
      GCWCoordsOutputFormatState();
}

class GCWCoordsOutputFormatState extends State<GCWCoordsOutputFormat> {
  var _currentFormat = defaultCoordFormat();

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          GCWTextDivider(
            text: i18n(context, 'coords_output_format'),
            trailing: Row(
              children: [
                Container(
                  child:  GCWIconButton(
                    iconData:  Icons.file_upload,
                    size: IconButtonSize.SMALL,
                    onPressed: () {
                      widget.onExportCoordinates();
                    },
                  ),
                  padding: EdgeInsets.only(right: DEFAULT_MARGIN),
                ),
              ],
            ),
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
        ]
      );
  }
}
