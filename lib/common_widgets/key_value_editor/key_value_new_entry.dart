part of 'package:gc_wizard/common_widgets/key_value_editor/gcw_key_value_editor.dart';


class GCWKeyValueNewEntry extends StatefulWidget {

  final List<KeyValueBase> entries;
  final String? keyHintText;
  final String valueHintText;
  final TextEditingController? keyController;
  final List<TextInputFormatter>? keyInputFormatters;
  final List<TextInputFormatter>? valueInputFormatters;
  final KeyValueBase? Function(KeyValueBase)? onGetNewEntry;
  final void Function(KeyValueBase)? onNewEntryChanged;
  final void Function(KeyValueBase)? onUpdateEntry;
  final bool addOnDispose;
  final int? valueFlex;
  final void Function()? onSetState;

  const GCWKeyValueNewEntry(
     {Key? key,
      required this.entries,
      this.keyHintText,
      required this.valueHintText,
      this.keyController,
      this.keyInputFormatters,
      this.valueInputFormatters,
      this.onGetNewEntry,
      this.onNewEntryChanged,
      this.onUpdateEntry,
      required this.addOnDispose,
      this.valueFlex,
      this.onSetState
     })
     : super(key: key);

 @override
 _GCWKeyValueNewEntryState createState() => _GCWKeyValueNewEntryState();
}

class _GCWKeyValueNewEntryState extends State<GCWKeyValueNewEntry> {
  late TextEditingController _keyController;
  late TextEditingController _valueController;
  late FocusNode _focusNodeEditValue;

  var _currentKey = '';
  var _currentValue = '';

  @override
  void initState() {
    super.initState();

    if (widget.keyController == null) {
      _keyController = TextEditingController(text: _currentKey);
    } else {
      _keyController = widget.keyController!;
      _currentKey = _keyController.text;
    }
    _valueController = TextEditingController(text: _currentValue);

    _focusNodeEditValue = FocusNode();
  }

  @override
  void dispose() {
    if (widget.addOnDispose && _currentKey.isNotEmpty  && _currentValue.isNotEmpty) {
      _addEntry(KeyValueBase(null, _currentKey, _currentValue));
    }
    if (widget.keyController == null) _keyController.dispose();
    _valueController.dispose();

    _focusNodeEditValue.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            _keyWidget(),
            _arrowIcon(),
            _valueWidget(),
            _addIcon(),
          ],
        ),
      ],
    );
  }

  Widget _keyWidget() {
    return Expanded(
        flex: 2,
        child: GCWTextField(
          hintText: widget.keyHintText,
          controller: _keyController,
          inputFormatters: widget.keyInputFormatters,
          onChanged: (text) {
            setState(() {
              _currentKey = text;
              _onNewEntryChanged(false);
            });
          },
        )
    );
  }

  Widget _arrowIcon() {
    return Icon(
      Icons.arrow_forward,
      color: themeColors().mainFont(),
    );
  }

  Widget _addIcon() {
    return GCWIconButton(
        icon: Icons.add,
        onPressed: () {
          if (!_validInput()) {
            return;
          }

          setState(() {
            _addEntry(KeyValueBase(null, _currentKey, _currentValue));
          });
        });
  }

  Widget _valueWidget() {
    return Expanded(
      flex: widget.valueFlex ?? 2,
      child: GCWTextField(
        hintText: widget.valueHintText,
        controller: _valueController,
        inputFormatters: widget.valueInputFormatters,
        onChanged: (text) {
          setState(() {
            _currentValue = text;
            _onNewEntryChanged(false);
          });
        },
      ),
    );
  }

  bool _validInput() {
    return true;
  }

  void _addEntry(KeyValueBase entry, {bool clearInput = true}) {
    var _entry = _getNewEntry(entry);
    if (_entry != null) {
      widget.entries.add(_entry);

      _finishAddEntry(_entry, clearInput);
    }
  }

  void _finishAddEntry(KeyValueBase entry, bool clearInput) {
    if (clearInput) _onNewEntryChanged(true);
    if (widget.onUpdateEntry != null) widget.onUpdateEntry!(entry);

    if (widget.onSetState != null) widget.onSetState!();
  }

  void _onNewEntryChanged(bool resetInput) {
    if (resetInput) {
      if (widget.keyController == null) {
        _keyController.clear();
        _currentKey = '';
      } else {
        _currentKey = _keyController.text;
      }

      _valueController.clear();
      _currentValue = '';
    }
    if (widget.onNewEntryChanged != null) {
      widget.onNewEntryChanged!(KeyValueBase(null, _currentKey, _currentValue));
    }
  }

  KeyValueBase? _getNewEntry(KeyValueBase entry) {
    if (widget.onGetNewEntry == null) {
      return entry;
    } else {
      return widget.onGetNewEntry!(entry);
    }
  }

  void pasteClipboard(String text) {
    Object? json = jsonDecode(text);
    List<MapEntry<String, String>>? list;
    if (isJsonArray(json)) {
      list = _fromJson(json as List<Object?>);
    } else {
      list = _parseClipboardText(text);
    }

    if (list != null) {
      for (var mapEntry in list) {
        _addEntry(KeyValueBase(null, mapEntry.key, mapEntry.value), clearInput: false);
      }
    }
  }

  List<MapEntry<String, String>>? _fromJson(List<Object?> json) {
    var list = <MapEntry<String, String>>[];
    String? key;
    String? value;

    for (var jsonEntry in json) {
      if (jsonEntry == null || jsonEntry is! String) {
        continue;
      }

      var json = jsonDecode(jsonEntry);
      key = toStringOrNull(json['key']);
      value = toStringOrNull(json['value']);

      if (key != null && value != null) list.add(MapEntry(key, value));
    }

    return list.isEmpty ? null : list;
  }

  List<MapEntry<String, String>>? _parseClipboardText(String? text) {
    var list = <MapEntry<String, String>>[];
    if (text == null) return null;

    List<String> lines = const LineSplitter().convert(text);

    for (var line in lines) {
      var regExp = RegExp(r"^([\s]*)([\S])([\s]*)([=]?)([\s]*)([\s*\S+]+)([\s]*)");
      var match = regExp.firstMatch(line);
      if (match != null && match.group(2) != null && match.group(6) != null) {
        list.add(MapEntry(match.group(2)!, match.group(6)!));
      }
    }

    return list.isEmpty ? null : list;
  }
}



