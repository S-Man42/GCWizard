import 'dart:async';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/theme/fixed_colors.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/gcw_toolbar.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/mappoint_editor.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/tools/coords/utils/user_location.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';

enum _LayerType {OPENSTREETMAP_MAPNIK, MAPBOX_SATELLITE}

final OSM_TEXT = 'coords_mapview_osm';
final OSM_URL = 'coords_mapview_osm_url';
final MAPBOX_SATELLITE_TEXT = 'coords_mapview_mapbox_satellite';
final MAPBOX_SATELLITE_URL = 'coords_mapview_mapbox_satellite_url';

final _DEFAULT_COORDINATE = LatLng(52.5, 13.4);
final _DEFAULT_ZOOM = 9.0;

class GCWMapView extends StatefulWidget {
  final List<GCWMapPoint> points;
  final List<GCWMapGeodetic> geodetics;
  final List<GCWMapPolyGeodetics> polyGeodetics;
  final List<GCWMapCircle> circles;
  final bool isEditable;

  const GCWMapView({
    Key key,
    this.points: const [],
    this.geodetics: const [],
    this.polyGeodetics: const [],
    this.circles: const [],
    this.isEditable: false
  })
    : super(key: key);

  @override
  GCWMapViewState createState() => GCWMapViewState();
}

class GCWMapViewState extends State<GCWMapView> {
  final PopupController _popupLayerController = PopupController();
  final MapController _mapController = MapControllerImpl();

  _LayerType _currentLayer = _LayerType.OPENSTREETMAP_MAPNIK;
  var _mapBoxToken;

  var _currentLocationPermissionGranted;
  StreamSubscription<LocationData> _locationSubscription;
  Location _location = Location();
  LatLng _currentPosition;
  double _currentAccuracy;

  var _isPolylineDrawing = false;

  //////////////////////////////////////////////////////////////////////////////
  // from: https://stackoverflow.com/a/58958668/3984221
  LatLng computeCentroid(Iterable<LatLng> points) {
    double latitude = 0;
    double longitude = 0;
    int n = points.length;

    for (LatLng point in points) {
      latitude += point.latitude;
      longitude += point.longitude;
    }

    return LatLng(latitude / n, longitude / n);
  }

  //////////////////////////////////////////////////////////////////////////////

  //////////////////////////////////////////////////////////////////////////////
  // from: https://stackoverflow.com/a/13274361/3984221

  double _latRad(_lat) {
    var _sin = sin(_lat * PI / 180);
    var _radX2 = log((1 + _sin) / (1 - _sin)) / 2;
    return max(min(_radX2, PI), -PI) / 2;
  }

  int _zoom(_mapPx, _worldPx, _fraction) {
    return (log(_mapPx / _worldPx / _fraction) / ln2).floor();
  }

  int _getBoundsZoomLevel() {
    var _mapDim = MediaQuery.of(context).size;
    var _worldDim = {'height': 256, 'width': 256};
    var _zoomMax = 18;

    var _bounds = LatLngBounds();
    widget.points.forEach((point) => _bounds.extend(point.point));

    var _ne = _bounds.northEast;
    var _sw = _bounds.southWest;

    var _latFraction = (_latRad(_ne.latitude) - _latRad(_sw.latitude)) / PI;

    var _lngDiff = _ne.longitude - _sw.longitude;
    var _lngFraction = ((_lngDiff < 0) ? (_lngDiff + 360) : _lngDiff) / 360;

    var _latZoom = _zoomMax;
    if (_latFraction > 0.0)
      _latZoom = _zoom(_mapDim.height, _worldDim['height'], _latFraction);

    var _lngZoom = _zoomMax;
    if (_lngFraction > 0.0)
      _lngZoom = _zoom(_mapDim.width, _worldDim['width'], _lngFraction);

    return min(min(_latZoom, _lngZoom), _zoomMax);
  }

  //////////////////////////////////////////////////////////////////////////////

