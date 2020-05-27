import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/coords/converter/reverse_whereigo_waldmeister.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:latlong/latlong.dart';

class GCWCoordsReverseWhereIGoWaldmeister extends StatefulWidget {
  final Function onChanged;

  const GCWCoordsReverseWhereIGoWaldmeister({Key key, this.onChanged}) : super(key: key);

  @override
  GCWCoordsReverseWhereIGoWaldmeisterState createState() => GCWCoordsReverseWhereIGoWaldmeisterState();
}

class GCWCoordsReverseWhereIGoWaldmeisterState extends State<GCWCoordsReverseWhereIGoWaldmeister> {
  var _currentA = 0;
  var _currentB = 0;
  var _currentC = 0;


  @override
  Widget build(BuildContext context) {
    return Column (
      children: <Widget>[
        GCWIntegerSpinner(
          value: _currentA,
          min: 0,
          max: 999999,
          onChanged: (value) {
            _currentA = value;
            _setCurrentValueAndEmitOnChange();
          },
        ),
        GCWIntegerSpinner(
          value: _currentB,
          min: 0,
          max: 999999,
          onChanged: (value) {
            _currentB = value;
            _setCurrentValueAndEmitOnChange();
          },
        ),
        GCWIntegerSpinner(
          value: _currentC,
          min: 0,
          max: 999999,
          onChanged: (value) {
            _currentC = value;
            _setCurrentValueAndEmitOnChange();
          },
        )
      ]
    );
  }

  _setCurrentValueAndEmitOnChange() {
    LatLng coords = waldmeisterToLatLon(_currentA, _currentB, _currentC);
    widget.onChanged(coords);
  }
}