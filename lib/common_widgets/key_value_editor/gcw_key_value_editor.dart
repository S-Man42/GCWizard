import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_paste_button.dart';
import 'package:gc_wizard/common_widgets/clipboard/gcw_clipboard.dart';
import 'package:gc_wizard/common_widgets/dialogs/gcw_dialog.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/gcw_popup_menu.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/common_widgets/gcw_toast.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/formula_solver/persistence/model.dart';
import 'package:gc_wizard/utils/data_type_utils/object_type_utils.dart';
import 'package:gc_wizard/utils/json_utils.dart';
import 'package:gc_wizard/utils/variable_string_expander.dart';

part "package:gc_wizard/common_widgets/key_value_editor/key_value_new_entry.dart";
part "package:gc_wizard/common_widgets/key_value_editor/key_value_type_new_entry.dart";
part "package:gc_wizard/common_widgets/key_value_editor/key_value_alphabet_new_entry.dart";
part "package:gc_wizard/common_widgets/key_value_editor/key_value_row.dart";
part "package:gc_wizard/common_widgets/key_value_editor/key_value_type_row.dart";

class KeyValueBase {
  Object? id;
  String key;
  String value;

  KeyValueBase(this.id, this.key, this.value);
}

class KeyValueString extends KeyValueBase {

  KeyValueString(MapEntry<String, String> entry)
    : super (entry.key, entry.key, entry.value);
}

class KeyValueFormulaValue extends KeyValueBase {
  @override
  String get id => key;
  @override
  set id(Object? id) => key = id == null ? '': id.toString();

  KeyValueFormulaValue(FormulaValue entry)
      : super (entry.id?.toString() ?? '', entry.key, entry.value);
}

class _KeyValueEditorControl {
  Object? currentEditId;
}

class GCWKeyValueEditor extends StatefulWidget {
  final List<KeyValueBase> entries;
  final String? keyHintText;
  final TextEditingController? keyController;
  final List<TextInputFormatter>? keyInputFormatters;
  final List<TextInputFormatter>? valueInputFormatters;
  final String valueHintText;
  final int? valueFlex;
  final KeyValueBase Function(KeyValueBase)? onGetNewEntry;
  final void Function(KeyValueBase, BuildContext)? onNewEntryChanged;
  final void Function(KeyValueBase, BuildContext)? onDispose;
  // final String? alphabetInstertButtonLabel;
  // final String? alphabetAddAndAdjustLetterButtonLabel;

  final Widget? middleWidget;

  final bool formulaFormat;
  final bool alphabetFormat;
  final String? dividerText;
  final bool editAllowed;
  final void Function(KeyValueBase)? onUpdateEntry;
  //final void Function(KeyValueBase, BuildContext)? onRemoveEntry;

  const GCWKeyValueEditor({
    Key? key,
    required this.entries,
    this.keyHintText,
    this.keyController,
    this.keyInputFormatters,
    this.onNewEntryChanged,
    required this.valueHintText,
    this.valueInputFormatters,
    this.valueFlex,
    this.onGetNewEntry,
    this.onDispose,
    // this.alphabetInstertButtonLabel,
    // this.alphabetAddAndAdjustLetterButtonLabel,
    this.middleWidget,
    this.dividerText,
    this.editAllowed = true,
    this.formulaFormat = false,
    this.alphabetFormat = false,
    this.onUpdateEntry,
  }) : super(key: key);

  @override
  _GCWKeyValueEditor createState() => _GCWKeyValueEditor();
}

class _GCWKeyValueEditor extends State<GCWKeyValueEditor> {

  var keyValueEditorControl = _KeyValueEditorControl();
  final GlobalKey<GCWKeyValueNewEntryState> _newEntryState = GlobalKey<GCWKeyValueNewEntryState>();

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[_buildInput(), _buildMiddleWidget(), _buildList()]);
  }

  Widget _buildInput() {
    if (widget.formulaFormat) {
      return GCWKeyValueTypeNewEntry(
        key: _newEntryState,
        entries: widget.entries,
        keyHintText: widget.keyHintText,
        valueHintText: widget.valueHintText,
        keyController: widget.keyController,
        keyInputFormatters: widget.keyInputFormatters,
        valueInputFormatters: widget.valueInputFormatters,
        onGetNewEntry: widget.onGetNewEntry,
        onNewEntryChanged: widget.onNewEntryChanged,
        valueFlex: widget.valueFlex,
      );
    } else if (widget.alphabetFormat) {
      return GCWKeyValueAlphabetNewEntry(
        key: _newEntryState,
        entries: widget.entries,
        keyHintText: widget.keyHintText,
        valueHintText: widget.valueHintText,
        keyController: widget.keyController,
        keyInputFormatters: widget.keyInputFormatters,
        valueInputFormatters: widget.valueInputFormatters,
        onGetNewEntry: widget.onGetNewEntry,
        onNewEntryChanged: widget.onNewEntryChanged,
        valueFlex: widget.valueFlex,
      );
    } else {
      return GCWKeyValueNewEntry(
        key: _newEntryState,
        entries: widget.entries,
        keyHintText: widget.keyHintText,
        valueHintText: widget.valueHintText,
        keyController: widget.keyController,
        keyInputFormatters: widget.keyInputFormatters,
        valueInputFormatters: widget.valueInputFormatters,
        onGetNewEntry: widget.onGetNewEntry,
        onNewEntryChanged: widget.onNewEntryChanged,
        valueFlex: widget.valueFlex,
      );
    }
  }

  Widget _buildMiddleWidget() {
    return widget.middleWidget ?? Container();
  }

  Widget _buildList() {
    var odd = false;
    List<Widget>? rows;

    rows = widget.entries.map((entry) {
      odd = !odd;
      return _buildRow(entry, odd);
    }).toList();

    if (rows.isNotEmpty) {
      rows.insert(
        0,
        GCWTextDivider(
            text: widget.dividerText ?? '',
            trailing: Row(children: <Widget>[
              GCWPasteButton(
                iconSize: IconButtonSize.SMALL,
                onSelected: (text) => _newEntryState.currentState?.pasteClipboard(text),
              ),
              GCWIconButton(
                size: IconButtonSize.SMALL,
                icon: Icons.content_copy,
                onPressed: () {
                  var copyText = _toJson();
                  if (copyText == null) return;
                  insertIntoGCWClipboard(context, copyText);
                },
              )
            ])),
      );
    }

    return rows.isEmpty ? Container() : Column(children: rows);
  }

  Widget _buildRow(KeyValueBase entry, bool odd) {
    if (widget.formulaFormat) {
      return GCWKeyValueTypeRow(
        entries: widget.entries,
        keyValueEntry: entry,
        keyValueEditorControl:keyValueEditorControl,
        odd: odd,
        keyInputFormatters: widget.keyInputFormatters,
        valueInputFormatters: widget.valueInputFormatters,
        editAllowed: widget.editAllowed,
        onUpdateEntry: widget.onUpdateEntry
      );
    } else {
      return GCWKeyValueRow(
        entries: widget.entries,
        keyValueEntry: entry,
        keyValueEditorControl:keyValueEditorControl,
        odd: odd,
        keyInputFormatters: widget.keyInputFormatters,
        valueInputFormatters: widget.valueInputFormatters,
        editAllowed: widget.editAllowed,
        onUpdateEntry: widget.onUpdateEntry
      );
    }
  }

  String? _toJson() {
    var list = widget.entries.map((e) {
      return jsonEncode({'key': e.key, 'value': e.value});
    }).toList();

    if (list.isEmpty) return null;

    return jsonEncode(list);
  }

}
