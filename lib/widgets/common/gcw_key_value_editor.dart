import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/persistence/formula_solver/model.dart';

class GCWKeyValueEditor extends StatefulWidget {
  final Function onNewEntryChanged;
  final String keyHintText;
  final List<TextInputFormatter> valueInputFormatters;
  final String valueHintText;
  final int valueFlex;
  final Function onAddEntry;
  final Function onAddEntry2;
  final Function onDispose;
  final String alphabetInstertButtonLabel;
  final String alphabetAddAndAdjustLetterButtonLabel;

  final Widget middleWidget;

  final Map<int, Map<String, String>> keyKeyValueMap;
  final Map<String, String> keyValueMap;
  final List<FormulaValue> formulaValueList;
  final String dividerText;
  final bool editAllowed;
  final Function onUpdateEntry;
  final Function onRemoveEntry;

  const GCWKeyValueEditor({
    Key key,
    this.keyHintText,
    this.onNewEntryChanged,
    this.valueHintText,
    this.valueInputFormatters,
    this.valueFlex,
    this.onAddEntry,
    this.onAddEntry2,
    this.onDispose,
    this.alphabetInstertButtonLabel,
    this.alphabetAddAndAdjustLetterButtonLabel,

    this.middleWidget,

    this.keyKeyValueMap,
    this.keyValueMap,
    this.formulaValueList,
    this.dividerText,
    this.editAllowed = true,
    this.onUpdateEntry,
    this.onRemoveEntry,
  }) : super(key: key);

  @override
  _GCWKeyValueEditor createState() => _GCWKeyValueEditor();
}

class _GCWKeyValueEditor extends State<GCWKeyValueEditor> {
  var _inputController;
  var _keyController;
  var _valueController;

  var _editKeyController;
  var _editValueController;

  var _currentInput = '';
  var _currentKeyInput = '';
  var _currentValueInput = '';

  var _currentEditedKey = '';
  var _currentEditedValue = '';
  var _currentEditId;

  @override
  void initState() {
    super.initState();

    _inputController = TextEditingController(text: _currentInput);
    _keyController = TextEditingController(text: _currentKeyInput);
    _valueController = TextEditingController(text: _currentValueInput);

    _editKeyController = TextEditingController(text: _currentEditedKey);
    _editValueController = TextEditingController(text: _currentEditedValue);
  }

