import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/permissions/user_location.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/clipboard/gcw_clipboard.dart';
import 'package:gc_wizard/tools/coords/_common/widget/coord_format_inputs/degrees_lat_textinputformatter.dart';
import 'package:gc_wizard/tools/coords/_common/widget/coord_format_inputs/degrees_lon_textinputformatter.dart';
import 'package:gc_wizard/tools/coords/_common/widget/gcw_coords_formatselector.dart';
import 'package:gc_wizard/tools/coords/_common/widget/gcw_coords_paste_button.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_sign_dropdown.dart';
import 'package:gc_wizard/common_widgets/gcw_distance.dart';
import 'package:gc_wizard/common_widgets/gcw_snackbar.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/common_widgets/text_input_formatters/gcw_integer_textinputformatter.dart';
import 'package:gc_wizard/common_widgets/text_input_formatters/gcw_minutesseconds_textinputformatter.dart';
import 'package:gc_wizard/common_widgets/text_input_formatters/wrapper_for_masktextinputformatter.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_double_textfield.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_integer_textfield.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/coords/_common/formats/dec/logic/dec.dart';
import 'package:gc_wizard/tools/coords/_common/formats/dmm/logic/dmm.dart';
import 'package:gc_wizard/tools/coords/_common/formats/dms/logic/dms.dart';
import 'package:gc_wizard/tools/coords/_common/formats/dutchgrid/logic/dutchgrid.dart';
import 'package:gc_wizard/tools/coords/_common/formats/gausskrueger/logic/gauss_krueger.dart';
import 'package:gc_wizard/tools/coords/_common/formats/geo3x3/logic/geo3x3.dart';
import 'package:gc_wizard/tools/coords/_common/formats/geohash/logic/geohash.dart';
import 'package:gc_wizard/tools/coords/_common/formats/geohex/logic/geohex.dart';
import 'package:gc_wizard/tools/coords/_common/formats/lambert/logic/lambert.dart';
import 'package:gc_wizard/tools/coords/_common/formats/maidenhead/logic/maidenhead.dart';
import 'package:gc_wizard/tools/coords/_common/formats/makaney/logic/makaney.dart';
import 'package:gc_wizard/tools/coords/_common/formats/mercator/logic/mercator.dart';
import 'package:gc_wizard/tools/coords/_common/formats/natural_area_code/logic/natural_area_code.dart';
import 'package:gc_wizard/tools/coords/_common/formats/openlocationcode/logic/open_location_code.dart';
import 'package:gc_wizard/tools/coords/_common/formats/quadtree/logic/quadtree.dart';
import 'package:gc_wizard/tools/coords/_common/formats/reversewherigo_day1976/logic/reverse_wherigo_day1976.dart';
import 'package:gc_wizard/tools/coords/_common/formats/reversewherigo_waldmeister/logic/reverse_wherigo_waldmeister.dart';
import 'package:gc_wizard/tools/coords/_common/formats/slippymap/logic/slippy_map.dart';
import 'package:gc_wizard/tools/coords/_common/formats/swissgrid/logic/swissgrid.dart';
import 'package:gc_wizard/tools/coords/_common/formats/swissgridplus/logic/swissgridplus.dart';
import 'package:gc_wizard/tools/coords/_common/formats/xyz/logic/xyz.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_constants.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_text_formatter.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/_common/formats/mgrs_utm/logic/mgrs.dart';
import 'package:gc_wizard/tools/coords/_common/formats/utm/logic/utm.dart';
import 'package:gc_wizard/utils/collection_utils.dart';
import 'package:gc_wizard/utils/complex_return_types.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/utils/data_type_utils/double_type_utils.dart';
import 'package:gc_wizard/utils/string_utils.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

