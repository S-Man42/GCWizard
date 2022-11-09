import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';

class GCWCoordsReverseWherigoWaldmeister extends StatefulWidget {
  final Function onChanged;
  final BaseCoordinates coordinates;

  const GCWCoordsReverseWherigoWaldmeister({Key key, this.onChanged, this.coordinates}) : super(key: key);

  @override
  GCWCoordsReverseWherigoWaldmeisterState createState() => GCWCoordsReverseWherigoWaldmeisterState();
}

class GCWCoordsReverseWherigoWaldmeisterState extends State<GCWCoordsReverseWherigoWaldmeister> {
  var _ControllerA;
  var _ControllerB;
  var _ControllerC;

  FocusNode _FocusNodeA;
  FocusNode _FocusNodeB;
  FocusNode _FocusNodeC;

  var _currentA = 0;
  var _currentB = 0;
  var _currentC = 0;

  @override
  void initState() {
    super.initState();
    _ControllerA = TextEditingController(text: _currentA.toString().padLeft(6, '0'));
    _ControllerB = TextEditingController(text: _currentB.toString().padLeft(6, '0'));
    _ControllerC = TextEditingController(text: _currentC.toString().padLeft(6, '0'));

    _FocusNodeA = FocusNode();
    _FocusNodeB = FocusNode();
    _FocusNodeC = FocusNode();
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
      _currentA = int.tryParse(waldmeister.a);
      _currentB = int.tryParse(waldmeister.b);
      _currentC = int.tryParse(waldmeister.c);

      _ControllerA.text = _currentA.toString();
      _ControllerB.text = _currentB.toString();
      _ControllerC.text = _currentC.toString();
    }

    return Column(children: <Widget>[
      GCWIntegerSpinner(
        controller: _ControllerA,
        focusNode: _FocusNodeA,
        value: _currentA,
        min: 0,
        max: 999999,
        leftPadZeros: 6,
        onChanged: (value) {
          _currentA = value;

          if (_ControllerA.text.length == 6) FocusScope.of(context).requestFocus(_FocusNodeB);
          _setCurrentValueAndEmitOnChange();
        },
      ),
      GCWIntegerSpinner(
        controller: _ControllerB,
        focusNode: _FocusNodeB,
        value: _currentB,
        min: 0,
        max: 999999,
        leftPadZeros: 6,
        onChanged: (value) {
          _currentB = value;

          if (_ControllerB.text.toString().length == 6) FocusScope.of(context).requestFocus(_FocusNodeC);
          _setCurrentValueAndEmitOnChange();
        },
      ),
      GCWIntegerSpinner(
        controller: _ControllerC,
        focusNode: _FocusNodeC,
        value: _currentC,
        min: 0,
        max: 999999,
        leftPadZeros: 6,
        onChanged: (value) {
          _currentC = value;
          _setCurrentValueAndEmitOnChange();
        },
      )
    ]);
  }

  _setCurrentValueAndEmitOnChange() {
    widget
        .onChanged(ReverseWherigoWaldmeister.parse(_currentA.toString() + '\n' + _currentB.toString() + '\n' + _currentC.toString()));
  }
}
