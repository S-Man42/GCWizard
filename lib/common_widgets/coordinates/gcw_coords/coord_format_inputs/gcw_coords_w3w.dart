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

  String _APIKey = Prefs.getString('coord_default_w3w_apikey');

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
    return (_APIKey == '');
  }

  bool _subtypeChanged() {
    return _currentSubtype != widget.coordinates.format.subtype;
  }

  void _setCurrentValueAndEmitOnChange() {
    widget.onChanged(What3Words(_currentW1, _currentW2, _currentW3, _currentSubtype));
  }

  void _calculateToW3W() async {
    await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: SizedBox(
            height: 220,
            width: 150,
            child: GCWAsyncExecuter<What3Words>(
              isolatedFunction: _getW3Wasync,
              parameter: _buildLatLon2W3WJobData,
              onReady: (data) => _showW3W(data),
              isOverlay: true,
            ),
          ),
        );
      },
    );
  }

  Future<GCWAsyncExecuterParameters> _buildLatLon2W3WJobData() async {
    return GCWAsyncExecuterParameters({'latlon': _currentCoords, 'language': _currentSubtype, 'apikey': _APIKey});
  }

  void _showW3W(What3Words output) {
    _currentOutput = [output.word1 + '.' + output.word2 + '.' + output.word3];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }
}

Future<What3Words> _getW3Wasync(dynamic jobData) async {
  late What3Words output;
  output = await _getW3W(jobData.parameters["latlon"], jobData.parameters["language"], jobData.parameters["apikey"], sendAsyncPort: jobData.sendAsyncPort);

  if (jobData.sendAsyncPort != null) {
    jobData.sendAsyncPort.send(output);
  }

  return output;
}

Future<What3Words> _getW3W(LatLng coord, CoordinateFormatKey language, String APIKey, {SendPort sendAsyncPort}) async {

  var api = What3WordsV3(APIKey);

  var words = await api.convertTo3wa(Coordinates(coord.latitude, coord.longitude))
      .language(language)
      .execute();

  if (words.isSuccessful()) {
    print(words.data()?.words);
    var w3w = words.data()?.words.split('.');
    return What3Words(w3w![0], w3w[1], w3w[2], language);
  } else {
    return What3Words('', '', '', language);
  }
}
