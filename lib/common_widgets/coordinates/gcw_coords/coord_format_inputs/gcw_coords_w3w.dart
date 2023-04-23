part of 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords.dart';

class buildW3WJobData {
  final LatLng jobDataCoordinates;
  final CoordinateFormatKey jobDataLanguage;

  buildW3WJobData({
    required this.jobDataCoordinates,
    required this.jobDataLanguage,
  });
}

class buildLatLonJobData {
  final What3Words jobDataCoordinates;

  buildLatLonJobData({
    required this.jobDataCoordinates,
  });
}

class _GCWCoordsWhat3Words extends StatefulWidget {
  final void Function(What3Words) onChanged;
  final What3Words coordinates;
  final bool isDefault;

  const _GCWCoordsWhat3Words({Key? key, required this.onChanged, required this.coordinates, this.isDefault = true})
      : super(key: key);

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

  String _currentOutput = '';

  final String _APIKey = Prefs.getString('coord_default_w3w_apikey');

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
          }),
      GCWTextField(
          hintText: i18n(context, 'coords_formatconverter_w3w_w1'),
          controller: _ControllerW2,
          onChanged: (ret) {
            setState(() {
              _currentW2 = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
      GCWTextField(
          hintText: i18n(context, 'coords_formatconverter_w3w_w1'),
          controller: _ControllerW3,
          onChanged: (ret) {
            setState(() {
              _currentW3 = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }),
      (_APIKeymissing())
          ? GCWOutput(
              title: i18n(context, 'coords_formatconverter_w3w_error'),
              child: i18n(context, 'coords_formatconverter_w3w_no_apikey'),
              suppressCopyButton: true)
          : Container()
    ]);
  }

  bool _APIKeymissing() {
    return (_APIKey == '');
  }

  bool _subtypeChanged() {
    return _currentSubtype != widget.coordinates.format.subtype;
  }

  void _setCurrentValueAndEmitOnChange() {
    _calculateW3WFromLatLon();
    widget.onChanged(What3Words(_currentW1, _currentW2, _currentW3, _currentSubtype));
  }



  void _calculateLatLonFromW3W() async {
    await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: SizedBox(
            height: 220,
            width: 150,
            child: GCWAsyncExecuter<LatLng>(
              isolatedFunction: _convertLatLonFromW3Wasync,
              parameter: _buildJobDataLatLonFromW3W,
              onReady: (data) => _showLatLon(data),
              isOverlay: true,
            ),
          ),
        );
      },
    );
  }

  Future<GCWAsyncExecuterParameters?> _buildJobDataLatLonFromW3W() async {
    return GCWAsyncExecuterParameters(
        buildLatLonJobData(jobDataCoordinates: widget.coordinates));
  }

  Future<LatLng> _convertLatLonFromW3Wasync(GCWAsyncExecuterParameters? jobData) async {
    if (jobData?.parameters is! buildLatLonJobData) {
      return Future.value(LatLng(0.0, 0.0));
    }

    var buildLatLonjob = jobData!.parameters as buildLatLonJobData;
    var output = LatLng(0.0, 0.0);
    //var output = await _getLatLonFrom(buildLatLonjob.jobDataCoordinates as LatLng, buildLatLonjob.jobDataLanguage,
    //    sendAsyncPort: jobData.sendAsyncPort);

    jobData.sendAsyncPort?.send(output);

    return output;
  }

  Future<LatLng> _getLatLonFromW3W(String words, {required SendPort sendAsyncPort}) async {
    if (_APIKey == '') return LatLng(0.0, 0.0);

    var api = What3WordsV3(_APIKey);

    var _coordinates = await api.convertToCoordinates(words).execute();

    return LatLng(_coordinates.data()!.coordinates.lat, _coordinates.data()!.coordinates.lng);
  }

  void _showLatLon(LatLng output) {
    _currentOutput = output.latitude.toString() + ' ' + output.longitude.toString();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }



  void _calculateW3WFromLatLon() async {
    await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: SizedBox(
            height: 220,
            width: 150,
            child: GCWAsyncExecuter<What3Words>(
              isolatedFunction: _convertW3WFromLatLonasync,
              parameter: _buildJobDataW3WFromLatLon,
              onReady: (data) => _showW3W(data),
              isOverlay: true,
            ),
          ),
        );
      },
    );
  }

  Future<GCWAsyncExecuterParameters?> _buildJobDataW3WFromLatLon() async {
    return GCWAsyncExecuterParameters(
        buildW3WJobData(jobDataCoordinates: widget.coordinates as LatLng, jobDataLanguage: _currentSubtype));
  }

  Future<What3Words> _convertW3WFromLatLonasync(GCWAsyncExecuterParameters? jobData) async {
    if (jobData?.parameters is! buildW3WJobData) {
      return Future.value(What3Words('', '', '', CoordinateFormatKey.WHAT3WORDS_DE));
    }

    var buildW3Wjob = jobData!.parameters as buildW3WJobData;
    var output = What3Words('', '', '', CoordinateFormatKey.WHAT3WORDS_DE);
    //var output = await _getW3WfromLatLon(buildW3Wjob.jobDataCoordinates as LatLng,
    //    sendAsyncPort: jobData.sendAsyncPort);

    jobData.sendAsyncPort?.send(output);

    return output;
  }

  Future<What3Words> _getW3WfromLatLon(LatLng coord, CoordinateFormatKey language, {required SendPort sendAsyncPort}) async {
    var api = What3WordsV3(_APIKey);

    var words = await api
        .convertTo3wa(Coordinates(coord.latitude, coord.longitude))
        .language(_convertLanguageFromFormatKey(language))
        .execute();

    if (words.isSuccessful()) {
      var w3w = words.data()?.words.split('.');
      return What3Words(w3w![0], w3w[1], w3w[2], language);
    } else {
      return What3Words('', '', '', language);
    }
  }

  void _showW3W(What3Words output) {
    _currentOutput = output.word1 + '.' + output.word2 + '.' + output.word3;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  String _convertLanguageFromFormatKey(CoordinateFormatKey formatKey) {
    switch (formatKey) {
      case CoordinateFormatKey.WHAT3WORDS_DE:
        return 'de';
      case CoordinateFormatKey.WHAT3WORDS_EN:
        return 'en';
      case CoordinateFormatKey.WHAT3WORDS_FR:
        return 'fr';
      case CoordinateFormatKey.WHAT3WORDS_ZH:
        return 'zh';
      case CoordinateFormatKey.WHAT3WORDS_DK:
        return 'da';
      case CoordinateFormatKey.WHAT3WORDS_NL:
        return 'nl';
      case CoordinateFormatKey.WHAT3WORDS_IT:
        return 'it';
      case CoordinateFormatKey.WHAT3WORDS_JA:
        return 'ja';
      case CoordinateFormatKey.WHAT3WORDS_KO:
        return 'ko';
      case CoordinateFormatKey.WHAT3WORDS_PL:
        return 'pl';
      case CoordinateFormatKey.WHAT3WORDS_RU:
        return 'ru';
      case CoordinateFormatKey.WHAT3WORDS_SP:
        return 'sp';
      case CoordinateFormatKey.WHAT3WORDS_CZ:
        return 'cs';
      default:
        return 'en';
    }
  }
}
