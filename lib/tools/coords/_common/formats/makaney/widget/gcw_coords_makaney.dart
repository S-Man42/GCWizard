part of 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords.dart';

class _GCWCoordsMakaney extends StatefulWidget {
  final void Function(MakaneyCoordinate?) onChanged;
  final MakaneyCoordinate coordinates;
  final bool initialize;

  const _GCWCoordsMakaney({Key? key, required this.onChanged, required this.coordinates, this.initialize = false})
      : super(key: key);

  @override
  _GCWCoordsMakaneyState createState() => _GCWCoordsMakaneyState();
}

class _GCWCoordsMakaneyState extends State<_GCWCoordsMakaney> {
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
      var makaney = widget.coordinates;
      _currentCoord = makaney.toString();

      _controller.text = _currentCoord;
    }

    return Column(children: <Widget>[
      GCWTextField(
          hintText: i18n(context, 'coords_formatconverter_makaney_locator'),
          controller: _controller,
          inputFormatters: [_MakaneyTextInputFormatter()],
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
      widget.onChanged(MakaneyCoordinate.parse(_currentCoord));
    } catch (e) {}
  }
}