part 'package:gc_wizard/tools/coords/_common/formats/dec/widget/gcw_coords_dec.dart';
part 'package:gc_wizard/tools/coords/_common/formats/dmm/widget/gcw_coords_dmm.dart';
part 'package:gc_wizard/tools/coords/_common/formats/dms/widget/gcw_coords_dms.dart';
part 'package:gc_wizard/tools/coords/_common/formats/dutchgrid/widget/gcw_coords_dutchgrid.dart';
part 'package:gc_wizard/tools/coords/_common/formats/gausskrueger/widget/gcw_coords_gausskrueger.dart';
part 'package:gc_wizard/tools/coords/_common/formats/lambert/widget/gcw_coords_lambert.dart';
part 'package:gc_wizard/tools/coords/_common/formats/mercator/widget/gcw_coords_mercator.dart';
part 'package:gc_wizard/tools/coords/_common/formats/openlocationcode/widget/gcw_coords_openlocationcode.dart';
part 'package:gc_wizard/tools/coords/_common/formats/quadtree/widget/gcw_coords_quadtree.dart';
part 'package:gc_wizard/tools/coords/_common/formats/reversewherigo_day1976/widget/gcw_coords_reversewherigo_day1976.dart';
part 'package:gc_wizard/tools/coords/_common/formats/reversewherigo_waldmeister/widget/gcw_coords_reversewherigo_waldmeister.dart';
part 'package:gc_wizard/tools/coords/_common/formats/slippymap/widget/gcw_coords_slippymap.dart';
part 'package:gc_wizard/tools/coords/_common/formats/swissgrid/widget/gcw_coords_swissgrid.dart';
part 'package:gc_wizard/tools/coords/_common/formats/swissgridplus/widget/gcw_coords_swissgridplus.dart';
part 'package:gc_wizard/tools/coords/_common/formats/xyz/widget/gcw_coords_xyz.dart';
part 'package:gc_wizard/tools/coords/_common/formats/geo3x3/widget/gcw_coords_geo3x3.dart';
part 'package:gc_wizard/tools/coords/_common/formats/geo3x3/widget/geo3x3_textinputformatter.dart';
part 'package:gc_wizard/tools/coords/_common/formats/geohash/widget/gcw_coords_geohash.dart';
part 'package:gc_wizard/tools/coords/_common/formats/geohash/widget/geohash_textinputformatter.dart';
part 'package:gc_wizard/tools/coords/_common/formats/geohex/widget/gcw_coords_geohex.dart';
part 'package:gc_wizard/tools/coords/_common/formats/geohex/widget/geohex_textinputformatter.dart';
part 'package:gc_wizard/tools/coords/_common/formats/maidenhead/widget/gcw_coords_maidenhead.dart';
part 'package:gc_wizard/tools/coords/_common/formats/maidenhead/widget/maidenhead_textinputformatter.dart';
part 'package:gc_wizard/tools/coords/_common/formats/makaney/widget/gcw_coords_makaney.dart';
part 'package:gc_wizard/tools/coords/_common/formats/makaney/widget/makaney_textinputformatter.dart';
part 'package:gc_wizard/tools/coords/_common/formats/mgrs_utm/widget/gcw_coords_mgrs.dart';
part 'package:gc_wizard/tools/coords/_common/formats/utm/widget/gcw_coords_utm.dart';
part 'package:gc_wizard/tools/coords/_common/formats/mgrs_utm/widget/utm_lonzone_textinputformatter.dart';
part 'package:gc_wizard/tools/coords/_common/formats/natural_area_code/widget/gcw_coords_naturalareacode.dart';
part 'package:gc_wizard/tools/coords/_common/formats/natural_area_code/widget/naturalareacode_textinputformatter.dart';

class GCWCoords extends StatefulWidget {
  final void Function(BaseCoordinate) onChanged;
  final LatLng? coordinates;
  final CoordinateFormat coordsFormat;
  final String? title;
  final bool? notitle;

  const GCWCoords(
      {Key? key,
      this.title,
      required this.onChanged,
      this.coordinates,
      required this.coordsFormat,
      this.notitle = false})
      : super(key: key);

  @override
  _GCWCoordsState createState() => _GCWCoordsState();
}

class _GCWCoordsState extends State<GCWCoords> {
  BaseCoordinate _currentCoords = defaultBaseCoordinate;
  bool _hasSetCoords = false;
  bool _resetCoords = false;

  Widget? _currentWidget;

  final _location = Location();
  bool _isOnLocationAccess = false;

  @override
  void initState() {
    super.initState();

    if (widget.coordinates != null) {
      _hasSetCoords = true;
      _resetCoords = true;
    }

    _currentCoords = buildCoordinate(widget.coordsFormat, widget.coordinates ?? defaultCoordinate);
  }

