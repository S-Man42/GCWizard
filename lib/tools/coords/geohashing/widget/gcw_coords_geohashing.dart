
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/permissions/user_location.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_submit_button.dart';
import 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords_paste_button.dart';
import 'package:gc_wizard/common_widgets/coordinates/gcw_coords_output/gcw_coords_output.dart';
import 'package:gc_wizard/common_widgets/coordinates/gcw_coords_output/gcw_coords_outputformat.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/gcw_date_picker.dart';
import 'package:gc_wizard/common_widgets/gcw_toast.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_onoff_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_double_textfield.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_integer_textfield.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/map_view/logic/map_geometries.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class Geohashing extends StatefulWidget {
  const Geohashing({Key? key}) : super(key: key);

  @override
  _GeohashingState createState() => _GeohashingState();
}

class _GeohashingState extends State<Geohashing> {
  late TextEditingController _LongitudeController;
  late TextEditingController _LatitudeController;
  late TextEditingController _DowJonesIndexController;
  late DateTime _currentDate;

  final _location = Location();
  bool _isOnLocationAccess = false;
  BaseCoordinate _currentCoords = defaultBaseCoordinate;
  bool _hasSetCoords = false;

  var _currentLongitude = defaultIntegerText;
  var _currentLatitude = defaultIntegerText;
  var _currentOnline = false;
  var _currentDowJonesIndex = 0.0;

  var _currentOutputFormat = defaultCoordinateFormat;
  var _currentMapPoints = <GCWMapPoint>[];
  List<String> _currentOutput = <String>[];


  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();
    _currentDate = DateTime(now.year, now.month, now.day);

    _LongitudeController = TextEditingController(text: _currentLongitude.text);
    _LatitudeController = TextEditingController(text: _currentLatitude.text);
    _DowJonesIndexController = TextEditingController(text: _currentDowJonesIndex.toString());
  }

  @override
  void dispose() {
    _LongitudeController.dispose();
    _LatitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      GCWTextDivider(text: '', trailing: _buildTrailingButtons(IconButtonSize.SMALL)),
      GCWDatePicker(
          date: _currentDate,
          onChanged: (value) {
          setState(() {
            _currentDate = value;
          });
        },
      ),
      Row(
        children: [
          Expanded(
            child:
              GCWIntegerTextField(
                hintText: i18n(context, 'coords_common_latitude'),
                controller: _LatitudeController,
                onChanged: (ret) {
                  setState(() {
                    _currentLatitude = ret;
                    _setCurrentValueAndEmitOnChange();
                  });
                }
              ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child:
            GCWIntegerTextField(
                hintText: i18n(context, 'coords_common_longitude'),
                controller: _LongitudeController,
                onChanged: (ret) {
                  setState(() {
                    _currentLongitude = ret;
                    _setCurrentValueAndEmitOnChange();
                  });
                }
              ),

          )
      ]),
      GCWTextDivider(text: i18n(context, 'geohashing_dow_jones_index')),
      GCWOnOffSwitch(
        title: i18n(context, 'common_loadfile_openfrom_url'),
        value: _currentOnline,
        onChanged: (value) {
          setState(() {
            _currentOnline = value;
          });
        }
      ),
      if (!_currentOnline) GCWDoubleTextField(
        min: 0,
        controller: _DowJonesIndexController,
        hintText: i18n(context, 'geohashing_dow_jones_index'),
        onChanged: (value) {
        setState(() {
          _currentDowJonesIndex = value.value;
        });
      }),
      GCWCoordsOutputFormat(
        coordFormat: _currentOutputFormat,
        onChanged: (value) {
          setState(() {
            _currentOutputFormat = value;
          });
        },
      ),
      GCWSubmitButton(
        onPressed: () {
          setState(() {
            _calculateOutput();
          });
        },
      ),
      GCWCoordsOutput(
        outputs: _currentOutput,
        points: _currentMapPoints,
      ),
    ]);
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
              //_setUserLocationCoords();
            },
          ),
        ),
        GCWCoordsPasteButton(size: size, onPasted: _setCoords)
      ],
    );
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

  void _calculateOutput() {
    // var _startCoords = _currentInputCoords.toLatLng() ?? defaultCoordinate;
    //
    // var shadowLen = shadowLength(
    //     _currentHeight, _startCoords, defaultEllipsoid, _currentDateTime);
    //
    // String lengthOutput = '';
    // double _currentLength = shadowLen.length;
    //
    // NumberFormat format = NumberFormat('0.000');
    // double? _currentFormattedLength;
    // if (_currentLength < 0) {
    //   lengthOutput = i18n(context, 'shadowlength_no_shadow');
    // } else {
    //   _currentFormattedLength = _currentOutputFormat.lengthUnit.fromMeter(_currentLength);
    //   lengthOutput = format.format(_currentFormattedLength) + ' ' + _currentOutputFormat.lengthUnit.symbol;
    // }
    //
    // Widget outputShadow = GCWOutput(
    //   title: i18n(context, 'shadowlength_length'),
    //   child: lengthOutput,
    //   copyText: _currentFormattedLength == null ? null : _currentLength.toString(),
    // );

    // var _currentMapPoints = [
    //   GCWMapPoint(
    //       point: _startCoords,
    //       markerText: i18n(context, 'coords_waypointprojection_start'),
    //       coordinateFormat: _currentOutputFormat),
    //   // GCWMapPoint(
    //   //     point: shadowLen.shadowEndPosition,
    //   //     color: COLOR_MAP_CALCULATEDPOINT,
    //   //     markerText: i18n(context, 'coords_waypointprojection_end'),
    //   //     coordinateFormat: _currentOutputFormat.format)
    // ];
    //
    // Widget outputLocation = GCWCoordsOutput(
    //   title: i18n(context, 'shadowlength_location'),
    //   outputs: [
    //     buildCoordinate(_currentOutputFormat.format, shadowLen.shadowEndPosition, defaultEllipsoid).toString()
    //   ],
    //   points: _currentMapPoints,
    // );
    //
    // var outputsSun = [
    //   [i18n(context, 'astronomy_position_azimuth'), format.format(shadowLen.sunPosition.azimuth) + '°'],
    //   [i18n(context, 'astronomy_position_altitude'), format.format(shadowLen.sunPosition.altitude) + '°'],
    // ];
    //
    // Widget rowsSunData = GCWColumnedMultilineOutput(
    //     firstRows: [GCWTextDivider(text: i18n(context, 'astronomy_sunposition_title'))], data: outputsSun);
    //
    // return Column(children: [outputShadow, outputLocation, rowsSunData]);
  }

  void _setCurrentValueAndEmitOnChange() {
    // var geohashing = Geohashing(_currentDate, _currentLatitude.value, _currentLongitude.value);
    //
    // widget.onChanged(geohashing);
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

        LatLng _coords;
        if (locationData.latitude == null || locationData.longitude == null) {
          _coords = defaultCoordinate;
        } else {
          _coords = LatLng(locationData.latitude!, locationData.longitude!);
        }
        _currentCoords = buildCoordinate(_currentCoords.format, _coords);
        _hasSetCoords = true;

        _isOnLocationAccess = false;
        _setCurrentValueAndEmitOnChange();
      });
    });
  }
}
