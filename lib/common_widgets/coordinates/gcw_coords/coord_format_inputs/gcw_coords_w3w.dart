part of 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords.dart';

class _GCWCoordsWhat3Words extends StatefulWidget {
  final void Function(What3Words) onChanged;
  final What3Words coordinates;
  final bool isDefault;

  const _GCWCoordsWhat3Words({Key? key, required this.onChanged, required this.coordinates, this.isDefault = true}) : super(key: key);

  @override
  _GCWCoordsWhat3WordsState createState() => _GCWCoordsWhat3WordsState();
}

class _GCWCoordsWhat3WordsState extends State<_GCWCoordsWhat3Words> {
  late TextEditingController _ControllerW1;
  late TextEditingController _ControllerW2;
  late TextEditingController _ControllerW3;

  CoordinateFormatKey _currentSubtype = defaultGaussKruegerType;

  var _currentW1 = '';
  var _currentW2 = '';
  var _currentW3 = '';

  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _ControllerW1 = TextEditingController(text: _currentW1.toString());
    _ControllerW2 = TextEditingController(text: _currentW2.toString());
    _ControllerW3 = TextEditingController(text: _currentW3.toString());
  }

  @override
  void dispose() {
    _ControllerW1.dispose();
    _ControllerW2.dispose();
    _ControllerW3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _currentSubtype = widget.coordinates.format.subtype!;

    if (_subtypeChanged()) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _setCurrentValueAndEmitOnChange());
    } else if (!widget.isDefault && !_initialized) {
      var what3words = widget.coordinates;
      _currentW1 = what3words.word1;
      _currentW2 = what3words.word2;
      _currentW3 = what3words.word3;

      _ControllerW1.text = _currentW1.toString();
      _ControllerW2.text = _currentW2.toString();
      _ControllerW3.text = _currentW3.toString();

      _initialized = true;
    }

    return Column(children: <Widget>[
      GCWTextField(
          hintText: i18n(context, 'coords_formatconverter_w3w_w1'),
          controller: _ControllerW1,
          onChanged: (ret) {
            setState(() {
              _currentW1 = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }
      ),
      GCWTextField(
          hintText: i18n(context, 'coords_formatconverter_w3w_w1'),
          controller: _ControllerW2,
          onChanged: (ret) {
            setState(() {
              _currentW2 = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }
      ),
      GCWTextField(
          hintText: i18n(context, 'coords_formatconverter_w3w_w1'),
          controller: _ControllerW3,
          onChanged: (ret) {
            setState(() {
              _currentW3 = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }
      ),
      (_APIKeymissing())
          ? GCWOutput(
          title: i18n(context, 'coords_formatconverter_w3w_error'),
          child: i18n(context, 'coords_formatconverter_w3w_no_apikey'),
          suppressCopyButton: true)
          : Container()
    ]);
  }

  bool _APIKeymissing(){
    String APIKey = Prefs.getString('coord_default_w3w_apikey');
    return (APIKey == '');
  }

  bool _subtypeChanged() {
    return _currentSubtype != widget.coordinates.format.subtype;
  }

  void _setCurrentValueAndEmitOnChange() {
    widget.onChanged(What3Words(_currentW1, _currentW2, _currentW3));
  }
}
