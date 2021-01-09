import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/common/units/length.dart';
import 'package:gc_wizard/logic/common/units/unit.dart';
import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/theme/fixed_colors.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_paste_button.dart';
import 'package:gc_wizard/widgets/common/gcw_popup_menu.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_export_dialog.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_paste_button.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/mappoint_editor.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/mappolyline_editor.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/mapview_persistence_adapter.dart';
import 'package:gc_wizard/widgets/tools/coords/utils/user_location.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:prefs/prefs.dart';
import 'package:url_launcher/url_launcher.dart';

enum _LayerType {OPENSTREETMAP_MAPNIK, MAPBOX_SATELLITE}

final OSM_TEXT = 'coords_mapview_osm';
final OSM_URL = 'coords_mapview_osm_url';
final MAPBOX_SATELLITE_TEXT = 'coords_mapview_mapbox_satellite';
final MAPBOX_SATELLITE_URL = 'coords_mapview_mapbox_satellite_url';

final _DEFAULT_BOUNDS = LatLngBounds(LatLng(51.5, 12.9), LatLng(53.5, 13.9));
final _POLYGON_STROKEWIDTH = 3.0;
final _BUTTONGROUP_MARGIN = 30.0;

class GCWMapView extends StatefulWidget {
  List<GCWMapPoint> points;
  List<GCWMapPolyline> polylines;
  final bool isEditable;

  GCWMapView({
    Key key,
    this.points,
    this.polylines,
    this.isEditable: false
  }) : super(key: key) {
    if (points == null)
      points = [];
    if (polylines == null)
      polylines = [];
  }

  @override
  GCWMapViewState createState() => GCWMapViewState();
}

class GCWMapViewState extends State<GCWMapView> {
  final MapController _mapController = MapControllerImpl();
  final _GCWMapPopupController _popupLayerController = _GCWMapPopupController();

  _LayerType _currentLayer = _LayerType.OPENSTREETMAP_MAPNIK;
  var _mapBoxToken;

  var _currentLocationPermissionGranted;
  StreamSubscription<LocationData> _locationSubscription;
  Location _location = Location();
  LatLng _currentPosition;
  double _currentAccuracy;
  bool _manuallyToggledPosition = false;

  var _isPolylineDrawing = false;

  MapViewPersistenceAdapter _persistanceAdapter;

  Length defaultLengthUnit;

  _getInitialBounds() {
    if (widget.points == null || widget.points.length == 0)
      return _DEFAULT_BOUNDS;

    var _bounds = LatLngBounds();
    widget.points.forEach((point) => _bounds.extend(point.point));

    return _bounds;
  }

  Future<String> _loadToken(String tokenName) async {
    return await rootBundle.loadString('assets/tokens/$tokenName');
  }

  @override
  void initState() {
    super.initState();
    _popupLayerController.mapController = _mapController;

    if (widget.isEditable)
      _persistanceAdapter = MapViewPersistenceAdapter(widget);

    defaultLengthUnit = getUnitBySymbol(allLengths(), Prefs.get('i18n_default_length_unit'));
  }

  @override
  void dispose() {
    _cancelLocationSubscription();

    super.dispose();
  }

