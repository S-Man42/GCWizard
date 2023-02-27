part of 'package:gc_wizard/tools/crypto_and_encodings/enigma/widget/enigma.dart';

class EnigmaRotorDropDown extends StatefulWidget {
  final void Function(Tuple2<int, EnigmaRotorConfiguration>) onChanged;
  final EnigmaRotorType type;
  final int position;

  const EnigmaRotorDropDown(
      {Key? key,
      required this.position,
      this.type = EnigmaRotorType.STANDARD,
      required this.onChanged})
      : super(key: key);

  @override
  EnigmaRotorDropDownState createState() => EnigmaRotorDropDownState();
}

class EnigmaRotorDropDownState extends State<EnigmaRotorDropDown> {
  late String _currentRotor;
  var _currentOffset = 1;
  var _currentSetting = 1;

  @override
  void initState() {
    super.initState();

    switch (widget.type) {
      case EnigmaRotorType.STANDARD:
        _currentRotor = defaultRotorStandard;
        break;
      case EnigmaRotorType.ENTRY_ROTOR:
        _currentRotor = defaultRotorEntryRotor;
        break;
      case EnigmaRotorType.REFLECTOR:
        _currentRotor = defaultRotorReflector;
        break;
      default:
        _currentRotor = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
                child: GCWDropDown<String>(
                  value: _currentRotor,
                  items: allEnigmaRotors
                      .where((rotor) => rotor.type == widget.type)
                      .map((rotor) {
                    return GCWDropDownMenuItem(
                      value: rotor.name,
                      child: '${rotor.name}',
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentRotor = value;
                      _setCurrentValueAndEmitOnChange();
                    });
                  },
                ),
                padding: EdgeInsets.only(right: DEFAULT_MARGIN)),
            flex: 2),
        widget.type == EnigmaRotorType.STANDARD
            ? Expanded(
                child: Container(
                  child: GCWABCDropDown(
                    value: _currentOffset,
                    onChanged: (value) {
                      setState(() {
                        _currentOffset = value;
                        _setCurrentValueAndEmitOnChange();
                      });
                    },
                  ),
                  padding: EdgeInsets.symmetric(horizontal: DEFAULT_MARGIN),
                ),
                flex: 1)
            : Container(),
        widget.type == EnigmaRotorType.STANDARD
            ? Expanded(
                child: Container(
                  child: GCWABCDropDown(
                    value: _currentSetting,
                    onChanged: (value) {
                      setState(() {
                        _currentSetting = value;
                        _setCurrentValueAndEmitOnChange();
                      });
                    },
                  ),
                  padding: EdgeInsets.only(left: DEFAULT_MARGIN),
                ),
                flex: 1)
            : Container(),
      ],
    );
  }

  void _setCurrentValueAndEmitOnChange() {
    widget.onChanged(Tuple2<int, EnigmaRotorConfiguration> (
      widget.position,
      EnigmaRotorConfiguration(
          getEnigmaRotorByName(_currentRotor),
          offset: _currentOffset,
          setting: _currentSetting)
    ));
  }
}