  Future<String> _loadToken(String tokenName) async {
    return await rootBundle.loadString('assets/tokens/$tokenName');
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
        })
        .listen((LocationData currentLocation) {
          setState(() {
            var newPosition = LatLng(currentLocation.latitude, currentLocation.longitude);

            if (_currentPosition == null) {
              _mapController.move(newPosition, _mapController.zoom);
            }

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
              center: widget.points.length > 0
                ? computeCentroid(widget.points.map((_point) => _point.point).toList())
                : _DEFAULT_COORDINATE,
              zoom: widget.points.length > 0
                ? _getBoundsZoomLevel().toDouble()
                : _DEFAULT_ZOOM,
              minZoom: 1.0,
              maxZoom: 18.0,
              plugins: [PopupMarkerPlugin(), TappablePolylineMapPlugin()],
              onTap: (_) => _popupLayerController.hidePopup(),
              onLongPress: widget.isEditable ? (LatLng coordinate) {
                setState(() {
                  var random = Random();
                  widget.points.add(GCWMapPoint(
                    point: coordinate,
                    isEditable: true,
                    color: Color.fromARGB(255, random.nextInt(255), random.nextInt(255), random.nextInt(255)),
                    circle: GCWMapCircle(
                      radius: 16100
                    ),
                    circleColorSameAsPointColor: true
                  ));

                  if (_isPolylineDrawing) {
                    widget.polyGeodetics.last.points.add(widget.points.last);
                    widget.polyGeodetics.last.update();
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

          Positioned(
            top: 15.0,
            left: 15.0,
            child: Column(
              children: _buildEditButtons()
            )
          ),

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
      // PolylineLayerOptions(
      //   polylines: _polylines
      // ),
      TappablePolylineLayerOptions(
        polylineCulling: true,
        polylines: _polylines,
        onTap: (GCWPolyline polyline) => _showPolylineDialog(polyline),
      ),
      MarkerLayerOptions(
        markers: _markers
      ),
      PopupMarkerLayerOptions(
        markers: _markers,
        popupSnap: PopupSnap.top,
        popupController: _popupLayerController,
        popupBuilder: (BuildContext _, Marker marker) => _buildPopups(marker)
      ),
    ]);

    return layers;
  }

  _showPolylineDialog(GCWPolyline polyline) {
    var child = polyline.child;
    if (child is GCWMapGeodetic) {
      print('Geodetic');
    } else if (child is GCWMapPolyGeodetics) {
      print('PolyGeodetic');
    } else if (child is GCWMapCircle) {
      print('Circle');
    }
  }

  _buildMarkers() {
    var points = List<GCWMapPoint>.from(widget.points);

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

      return GCWMarker(
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
        point.update();

        widget.geodetics.forEach((element) {
          if (element.start == point || element.end == point)
            element.update();
        });

        widget.polyGeodetics.forEach((element) {
          if (element.points.contains(point))
            element.update();
        });

        setState(() {});
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
      GCWIconButton(
        customIcon: _createIconButtonIcons(Icons.my_location, stacked: Icons.add),
        onPressed: () {
          setState(() {
            widget.points.add(GCWMapPoint(
              point: _mapController.center,
              isEditable: true,
              circleColorSameAsPointColor: true
            ));
          });
        },
      ),
      GCWIconButton(
        customIcon: _isPolylineDrawing
          ? _createIconButtonIcons(Icons.timeline, color: Colors.red)
          : _createIconButtonIcons(Icons.timeline, stacked: Icons.edit),
        onPressed: () {
          setState(() {
            if (_isPolylineDrawing) {
              _isPolylineDrawing = false;
            } else {
              _isPolylineDrawing = true;
              widget.polyGeodetics.add(
                GCWMapPolyGeodetics(
                  points: []
                )
              );
            }
          });
        },
      )
    ];

    return buttons;
  }

  _buildLayerButtons() {
    var buttons = [
      GCWIconButton(
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
          customIcon: _createIconButtonIcons(_locationSubscription.isPaused ? Icons.location_off : Icons.location_on),
          onPressed: _toggleLocationListening,
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

  _buildPopups(Marker marker) {


    ThemeColors colors = themeColors();
    GCWMarker gcwMarker = marker as GCWMarker;

    return Container(
      width: 250,
      height: defaultFontSize() * (gcwMarker.mapPoint.isEditable ? 12 : 7),
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
                  style: TextStyle(
                    fontFamily: gcwTextStyle().fontFamily,
                    fontSize: defaultFontSize(),
                    color: colors.dialogText(),
                    fontWeight: FontWeight.bold
                  )
                ),
                padding: EdgeInsets.only(
                  bottom: 10
                ),
              ),
          GCWOutputText(
            text: gcwMarker.coordinateText,
            style: TextStyle(
              fontFamily: gcwTextStyle().fontFamily,
              fontSize: defaultFontSize(),
              color: colors.dialogText()
            )
          ),
          gcwMarker.mapPoint.hasCircle()
            ? GCWOutputText(
                text: 'Radius: ${gcwMarker.mapPoint.circle.radius} m',
                style: TextStyle(
                  fontFamily: gcwTextStyle().fontFamily,
                  fontSize: defaultFontSize(),
                  color: colors.dialogText()
                ),
                copyText: gcwMarker.mapPoint.circle.radius.toString() + ' m',
              )
            : Container(),
          gcwMarker.mapPoint.isEditable
            ? GCWToolBar(
                children: [
                  GCWButton(
                      text: 'Edit',
                      onPressed: () {
                        Navigator.push(context, NoAnimationMaterialPageRoute(
                          builder: (context) => GCWTool(
                            tool: MapPointEditor(mapPoint: gcwMarker.mapPoint),
                            toolName: 'Map Point Editor'
                            )
                        ))
                        .whenComplete(() {
                          setState(() {
                            gcwMarker.mapPoint.update();
                            _mapController.move(gcwMarker.mapPoint.point, _mapController.zoom);
                            _popupLayerController.hidePopup();
                          });
                        });
                      }
                  ),
                  GCWButton(
                    text: 'Remove',
                    onPressed: () {
                      setState(() {
                        var tempPolyGeodetics = List<GCWMapPolyGeodetics>.from(widget.polyGeodetics);
                        var removeablePolyGeodetics = [];
                        tempPolyGeodetics.asMap().forEach((tempIndex, element) {
                          var index = widget.polyGeodetics[tempIndex].points.indexOf(gcwMarker.mapPoint);
                          if (index > -1)
                            widget.polyGeodetics[tempIndex].points.remove(gcwMarker.mapPoint);

                          if (widget.polyGeodetics[tempIndex].points.length < 2) {
                            removeablePolyGeodetics.add(widget.polyGeodetics[tempIndex]);
                          } else {
                            widget.polyGeodetics[tempIndex].update();
                          }
                        });
                        removeablePolyGeodetics.forEach((element) {
                          widget.polyGeodetics.remove(element);
                        });

                        var tempGeodetics = List<GCWMapGeodetic>.from(widget.geodetics);
                        var removeableGeodetics = [];
                        tempGeodetics.asMap().forEach((index, element) {
                          if (element.start == gcwMarker.mapPoint || element.end == gcwMarker.mapPoint)
                            removeableGeodetics.add(widget.geodetics[index]);
                        });
                        removeableGeodetics.forEach((element) {
                          widget.geodetics.remove(element);
                        });

                        widget.points.remove(gcwMarker.mapPoint);

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
    List<Polyline> _polylines = widget.geodetics.map((_geodetic) {
      return GCWPolyline(
        points: _geodetic.shape,
        strokeWidth: 3.0,
        color: _geodetic.color,
        child: _geodetic
      );
    }).toList();

    _polylines.addAll(
      widget.polyGeodetics.map((_polyGeodetic) {
        return GCWPolyline(
          points: _polyGeodetic.shape,
          strokeWidth: 3.0,
          color: _polyGeodetic.color,
          child: _polyGeodetic
        );
      }).toList()
    );
    return _polylines;
  }

  List<Polyline> _addCircles() {
    List<Polyline> _polylines =  widget.circles.map((_circle) {
      return GCWPolyline(
        points: _circle.shape,
        strokeWidth: 3.0,
        color: _circle.color,
        child: _circle
      );
    }).toList();

    _polylines.addAll(
      widget.points
        .where((point) => point.circle != null && point.circle.shape != null)
        .map((point) {
          return GCWPolyline(
            points: point.circle.shape,
            strokeWidth: 3.0,
            color: point.circle.color,
            child: point.circle
          );
        }).toList()
    );

    return _polylines;
  }
}

class GCWMarker extends Marker {
  final String coordinateText;
  final String coordinateDescription;
  final GCWMapPoint mapPoint;

  GCWMarker({
    this.coordinateText,
    this.coordinateDescription,
    this.mapPoint,
    WidgetBuilder builder,
    double width,
    double height,
    AnchorPos anchorPos
  }) : super(point: mapPoint.point, builder: builder, width: width, height: height);
}

class GCWPolyline extends TaggedPolyline {
  dynamic child;

  GCWPolyline({
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
