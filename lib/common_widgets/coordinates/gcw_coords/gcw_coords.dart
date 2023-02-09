import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/permissions/user_location.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords_formatselector.dart';
import 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords_paste_button.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_sign_dropdown.dart';
import 'package:gc_wizard/common_widgets/gcw_distance.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/common_widgets/gcw_toast.dart';
import 'package:gc_wizard/common_widgets/text_input_formatters/gcw_integer_textinputformatter.dart';
import 'package:gc_wizard/common_widgets/text_input_formatters/gcw_minutesseconds_textinputformatter.dart';
import 'package:gc_wizard/common_widgets/text_input_formatters/wrapper_for_masktextinputformatter.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_double_textfield.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_integer_textfield.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/mgrs.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/utm.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coord_format_getter.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/utils/complex_return_types.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/utils/string_utils.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/degrees_latlon/degrees_lat_textinputformatter.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/degrees_latlon/degrees_lon_textinputformatter.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/degrees_latlon/gcw_coords_dec.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/degrees_latlon/gcw_coords_dmm.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/degrees_latlon/gcw_coords_dms.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/gcw_coords_dutchgrid.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/gcw_coords_gausskrueger.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/gcw_coords_lambert.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/gcw_coords_mercator.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/gcw_coords_openlocationcode.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/gcw_coords_quadtree.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/gcw_coords_reversewherigo_day1976.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/gcw_coords_reversewherigo_waldmeister.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/gcw_coords_slippymap.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/gcw_coords_swissgrid.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/gcw_coords_swissgridplus.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/gcw_coords_xyz.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/geo3x3/gcw_coords_geo3x3.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/geo3x3/geo3x3_textinputformatter.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/geohash/gcw_coords_geohash.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/geohash/geohash_textinputformatter.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/geohex/gcw_coords_geohex.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/geohex/geohex_textinputformatter.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/maidenhead/gcw_coords_maidenhead.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/maidenhead/maidenhead_textinputformatter.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/makaney/gcw_coords_makaney.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/makaney/makaney_textinputformatter.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/mgrs_utm/gcw_coords_mgrs.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/mgrs_utm/gcw_coords_utm.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/mgrs_utm/utm_lonzone_textinputformatter.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/natural_area_code/gcw_coords_naturalareacode.dart';
part 'package:gc_wizard/common_widgets/coordinates/gcw_coords/coord_format_inputs/natural_area_code/naturalareacode_textinputformatter.dart';

class GCWCoordsValue{
  GCWCoordsFormatValue format;
  BaseCoordinates value;

  GCWCoordsValue(this.format, this.value);
}

class GCWCoordsFormatValue{
  final String format;
  final String subtype;

  GCWCoordsFormatValue(this.format, this.subtype);
}

class GCWCoords extends StatefulWidget {
  final void Function(GCWCoordsValue) onChanged;
  final GCWCoordsFormatValue coordsFormat;
  final LatLng? coordinates;
  final String? title;
  final bool? notitle;
  final bool? restoreCoordinates;

  const GCWCoords(
      {Key? key,
      this.title,
      this.coordinates,
      required this.onChanged,
      required this.coordsFormat,
      this.notitle: false,
      this.restoreCoordinates: false})
      : super(key: key);

  @override
  GCWCoordsState createState() => GCWCoordsState();
}

class GCWCoordsState extends State<GCWCoords> {
  GCWCoordsValue _currentCoordsValue;
  BaseCoordinates _pastedCoords;

  Widget _currentWidget;

  var _location = Location();
  bool _isOnLocationAccess = false;

