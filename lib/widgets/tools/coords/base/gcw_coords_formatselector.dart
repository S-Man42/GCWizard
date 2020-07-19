import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';

class GCWCoordsFormatSelector extends StatefulWidget {
  final Function onChanged;
  final Map<String, String> format;

  const GCWCoordsFormatSelector({Key key, this.onChanged, this.format}) : super(key: key);

  @override
  _GCWCoordsFormatSelectorState createState() => _GCWCoordsFormatSelectorState();
}

class _GCWCoordsFormatSelectorState extends State<GCWCoordsFormatSelector> {

  var _currentFormat = defaultCoordFormat()['format'];
  var _currentSubtype = defaultCoordFormat()['subtype'];

  @override
  void initState() {
    super.initState();

    if (widget.format != null) {
      _currentFormat = widget.format['format'];

      if (widget.format['subtype'] != null)
        _currentSubtype = widget.format['subtype'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWDropDownButton(
          value: _currentFormat,
          onChanged: (newValue) {
            setState(() {
              _currentFormat = newValue;

              switch(_currentFormat) {
                case keyCoordsGaussKrueger: _currentSubtype = keyCoordsGaussKruegerGK1; break;
                default: _currentSubtype = null;
              }

              _emitOnChange();
            });
          },
          items: allCoordFormats.map((entry) {
            return DropdownMenuItem(
              value: entry.key,
              child: Text(i18n(context, entry.name) ?? entry.name),
            );
          }).toList(),
        ),
        _buildSubtype()
      ],
    );
  }

  _buildSubtype() {
    switch (_currentFormat) {
      case keyCoordsGaussKrueger:
        return GCWDropDownButton(
          value: _currentSubtype,
          items: getCoordinateFormatByKey(keyCoordsGaussKrueger).subtypes.map((subtype) {
            return DropdownMenuItem(
              value: subtype.key,
              child: Text(i18n(context, subtype.name)),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _currentSubtype = value;
              _emitOnChange();
            });
          },
        );
      default:
        return Container();
    }
  }

  _emitOnChange() {
    Map<String, String> output = {'format': _currentFormat, 'subtype': _currentSubtype};
    widget.onChanged(output);
  }
}