  BaseCoordinate _buildCoord(CoordinateFormat format) {
    if (_hasSetCoords && _currentCoords.toLatLng() != null) {
      return buildCoordinate(format, _currentCoords.toLatLng()!);
    } else {
      return buildUninitializedCoordinateByFormat(format);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<_GCWCoordWidget> _coordsWidgets = [
      _GCWCoordsDEC(
        initialize: _resetCoords,
        coordinates: _currentCoords,
        onChanged: (newValue) {
          setState(() {
            _setCurrentValueAndEmitOnChange(newValue);
          });
        },
      ),
      _GCWCoordsDMM(
        initialize: _resetCoords,
        coordinates: _currentCoords,
        onChanged: (newValue) {
          setState(() {
            _setCurrentValueAndEmitOnChange(newValue);
          });
        },
      ),
      _GCWCoordsDMS(
        initialize: _resetCoords,
        coordinates: _currentCoords,
        onChanged: (newValue) {
          setState(() {
            _setCurrentValueAndEmitOnChange(newValue);
          });
        },
      ),
      _GCWCoordsUTM(
        initialize: _resetCoords,
        coordinates: _currentCoords,
        onChanged: (newValue) {
          setState(() {
            _setCurrentValueAndEmitOnChange(newValue);
          });
        },
      ),
      _GCWCoordsMGRS(
        initialize: _resetCoords,
        coordinates: _currentCoords,
        onChanged: (newValue) {
          setState(() {
            _setCurrentValueAndEmitOnChange(newValue);
          });
        },
      ),
      _GCWCoordsXYZ(
        initialize: _resetCoords,
        coordinates: _currentCoords is XYZCoordinate
            ? _currentCoords as XYZCoordinate
            : XYZCoordinate.defaultCoordinate,
        onChanged: (newValue) {
          setState(() {
            _setCurrentValueAndEmitOnChange(newValue);
          });
        },
      ),
      _GCWCoordsSwissGrid(
        initialize: _resetCoords,
        coordinates: _currentCoords,
        onChanged: (newValue) {
          setState(() {
            _setCurrentValueAndEmitOnChange(newValue);
          });
        },
      ),
      _GCWCoordsSwissGridPlus(
        initialize: _resetCoords,
        coordinates: _currentCoords,
        onChanged: (newValue) {
          setState(() {
            _setCurrentValueAndEmitOnChange(newValue);
          });
        },
      ),
      _GCWCoordsGaussKrueger(
        initialize: _resetCoords,
        coordinates: _currentCoords,
        onChanged: (newValue) {
          setState(() {
            _setCurrentValueAndEmitOnChange(newValue);
          });
        },
      ),
      _GCWCoordsLambert(
        initialize: _resetCoords,
        coordinates: _currentCoords,
        onChanged: (newValue) {
          setState(() {
            _setCurrentValueAndEmitOnChange(newValue);
          });
        },
      ),
      _GCWCoordsDutchGrid(
        initialize: _resetCoords,
        coordinates: _currentCoords,
        onChanged: (newValue) {
          setState(() {
            _setCurrentValueAndEmitOnChange(newValue);
          });
        },
      ),
      _GCWCoordsMaidenhead(
        initialize: _resetCoords,
        coordinates: _currentCoords,
        onChanged: (newValue) {
          setState(() {
            _setCurrentValueAndEmitOnChange(newValue);
          });
        },
      ),
      _GCWCoordsMercator(
        initialize: _resetCoords,
        coordinates: _currentCoords,
        onChanged: (newValue) {
          setState(() {
            _setCurrentValueAndEmitOnChange(newValue);
          });
        },
      ),
      _GCWCoordsNaturalAreaCode(
        initialize: _resetCoords,
        coordinates: _currentCoords,
        onChanged: (newValue) {
          setState(() {
            _setCurrentValueAndEmitOnChange(newValue);
          });
        },
      ),
      _GCWCoordsSlippyMap(
        initialize: _resetCoords,
        coordinates: _currentCoords,
        onChanged: (newValue) {
          setState(() {
            _setCurrentValueAndEmitOnChange(newValue);
          });
        },
      ),
      _GCWCoordsMakaney(
        initialize: _resetCoords,
        coordinates: _currentCoords,
        onChanged: (newValue) {
          setState(() {
            _setCurrentValueAndEmitOnChange(newValue);
          });
        },
      ),
      _GCWCoordsGeohash(
        initialize: _resetCoords,
        coordinates: _currentCoords,
        onChanged: (newValue) {
          setState(() {
            _setCurrentValueAndEmitOnChange(newValue);
          });
        },
      ),
      _GCWCoordsGeoHex(
        initialize: _resetCoords,
        coordinates: _currentCoords,
        onChanged: (newValue) {
          setState(() {
            _setCurrentValueAndEmitOnChange(newValue);
          });
        },
      ),
      _GCWCoordsGeo3x3(
        initialize: _resetCoords,
        coordinates: _currentCoords,
        onChanged: (newValue) {
          setState(() {
            _setCurrentValueAndEmitOnChange(newValue);
          });
        },
      ),
      _GCWCoordsOpenLocationCode(
        initialize: _resetCoords,
        coordinates: _currentCoords,
        onChanged: (newValue) {
          setState(() {
            _setCurrentValueAndEmitOnChange(newValue);
          });
        },
      ),
      _GCWCoordsQuadtree(
        initialize: _resetCoords,
        coordinates: _currentCoords,
        onChanged: (newValue) {
          setState(() {
            _setCurrentValueAndEmitOnChange(newValue);
          });
        },
      ),
      _GCWCoordsReverseWherigoWaldmeister(
        initialize: _resetCoords,
        coordinates: _currentCoords,
        onChanged: (newValue) {
          setState(() {
            _setCurrentValueAndEmitOnChange(newValue);
          });
        },
      ),
      _GCWCoordsReverseWherigoDay1976(
        initialize: _resetCoords,
        coordinates: _currentCoords,
        onChanged: (newValue) {
          setState(() {
            _setCurrentValueAndEmitOnChange(newValue);
          });
        },
      ),
    ];

    _resetCoords = false;

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

    var rawWidget = _coordsWidgets
        .firstWhereOrNull((_GCWCoordWidget entry) => entry.type == _currentCoords.format.type);
    if (rawWidget == null) {
      _currentWidget = _coordsWidgets.first;
    } else {
      _currentWidget = rawWidget;
    }

    _widget.children.add(_currentWidget!);

    return _widget;
  }

  GCWCoordsFormatSelector _buildInputFormatSelector() {
    return GCWCoordsFormatSelector(
      format: _currentCoords.format,
      onChanged: (CoordinateFormat newFormat) {
        setState(() {
          if (equalsCoordinateFormats(_currentCoords.format, newFormat)) {
            return;
          }

          if (_currentCoords.format.type != newFormat.type) {
            _currentCoords = _buildCoord(newFormat);
          } else if (_currentCoords.format.subtype != newFormat.subtype) {
            _currentCoords.format.subtype = newFormat.subtype;
          }

          _resetCoords = true;
          _setCurrentValueAndEmitOnChange();

          FocusScope.of(context).requestFocus(FocusNode()); //Release focus from previously edited field
        });
      },
    );
  }

  Row _buildTrailingButtons(IconButtonSize size) {
    return Row(
      children: [
        GCWIconButton(
            icon: Icons.copy,
            size: IconButtonSize.SMALL,
            onPressed: () {
              insertIntoGCWClipboard(
                  context,
                  formatCoordOutput(
                      _currentCoords.toLatLng() ?? defaultCoordinate, _currentCoords.format, defaultEllipsoid));
            }),
        Container(width: DEFAULT_MARGIN),
        GCWIconButton(
          icon: _isOnLocationAccess ? Icons.refresh : Icons.location_on,
          size: size,
          onPressed: () {
            _setUserLocationCoords();
          },
        ),
        Container(width: DEFAULT_MARGIN),
        GCWCoordsPasteButton(size: size, onPasted: _setCoords),
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

    var _coordsForCurrentFormat =
        pastedCoords.firstWhereOrNull((BaseCoordinate coords) => coords.format.type == _currentCoords.format.type);
    _coordsForCurrentFormat ??= pastedCoords.first;
    if (isCoordinateFormatWithSubtype(_coordsForCurrentFormat.format.type)) {
      _coordsForCurrentFormat.format.subtype =
          defaultCoordinateFormatSubtypeForFormat(_coordsForCurrentFormat.format.type);
    }

    _currentCoords = _coordsForCurrentFormat;
    _hasSetCoords = true;
    _resetCoords = true;

    _setCurrentValueAndEmitOnChange();
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
        showSnackBar(i18n(context, 'coords_common_location_permissiondenied'), context);

        return;
      }

      _location.getLocation().then((LocationData locationData) {
        if (locationData.accuracy == null || locationData.accuracy! > LOW_LOCATION_ACCURACY) {
          showSnackBar(
              i18n(context, 'coords_common_location_lowaccuracy',
                  parameters: [NumberFormat('0.0').format(locationData.accuracy)]),
              context);
        }

        LatLng _coords;
        if (locationData.latitude == null || locationData.longitude == null) {
          _coords = defaultCoordinate;
        } else {
          _coords = LatLng(locationData.latitude!, locationData.longitude!);
        }
        _currentCoords = buildCoordinate(_currentCoords.format, _coords);
        _hasSetCoords = true;
        _resetCoords = true;

        _isOnLocationAccess = false;
        _setCurrentValueAndEmitOnChange();
      });
    });
  }
}

abstract class _GCWCoordWidget extends StatefulWidget{
  final CoordinateFormatKey type;
  final String i18nKey;
  final bool initialize;
  final BaseCoordinate coordinates;
  final void Function(BaseCoordinate?) onChanged;

  const _GCWCoordWidget({
      super.key,
      required this.type,
      required this.i18nKey,
      this.initialize = false,
      required this.coordinates,
      required this.onChanged});
}
