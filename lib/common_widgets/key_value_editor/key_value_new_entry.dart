part of 'package:gc_wizard/common_widgets/key_value_editor/gcw_key_value_editor.dart';


class GCWKeyValueNewEntry extends StatefulWidget {

  final String? keyHintText;
  final String valueHintText;
  final TextEditingController? keyController;
  final List<TextInputFormatter>? keyInputFormatters;
  final List<TextInputFormatter>? valueInputFormatters;
  final void Function(String, String, FormulaValueType, BuildContext)? onAddEntry;
  final void Function(KeyValueBase, BuildContext)? onNewEntryChanged;
  final int? valueFlex;

  const GCWKeyValueNewEntry(
     {Key? key,
      this.keyHintText,
      required this.valueHintText,
      this.keyController,
      this.keyInputFormatters,
      this.valueInputFormatters,
      this.onAddEntry,
      this.onNewEntryChanged,
      this.valueFlex,

     })
     : super(key: key);

 @override
 GCWKeyValueNewEntryState createState() => GCWKeyValueNewEntryState();
}

class GCWKeyValueNewEntryState extends State<GCWKeyValueNewEntry> {
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

  Widget _addIcon() {
    return Icon(
      Icons.arrow_forward,
      color: themeColors().mainFont(),
    );
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

  void _addEntry(String key, String value, {bool clearInput = true, FormulaValueType formulaType = FormulaValueType.FIXED}) {
    if (widget.onAddEntry != null) {
      widget.onAddEntry!(key, value, formulaType, context);
    }

    if (clearInput) _onNewEntryChanged(true);
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
    if (widget.onNewEntryChanged != null) widget.onNewEntryChanged!(KeyValueBase(null, _currentKey, _currentValue), context);
  }
}



