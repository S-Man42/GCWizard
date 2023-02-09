import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coord_format_getter.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coords_return_types.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/utils/collection_utils.dart';

class GCWCoordsFormatSelector extends StatefulWidget {
  final Function(CoordsFormatValue) onChanged;
  final CoordsFormatValue format;

  const GCWCoordsFormatSelector({Key? key, required this.onChanged, required this.format}) : super(key: key);

  @override
  GCWCoordsFormatSelectorState createState() => GCWCoordsFormatSelectorState();

  List<GCWDropDownMenuItem> getDropDownItems(BuildContext context) {
    return allCoordFormats.map((entry) {
      return GCWDropDownMenuItem(
          value: entry.key, child: i18n(context, entry.name, ifTranslationNotExists: entry.name), subtitle: entry.example);
    }).toList();
  }
}

class GCWCoordsFormatSelectorState extends State<GCWCoordsFormatSelector> {
    var _currentFormat = defaultCoordFormat().format;
    var _currentSubtype = defaultCoordFormat().subtype;

  @override
  Widget build(BuildContext context) {
    _currentFormat = widget.format.format;
    _currentSubtype = widget.format.subtype;

    return Column(
      children: <Widget>[
        GCWDropDown<CoordFormatKey>(
          value: widget.format.format,
          onChanged: (CoordFormatKey newValue) {
            setState(() {
              _currentFormat = newValue;

              switch (_currentFormat) {
                case CoordFormatKey.GAUSS_KRUEGER:
                  _currentSubtype = defaultGaussKruegerType;
                  break;
                case CoordFormatKey.LAMBERT:
                  _currentSubtype = defaultLambertType;
                  break;
                case CoordFormatKey.SLIPPY_MAP:
                  _currentSubtype = defaultSlippyMapType;
                  break;
                default:
                  _currentSubtype = null;
              }

              _emitOnChange();
            });
          },
          items: widget.getDropDownItems(context),
        ),
        _buildSubtype()
      ],
    );
  }

  _buildSubtype() {
    var format = widget.format.format;

    if (_currentSubtype == null) {
      _currentSubtype = getDefaultSubtypesForFormat(format);
      if (_currentSubtype == null)
        return Container();
    }

    switch (format) {
      case CoordFormatKey.GAUSS_KRUEGER:
      case CoordFormatKey.LAMBERT:
        return GCWDropDown<CoordFormatKey>(
          value: _currentSubtype,
          items: getCoordinateFormatByKey(format).subtypes!.map((subtype) {
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
      case CoordFormatKey.SLIPPY_MAP:
        return GCWIntegerSpinner(
          min: 0,
          max: 30,
          title: i18n(context, 'coords_formatconverter_slippymap_zoom') + ' (Z)',
          value: switchMapKeyValue(SLIPPY_MAP_ZOOM)[_currentSubtype]!,
          onChanged: (int value) {
            setState(() {
              _currentSubtype = SLIPPY_MAP_ZOOM[value];
              _emitOnChange();
            });
          },
        );
      default:
        return Container();
    }
  }

  _emitOnChange() {
    var output = CoordsFormatValue(_currentFormat, _currentSubtype);
    widget.onChanged(output);
  }
}
