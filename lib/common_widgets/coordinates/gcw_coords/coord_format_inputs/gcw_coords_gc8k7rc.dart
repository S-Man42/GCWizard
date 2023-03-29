part of 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords.dart';

class _GCWCoordsGC8K7RC extends StatefulWidget {
  final void Function(GC8K7RC?) onChanged;
  final GC8K7RC coordinates;

  const _GCWCoordsGC8K7RC({Key? key, required this.onChanged, required this.coordinates}) : super(key: key);

  @override
  _GCWCoordsGC8K7RCState createState() => _GCWCoordsGC8K7RCState();
}

class _GCWCoordsGC8K7RCState extends State<_GCWCoordsGC8K7RC> {
  late TextEditingController _ControllerA;
  late TextEditingController _ControllerB;

  final FocusNode _FocusNodeA = FocusNode();
  final FocusNode _FocusNodeB = FocusNode();

  var _currentA = '';
  var _currentB = '';

  @override
  void initState() {
    super.initState();
    _ControllerA = TextEditingController(text: _currentA);
    _ControllerB = TextEditingController(text: _currentB);
  }

  @override
  void dispose() {
    _ControllerA.dispose();
    _ControllerB.dispose();

    _FocusNodeA.dispose();
    _FocusNodeB.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var GC8K7RC = widget.coordinates;
    _currentA = GC8K7RC.v.toString();
    _currentB = GC8K7RC.d.toString();

    _ControllerA.text = _currentA.toString();
    _ControllerB.text = _currentB.toString();

    return Column(children: <Widget>[
      GCWDoubleTextField(
        controller: _ControllerA,
        focusNode: _FocusNodeA,
        onChanged: (value) {
          _currentA = value as String;

          FocusScope.of(context).requestFocus(_FocusNodeB);
          _setCurrentValueAndEmitOnChange();
        },
      ),
      GCWDoubleTextField(
        controller: _ControllerB,
        focusNode: _FocusNodeB,
        onChanged: (value) {
          _currentB = value as String;

          FocusScope.of(context).requestFocus(_FocusNodeA);
          _setCurrentValueAndEmitOnChange();
        },
      ),
    ]);
  }

  void _setCurrentValueAndEmitOnChange() {
    widget.onChanged(GC8K7RC.parse(_currentA.toString() + '\n' + _currentB.toString()));
  }
}
