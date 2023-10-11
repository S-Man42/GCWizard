part of 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords.dart';

class _GCWCoordsMapCode extends StatefulWidget {
  final void Function(MapCode?) onChanged;
  final BaseCoordinate coordinates;
  final bool initialize;

  const _GCWCoordsMapCode({Key? key, required this.onChanged, required this.coordinates, this.initialize = false})
      : super(key: key);

  @override
  _GCWCoordsMapCodeState createState() => _GCWCoordsMapCodeState();
}

class _GCWCoordsMapCodeState extends State<_GCWCoordsMapCode> {
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
      var quadtree = widget.coordinates;
      _currentCoord = quadtree.toString();

      _controller.text = _currentCoord;
    }

    return Column(children: <Widget>[
      GCWTextField(
          controller: _controller,
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
      widget.onChanged(MapCode.parse(_currentCoord));
    } catch (e) {}
  }
}
