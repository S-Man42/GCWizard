part of 'package:gc_wizard/tools/coords/_common/widget/gcw_coords.dart';

class _GCWCoordsGeo3x3 extends StatefulWidget {
  final void Function(Geo3x3Coordinate?) onChanged;
  final Geo3x3Coordinate coordinates;
  final bool initialize;

  const _GCWCoordsGeo3x3({Key? key, required this.onChanged, required this.coordinates, this.initialize = false})
      : super(key: key);

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
      var geo3x3 = widget.coordinates;
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