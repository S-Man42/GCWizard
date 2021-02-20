import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/theme/theme_colors.dart';

class GCWKeyValueList extends StatefulWidget {
  final Map<int, Map<String, String>> keyKeyValueMap;
  final Map<String, String> keyValueMap;
  final String dividerText;
  final bool editAllowed;
  final Function onKeyValueListChanged;

  const GCWKeyValueList({
    Key key,
    this.keyKeyValueMap,
    this.keyValueMap,
    this.dividerText,
    this.editAllowed = true,
    this.onKeyValueListChanged,
  }) : super(key: key);

  @override
  _GCWKeyValueList createState() => _GCWKeyValueList();
}



class _GCWKeyValueList extends State<GCWKeyValueList> {
  var _editKeyController;
  var _editValueController;
  var _currentEditedKey = '';
  var _currentEditedValue = '';
  var _currentEditId;

  @override
  void initState() {
    super.initState();

    _editKeyController = TextEditingController(text: _currentEditedKey);
    _editValueController = TextEditingController(text: _currentEditedValue);
  }

  @override
  void dispose() {
    _editKeyController.dispose();
    _editValueController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var odd = true;
    var rows = (widget.keyKeyValueMap ?? widget.keyValueMap).entries.map((entry) {
      Widget output;

      var row = Container(
          child: Row (
            children: <Widget>[
              Expanded(
                child: Container(
                  child: _currentEditId == entry.key
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
                    child: _currentEditId == entry.key
                        ? GCWTextField(
                      controller: _editValueController,
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
                    (widget.keyKeyValueMap ?? widget.keyValueMap).remove(entry.key);

                    widget.onKeyValueListChanged;
                  });
                },
              )
            ],
          )
      );

      if (odd) {
        output = Container(
            color: themeColors().outputListOddRows(),
            child: row
        );
      } else {
        output = Container(
            child: row
        );
      }
      odd = !odd;

      return output;
    }).toList();

    if (rows.length > 0 && widget.dividerText != null) {
      rows.insert(0,
          GCWTextDivider(
              text: widget.dividerText
          )
      );
    }

    return Column(
        children: rows
    );
  }

  Widget _editButton(dynamic entry) {
    if (!widget.editAllowed)
      return Container();

    return _currentEditId == entry.key
      ? GCWIconButton(
        iconData: Icons.check,
        onPressed: () {

          widget.keyKeyValueMap[_currentEditId] = {_currentEditedKey: _currentEditedValue};

          setState(() {
            _currentEditId = null;
            _editKeyController.clear();
            _editValueController.clear();

            widget.onKeyValueListChanged;
          });
        },
      )
      : GCWIconButton(
        iconData: Icons.edit,
        onPressed: () {
          setState(() {
            _currentEditId = entry.key;
            _editKeyController.text = getEntryKey(entry);
            _editValueController.text = getEntryValue(entry);
            _currentEditedKey = getEntryKey(entry);
            _currentEditedValue = getEntryValue(entry);
          });
        },
      );
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
