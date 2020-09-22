import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:intl/intl.dart';

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
          value: widget.format['format'] ?? _currentFormat,
          onChanged: (newValue) {
            setState(() {
              _currentFormat = newValue;

              switch(_currentFormat) {
                case keyCoordsGaussKrueger: _currentSubtype = keyCoordsGaussKruegerGK1; break;
                case keyCoordsSlippyMap: _currentSubtype = '10'; break;
                default: _currentSubtype = null;
              }

              _emitOnChange();
            });
          },
          items: allCoordFormats.map((entry) {
            return GCWDropDownMenuItem(
              value: entry.key,
              child: i18n(context, entry.name) ?? entry.name,
            );
          }).toList(),
        ),
        _buildSubtype()
      ],
    );
  }

  _buildSubtype() {
    switch (widget.format['format'] ?? _currentFormat) {
      case keyCoordsGaussKrueger:
        return GCWDropDownButton(
          value: _currentSubtype,
          items: getCoordinateFormatByKey(keyCoordsGaussKrueger).subtypes.map((subtype) {
            return GCWDropDownMenuItem(
              value: subtype.key,
              child: i18n(context, subtype.name),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _currentSubtype = value;
              _emitOnChange();
            });
          },
        );
      case keyCoordsSlippyMap:
        return GCWDoubleSpinner(
          min: 0.0,
          max: 30.0,
          title: i18n(context, 'coords_formatconverter_slippymap_zoom') + ' (Z)',
          value: double.tryParse(_currentSubtype),
          onChanged: (value) {
            setState(() {
              _currentSubtype = NumberFormat('0.00000').format(value);
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
