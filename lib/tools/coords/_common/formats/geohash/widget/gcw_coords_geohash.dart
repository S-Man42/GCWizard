part of 'package:gc_wizard/tools/coords/_common/widget/gcw_coords.dart';

class _GCWCoordsGeohash extends _GCWCoordWidget {

  _GCWCoordsGeohash({super.key, required super.onChanged, required BaseCoordinate coordinates, super.initialize = false}) :
        super(coordinates: coordinates is GeohashCoordinate ? coordinates : GeohashCoordinate.defaultCoordinate,
          type: CoordinateFormatKey.GEOHASH, i18nKey: geohashKey);

  @override
  _GCWCoordsGeohashState createState() => _GCWCoordsGeohashState();
}

class _GCWCoordsGeohashState extends State<_GCWCoordsGeohash> {
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
      var geohash = widget.coordinates as GeohashCoordinate;
      _currentCoord = geohash.text;

      _controller.text = _currentCoord;
    }

    return Column(children: <Widget>[
      GCWTextField(
          hintText: i18n(context, 'coords_formatconverter_geohash_locator'),
          controller: _controller,
          inputFormatters: [_GeohashTextInputFormatter()],
          onChanged: (ret) {
            setState(() {
              _currentCoord = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
    ]);
  }

  void _setCurrentValueAndEmitOnChange() {
    widget.onChanged(GeohashCoordinate.parse(_currentCoord));
  }
}
