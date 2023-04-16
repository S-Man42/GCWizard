part of 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords.dart';

class _GCWCoordsGC8K7RC extends StatefulWidget {
  final void Function(GC8K7RC?) onChanged;
  final GC8K7RC coordinates;
  final bool isDefault;

  const _GCWCoordsGC8K7RC({Key? key, required this.onChanged, required this.coordinates, required this.isDefault}) : super(key: key);

  @override
  _GCWCoordsGC8K7RCState createState() => _GCWCoordsGC8K7RCState();
}

class _GCWCoordsGC8K7RCState extends State<_GCWCoordsGC8K7RC> {
  late TextEditingController _ControllerVelocity;
  late TextEditingController _ControllerDistance;

  final FocusNode _FocusNodeVelocity = FocusNode();
  final FocusNode _FocusNodeDistance = FocusNode();

  var _currentVelocity = defaultDoubleText;
  var _currentDistance = defaultDoubleText;

  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _ControllerVelocity = TextEditingController(text: _currentVelocity.text);
    _ControllerDistance = TextEditingController(text: _currentDistance.text);
  }

  @override
  void dispose() {
    _ControllerVelocity.dispose();
    _ControllerDistance.dispose();

    _FocusNodeVelocity.dispose();
    _FocusNodeDistance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isDefault && !_initialized) {
      var gc8K7RC = widget.coordinates;
      _currentVelocity = gc8K7RC.velocity as DoubleText;
      _currentDistance = gc8K7RC.distance as DoubleText;

      _ControllerVelocity.text = _currentVelocity.value.toString();
      _ControllerDistance.text = _currentDistance.value.toString();

      _initialized = true;
    }

    return Column(children: <Widget>[
      GCWDoubleTextField(
        hintText: i18n(context, 'coords_formatconverter_gc8k7rc_velocity'),
        controller: _ControllerVelocity,
        onChanged: (value) {
          _currentVelocity = value;
          _setCurrentValueAndEmitOnChange();
        },
      ),
      GCWDoubleTextField(
        hintText: i18n(context, 'coords_formatconverter_gc8k7rc_distance'),
        controller: _ControllerDistance,
        onChanged: (value) {
          _currentDistance = value;
          _setCurrentValueAndEmitOnChange();
        },
      ),
    ]);
  }

  void _setCurrentValueAndEmitOnChange() {
    var gc8K7RC = GC8K7RC(_currentVelocity.value, _currentDistance.value,);
    widget.onChanged(gc8K7RC);
  }
}
