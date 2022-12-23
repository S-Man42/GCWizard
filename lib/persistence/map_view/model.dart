import 'package:gc_wizard/utils/common_utils.dart';

List<MapViewDAO> mapViews = [];

class MapViewDAO {
  int id;
  String name;
  List<MapPointDAO> points = [];
  List<MapPolylineDAO> polylines = [];

  MapViewDAO(this.points, this.polylines);

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'points': points.map((point) => point.toMap()).toList(),
        'polylines': polylines.map((polyline) => polyline.toMap()).toList(),
      };

  MapViewDAO.fromJson(Map<String, dynamic> json)
      : name = jsonString(json['name']),
        id = jsonInt(json['id']),
        points = List<MapPointDAO>.from(json['points'].map((point) => MapPointDAO.fromJson(point))),
        polylines = List<MapPolylineDAO>.from(json['polylines'].map((polyline) => MapPolylineDAO.fromJson(polyline)));

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
  double radius;
  bool circleColorSameAsColor;
  String circleColor;

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

  MapPointDAO.fromJson(Map<String, dynamic> json)
      : uuid = jsonString(json['uuid']),
        name = jsonString(json['name']),
        latitude = jsonDouble(json['latitude']),
        longitude = jsonDouble(json['longitude']),
        coordinateFormat = jsonString(json['coordinateFormat']),
        isVisible = jsonBool(json['isVisible']) ?? true,
        color = jsonString(json['color']),
        radius = jsonDouble(json['radius']),
        circleColorSameAsColor = jsonBool(json['circleColorSameAsColor']),
        circleColor = jsonString(json['circleColor']);

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
      : uuid = jsonString(json['uuid']),
        pointUUIDs = List<String>.from(jsonStringList(json['pointUUIDs'])),
        color = jsonString(json['color']);

  @override
  String toString() {
    return toMap().toString();
  }
}
