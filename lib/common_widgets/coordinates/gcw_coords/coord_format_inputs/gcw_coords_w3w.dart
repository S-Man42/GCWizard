part of 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords.dart';

class _GCWCoordsWhat3Words extends StatefulWidget {
  final void Function(XYZ) onChanged;
  final BaseCoordinate coordinates;
  final bool isDefault;

  const _GCWCoordsWhat3Words({Key? key, required this.onChanged, required this.coordinates, this.isDefault = true}) : super(key: key);

  @override
  _GCWCoordsWhat3WordsState createState() => _GCWCoordsWhat3WordsState();
}

class _GCWCoordsWhat3WordsState extends State<_GCWCoordsWhat3Words> {
  late TextEditingController _ControllerW1;
  late TextEditingController _ControllerW2;
  late TextEditingController _ControllerW3;

  var _currentW1 = 0.0;
  var _currentW2 = 0.0;
  var _currentW3 = 0.0;

  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _ControllerW1 = TextEditingController(text: _currentW1.toString());
    _ControllerW2 = TextEditingController(text: _currentW2.toString());
    _ControllerW3 = TextEditingController(text: _currentW3.toString());
  }

  @override
  void dispose() {
    _ControllerW1.dispose();
    _ControllerW2.dispose();
    _ControllerW3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isDefault && !_initialized) {
      var xyz = widget.coordinates is XYZ
          ? widget.coordinates as XYZ
          : XYZ.fromLatLon(widget.coordinates.toLatLng() ?? defaultCoordinate, defaultEllipsoid);
      _currentW1 = xyz.x;
      _currentW2 = xyz.y;
      _currentW3 = xyz.z;

      _ControllerW1.text = _currentW1.toString();
      _ControllerW2.text = _currentW2.toString();
      _ControllerW3.text = _currentW3.toString();

      _initialized = true;
    }

    return Column(children: <Widget>[
    ]);
  }

  void _setCurrentValueAndEmitOnChange() {
    widget.onChanged(XYZ(_currentW1, _currentW2, _currentW3));
  }
}
