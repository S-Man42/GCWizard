part of 'package:gc_wizard/common_widgets/key_value_editor/gcw_key_value_editor.dart';

Widget _alphabetAddLetterButton() {
  return Container(
      padding: const EdgeInsets.only(left: 4, right: 2),
      child: GCWButton(
        text: widget.alphabetInstertButtonLabel ?? '',
        onPressed: () {
          setState(() {
            _addEntry(_currentKeyInput, _currentValueInput);
          });
        },
      ));
}

Widget _alphabetAddAndAdjustLetterButton() {
  return Container(
      padding: const EdgeInsets.only(left: 4, right: 2),
      child: GCWButton(
        text: widget.alphabetAddAndAdjustLetterButtonLabel ?? '',
        onPressed: () => _isAddAndAdjustEnabled()
            ? () {
          setState(() {
            if (widget.onAddEntry2 != null) widget.onAddEntry2!(_currentKeyInput, _currentValueInput, context);

            _onNewEntryChanged(true);
          });
        }
            : null,
      ));
}