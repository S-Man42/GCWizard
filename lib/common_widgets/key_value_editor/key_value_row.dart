part of 'package:gc_wizard/common_widgets/key_value_editor/gcw_key_value_editor.dart';


class GCWKeyValueRow extends StatefulWidget {

}

Widget _buildRow(Object entry, bool odd) {
  Widget output;

  var row = Row(
    children: <Widget>[
      Expanded(
        flex: 1,
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          child: _currentEditId == _getEntryId(entry)
              ? GCWTextField(
            controller: _editKeyController,
            inputFormatters: widget.keyInputFormatters,
            onChanged: (text) {
              setState(() {
                _currentEditedKey = text;
              });
            },
          )
              : GCWText(text: (_getEntryKey(entry)).toString()),
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
            child: _currentEditId == _getEntryId(entry)
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
                : GCWText(text: _getEntryValue(entry).toString()),
          )),
      widget.formulaValueList != null && !widget.varcoords
          ? Expanded(
          child: Container(
              child: _currentEditId == _getEntryId(entry)
                  ? Container(
                  padding: const EdgeInsets.only(left: DEFAULT_MARGIN),
                  child: GCWPopupMenu(
                    iconData: _formulaValueTypeIcon(_currentEditedFormulaValueTypeInput),
                    rotateDegrees: _currentEditedFormulaValueTypeInput == FormulaValueType.TEXT ? 0.0 : 90.0,
                    menuItemBuilder: (context) => [
                      GCWPopupMenuItem(
                          child: iconedGCWPopupMenuItem(context, Icons.vertical_align_center_outlined,
                              i18n(context, 'formulasolver_values_type_fixed'),
                              rotateDegrees: 90.0),
                          action: (index) => setState(() {
                            _currentEditedFormulaValueTypeInput = FormulaValueType.FIXED;
                          })),
                      GCWPopupMenuItem(
                          child: iconedGCWPopupMenuItem(
                              context, Icons.expand, i18n(context, 'formulasolver_values_type_interpolated'),
                              rotateDegrees: 90.0),
                          action: (index) => setState(() {
                            _currentEditedFormulaValueTypeInput = FormulaValueType.INTERPOLATED;
                          })),
                      GCWPopupMenuItem(
                          child: iconedGCWPopupMenuItem(
                              context, Icons.text_fields, i18n(context, 'formulasolver_values_type_text')),
                          action: (index) => setState(() {
                            _currentEditedFormulaValueTypeInput = FormulaValueType.TEXT;
                          })),
                    ],
                  ))
                  : Transform.rotate(
                // TODO Mike Check that entry is really of type FormulaValue and type is really not NULL
                angle: degreesToRadian((entry as FormulaValue).type == FormulaValueType.TEXT ? 0.0 : 90.0),
                // TODO Mike Check that entry is really of type FormulaValue and type is really not NULL
                child: Icon(_formulaValueTypeIcon((entry).type!), color: themeColors().mainFont()),
              )))
          : Container(),
      _editButton(entry),
      GCWIconButton(
        icon: Icons.remove,
        onPressed: () {
          setState(() {
            var entryId = _getEntryId(entry);
            if (widget.onRemoveEntry != null) widget.onRemoveEntry!(entryId, context);
          });
        },
      )
    ],
  );

  if (odd) {
    output = Container(color: themeColors().outputListOddRows(), child: row);
  } else {
    output = Container(child: row);
  }

  return output;
}
