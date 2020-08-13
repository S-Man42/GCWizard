import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/coords/converter/slippy_map.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/widgets/common/gcw_double_textfield.dart';
import 'package:latlong/latlong.dart';

class GCWCoordsSlippyMap extends StatefulWidget {
  final Function onChanged;
  final String zoom;

  const GCWCoordsSlippyMap({Key key, this.zoom: '10.0', this.onChanged}) : super(key: key);

  @override
  GCWCoordsSlippyMapState createState() => GCWCoordsSlippyMapState();
}

class GCWCoordsSlippyMapState extends State<GCWCoordsSlippyMap> {
  var _xController;
  var _yController;

  var _currentX = {'text': '', 'value': 0.0};
  var _currentY = {'text': '', 'value': 0.0};

  var _currentZoom;

  @override
  void initState() {
    super.initState();

    _currentZoom = widget.zoom;

    _xController = TextEditingController(text: _currentX['text']);
    _yController = TextEditingController(text: _currentY['text']);
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentZoom != widget.zoom) {
      _xController.clear();
      _yController.clear();

      _currentZoom = widget.zoom;
    }

    return Column (
      children: <Widget>[
        GCWDoubleTextField(
          hintText: 'X',
          min: 0.0,
          controller: _xController,
          onChanged: (ret) {
            setState(() {
              _currentX = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }
        ),
        GCWDoubleTextField(
          hintText: 'Y',
          min: 0.0,
          controller: _yController,
          onChanged: (ret) {
            setState(() {
              _currentY = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }
        ),
      ]
    );
  }

  _setCurrentValueAndEmitOnChange() {
    var slippyMap = SlippyMap(_currentX['value'], _currentY['value'], double.tryParse(_currentZoom));
    LatLng coords = slippyMapToLatLon(slippyMap);

    widget.onChanged(coords);
  }
}