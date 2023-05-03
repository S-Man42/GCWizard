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
     })
     : super(key: key);

 @override
 GCWKeyValueRowState createState() => GCWKeyValueRowState();
}

class GCWKeyValueRowState extends State<GCWKeyValueRow> {
  late TextEditingController _editKeyController;
  late TextEditingController _editValueController;
  late FocusNode _focusNodeEditValue;

  var _currentEditedKey = '';
  var _currentEditedValue = '';

  @override
  void initState() {
    super.initState();

    _editKeyController = TextEditingController(text: _currentEditedKey);
    _editValueController = TextEditingController(text: _currentEditedValue);

    _focusNodeEditValue = FocusNode();
  }

  @override
  void dispose() {
    _editKeyController.dispose();
    _editValueController.dispose();

    _focusNodeEditValue.dispose();

    super.dispose();
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
        child: widget.keyValueEditorControl.currentEditId == widget.keyValueEntry.id
            ? GCWTextField(
          controller: _editKeyController,
          inputFormatters: widget.keyInputFormatters,
          onChanged: (text) {
            setState(() {
              _currentEditedKey = text;
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
          child: widget.keyValueEditorControl.currentEditId == widget.keyValueEntry.id
              ? GCWTextField(
                  controller: _editValueController,
                  focusNode: _focusNodeEditValue,
                  inputFormatters: widget.valueInputFormatters,
                  onChanged: (text) {
                    setState(() {
                      _currentEditedValue = text;
                    });
                  },
                )
              : GCWText(text: widget.keyValueEntry.value),
        )
    );
  }

  Widget _editButton() {
    if (!widget.editAllowed) return Container();

    return widget.keyValueEditorControl.currentEditId == widget.keyValueEntry.id
        ? GCWIconButton(
            icon: Icons.check,
            onPressed: () {
              if (widget.keyValueEditorControl.currentEditId != null) {
                widget.keyValueEntry.value = _currentEditedValue;
                if (widget.onUpdateEntry != null) widget.onUpdateEntry!(widget.keyValueEntry);
              }
              setState(() {
                widget.keyValueEditorControl.currentEditId = null;
                _editKeyController.clear();
                _editValueController.clear();
              });
            },
          )
        : GCWIconButton(
            icon: Icons.edit,
            onPressed: () {
              setState(() {
                FocusScope.of(context).requestFocus(_focusNodeEditValue);

                widget.keyValueEditorControl.currentEditId = widget.keyValueEntry.id;
                _editKeyController.text = widget.keyValueEntry.key;
                _editValueController.text = widget.keyValueEntry.value;
                _currentEditedKey = widget.keyValueEntry.key;
                _currentEditedValue = widget.keyValueEntry.value;
              });
            },
          );
  }

  Widget _removeButton() {
    return GCWIconButton(
      icon: Icons.remove,
      onPressed: () {
        setState(() {
          if (widget.onRemoveEntry != null) widget.onRemoveEntry!(widget.keyValueEntry, context);
        });
      },
    );
  }
}



