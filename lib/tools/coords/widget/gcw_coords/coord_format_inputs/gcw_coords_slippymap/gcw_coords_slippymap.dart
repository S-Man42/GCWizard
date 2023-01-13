import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_double_textfield.dart';
import 'package:gc_wizard/tools/coords/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/utils/default_getter.dart';

class GCWCoordsSlippyMap extends StatefulWidget {
  final Function onChanged;
  final BaseCoordinates coordinates;
  final double zoom;

  const GCWCoordsSlippyMap({Key key, this.onChanged, this.coordinates, this.zoom: DefaultSlippyZoom}) : super(key: key);

  @override
  GCWCoordsSlippyMapState createState() => GCWCoordsSlippyMapState();
}

class GCWCoordsSlippyMapState extends State<GCWCoordsSlippyMap> {
  TextEditingController _xController;
  TextEditingController _yController;

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
    if (widget.coordinates != null) {
      var slippyMap = widget.coordinates is SlippyMap
          ? widget.coordinates as SlippyMap
          : SlippyMap.fromLatLon(widget.coordinates.toLatLng(), widget.zoom);
      _currentX['value'] = slippyMap.x;
      _currentY['value'] = slippyMap.y;

      _xController.text = _currentX['value'].toString();
      _yController.text = _currentY['value'].toString();
    } else if (_subtypeChanged()) {
      _currentZoom = widget.zoom;
      WidgetsBinding.instance.addPostFrameCallback((_) => _setCurrentValueAndEmitOnChange());
    }

    return Column(children: <Widget>[
      GCWDoubleTextField(
          hintText: 'X',
          min: 0.0,
          controller: _xController,
          onChanged: (ret) {
            setState(() {
              _currentX = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
      GCWDoubleTextField(
          hintText: 'Y',
          min: 0.0,
          controller: _yController,
          onChanged: (ret) {
            setState(() {
              _currentY = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
    ]);
  }

  bool _subtypeChanged() {
    return _currentZoom != widget.zoom;
  }

  _setCurrentValueAndEmitOnChange() {
    widget.onChanged(SlippyMap(_currentX['value'], _currentY['value'], double.tryParse(_currentZoom)));
  }
}
