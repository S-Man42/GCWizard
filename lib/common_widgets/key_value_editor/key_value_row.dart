part of 'package:gc_wizard/common_widgets/key_value_editor/gcw_key_value_editor.dart';


class GCWKeyValueRow extends StatefulWidget {

  final List<KeyValueBase> entries;
  KeyValueBase keyValueEntry;
  _KeyValueEditorControl keyValueEditorControl;
  final bool odd;
  final List<TextInputFormatter>? keyInputFormatters;
  final List<TextInputFormatter>? valueInputFormatters;
  final bool editAllowed;
  final void Function(KeyValueBase)? onUpdateEntry;
  final void Function()? onSetState;

  GCWKeyValueRow(
     {Key? key,
       required this.entries,
       required this.keyValueEntry,
       required this.keyValueEditorControl,

       required this.odd,
       this.keyInputFormatters,
       this.valueInputFormatters,
       this.editAllowed = true,
       this.onUpdateEntry,
       this.onSetState
     })
     : super(key: key);

 @override
 GCWKeyValueRowState createState() => GCWKeyValueRowState();
}

class GCWKeyValueRowState extends State<GCWKeyValueRow> {
  late TextEditingController _keyController;
  late TextEditingController _valueController;
  late FocusNode _focusNodeEditValue;

  var _currentKey = '';
  var _currentValue = '';

  @override
  void initState() {
    super.initState();

    _initValues();

    _focusNodeEditValue = FocusNode();
  }

  @override
  void didUpdateWidget(GCWKeyValueRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initValues();
  }

  @override
  void dispose() {
    _keyController.dispose();
    _valueController.dispose();

    _focusNodeEditValue.dispose();

    super.dispose();
  }

  void _initValues() {
    _currentKey = widget.keyValueEntry.key;
    _currentValue = widget.keyValueEntry.value;

    _keyController = TextEditingController(text: _currentKey);
    _valueController = TextEditingController(text: _currentValue);
  }

  @override
  Widget build(BuildContext context) {
    Widget output;

    var row = Row(
      children: <Widget>[
        _keyWidget(),
        _arrowIcon(),
        _valueWidget(),
        _editButton(),
        _removeButton(),
      ],
    );

    if (widget.odd) {
      output = Container(color: themeColors().outputListOddRows(), child: row);
    } else {
      output = Container(child: row);
    }

    return output;
  }

  Widget _keyWidget() {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: widget.keyValueEditorControl.currentEditId == entryId(widget.keyValueEntry)
            ? GCWTextField(
                controller: _keyController,
                inputFormatters: widget.keyInputFormatters,
                onChanged: (text) {
                  setState(() {
                    _currentKey = text;
                  });
                },
              )
            : GCWText(text: widget.keyValueEntry.key),
      ),
    );
  }

  Widget _arrowIcon() {
    return Icon(
      Icons.arrow_forward,
      color: themeColors().mainFont(),
    );
  }

  Widget _valueWidget() {
    return Expanded(
        flex: 3,
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          child: widget.keyValueEditorControl.currentEditId == entryId(widget.keyValueEntry)
              ? GCWTextField(
                  controller: _valueController,
                  focusNode: _focusNodeEditValue,
                  inputFormatters: widget.valueInputFormatters,
                  onChanged: (text) {
                    setState(() {
                      _currentValue = text;
                    });
                  },
                )
              : GCWText(text: widget.keyValueEntry.value),
        )
    );
  }

  Widget _editButton() {
    if (!widget.editAllowed) return Container();

    return widget.keyValueEditorControl.currentEditId == entryId(widget.keyValueEntry)
        ? GCWIconButton(
            icon: Icons.check,
            onPressed: () {
              _updateEntry();
            },
          )
        : GCWIconButton(
            icon: Icons.edit,
            onPressed: () {
              setState(() {
                FocusScope.of(context).requestFocus(_focusNodeEditValue);

                widget.keyValueEditorControl.currentEditId = entryId(widget.keyValueEntry);
                _currentKey = widget.keyValueEntry.key;
                _currentValue = widget.keyValueEntry.value;
                _keyController.text = _currentKey;
                _valueController.text = _currentValue;
              });
            },
          );
  }

  Object? entryId(KeyValueBase entry) {
    return widget.keyValueEntry.id ?? widget.keyValueEntry.key;
  }

  Widget _removeButton() {
    return GCWIconButton(
      icon: Icons.remove,
      onPressed: () {
        setState(() {
          _removeEntry();
        });
        if (widget.onSetState != null) widget.onSetState!();
      },
    );
  }

  void _updateEntry() {
    widget.keyValueEntry.key = _currentKey;
    widget.keyValueEntry.value = _currentValue;
    if (widget.onUpdateEntry != null) widget.onUpdateEntry!(widget.keyValueEntry);

    setState(() {
      widget.keyValueEditorControl.currentEditId = null;
      _keyController.clear();
      _valueController.clear();
    });
  }

  void _removeEntry() {
    widget.entries.remove(widget.keyValueEntry);
    _finishRemoveEntry(widget.keyValueEntry);
  }

  void _finishRemoveEntry(KeyValueBase entry) {
    if (widget.onUpdateEntry != null) widget.onUpdateEntry!(entry);

    if (widget.onSetState != null) widget.onSetState!();
  }
}



