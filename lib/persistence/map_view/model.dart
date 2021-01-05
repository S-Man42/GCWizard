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
    'points' : points.map((point) => point.toMap()).toList(),
    'polylines' : polylines.map((polyline) => polyline.toMap()).toList(),
  };

  MapViewDAO.fromJson(Map<String, dynamic> json):
    name = json['name'],
    id = json['id'],
    points = List<MapPointDAO>.from(json['points'].map((point) => MapPointDAO.fromJson(point))),
    polylines = List<MapPolylineDAO>.from(json['polylines'].map((polyline) => MapPolylineDAO.fromJson(polyline)));

  @override
  String toString() {
    return toMap().toString();
  }
}

class MapPointDAO {
  final String uuid;
  double latitude;
  double longitude;
  String coordinateFormat;
  String color;
  double radius;
  bool circleColorSameAsColor;
  String circleColor;

  MapPointDAO(
    this.uuid,
    this.latitude,
    this.longitude,
    this.coordinateFormat,
    this.color,
    this.radius,
    this.circleColorSameAsColor,
    this.circleColor
  );

  Map<String, dynamic> toMap() => {
    'uuid': uuid,
    'latitude': latitude,
    'longitude': longitude,
    'coordinateFormat': coordinateFormat,
    'color': color,
    'radius': radius,
    'circleColorSameAsColor': circleColorSameAsColor,
    'circleColor': circleColor
  };

  MapPointDAO.fromJson(Map<String, dynamic> json):
    uuid = json['uuid'],
    latitude = json['latitude'],
    longitude = json['longitude'],
    coordinateFormat = json['coordinateFormat'],
    color = json['color'],
    radius = json['radius'],
    circleColorSameAsColor = json['circleColorSameAsColor'],
    circleColor = json['circleColor'];

  @override
  String toString() {
    return toMap().toString();
  }
}

class MapPolylineDAO {
  String uuid;
  List<String> pointUUIDs;
  String color;

  MapPolylineDAO(
    this.uuid,
    this.pointUUIDs,
    this.color
  );

  Map<String, dynamic> toMap() => {
    'uuid': uuid,
    'pointUUIDs': pointUUIDs,
    'color': color
  };

  MapPolylineDAO.fromJson(Map<String, dynamic> json):
    uuid = json['uuid'],
    pointUUIDs = List<String>.from(json['pointUUIDs']),
    color = json['color'];

  @override
  String toString() {
    return toMap().toString();
  }
}