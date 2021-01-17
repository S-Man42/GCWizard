import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/coords/converter/xyz.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/common/gcw_double_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_distance.dart';
import 'package:latlong/latlong.dart';

class GCWCoordsXYZ extends StatefulWidget {
  final Function onChanged;

  const GCWCoordsXYZ({Key key, this.onChanged}) : super(key: key);

  @override
  GCWCoordsXYZState createState() => GCWCoordsXYZState();
}

class GCWCoordsXYZState extends State<GCWCoordsXYZ> {
  var _currentX = 0.0;
  var _currentY = 0.0;
  var _currentZ = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column (
        children: <Widget>[
          GCWDistance(
            hintText: 'X',
            onChanged: (value) {
              setState(() {
                _currentX = value;
                _setCurrentValueAndEmitOnChange();
              });
            }
          ),
          GCWDistance(
            hintText: 'Y',
            onChanged: (value) {
              setState(() {
                _currentY = value;
                _setCurrentValueAndEmitOnChange();
              });
            }
          ),
          GCWDistance(
            hintText: 'Z',
            onChanged: (value) {
              setState(() {
                _currentZ = value;
                _setCurrentValueAndEmitOnChange();
              });
            }
          ),
        ]
    );
  }

  _setCurrentValueAndEmitOnChange() {
    var xyz = XYZ(_currentX, _currentY, _currentZ);

    LatLng coords = xyzToLatLon(xyz, defaultEllipsoid());
    widget.onChanged(coords);
  }
}