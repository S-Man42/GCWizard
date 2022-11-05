import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';

class GCWCoordsReverseWherigoDay1976 extends StatefulWidget {
  final Function onChanged;
  final BaseCoordinates coordinates;

  const GCWCoordsReverseWherigoDay1976({Key key, this.onChanged, this.coordinates}) : super(key: key);

  @override
  GCWCoordsReverseWherigoDay1976State createState() => GCWCoordsReverseWherigoDay1976State();
}

class GCWCoordsReverseWherigoDay1976State extends State<GCWCoordsReverseWherigoDay1976> {
  var _ControllerA;
  var _ControllerB;

  FocusNode _FocusNodeA;
  FocusNode _FocusNodeB;

  var _currentA = "";
  var _currentB = "";

  @override
  void initState() {
    super.initState();
    _ControllerA = TextEditingController(text: _currentA);
    _ControllerB = TextEditingController(text: _currentB);

    _FocusNodeA = FocusNode();
    _FocusNodeB = FocusNode();
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
    if (widget.coordinates != null) {
      var day1976 = widget.coordinates is ReverseWherigoDay1976
          ? widget.coordinates as ReverseWherigoDay1976
          : ReverseWherigoDay1976.fromLatLon(widget.coordinates.toLatLng());
      _currentA = day1976.s;
      _currentB = day1976.t;

      _ControllerA.text = _currentA.toString();
      _ControllerB.text = _currentB.toString();
    }

    return Column(children: <Widget>[
      GCWTextField(
        controller: _ControllerA,
        focusNode: _FocusNodeA,
        onChanged: (value) {
          _currentA = value;

          if (_ControllerA.text.length == 5) FocusScope.of(context).requestFocus(_FocusNodeB);
          _setCurrentValueAndEmitOnChange();
        },
      ),
      GCWTextField(
        controller: _ControllerB,
        focusNode: _FocusNodeB,
        onChanged: (value) {
          _currentB = value;

          if (_ControllerB.text.toString().length == 5) FocusScope.of(context).requestFocus(_FocusNodeA);
          _setCurrentValueAndEmitOnChange();
        },
      ),
    ]);
  }

  _setCurrentValueAndEmitOnChange() {
    widget
        .onChanged(ReverseWherigoDay1976.parse(_currentA.toString().toLowerCase() + '\n' + _currentB.toString().toLowerCase()));
  }
}
