import 'package:latlong/latlong.dart';

LatLng antipodes(LatLng coord) {

  coord.latitude *= -1;
  if (coord.longitude > 0)
    coord.longitude += -180;
  else
    coord.longitude += 180;

  return coord;
}
