import 'package:gc_wizard/utils/data_type_utils/object_type_utils.dart';
import 'package:gc_wizard/utils/json_utils.dart';

List<MapViewDAO> mapViews = [];

class MapViewDAO {
  int? id;
  String? name;
  List<MapPointDAO> points = [];
  List<MapPolylineDAO> polylines = [];

  MapViewDAO(this.points, this.polylines);

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'points': points.map((point) => point.toMap()).toList(),
        'polylines': polylines.map((polyline) => polyline.toMap()).toList(),
      };

  MapViewDAO.fromJson(Map<String, Object?> json) {
    this.name = toStringOrNull(json['name']);
    this.id = toIntOrNull(json['id']);

    var pointsRaw = toObjectWithNullableContentListOrNull(json['points']);
    if (pointsRaw != null) {
      this.points = <MapPointDAO>[];
      pointsRaw.forEach((element) {
        var point = asJsonMapOrNull(element);
        if (point == null) return;

        this.points.add(MapPointDAO.fromJson(point));
      });
    }

    var polylinesRaw = toObjectWithNullableContentListOrNull(json['polylines']);
    if (polylinesRaw != null) {
      this.polylines = <MapPolylineDAO>[];
      polylinesRaw.forEach((element) {
        var polyline = asJsonMapOrNull(element);
        if (polyline == null) return;

        this.polylines.add(MapPolylineDAO.fromJson(polyline));
      });
    }
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

class MapPointDAO {
  final String uuid;
  String name;
  double latitude;
  double longitude;
  String coordinateFormat;
  bool isVisible;
  String color;
  double? radius;
  bool circleColorSameAsColor;
  String? circleColor;

  MapPointDAO(this.uuid, this.name, this.latitude, this.longitude, this.coordinateFormat, this.isVisible, this.color,
      this.radius, this.circleColorSameAsColor, this.circleColor);

  Map<String, dynamic> toMap() => {
        'uuid': uuid,
        'name': name,
        'latitude': latitude,
        'longitude': longitude,
        'coordinateFormat': coordinateFormat,
        'isVisible': isVisible ?? true,
        'color': color,
        'radius': radius,
        'circleColorSameAsColor': circleColorSameAsColor,
        'circleColor': circleColor,
      };

  MapPointDAO.fromJson(Map<String, Object?> json)
      : uuid = toStringOrNull(json['uuid']),
        name = toStringOrNull(json['name']),
        latitude = toDoubleOrNull(json['latitude']),
        longitude = toDoubleOrNull(json['longitude']),
        coordinateFormat = toStringOrNull(json['coordinateFormat']),
        isVisible = toBoolOrNull(json['isVisible']) ?? true,
        color = toStringOrNull(json['color']),
        radius = toDoubleOrNull(json['radius']),
        circleColorSameAsColor = toBoolOrNull(json['circleColorSameAsColor']),
        circleColor = toStringOrNull(json['circleColor']);

  @override
  String toString() {
    return toMap().toString();
  }
}

class MapPolylineDAO {
  String uuid;
  List<String> pointUUIDs;
  String color;

  MapPolylineDAO(this.uuid, this.pointUUIDs, this.color);

  Map<String, dynamic> toMap() => {'uuid': uuid, 'pointUUIDs': pointUUIDs, 'color': color};

  MapPolylineDAO.fromJson(Map<String, dynamic> json)
      : uuid = toStringOrNull(json['uuid']),
        pointUUIDs = List<String>.from(toStringListOrNull(json['pointUUIDs'])),
        color = toStringOrNull(json['color']);

  @override
  String toString() {
    return toMap().toString();
  }
}
