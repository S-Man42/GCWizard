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
import 'package:location/location.dart';
import 'package:collection/collection.dart';
import 'package:latlong2/latlong.dart';

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
  final void Function(BaseCoordinate) onChanged;
  final LatLng? coordinates;
  final CoordinateFormat coordsFormat;
  final String? title;
  final bool? notitle;
  final bool? restoreCoordinates;

  const GCWCoords(
      {Key? key,
      this.title,
      required this.onChanged,
      this.coordinates,
      required this.coordsFormat,
      this.notitle = false,
      this.restoreCoordinates = false})
      : super(key: key);

  @override
  GCWCoordsState createState() => GCWCoordsState();
}

class GCWCoordsState extends State<GCWCoords> {  
  BaseCoordinate _currentCoords = defaultBaseCoordinate;
  bool _hasSetCoords = false;

  Widget? _currentWidget;

  final _location = Location();
  bool _isOnLocationAccess = false;

  @override
  void initState() {
    super.initState();

    _currentCoords = buildFormatByCoordinates(widget.coordsFormat, widget.coordinates ?? defaultCoordinate);
  }
  
  @override
  Widget build(BuildContext context) {
    final List<_GCWCoordWidget> _coordsWidgets = [
      _GCWCoordWidget(
        CoordinateFormatKey.DEC,
        _GCWCoordsDEC(
          isDefault: !_hasSetCoords,
          coordinates: _currentCoords is DEC
              ? _currentCoords as DEC
              : buildUninitializedCoordinatesByFormat(CoordinateFormat(CoordinateFormatKey.DEC)) as DEC,
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
          isDefault: !_hasSetCoords,
          coordinates: _currentCoords is DMM
              ? _currentCoords as DMM
              : buildUninitializedCoordinatesByFormat(CoordinateFormat(CoordinateFormatKey.DMM)) as DMM,
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
          isDefault: !_hasSetCoords,
          coordinates: _currentCoords is DMS
              ? _currentCoords as DMS
              : buildUninitializedCoordinatesByFormat(CoordinateFormat(CoordinateFormatKey.DMS)) as DMS,
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
          isDefault: !_hasSetCoords,
          coordinates: _currentCoords is UTMREF
              ? _currentCoords as UTMREF
              : buildUninitializedCoordinatesByFormat(CoordinateFormat(CoordinateFormatKey.UTM)) as UTMREF,
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
          isDefault: !_hasSetCoords,
          coordinates: _currentCoords is MGRS
              ? _currentCoords as MGRS
              : buildUninitializedCoordinatesByFormat(CoordinateFormat(CoordinateFormatKey.MGRS)) as MGRS,
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
          isDefault: !_hasSetCoords,
          coordinates: _currentCoords is XYZ
              ? _currentCoords as XYZ
              : buildUninitializedCoordinatesByFormat(CoordinateFormat(CoordinateFormatKey.XYZ)) as XYZ,
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
          isDefault: !_hasSetCoords,
          coordinates: _currentCoords is SwissGrid
              ? _currentCoords as SwissGrid
              : buildUninitializedCoordinatesByFormat(CoordinateFormat(CoordinateFormatKey.SWISS_GRID)) as SwissGrid,
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
          isDefault: !_hasSetCoords,
          coordinates: _currentCoords is SwissGridPlus
              ? _currentCoords as SwissGridPlus
              : buildUninitializedCoordinatesByFormat(CoordinateFormat(CoordinateFormatKey.SWISS_GRID_PLUS)) as SwissGridPlus,
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
          isDefault: !_hasSetCoords,
          coordinates: _currentCoords is GaussKrueger
              ? _currentCoords as GaussKrueger
              : buildUninitializedCoordinatesByFormat(CoordinateFormat(CoordinateFormatKey.GAUSS_KRUEGER)) as GaussKrueger,
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
          isDefault: !_hasSetCoords,
          coordinates: _currentCoords is Lambert
              ? _currentCoords as Lambert
              : buildUninitializedCoordinatesByFormat(CoordinateFormat(CoordinateFormatKey.LAMBERT)) as Lambert,
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
          isDefault: !_hasSetCoords,
          coordinates: _currentCoords is DutchGrid
              ? _currentCoords as DutchGrid
              : buildUninitializedCoordinatesByFormat(CoordinateFormat(CoordinateFormatKey.DUTCH_GRID)) as DutchGrid,
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
          isDefault: !_hasSetCoords,
          coordinates: _currentCoords is Maidenhead
              ? _currentCoords as Maidenhead
              : buildUninitializedCoordinatesByFormat(CoordinateFormat(CoordinateFormatKey.MAIDENHEAD)) as Maidenhead,
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
          isDefault: !_hasSetCoords,
          coordinates: _currentCoords is Mercator
              ? _currentCoords as Mercator
              : buildUninitializedCoordinatesByFormat(CoordinateFormat(CoordinateFormatKey.MERCATOR)) as Mercator,
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
          isDefault: !_hasSetCoords,
          coordinates: _currentCoords is NaturalAreaCode
              ? _currentCoords as NaturalAreaCode
              : buildUninitializedCoordinatesByFormat(CoordinateFormat(CoordinateFormatKey.NATURAL_AREA_CODE)) as NaturalAreaCode,
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
          isDefault: !_hasSetCoords,
          coordinates: _currentCoords is SlippyMap
              ? _currentCoords as SlippyMap
              : buildUninitializedCoordinatesByFormat(CoordinateFormat(CoordinateFormatKey.SLIPPY_MAP)) as SlippyMap,
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
          isDefault: !_hasSetCoords,
          coordinates: _currentCoords is Makaney
              ? _currentCoords as Makaney
              : buildUninitializedCoordinatesByFormat(CoordinateFormat(CoordinateFormatKey.MAKANEY)) as Makaney,
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
          isDefault: !_hasSetCoords,
          coordinates: _currentCoords is Geohash
              ? _currentCoords as Geohash
              : buildUninitializedCoordinatesByFormat(CoordinateFormat(CoordinateFormatKey.GEOHASH)) as Geohash,
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
          isDefault: !_hasSetCoords,
          coordinates: _currentCoords is GeoHex
              ? _currentCoords as GeoHex
              : buildUninitializedCoordinatesByFormat(CoordinateFormat(CoordinateFormatKey.GEOHEX)) as GeoHex,
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
          isDefault: !_hasSetCoords,
          coordinates: _currentCoords is Geo3x3
              ? _currentCoords as Geo3x3
              : buildUninitializedCoordinatesByFormat(CoordinateFormat(CoordinateFormatKey.GEO3X3)) as Geo3x3,
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
          isDefault: !_hasSetCoords,
          coordinates: _currentCoords is OpenLocationCode
              ? _currentCoords as OpenLocationCode
              : buildUninitializedCoordinatesByFormat(CoordinateFormat(CoordinateFormatKey.OPEN_LOCATION_CODE)) as OpenLocationCode,
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
          isDefault: !_hasSetCoords,
          coordinates: _currentCoords is Quadtree
              ? _currentCoords as Quadtree
              : buildUninitializedCoordinatesByFormat(CoordinateFormat(CoordinateFormatKey.QUADTREE)) as Quadtree,
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
          isDefault: !_hasSetCoords,
          coordinates: _currentCoords is ReverseWherigoWaldmeister
              ? _currentCoords as ReverseWherigoWaldmeister
              : buildUninitializedCoordinatesByFormat(CoordinateFormat(CoordinateFormatKey.REVERSE_WIG_WALDMEISTER)) as ReverseWherigoWaldmeister,
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
          isDefault: !_hasSetCoords,
          coordinates: _currentCoords is ReverseWherigoDay1976
              ? _currentCoords as ReverseWherigoDay1976
              : buildUninitializedCoordinatesByFormat(CoordinateFormat(CoordinateFormatKey.REVERSE_WIG_DAY1976)) as ReverseWherigoDay1976,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      ),
    ];

    // TODO Mike: Please check if this is really nullable. If so, all coordinate specific _GCWCoords* widgets need to have nullable coordinates fields which yields even more nullable stuff...
    // _currentCoords = null;

    Column _widget;
    if (widget.notitle != null && widget.notitle! && widget.title != null && widget.title!.isNotEmpty) {
      _widget = Column(
        children: <Widget>[
          Row(
            children: [
              Expanded(child: _buildInputFormatSelector()),
              Container(
                  padding: const EdgeInsets.only(left: 2 * DEFAULT_MARGIN),
                  child: _buildTrailingButtons(IconButtonSize.NORMAL))
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

    var rawWidget = _coordsWidgets.firstWhereOrNull((_GCWCoordWidget entry) => entry.coordinateFormatKey == _currentCoords.format.type);
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
      format: _currentCoords.format,
      onChanged: (CoordinateFormat newFormat) {
        setState(() {
          // TODO Mike Please check against previous code. The change made here is not quite simple and clear if logic still does the same here for changing Coords Format and Subtypes
          if (_currentCoords.format.type != newFormat.type) {
            if (widget.restoreCoordinates != null && widget.restoreCoordinates!) {
              _currentCoords = _currentCoords;
            } else if (_currentCoords.format.subtype == newFormat.subtype) {  // TODO Mike: If they have the same subtype, the format type could not have been changed...
              _currentCoords = defaultBaseCoordinate;
            }

            _currentCoords = buildUninitializedCoordinatesByFormat(newFormat);
            _hasSetCoords = false;
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
          padding: const EdgeInsets.only(right: DEFAULT_MARGIN),
          child: GCWIconButton(
            icon: _isOnLocationAccess ? Icons.refresh : Icons.location_on,
            size: size,
            onPressed: () {
              _setUserLocationCoords();
            },
          ),
        ),
        GCWCoordsPasteButton(size: size, onPasted: _setCoords)
      ],
    );
  }

  void _setCurrentValueAndEmitOnChange([BaseCoordinate? newValue]) {
    if (newValue != null) {
      _currentCoords = newValue;
    }

    if (_currentCoords.toLatLng() != null) {
      widget.onChanged(_currentCoords);
    }
  }

  void _setCoords(List<BaseCoordinate> pastedCoords) {
    if (pastedCoords.isEmpty) return;

    var _coordsForCurrentFormat = pastedCoords.firstWhereOrNull((BaseCoordinate coords) => coords.format.type == _currentCoords.format.type);
    _coordsForCurrentFormat ??= pastedCoords.first;
    if (isCoordinateFormatWithSubtype(_coordsForCurrentFormat.format.type)) {
      _coordsForCurrentFormat.format.subtype = defaultCoordinateFormatSubtypeForFormat(_coordsForCurrentFormat.format.type);
    }

    _currentCoords = _coordsForCurrentFormat;
    _hasSetCoords = true;

    _setCurrentValueAndEmitOnChange();
  }

  // void _setPastedCoordsFormat() {
  //   switch (_currentCoords.format.type) {
  //     case CoordinateFormatKey.DEC:
  //     case CoordinateFormatKey.DMM:
  //     case CoordinateFormatKey.DMS:
  //     case CoordinateFormatKey.UTM:
  //     case CoordinateFormatKey.MGRS:
  //     case CoordinateFormatKey.XYZ:
  //     case CoordinateFormatKey.SWISS_GRID:
  //     case CoordinateFormatKey.SWISS_GRID_PLUS:
  //       break;
  //     case CoordinateFormatKey.GAUSS_KRUEGER:
  //       _currentCoords.format.subtype = defaultGaussKruegerType;
  //       break;
  //     case CoordinateFormatKey.LAMBERT:
  //       _currentCoords.format.subtype = defaultLambertType;
  //       break;
  //     case CoordinateFormatKey.DUTCH_GRID:
  //     case CoordinateFormatKey.MAIDENHEAD:
  //     case CoordinateFormatKey.MERCATOR:
  //     case CoordinateFormatKey.NATURAL_AREA_CODE:
  //       break;
  //     case CoordinateFormatKey.SLIPPY_MAP:
  //       _currentCoords.format.subtype = defaultSlippyMapType;
  //       break;
  //     case CoordinateFormatKey.GEOHASH:
  //     case CoordinateFormatKey.GEOHEX:
  //     case CoordinateFormatKey.GEO3X3:
  //     case CoordinateFormatKey.OPEN_LOCATION_CODE:
  //     case CoordinateFormatKey.QUADTREE:
  //     case CoordinateFormatKey.MAKANEY:
  //     case CoordinateFormatKey.REVERSE_WIG_WALDMEISTER:
  //     case CoordinateFormatKey.REVERSE_WIG_DAY1976:
  //       break;
  //     default:
  //       _currentCoords.format = defaultCoordinateFormat;
  //   }
  // }

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
        if (locationData.accuracy == null || locationData.accuracy! > LOW_LOCATION_ACCURACY) {
          showToast(i18n(context, 'coords_common_location_lowaccuracy',
              parameters: [NumberFormat('0.0').format(locationData.accuracy)]));
        }

        LatLng _coords;
        if (locationData.latitude == null || locationData.longitude == null) {
          _coords = defaultCoordinate;
        } else {
          _coords = LatLng(locationData.latitude!, locationData.longitude!);
        }
        _currentCoords = buildDefaultFormatByCoordinates(_coords);

        _isOnLocationAccess = false;
        _setCurrentValueAndEmitOnChange();
      });
    });
  }
}
