import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/permissions/user_location.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords_formatselector.dart';
import 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords_paste_button.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format.dart';
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
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_constants.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/mgrs.dart';
import 'package:gc_wizard/tools/coords/format_converter/logic/utm.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/utils/collection_utils.dart';
import 'package:gc_wizard/utils/complex_return_types.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/utils/data_type_utils/double_type_utils.dart';
import 'package:gc_wizard/utils/string_utils.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:collection/collection.dart';

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

class _GCWCoordWidget{
  final CoordinateFormatKey coordinateFormatKey;
  final Widget widget;
  
  _GCWCoordWidget(this.coordinateFormatKey, this.widget);
}

class GCWCoords extends StatefulWidget {
  final void Function(BaseCoordinates) onChanged;
  final CoordinateFormat coordsFormat;
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
      this.notitle = false,
      this.restoreCoordinates = false})
      : super(key: key);

  @override
  GCWCoordsState createState() => GCWCoordsState();
}

class GCWCoordsState extends State<GCWCoords> {  
  late BaseCoordinates _currentCoords;
  late CoordinateFormat _currentCoordFormat;
  late BaseCoordinates _pastedCoords;

  Widget? _currentWidget;

  var _location = Location();
  bool _isOnLocationAccess = false;

  @override
  void initState() {
    super.initState();

    _currentCoordFormat = widget.coordsFormat;
    _currentCoords = DEC.fromLatLon(widget.coordinates ?? defaultCoordinate);
    _setPastedCoordsFormat();
    _pastedCoords = _currentCoords;
  }
  
