import 'package:location/location.dart';

Future<bool> locationServiceEnabled(Location location) async {
  bool _serviceEnabled;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
  }

  return _serviceEnabled;
}

Future<bool> locationPermissionGranted(Location location) async {
  PermissionStatus _permissionGranted;

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
  }

  return _permissionGranted == PermissionStatus.granted;
}

Future<LocationData> getLocation(Location location, {bool silent: false}) async {
  if (!await locationServiceEnabled(location)) {
    if (silent)
      return null;
    else
      throw Exception('Service not enabled');
  }

  if (!await locationPermissionGranted(location)) {
    if (silent)
      return null;
    else
      throw Exception('Permission not granted');
  }

  var currentLocation;
  try {
    currentLocation = await location.getLocation();
  } catch (e) {
    if (silent)
      return null;
    else
      throw Exception('Location not found');
  }

  return currentLocation;
}