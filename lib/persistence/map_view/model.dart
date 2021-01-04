List<MapView> mapViews = [];

class MapView {
  int id;
  String name;
  List<MapPoint> points = [];
  List<MapPolyline> polylines = [];

  MapView(this.points, this.polylines);

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'points' : points.map((point) => point.toMap()).toList(),
    'polylines' : polylines.map((polyline) => polyline.toMap()).toList(),
  };

  MapView.fromJson(Map<String, dynamic> json):
    name = json['name'],
    id = json['id'],
    points = List<MapPoint>.from(json['points'].map((point) => MapPoint.fromJson(point))),
    polylines = List<MapPolyline>.from(json['polylines'].map((polyline) => MapPolyline.fromJson(polyline)));

  @override
  String toString() {
    return toMap().toString();
  }
}

class MapPoint {
  final String uuid;
  final double latitude;
  final double longitude;
  final String coordinateFormat;
  final String color;
  final double radius;
  final bool circleColorSameAsColor;
  final String circleColor;

  MapPoint(
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

  MapPoint.fromJson(Map<String, dynamic> json):
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

class MapPolyline {
  int id;
  final List<int> pointIds;
  final String color;

  MapPolyline(
    this.pointIds,
    this.color
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'pointIds': pointIds,
    'color': color
  };

  MapPolyline.fromJson(Map<String, dynamic> json):
    id = json['id'],
    pointIds = json['pointIds'],
    color = json['color'];

  @override
  String toString() {
    return toMap().toString();
  }
}