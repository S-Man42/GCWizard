part of 'package:gc_wizard/tools/coords/_common/widget/gcw_coords.dart';

class _GCWCoordsOpenLocationCode extends _GCWCoordWidget {

  _GCWCoordsOpenLocationCode({super.key, required super.onChanged, required BaseCoordinate coordinates, super.initialize = false}) :
        super(coordinates: coordinates is OpenLocationCodeCoordinate ? coordinates : OpenLocationCodeCoordinate.defaultCoordinate,
          type: CoordinateFormatKey.OPEN_LOCATION_CODE, i18nKey: openLocationCodeKey);

  @override
  _GCWCoordsOpenLocationCodeState createState() => _GCWCoordsOpenLocationCodeState();
}

class _GCWCoordsOpenLocationCodeState extends State<_GCWCoordsOpenLocationCode> {
  late TextEditingController _controller;
  var _currentCoord = '';

  final _maskInputFormatter = GCWMaskTextInputFormatter(
      mask: '**#################',
      filter: {"*": RegExp(r'[23456789CFGHJMPQRVcfghjmpqrv]'), "#": RegExp(r'[23456789CFGHJMPQRVWXcfghjmpqrvwx+]')});

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
      var openLocationCode = widget.coordinates as OpenLocationCodeCoordinate;
      _currentCoord = openLocationCode.text;

      _controller.text = _currentCoord;
    }

    return Column(children: <Widget>[
      GCWTextField(
          controller: _controller,
          inputFormatters: [_maskInputFormatter],
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
      widget.onChanged(OpenLocationCodeCoordinate.parse(_currentCoord));
    } catch (e) {}
  }
}