  @override
  Widget build(BuildContext context) {
    final List<_GCWCoordWidget> _coordsWidgets = [
      _GCWCoordWidget(
        CoordinateFormatKey.DEC,
        _GCWCoordsDEC(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      ),
      _GCWCoordWidget(
        CoordinateFormatKey.DMM,
        _GCWCoordsDMM(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
    ),
    _GCWCoordWidget(
        CoordinateFormatKey.DMS,
        _GCWCoordsDMS(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
    ),
    _GCWCoordWidget(
        CoordinateFormatKey.UTM,
        _GCWCoordsUTM(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
    ),
    _GCWCoordWidget(
        CoordinateFormatKey.MGRS,
        _GCWCoordsMGRS(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
    ),
    _GCWCoordWidget(
        CoordinateFormatKey.XYZ,
        _GCWCoordsXYZ(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
    ),
    _GCWCoordWidget(
        CoordinateFormatKey.SWISS_GRID,
        _GCWCoordsSwissGrid(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
    ),
    _GCWCoordWidget(
        CoordinateFormatKey.SWISS_GRID_PLUS,
        _GCWCoordsSwissGridPlus(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
    ),
    _GCWCoordWidget(
        CoordinateFormatKey.GAUSS_KRUEGER,
        _GCWCoordsGaussKrueger(
          coordinates: _pastedCoords,
          subtype: _currentCoordFormat.subtype ?? defaultGaussKruegerType,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
    ),
    _GCWCoordWidget(
        CoordinateFormatKey.LAMBERT,
        _GCWCoordsLambert(
          coordinates: _pastedCoords,
          subtype: _currentCoordFormat.subtype ?? defaultLambertType,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
    ),
    _GCWCoordWidget(
        CoordinateFormatKey.DUTCH_GRID,
        _GCWCoordsDutchGrid(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
    ),
    _GCWCoordWidget(
        CoordinateFormatKey.MAIDENHEAD,
        _GCWCoordsMaidenhead(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
    ),
    _GCWCoordWidget(
        CoordinateFormatKey.MERCATOR,
        _GCWCoordsMercator(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
    ),
    _GCWCoordWidget(
        CoordinateFormatKey.NATURAL_AREA_CODE,
        _GCWCoordsNaturalAreaCode(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
    ),
    _GCWCoordWidget(
        CoordinateFormatKey.SLIPPY_MAP,
        _GCWCoordsSlippyMap(
          coordinates: _pastedCoords,
          subtype: (_currentCoords as SlippyMap).subtype,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
    ),
    _GCWCoordWidget(
        CoordinateFormatKey.MAKANEY,
        _GCWCoordsMakaney(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
    ),
    _GCWCoordWidget(
        CoordinateFormatKey.GEOHASH,
        _GCWCoordsGeohash(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
    ),
    _GCWCoordWidget(
        CoordinateFormatKey.GEOHEX,
        _GCWCoordsGeoHex(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
    ),
    _GCWCoordWidget(
        CoordinateFormatKey.GEO3X3,
        _GCWCoordsGeo3x3(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
    ),
    _GCWCoordWidget(
        CoordinateFormatKey.OPEN_LOCATION_CODE,
        _GCWCoordsOpenLocationCode(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
    ),
    _GCWCoordWidget(
        CoordinateFormatKey.QUADTREE,
        _GCWCoordsQuadtree(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
    ),
    _GCWCoordWidget(
        CoordinateFormatKey.REVERSE_WIG_WALDMEISTER,
        _GCWCoordsReverseWherigoWaldmeister(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
    ),
    _GCWCoordWidget(
        CoordinateFormatKey.REVERSE_WIG_DAY1976,
        _GCWCoordsReverseWherigoDay1976(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      ),
    ];

    // TODO Mike: Please check if this is really nullable. If so, all coordinate specific _GCWCoords* widgets need to have nullable coordinates fields which yields even more nullable stuff...
    // _pastedCoords = null;

    Column _widget;
    if (widget.notitle != null && widget.notitle! && widget.title != null && widget.title!.isNotEmpty) {
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
          GCWTextDivider(text: widget.title!, trailing: _buildTrailingButtons(IconButtonSize.SMALL)),
          _buildInputFormatSelector()
        ],
      );
    }

    var rawWidget = _coordsWidgets.firstWhereOrNull((_GCWCoordWidget entry) => entry.coordinateFormatKey == _currentCoordFormat.type);
    if (rawWidget == null) {
      _currentWidget = _coordsWidgets.first.widget;
    } else {
      _currentWidget = rawWidget.widget;
    }

    _widget.children.add(_currentWidget!);

    return _widget;
  }

  GCWCoordsFormatSelector _buildInputFormatSelector() {
    return GCWCoordsFormatSelector(
      format: _currentCoordFormat,
      onChanged: (CoordinateFormat newFormat) {
        setState(() {
          // TODO Mike Please check against previous code. The change made here is not quite simple and clear if logic still does the same here for changing Coords Format and Subtypes
          if (_currentCoordFormat != newFormat) {
            if (widget.restoreCoordinates != null && widget.restoreCoordinates!)
              _pastedCoords = _currentCoords;
            else if (_currentCoordFormat.subtype == newFormat.subtype)
              _currentCoords = BaseCoordinates();

            _currentCoordFormat = newFormat;
            _setCurrentValueAndEmitOnChange();
          }
          FocusScope.of(context).requestFocus(FocusNode()); //Release focus from previously edited field
        });
      },
    );
  }

  Row _buildTrailingButtons(IconButtonSize size) {
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

  void _setCurrentValueAndEmitOnChange([BaseCoordinates? newValue]) {
    if (newValue != null)
      _currentCoords = newValue;

    widget.onChanged(_currentCoords);
  }

  void _setCoords(List<BaseCoordinates> pastedCoords) {
    if (pastedCoords.isEmpty) return;

    var _coordsForCurrentFormat = pastedCoords.firstWhereOrNull((BaseCoordinates coords) => coords.key == _currentCoordFormat.type);
    if (_coordsForCurrentFormat == null) {
      _coordsForCurrentFormat = pastedCoords.first;
      _currentCoordFormat.type = pastedCoords.first.key;
    }

    _setPastedCoordsFormat();
    _currentCoords = _coordsForCurrentFormat;

    _setCurrentValueAndEmitOnChange();
  }

  void _setPastedCoordsFormat() {
    switch (_currentCoordFormat.type) {
      case CoordinateFormatKey.DEC:
      case CoordinateFormatKey.DMM:
      case CoordinateFormatKey.DMS:
      case CoordinateFormatKey.UTM:
      case CoordinateFormatKey.MGRS:
      case CoordinateFormatKey.XYZ:
      case CoordinateFormatKey.SWISS_GRID:
      case CoordinateFormatKey.SWISS_GRID_PLUS:
        break;
      case CoordinateFormatKey.GAUSS_KRUEGER:
        _currentCoordFormat.subtype = defaultGaussKruegerType;
        break;
      case CoordinateFormatKey.LAMBERT:
        _currentCoordFormat.subtype = defaultLambertType;
        break;
      case CoordinateFormatKey.DUTCH_GRID:
      case CoordinateFormatKey.MAIDENHEAD:
      case CoordinateFormatKey.MERCATOR:
      case CoordinateFormatKey.NATURAL_AREA_CODE:
        break;
      case CoordinateFormatKey.SLIPPY_MAP:
        _currentCoordFormat.subtype = defaultSlippyMapType;
        break;
      case CoordinateFormatKey.GEOHASH:
      case CoordinateFormatKey.GEOHEX:
      case CoordinateFormatKey.GEO3X3:
      case CoordinateFormatKey.OPEN_LOCATION_CODE:
      case CoordinateFormatKey.QUADTREE:
      case CoordinateFormatKey.MAKANEY:
      case CoordinateFormatKey.REVERSE_WIG_WALDMEISTER:
      case CoordinateFormatKey.REVERSE_WIG_DAY1976:
        break;
      default:
        _currentCoordFormat = defaultCoordinateFormat;
    }
  }

  void _setUserLocationCoords() {
    if (_isOnLocationAccess) return;

    setState(() {
      _isOnLocationAccess = true;
    });

    checkLocationPermission(_location).then((bool value) {
      if (value == false) {
        setState(() {
          _isOnLocationAccess = false;
        });
        showToast(i18n(context, 'coords_common_location_permissiondenied'));

        return;
      }

      _location.getLocation().then((LocationData locationData) {
        if (locationData.accuracy == null || locationData.accuracy! > 20) {
          showToast(i18n(context, 'coords_common_location_lowaccuracy',
              parameters: [NumberFormat('0.0').format(locationData.accuracy)]));
        }

        _pastedCoords = BaseCoordinates(locationData.latitude, locationData.longitude);
        _currentCoords = _pastedCoords;
        _setPastedCoordsFormat();

        _isOnLocationAccess = false;
        _setCurrentValueAndEmitOnChange();
      });
    });
  }
}
