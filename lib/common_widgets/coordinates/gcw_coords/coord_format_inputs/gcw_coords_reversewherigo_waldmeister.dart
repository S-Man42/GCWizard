part of 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords.dart';

class _GCWCoordsReverseWherigoWaldmeister extends StatefulWidget {
  final void Function(ReverseWherigoWaldmeister) onChanged;
  final BaseCoordinates coordinates;

  const _GCWCoordsReverseWherigoWaldmeister({Key? key, required this.onChanged, required this.coordinates}) : super(key: key);

  @override
  _GCWCoordsReverseWherigoWaldmeisterState createState() => _GCWCoordsReverseWherigoWaldmeisterState();
}

class _GCWCoordsReverseWherigoWaldmeisterState extends State<_GCWCoordsReverseWherigoWaldmeister> {
  late TextEditingController _ControllerA;
  late TextEditingController _ControllerB;
  late TextEditingController _ControllerC;

  var _FocusNodeA = FocusNode();
  var _FocusNodeB = FocusNode();
  var _FocusNodeC = FocusNode();

  var _currentA = 0;
  var _currentB = 0;
  var _currentC = 0;

  var _integerInputFormatter = GCWIntegerTextInputFormatter(min: 0, max: 999999);

  @override
  void initState() {
    super.initState();
    _ControllerA = TextEditingController(text: _currentA.toString());
    _ControllerB = TextEditingController(text: _currentB.toString());
    _ControllerC = TextEditingController(text: _currentC.toString());
  }

  @override
  void dispose() {
    _ControllerA.dispose();
    _ControllerB.dispose();
    _ControllerC.dispose();

    _FocusNodeA.dispose();
    _FocusNodeB.dispose();
    _FocusNodeC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.coordinates != null) {
      var waldmeister = widget.coordinates is ReverseWherigoWaldmeister
          ? widget.coordinates as ReverseWherigoWaldmeister
          : ReverseWherigoWaldmeister.fromLatLon(widget.coordinates.toLatLng());
      _currentA = extractIntegerFromText(waldmeister.a);
      _currentB = extractIntegerFromText(waldmeister.b);
      _currentC = extractIntegerFromText(waldmeister.c);

      _ControllerA.text = waldmeister.a;
      _ControllerB.text = waldmeister.b;
      _ControllerC.text = waldmeister.c;
    }

    return Column(children: <Widget>[
      GCWTextField(
        controller: _ControllerA,
        focusNode: _FocusNodeA,
        inputFormatters: [_integerInputFormatter],
        onChanged: (String value) {
          _currentA = extractIntegerFromText(value);

          if (_ControllerA.text.length == 6) FocusScope.of(context).requestFocus(_FocusNodeB);
          _setCurrentValueAndEmitOnChange();
        },
      ),
      GCWTextField(
        controller: _ControllerB,
        focusNode: _FocusNodeB,
        inputFormatters: [_integerInputFormatter],
        onChanged: (String value) {
          _currentB = extractIntegerFromText(value);

          if (_ControllerB.text.toString().length == 6) FocusScope.of(context).requestFocus(_FocusNodeC);
          _setCurrentValueAndEmitOnChange();
        },
      ),
      GCWTextField(
        controller: _ControllerC,
        focusNode: _FocusNodeC,
        inputFormatters: [_integerInputFormatter],
        onChanged: (String value) {
          _currentC = extractIntegerFromText(value);
          _setCurrentValueAndEmitOnChange();
        },
      )
    ]);
  }

  _setCurrentValueAndEmitOnChange() {
    widget.onChanged(ReverseWherigoWaldmeister.parse(
        _currentA.toString() + '\n' + _currentB.toString() + '\n' + _currentC.toString()));
  }
}
