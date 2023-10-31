part of 'package:gc_wizard/tools/coords/_common/widget/gcw_coords.dart';

class _GCWCoordsGeo3x3 extends _GCWCoordWidget {

  _GCWCoordsGeo3x3({super.key, required super.onChanged, required BaseCoordinate coordinates, super.initialize = false}) :
        super(coordinates: coordinates is Geo3x3Coordinate ? coordinates : Geo3x3Coordinate.defaultCoordinate,
          type: CoordinateFormatKey.GEO3X3, i18nKey: geo3x3Key);

  @override
  _GCWCoordsGeo3x3State createState() => _GCWCoordsGeo3x3State();
}

class _GCWCoordsGeo3x3State extends State<_GCWCoordsGeo3x3> {
  late TextEditingController _controller;
  var _currentCoord = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _currentCoord);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialize) {
      var geo3x3 = widget.coordinates as Geo3x3Coordinate;
      _currentCoord = geo3x3.text;

      _controller.text = _currentCoord;
    }

    return Column(children: <Widget>[
      GCWTextField(
          hintText: i18n(context, 'coords_formatconverter_geo3x3_locator'),
          controller: _controller,
          inputFormatters: [_Geo3x3TextInputFormatter()],
          onChanged: (ret) {
            setState(() {
              _currentCoord = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
    ]);
  }

  void _setCurrentValueAndEmitOnChange() {
    try {
      widget.onChanged(Geo3x3Coordinate.parse(_currentCoord));
    } catch (e) {}
  }
}
