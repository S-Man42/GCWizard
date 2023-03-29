part of 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords.dart';

class _GCWCoordsGC8K7RC extends StatefulWidget {
  final void Function(GC8K7RC?) onChanged;
  final GC8K7RC coordinates;

  const _GCWCoordsGC8K7RC({Key? key, required this.onChanged, required this.coordinates}) : super(key: key);

  @override
  _GCWCoordsGC8K7RCState createState() => _GCWCoordsGC8K7RCState();
}

class _GCWCoordsGC8K7RCState extends State<_GCWCoordsGC8K7RC> {
  late TextEditingController _ControllerVelocity;
  late TextEditingController _ControllerDistance;

  final FocusNode _FocusNodeVelocity = FocusNode();
  final FocusNode _FocusNodeDistance = FocusNode();

  var _currentVelocity = '';
  var _currentDistance = '';

  @override
  void initState() {
    super.initState();
    _ControllerVelocity = TextEditingController(text: _currentVelocity);
    _ControllerDistance = TextEditingController(text: _currentDistance);
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
    var GC8K7RC = widget.coordinates;
    _currentVelocity = GC8K7RC.velocity.toString();
    _currentDistance = GC8K7RC.distance.toString();

    _ControllerVelocity.text = _currentVelocity.toString();
    _ControllerDistance.text = _currentDistance.toString();

    return Column(children: <Widget>[
      GCWDoubleTextField(
        controller: _ControllerVelocity,
        focusNode: _FocusNodeVelocity,
        onChanged: (value) {
          _currentVelocity = value as String;

          FocusScope.of(context).requestFocus(_FocusNodeDistance);
          _setCurrentValueAndEmitOnChange();
        },
      ),
      GCWDoubleTextField(
        controller: _ControllerDistance,
        focusNode: _FocusNodeDistance,
        onChanged: (value) {
          _currentDistance = value as String;

          FocusScope.of(context).requestFocus(_FocusNodeVelocity);
          _setCurrentValueAndEmitOnChange();
        },
      ),
    ]);
  }

  void _setCurrentValueAndEmitOnChange() {
    widget.onChanged(GC8K7RC.parse(_currentVelocity.toString() + '\n' + _currentDistance.toString()));
  }
}
