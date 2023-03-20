part of 'package:gc_wizard/common_widgets/key_value_editor/gcw_key_value_editor.dart';


class GCWKeyValueRow extends StatefulWidget {
  KeyValueBase keyValueEntry;
  bool odd;
  List<TextInputFormatter>? keyInputFormatters;
  List<TextInputFormatter>? valueInputFormatters;
  final bool editAllowed;

  final void Function(Object, String, String, FormulaValueType)? onUpdateEntry;
  final void Function(Object, BuildContext)? onRemoveEntry;

  GCWKeyValueRow(
     {Key? key,
       required this.keyValueEntry,

       required this.odd,
       this.keyInputFormatters,
       this.valueInputFormatters,
       this.editAllowed = true,
       this.onUpdateEntry,
       this.onRemoveEntry,
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
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            child: _currentEditId == widget.keyValueEntry.id
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
        ),
        Icon(
          Icons.arrow_forward,
          color: themeColors().mainFont(),
        ),
        Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: _currentEditId == widget.keyValueEntry.id
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
            )),
        _editButton(entry),
        GCWIconButton(
          icon: Icons.remove,
          onPressed: () {
            setState(() {
              if (widget.onRemoveEntry != null) widget.onRemoveEntry!(widget.keyValueEntry.id, context);
            });
          },
        )
      ],
    );

    if (widget.odd) {
      output = Container(color: themeColors().outputListOddRows(), child: row);
    } else {
      output = Container(child: row);
    }

    return output;
  }

  Widget _editButton() {
    if (!widget.editAllowed) return Container();

    return _currentEditId == _getEntryId(entry)
        ? GCWIconButton(
      icon: Icons.check,
      onPressed: () {
        if (widget.onUpdateEntry != null) {
          if (widget.formulaValueList == null && _currentEditId != null) {
            widget.onUpdateEntry!(_currentEditId!, _currentEditedKey, _currentEditedValue, _currentEditedFormulaValueTypeInput);
          } else {
            if (_currentEditedFormulaValueTypeInput == FormulaValueType.INTERPOLATED) {
              if (!VARIABLESTRING.hasMatch(_currentEditedValue.toLowerCase())) {
                showToast(i18n(context, 'formulasolver_values_novalidinterpolated'));
                return;
              }
            }
            if (_currentEditId != null) {
              widget.onUpdateEntry!(
                  _currentEditId!, _currentEditedKey, _currentEditedValue, _currentEditedFormulaValueTypeInput);
            }
          }
        }

        setState(() {
          _currentEditId = null;
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

          _currentEditId = widget.id;
          _editKeyController.text = widget.key_;
          _editValueController.text = widget.value;
          _currentEditedKey = widget.key_;
          _currentEditedValue = widget.value;

          if (widget.formulaValueList != null) {
            _currentEditedFormulaValueTypeInput =
                widget.formulaValueList!.firstWhere((element) => element.id == _currentEditId).type ?? FormulaValueType.FIXED;
          }
        });
      },
    );
  }
}