  _cancelLocationSubscription() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
      _locationSubscription = null;
      _currentPosition = null;
    }
  }

  _toggleLocationListening() {
    if (_currentLocationPermissionGranted == false)
      return;

    if (_locationSubscription == null) {
      _locationSubscription = _location.onLocationChanged
          .handleError((error) {
        _cancelLocationSubscription();
      }).listen((LocationData currentLocation) {
        setState(() {
          var newPosition = LatLng(currentLocation.latitude, currentLocation.longitude);

          if (_currentPosition == null && (_manuallyToggledPosition || widget.points.length == 0)) {
            _mapController.move(newPosition, _mapController.zoom);
          }
          _manuallyToggledPosition = false;

          _currentPosition = newPosition;
          _currentAccuracy = currentLocation.accuracy;
        });
      });

      _locationSubscription.pause();
    }

    setState(() {
      if (_locationSubscription.isPaused) {
        _locationSubscription.resume();
      } else {
        _locationSubscription.pause();
        _currentPosition = null;
      }
    });
  }

  _formatLengthOutput(double length) {
    return NumberFormat('0.00').format(defaultLengthUnit.fromMeter(length)) + ' ' + defaultLengthUnit.symbol;
  }

  @override
  Widget build(BuildContext context) {
    if (_currentLocationPermissionGranted == null) {
      checkLocationPermission(_location).then((value) {
        _currentLocationPermissionGranted = value;
        _toggleLocationListening();
      });
    }

    var layer = _currentLayer == _LayerType.MAPBOX_SATELLITE && _mapBoxToken != null && _mapBoxToken != ''
      ? TileLayerOptions(
          urlTemplate: 'https://api.mapbox.com/v4/mapbox.satellite/{z}/{x}/{y}@2x.jpg90?access_token={accessToken}',
          additionalOptions: {
            'accessToken': _mapBoxToken
          },
          tileProvider: CachedNetworkTileProvider()
        )
      : TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
          tileProvider: CachedNetworkTileProvider()
        );

    var layers = <LayerOptions>[layer];
    layers.addAll(_buildLinesAndMarkersLayers());

    return Listener(
      onPointerSignal: handleSignal,
      child: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              bounds: _getInitialBounds(),
              boundsOptions: FitBoundsOptions(padding: EdgeInsets.all(30.0)),
              minZoom: 1.0,
              maxZoom: 18.0,
              plugins: [PopupMarkerPlugin(), TappablePolylineMapPlugin()],
              onTap: (_) => _popupLayerController.hidePopup(),
              onLongPress: widget.isEditable ? (LatLng coordinate) {
                setState(() {
                  var newPoint = _persistanceAdapter.addMapPoint(coordinate);

                  if (_isPolylineDrawing) {
                    _persistanceAdapter.addMapPointIntoPolyline(newPoint, widget.polylines.last);
                  }
                });
              } : null
            ),
            layers: layers,
          ),
          Positioned(
            top: 15.0,
            right: 15.0,
            child: Column(
              children: _buildLayerButtons()
            )
          ),

          widget.isEditable ? Positioned(
            top: 15.0,
            left: 15.0,
            child: Column(
              children: _buildEditButtons()
            )
          ) : Container(),

          Positioned(
            bottom: 5.0,
            left: 5.0,
            child: InkWell(
              child: Opacity(
                child: Container(
                  color: COLOR_MAP_LICENSETEXT_BACKGROUND,
                  child: Text(
                    i18n(context, _currentLayer == _LayerType.OPENSTREETMAP_MAPNIK ? OSM_TEXT : MAPBOX_SATELLITE_TEXT),
                    style: TextStyle(
                      color: COLOR_MAP_LICENSETEXT,
                      fontSize: defaultFontSize() - 4,
                      decoration: TextDecoration.underline
                    )
                  )
                ),
                opacity: 0.7,
              ),
              onTap: () {
                launch(i18n(context, _currentLayer == _LayerType.OPENSTREETMAP_MAPNIK ? OSM_URL : MAPBOX_SATELLITE_URL));
              },
            ),
          )
        ],
      )
    );
  }

  List<LayerOptions> _buildLinesAndMarkersLayers() {
    var layers = <LayerOptions>[];

    // build accuracy circle for user position
    if (
         _locationSubscription != null && !_locationSubscription.isPaused
      && _currentAccuracy != null && _currentPosition != null
    ) {
      layers.add(
        CircleLayerOptions(
          circles: [
            CircleMarker(
              point: _currentPosition,
              borderStrokeWidth: 1,
              useRadiusInMeter: true,
              radius: _currentAccuracy,
              color: Colors.white.withOpacity(0.0), // hack for: without color
              borderColor: COLOR_MAP_USERPOSITION,
            )
          ]
        )
      );
    }

    List<Marker> _markers = _buildMarkers();

    List<Polyline> _polylines = _addPolylines();
    List<Polyline> _circlePolylines = _addCircles();
    _polylines.addAll(_circlePolylines);

    layers.addAll([
      TappablePolylineLayerOptions(
        polylineCulling: true,
        polylines: _polylines,
        onTap: (polyline) => _showPolylineDialog(polyline),
        onMiss: () {} //Bug in framework: https://github.com/OwnWeb/flutter_map_tappable_polyline/issues/20
      ),
      MarkerLayerOptions(
        markers: _markers
      ),
      PopupMarkerLayerOptions(
        markers: _markers,
        popupSnap: PopupSnap.top,
        popupController: _popupLayerController,
        popupBuilder: (BuildContext _, Marker marker) => _buildPopup(marker)
      ),
    ]);

    return layers;
  }

  _showPolylineDialog(_GCWTappablePolyline polyline) {
    if (polyline == null)
      return;

    var text;
    var copyableText;
    var child = polyline.child;
    if (child is GCWMapPolyline) {
      copyableText = child.length.toString();
      text = i18n(context, 'unitconverter_category_length') + ': ${_formatLengthOutput(child.length)}';
    } else if (child is GCWMapCircle) {
      copyableText = child.radius.toString();
      text = i18n(context, 'common_radius') + ': ${_formatLengthOutput(child.radius)}';
    }

    var dialogButtons = <GCWDialogButton>[];
    if (widget.isEditable) {
      dialogButtons.addAll([
        GCWDialogButton(
          text: 'Edit',
          onPressed: () {
            if (child is GCWMapPolyline) {
              Navigator.push(context, NoAnimationMaterialPageRoute(
                builder: (context) => GCWTool(
                  tool: MapPolylineEditor(polyline: child),
                  toolName: i18n(context, 'coords_openmap_lineeditor')
                )
              ))
              .whenComplete(() {
                setState(() {
                  if (child is GCWMapPolyline) {
                    _persistanceAdapter.updateMapPolyline(child);
                  }
                });
              });
            } else if (child is GCWMapCircle) {
              var mapPoint = widget.points.firstWhere((element) => element.circle == child);
              Navigator.push(context, NoAnimationMaterialPageRoute(
                builder: (context) => GCWTool(
                  tool: MapPointEditor(mapPoint: mapPoint, lengthUnit: defaultLengthUnit),
                  toolName: i18n(context, 'coords_openmap_lineeditor')
                )
              ))
              .whenComplete(() {
                setState(() {
                  _persistanceAdapter.updateMapPoint(mapPoint);
                  _mapController.move(mapPoint.point, _mapController.zoom);
                });
              });
            }
          }
        ),
        GCWDialogButton(
          text: i18n(context, 'coords_openmap_lineremove_button'),
          onPressed: () {
            if (child is GCWMapPolyline) {
              showGCWDialog(
                context,
                i18n(context, 'coords_openmap_lineremove_dialog_title'),
                Container(
                  width: 250,
                  height: 100,
                  child: GCWText(
                    text: i18n(context, 'coords_openmap_lineremove_dialog_text'),
                    style: gcwDialogTextStyle()
                  ),
                ),
                [
                  GCWDialogButton(
                    text: i18n(context, 'coords_openmap_lineremove_dialog_keeppoints'),
                    onPressed: () {
                      setState(() {
                        _persistanceAdapter.removeMapPolyline(child);
                      });
                    }
                  ),
                  GCWDialogButton(
                    text: i18n(context, 'coords_openmap_lineremove_dialog_removepoints'),
                    onPressed: () {
                      setState(() {
                        _persistanceAdapter.removeMapPolyline(child, removePoints: true);
                      });
                    }
                  ),
                ]
              );
            } else if (child is GCWMapCircle) {
              setState(() {
                var mapPoint = widget.points.firstWhere((element) => element.circle == child);
                mapPoint.circle = null;
                _persistanceAdapter.updateMapPoint(mapPoint);
              });
            }
          }
        ),
      ]);
    }

    showGCWDialog(context, '',
      Container(
        width: 250,
        height: defaultFontSize() * 2,
        child: GCWOutputText(
          text: text,
          style: gcwDialogTextStyle(),
          copyText: copyableText,
        ) ,
      ),
      dialogButtons,
      closeOnOutsideTouch: true
    );
  }

  _buildMarkers() {
    var points = List<GCWMapPoint>.from(widget.points.where((point) => point.isVisible));

    // Add User Position
    if (
         _locationSubscription != null && !_locationSubscription.isPaused
      && _currentPosition != null
    ) {
      points.add(GCWMapPoint(
        point: _currentPosition,
        markerText: i18n(context, 'common_userposition'),
        color: COLOR_MAP_USERPOSITION,
        coordinateFormat: defaultCoordFormat()
      ));
    }

    return points.map((_point) {
      var icon = Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.my_location,
            size: 28.3,
            color: COLOR_MAP_POINT_OUTLINE,
          ),
          Icon(
            Icons.my_location,
            size: 25.0,
            color: _point.color,
          )
        ],
      );

      var marker = _point.isEditable ? _createDragableIcon(_point, icon) : icon;

      return _GCWMarker(
        coordinateDescription: _buildPopupCoordinateDescription(_point),
        coordinateText: _buildPopupCoordinateText(_point),
        width: 28.3,
        height: 28.3,
        mapPoint: _point,
        builder: (context) => marker
      );
    }).toList();
  }

  _createDragableIcon(GCWMapPoint point, Widget icon) {
    return GestureDetector(
      onPanUpdate: (details) {
        _popupLayerController.hidePopup();

        CustomPoint position = Epsg3857().latLngToPoint(point.point, _mapController.zoom);
        Offset delta = details.delta;
        LatLng pointToLatLng = Epsg3857().pointToLatLng(position + CustomPoint(delta.dx, delta.dy), _mapController.zoom);

        point.point = pointToLatLng;

        setState(() {
          _persistanceAdapter.updateMapPoint(point);
        });
      },
      child: icon,
    );
  }

  _createIconButtonIcons(IconData iconData, {IconData stacked, Color color}) {
    var icon = Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          iconData,
          size: 30.0,
          color: COLOR_MAP_POINT_OUTLINE,
        ),
        Icon(
          iconData,
          size: 25.0,
          color: color ?? COLOR_MAP_POINT,
        )
      ],
    );

    if (stacked == null)
      return icon;

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        icon,
        Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.circle,
              size: 17.0,
              color: COLOR_MAP_POINT_OUTLINE,
            ),
            Icon(
              stacked,
              size: 14.0,
              color: COLOR_MAP_POINT,
            )
          ],
        ),
      ],
    );
  }

  _buildEditButtons() {
    var buttons = [
      GCWCoordsPasteButton(
        backgroundColor: COLOR_MAP_ICONBUTTONS,
        customIcon: _createIconButtonIcons(Icons.content_paste),
        onPasted: (pastedCoordinate) {
          if (pastedCoordinate == null)
            return;

          setState(() {
            _persistanceAdapter.addMapPoint(pastedCoordinate['coordinate'], coordinateFormat: {'format': pastedCoordinate['format']});
            _mapController.move(pastedCoordinate['coordinate'], _mapController.zoom);
          });
        },
      ),
      GCWIconButton(
        backgroundColor: COLOR_MAP_ICONBUTTONS,
        customIcon: _createIconButtonIcons(Icons.my_location, stacked: Icons.add),
        onPressed: () {
          setState(() {
            _persistanceAdapter.addMapPoint(_mapController.center);
          });
        },
      ),
      GCWIconButton(
        backgroundColor: _isPolylineDrawing ? COLOR_MAP_DRAWLINE_ICONBUTTON : COLOR_MAP_ICONBUTTONS,
        customIcon: _isPolylineDrawing
          ? _createIconButtonIcons(Icons.timeline, stacked: Icons.priority_high)
          : _createIconButtonIcons(Icons.timeline, stacked: Icons.add),
        onPressed: () {
          setState(() {
            if (_isPolylineDrawing) {
              _isPolylineDrawing = false;
            } else {
              _isPolylineDrawing = true;
              _persistanceAdapter.createMapPolyline();
            }
          });
        },
      ),
      Container(
        padding: EdgeInsets.only(top: _BUTTONGROUP_MARGIN),
        child: GCWIconButton(
          backgroundColor: COLOR_MAP_ICONBUTTONS,
          customIcon: _createIconButtonIcons(Icons.delete),
          onPressed: () {
            showGCWDialog(
              context,
              i18n(context, 'coords_openmap_removeeverything_title'),
              Container(
                width: 250,
                height: 100,
                child: GCWText(
                  text: i18n(context, 'coords_openmap_removeeverything_text'),
                  style: gcwDialogTextStyle(),
                ),
              ),
              [
                GCWDialogButton(
                  text: i18n(context, 'common_ok'),
                  onPressed: () {
                    setState(() {
                      _persistanceAdapter.clearMapView();
                    });
                  }
                ),
              ]
            );
          },
        )
      ),
      GCWIconButton(
        backgroundColor: COLOR_MAP_ICONBUTTONS,
        customIcon: _createIconButtonIcons(Icons.save),
        onPressed: () {
          showCoordinatesExportDialog(context, widget.points, widget.polylines);
        },
      ),
    ];

    return buttons;
  }

  _buildLayerButtons() {
    var buttons = [
      GCWIconButton(
        backgroundColor: COLOR_MAP_ICONBUTTONS,
        customIcon: _createIconButtonIcons(Icons.layers),
        onPressed: () {
          _currentLayer = _currentLayer == _LayerType.OPENSTREETMAP_MAPNIK ? _LayerType.MAPBOX_SATELLITE : _LayerType.OPENSTREETMAP_MAPNIK;

          if (_currentLayer == _LayerType.MAPBOX_SATELLITE && (_mapBoxToken == null || _mapBoxToken == '')) {
            _loadToken('mapbox').then((token) {
              setState(() {
                _mapBoxToken = token;
              });
            });
          } else {
            setState(() {});
          }
        }
      ),
    ];

    if (
         _currentLocationPermissionGranted != null && _currentLocationPermissionGranted
      && _locationSubscription != null
    ) {
      buttons.add(
        GCWIconButton(
          backgroundColor: COLOR_MAP_ICONBUTTONS,
          customIcon: _createIconButtonIcons(_locationSubscription.isPaused ? Icons.location_off : Icons.location_on),
          onPressed: () {
            _toggleLocationListening();
            if (!_locationSubscription.isPaused)
              _manuallyToggledPosition = true;
          }
        )
      );
    }

    return buttons;
  }

  // handle mouse wheel on web
  void handleSignal(e) {
    if (e is PointerScrollEvent) {
      var delta = e.scrollDelta.direction;
      _mapController.move(_mapController.center, _mapController.zoom + (delta > 0 ? -0.2 : 0.2));
    }
  }

  _buildPopupCoordinateText(GCWMapPoint point) {
    var coordinateFormat = defaultCoordFormat();
    if (point.coordinateFormat != null)
      coordinateFormat = point.coordinateFormat;

    return formatCoordOutput(point.point, coordinateFormat, getEllipsoidByName(ELLIPSOID_NAME_WGS84));
  }

  _buildPopupCoordinateDescription(GCWMapPoint point) {
    if (point.markerText == null || point.markerText.length == 0)
      return null;

    return point.markerText;
  }

  _buildPopup(Marker marker) {

    ThemeColors colors = themeColors();
    _GCWMarker gcwMarker = marker as _GCWMarker;

    var containerHeightMultiplier = 7;
    if (gcwMarker.mapPoint.hasCircle())
      containerHeightMultiplier += 3;
    if (gcwMarker.mapPoint.isEditable)
      containerHeightMultiplier += 2;
    if (gcwMarker.coordinateDescription != null && gcwMarker.coordinateDescription.length > 0)
      containerHeightMultiplier += 2;

    return Container(
      width: 250,
      height: defaultFontSize() * containerHeightMultiplier,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(
        bottom: 5
      ),
      decoration: ShapeDecoration(
        color: colors.dialog(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(roundedBorderRadius),
          side:  BorderSide(
            width: 1,
            color: colors.dialogText(),
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          gcwMarker.coordinateDescription == null ? Container()
            : Container(
                child: GCWText(
                  text: gcwMarker.coordinateDescription,
                  style: gcwDialogTextStyle().copyWith(
                    fontWeight: FontWeight.bold
                  )
                ),
                padding: EdgeInsets.only(
                  bottom: 10
                ),
              ),
          GCWOutputText(
            text: gcwMarker.coordinateText,
            style: gcwDialogTextStyle()
          ),
          gcwMarker.mapPoint.hasCircle()
            ? GCWOutputText(
                text: i18n(context, 'common_radius') + ': ' + _formatLengthOutput(gcwMarker.mapPoint.circle.radius),
                style: gcwDialogTextStyle(),
                copyText: gcwMarker.mapPoint.circle.radius.toString(),
              )
            : Container(),
          gcwMarker.mapPoint.isEditable
            ? Row(
                children: [
                  _isPolylineDrawing
                    ? GCWDialogButton(
                        text: i18n(context, 'coords_openmap_linetohere'),
                        suppressClose: true,
                        onPressed: () {
                          setState(() {
                            var polyline = widget.polylines.last;
                            _persistanceAdapter.addMapPointIntoPolyline(gcwMarker.mapPoint, polyline);

                            _popupLayerController.hidePopup();
                          });
                        }
                      )
                    : GCWDialogButton(
                        text: i18n(context, 'coords_openmap_linefromhere'),
                        suppressClose: true,
                        onPressed: () {
                          setState(() {
                            _isPolylineDrawing = true;

                            var newPolyline = _persistanceAdapter.createMapPolyline();
                            _persistanceAdapter.addMapPointIntoPolyline(gcwMarker.mapPoint, newPolyline);

                            _popupLayerController.hidePopup();
                          });
                        }
                      ),
                  GCWIconButton(
                    iconData: Icons.edit,
                    iconColor: colors.dialogText(),
                    onPressed: () {
                      Navigator.push(context, NoAnimationMaterialPageRoute(
                        builder: (context) => GCWTool(
                          tool: MapPointEditor(mapPoint: gcwMarker.mapPoint, lengthUnit: defaultLengthUnit),
                          toolName: i18n(context, 'coords_openmap_pointeditor')
                          )
                      ))
                      .whenComplete(() {
                        setState(() {
                          _persistanceAdapter.updateMapPoint(gcwMarker.mapPoint);
                          _mapController.move(gcwMarker.mapPoint.point, _mapController.zoom);
                          _popupLayerController.hidePopup();
                        });
                      });
                    }
                  ),
                  GCWIconButton(
                    iconData: Icons.delete,
                    iconColor: colors.dialogText(),
                    onPressed: () {
                      setState(() {
                        _persistanceAdapter.removeMapPoint(gcwMarker.mapPoint);
                        _popupLayerController.hidePopup();
                      });
                    },
                  )
                ]
              )
            : Container()
        ],
      )
    );
  }

  List<Polyline> _addPolylines() {
    List<Polyline> _polylines = widget.polylines.map((polyline) {
      return _GCWTappablePolyline(
        points: polyline.shape,
        strokeWidth: _POLYGON_STROKEWIDTH,
        color: polyline.color,
        child: polyline
      );
    }).toList();

    return _polylines;
  }

  List<Polyline> _addCircles() {
    List<Polyline> _polylines = widget.points
      .where((point) => point.circle != null && point.circle.shape != null)
      .map((point) {
        return _GCWTappablePolyline(
          points: point.circle.shape,
          strokeWidth: _POLYGON_STROKEWIDTH,
          color: point.circle.color,
          child: point.circle
        );
      }).toList();

    return _polylines;
  }
}

class _GCWMarker extends Marker {
  final String coordinateText;
  final String coordinateDescription;
  final GCWMapPoint mapPoint;

  _GCWMarker({
    this.coordinateText,
    this.coordinateDescription,
    this.mapPoint,
    WidgetBuilder builder,
    double width,
    double height,
  }) : super(point: mapPoint.point, builder: builder, width: width, height: height);
}

class _GCWTappablePolyline extends TaggedPolyline {
  dynamic child;

  _GCWTappablePolyline({
    points,
    strokeWidth,
    color,
    this.child
  }) : super(
    points: points,
    strokeWidth: strokeWidth,
    color: color,
  );
}

class _GCWMapPopupController extends PopupController {
  MapController mapController;

  @override
  void togglePopup(Marker marker) {
    if (mapController != null)
    mapController.move(marker.point, mapController.zoom);
    super.togglePopup(marker);
  }
}