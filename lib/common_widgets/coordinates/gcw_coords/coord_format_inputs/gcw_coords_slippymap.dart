part of 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords.dart';

class _GCWCoordsSlippyMap extends StatefulWidget {
  final Function(SlippyMap) onChanged;
  final BaseCoordinates? coordinates;
  final double zoom;

  const _GCWCoordsSlippyMap({Key? key, required this.onChanged, this.coordinates, required this.zoom}) : super(key: key);

  @override
  _GCWCoordsSlippyMapState createState() => _GCWCoordsSlippyMapState();
}

class _GCWCoordsSlippyMapState extends State<_GCWCoordsSlippyMap> {
  late TextEditingController _xController;
  late TextEditingController _yController;

  var _currentX = defaultDoubleText;
  var _currentY = defaultDoubleText;

  late double _currentZoom;

  @override
  void initState() {
    super.initState();

    _currentZoom = widget.zoom;

    _xController = TextEditingController(text: _currentX.text);
    _yController = TextEditingController(text: _currentY.text);
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
          : SlippyMap.fromLatLon(widget.coordinates!.toLatLng(), SLIPPY_MAP_ZOOM[widget.zoom] ?? defaultSlippyMapType);
      _currentX.value = slippyMap.x;
      _currentY.value = slippyMap.y;

      _xController.text = _currentX.value.toString();
      _yController.text = _currentY.value.toString();
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
    widget.onChanged(SlippyMap(_currentX.value, _currentY.value, _currentZoom));
  }
}