  @override
  void initState() {
    super.initState();

    _currentCoordsValue = GCWCoordsValue(widget.coordsFormat, DEC.fromLatLon(widget.coordinates ?? defaultCoordinate));
    _setPastedCoordsFormat();
    _pastedCoords = _currentValue;
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _coordsWidgets = [
      {
        'coordFormat': getCoordinateFormatByKey(CoordFormatKey.DEC),
        'widget': _GCWCoordsDEC(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(CoordFormatKey.DMM),
        'widget': _GCWCoordsDMM(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(CoordFormatKey.DMS),
        'widget': _GCWCoordsDMS(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(CoordFormatKey.UTM),
        'widget': _GCWCoordsUTM(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(CoordFormatKey.MGRS),
        'widget': _GCWCoordsMGRS(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(CoordFormatKey.XYZ),
        'widget': _GCWCoordsXYZ(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(CoordFormatKey.SWISS_GRID),
        'widget': _GCWCoordsSwissGrid(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(CoordFormatKey.SWISS_GRID_PLUS),
        'widget': _GCWCoordsSwissGridPlus(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(CoordFormatKey.GAUSS_KRUEGER),
        'widget': _GCWCoordsGaussKrueger(
          coordinates: _pastedCoords,
          subtype: _currentCoordsFormat['subtype'],
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(CoordFormatKey.LAMBERT),
        'widget': _GCWCoordsLambert(
          coordinates: _pastedCoords,
          subtype: _currentCoordsFormat['subtype'],
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(CoordFormatKey.DUTCH_GRID),
        'widget': _GCWCoordsDutchGrid(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(CoordFormatKey.MAIDENHEAD),
        'widget': _GCWCoordsMaidenhead(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(CoordFormatKey.MERCATOR),
        'widget': _GCWCoordsMercator(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(CoordFormatKey.NATURAL_AREA_CODE),
        'widget': _GCWCoordsNaturalAreaCode(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(CoordFormatKey.SLIPPY_MAP),
        'widget': _GCWCoordsSlippyMap(
          coordinates: _pastedCoords,
          zoom: double.tryParse(_currentCoordsFormat['subtype'] ?? defaultSlippyZoom.toString()),
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(CoordFormatKey.MAKANEY),
        'widget': _GCWCoordsMakaney(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(CoordFormatKey.GEOHASH),
        'widget': _GCWCoordsGeohash(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(CoordFormatKey.GEOHEX),
        'widget': _GCWCoordsGeoHex(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(CoordFormatKey.GEO3X3),
        'widget': _GCWCoordsGeo3x3(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(CoordFormatKey.OPEN_LOCATION_CODE),
        'widget': _GCWCoordsOpenLocationCode(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(CoordFormatKey.QUADTREE),
        'widget': _GCWCoordsQuadtree(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(CoordFormatKey.REVERSE_WIG_WALDMEISTER),
        'widget': _GCWCoordsReverseWherigoWaldmeister(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(CoordFormatKey.REVERSE_WIG_DAY1976),
        'widget': _GCWCoordsReverseWherigoDay1976(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
    ];

    _pastedCoords = null;

    Column _widget;
    if (widget.notitle) {
      _widget = Column(
        children: <Widget>[
          Row(
            children: [
              Expanded(child: _buildInputFormatSelector()),
              Container(
                  child: _buildTrailingButtons(IconButtonSize.NORMAL),
                  padding: EdgeInsets.only(left: 2 * DEFAULT_MARGIN))
            ],
          )
        ],
      );
    } else {
      _widget = Column(
        children: <Widget>[
          GCWTextDivider(text: widget.title, bottom: 0.0, trailing: _buildTrailingButtons(IconButtonSize.SMALL)),
          _buildInputFormatSelector()
        ],
      );
    }

    _currentWidget =
        _coordsWidgets.firstWhere((entry) => entry['coordFormat'].key == _currentCoordsFormat['format'])['widget'];

    _widget.children.add(_currentWidget);

    return _widget;
  }

  _buildInputFormatSelector() {
    return GCWCoordsFormatSelector(
      format: _currentCoordsFormat,
      onChanged: (newValue) {
        setState(() {
          if (_currentCoordsFormat != newValue) {
            if (widget.restoreCoordinates)
              _pastedCoords = _currentValue;
            else if (_subtypeChanged(_currentCoordsFormat, newValue))
              ;
            else
              _currentValue = DEC(defaultCoordinate.latitude, defaultCoordinate.longitude);

            _currentCoordsFormat = newValue;
            _setCurrentValueAndEmitOnChange();
          }
          FocusScope.of(context).requestFocus(FocusNode()); //Release focus from previous edited field
        });
      },
    );
  }

  bool _subtypeChanged(Map<String, String> currentValue, Map<String, String> newValue) {
    return currentValue["subtype"] != newValue["subtype"];
  }

  _buildTrailingButtons(IconButtonSize size) {
    return Row(
      children: [
        Container(
          child: GCWIconButton(
            icon: _isOnLocationAccess ? Icons.refresh : Icons.location_on,
            size: size,
            onPressed: () {
              _setUserLocationCoords();
            },
          ),
          padding: EdgeInsets.only(right: DEFAULT_MARGIN),
        ),
        GCWCoordsPasteButton(size: size, onPasted: _setCoords)
      ],
    );
  }

  _setCurrentValueAndEmitOnChange([BaseCoordinates newValue]) {
    widget.onChanged({'coordsFormat': _currentCoordsFormat, 'value': (newValue ?? _currentValue)?.toLatLng()});
  }

  _setCoords(List<BaseCoordinates> pastedCoords) {
    if (pastedCoords == null || pastedCoords.length == 0) return;

    if (pastedCoords.any((coords) => coords.key == _currentCoordsFormat['format'].toString())) {
      _pastedCoords = pastedCoords.where((coords) => coords.key == _currentCoordsFormat['format'].toString()).first;
    } else {
      _pastedCoords = pastedCoords.elementAt(0);
      _currentCoordsFormat = {'format': pastedCoords.elementAt(0).key};
    }

    _setPastedCoordsFormat();
    _currentValue = _pastedCoords;

    _setCurrentValueAndEmitOnChange();
  }

  _setPastedCoordsFormat() {
    switch (_currentCoordsFormat['format']) {
      case CoordFormatKey.DEC:
      case CoordFormatKey.DMM:
      case CoordFormatKey.DMS:
      case CoordFormatKey.UTM:
      case CoordFormatKey.MGRS:
      case CoordFormatKey.XYZ:
      case CoordFormatKey.SWISS_GRID:
      case CoordFormatKey.SWISS_GRID_PLUS:
        break;
      case CoordFormatKey.GAUSS_KRUEGER:
        _currentCoordsFormat.addAll({'subtype': getGaussKruegerTypKeyFromCode()});
        break;
      case CoordFormatKey.LAMBERT:
        _currentCoordsFormat.addAll({'subtype': getLambertKey()});
        break;
      case CoordFormatKey.DUTCH_GRID:
      case CoordFormatKey.MAIDENHEAD:
      case CoordFormatKey.MERCATOR:
      case CoordFormatKey.NATURAL_AREA_CODE:
        break;
      case CoordFormatKey.SLIPPY_MAP:
        _currentCoordsFormat.addAll({'subtype': defaultSlippyZoom.toString()});
        break;
      case CoordFormatKey.GEOHASH:
      case CoordFormatKey.GEOHEX:
      case CoordFormatKey.GEO3X3:
      case CoordFormatKey.OPEN_LOCATION_CODE:
      case CoordFormatKey.QUADTREE:
      case CoordFormatKey.MAKANEY:
      case CoordFormatKey.REVERSE_WIG_WALDMEISTER:
      case CoordFormatKey.REVERSE_WIG_DAY1976:
        break;
      default:
        _currentCoordsFormat = {'format': CoordFormatKey.DMM};
    }
  }

  _setUserLocationCoords() {
    if (_isOnLocationAccess) return;

    setState(() {
      _isOnLocationAccess = true;
    });

    checkLocationPermission(_location).then((value) {
      if (value == null || value == false) {
        setState(() {
          _isOnLocationAccess = false;
        });
        showToast(i18n(context, 'coords_common_location_permissiondenied'));

        return;
      }

      _location.getLocation().then((locationData) {
        if (locationData.accuracy > 20)
          showToast(i18n(context, 'coords_common_location_lowaccuracy',
              parameters: [NumberFormat('0.0').format(locationData.accuracy)]));

        _pastedCoords = DEC(locationData.latitude, locationData.longitude);
        _currentValue = _pastedCoords;
        _setPastedCoordsFormat();

        _isOnLocationAccess = false;
        _setCurrentValueAndEmitOnChange();
      });
    });
  }
}