  @override
  void dispose() {
    if (widget.onDispose != null)
      widget.onDispose(_currentKeyInput, _currentValueInput, context);

    _inputController.dispose();
    _keyController.dispose();
    _valueController.dispose();

    _editKeyController.dispose();
    _editValueController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildInput(),
        _buildMiddleWidget(),
        _buildList()
      ]
    );
  }

  Widget _buildInput() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: GCWTextField(
                hintText: widget.keyHintText,
                controller: _keyController,
                onChanged:  (text) {
                  setState(() {
                    _currentKeyInput = text;
                    _onNewEntryChanged(false);
                  });
                },
              ),
              flex: 1
            ),
            Icon(
              Icons.arrow_forward,
              color: themeColors().mainFont(),
            ),
            Expanded(
              child: GCWTextField(
                hintText: widget.valueHintText,
                controller:  _valueController,
                inputFormatters: widget.valueInputFormatters,
                onChanged:  (text) {
                  setState(() {
                    _currentValueInput = text;
                    _onNewEntryChanged(false);
                  });
                },
              ),
              flex: widget.valueFlex ?? 1,
            ),
            widget.alphabetInstertButtonLabel != null
              ? _alphabetAddLetterButton()
              : GCWIconButton(
                  iconData: Icons.add,
                  onPressed: () {
                    setState(() {
                      if (widget.onAddEntry != null)
                        widget.onAddEntry(_currentKeyInput, _currentValueInput, context);

                      _onNewEntryChanged(true);
                    });
                  }
                ),
            widget.alphabetAddAndAdjustLetterButtonLabel != null ? _alphabetAddAndAdjustLetterButton() : Container()
          ],
        ),
      ],
    );
  }

  Widget _alphabetAddLetterButton() {
    return Container(
        child: GCWButton(
          text: widget.alphabetInstertButtonLabel,
          onPressed: () {
            setState(() {
              if (widget.onAddEntry != null)
                widget.onAddEntry(_currentKeyInput, _currentValueInput, context);

              _onNewEntryChanged(true);
            });
          },
        ),
        padding: EdgeInsets.only(left: 4, right: 2)
    );
  }

  Widget _alphabetAddAndAdjustLetterButton() {
    return Container(
        child: GCWButton(
          text: widget.alphabetAddAndAdjustLetterButtonLabel,
          onPressed: _isAddAndAdjustEnabled() ? () {
            setState(() {
              if (widget.onAddEntry2 != null)
                widget.onAddEntry2(_currentKeyInput, _currentValueInput, context);

              _onNewEntryChanged(true);
            });
          } : null,
        ),
        padding: EdgeInsets.only(left: 4, right: 2)
    );
  }

  _onNewEntryChanged(bool resetInput) {
    if (resetInput) {
      _keyController.clear();
      _valueController.clear();
      _currentKeyInput = '';
      _currentValueInput = '';
    }
    if (widget.onNewEntryChanged != null)
      widget.onNewEntryChanged(_currentKeyInput, _currentValueInput, context);
  }

  _isAddAndAdjustEnabled() {
    if (widget.keyValueMap.containsKey(_currentKeyInput.toUpperCase()))
      return false;

    if (_currentValueInput.contains(','))
      return false;

    return true;
  }

  Widget _buildMiddleWidget() {
    return widget.middleWidget ?? Container();
  }

  Widget _buildList() {
    var odd = false;
    List<Widget> rows;
    if (widget.formulaValueList != null) {
      rows = widget.formulaValueList.map((entry) {
        odd = !odd;
        return _buidRow(entry, odd);
      }).toList();
    } else {
      rows = (widget.keyKeyValueMap?.entries ?? widget.keyValueMap?.entries).map((entry) {
        odd = !odd;
        return _buidRow(entry, odd);
      }).toList();
    }
    if (rows.length > 0 && widget.dividerText != null) {
      rows.insert(0, GCWTextDivider(text: widget.dividerText));
    }

    return Column(
        children: rows
    );
  }

  Widget _buidRow(dynamic entry, bool odd) {
    Widget output;

    var row = Container(
      child: Row (
        children: <Widget>[
          Expanded(
            child: Container(
              child: _currentEditId == getEntryId(entry)
              ? GCWTextField (
                  controller: _editKeyController,
                  onChanged: (text) {
                    setState(() {
                      _currentEditedKey = text;
                    });
                  },
                )
              : GCWText (
                  text: getEntryKey(entry)
                ),
              margin: EdgeInsets.only(left: 10),
            ),
            flex: 1,
          ),
          Icon(
            Icons.arrow_forward,
            color: themeColors().mainFont(),
          ),
          Expanded(
            child: Container(
              child: _currentEditId == getEntryId(entry)
                ? GCWTextField(
                    controller: _editValueController,
                    inputFormatters: widget.valueInputFormatters,
                    autofocus: true,
                    onChanged: (text) {
                      setState(() {
                        _currentEditedValue = text;
                      });
                    },
                  )
                : GCWText (
                    text: getEntryValue(entry)
                  ),
              margin: EdgeInsets.only(left: 10),
            ),
            flex: 3
          ),
          _editButton(entry),
          GCWIconButton(
            iconData: Icons.remove,
            onPressed: () {
              setState(() {
                if (widget.onRemoveEntry != null)
                  widget.onRemoveEntry(getEntryId(entry), context);
              });
            },
          )
        ],
      )
    );

    if (odd) {
      output = Container(color: themeColors().outputListOddRows(), child: row);
    } else {
      output = Container(child: row);
    }

    return output;
  }

  Widget _editButton(dynamic entry) {
    if (!widget.editAllowed)
      return Container();

    return _currentEditId == getEntryId(entry)
      ? GCWIconButton(
          iconData: Icons.check,
          onPressed: () {
            if (widget.onUpdateEntry != null)
              widget.onUpdateEntry(_currentEditId, _currentEditedKey, _currentEditedValue);

            setState(() {
              _currentEditId = null;
              _editKeyController.clear();
              _editValueController.clear();
            });
          },
        )
      : GCWIconButton(
          iconData: Icons.edit,
          onPressed: () {
            setState(() {
              _currentEditId = getEntryId(entry);
              _editKeyController.text = getEntryKey(entry);
              _editValueController.text = getEntryValue(entry);
              _currentEditedKey = getEntryKey(entry);
              _currentEditedValue = getEntryValue(entry);
            });
          },
        );
  }

  getEntryId(dynamic entry) {
    if (widget.formulaValueList != null)
      return entry.id;
    else
      return entry.key;
  }

  getEntryKey(dynamic entry) {
    if (widget.keyKeyValueMap != null)
      return entry.value.keys.first;
    else
      return entry.key;
  }

  getEntryValue(dynamic entry) {
    if (widget.keyKeyValueMap != null)
      return entry.value.values.first;
    else
      return entry.value;
  }
}