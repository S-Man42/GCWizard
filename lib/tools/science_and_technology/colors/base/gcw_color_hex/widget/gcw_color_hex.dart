import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/base/gcw_textfield/gcw_textfield.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/logic/colors_rgb.dart';
import 'package:gc_wizard/tools/utils/textinputformatter/wrapper_for_masktextinputformatter/widget/wrapper_for_masktextinputformatter.dart';

class GCWColorHexCode extends StatefulWidget {
  final Function onChanged;
  final HexCode color;

  const GCWColorHexCode({Key key, this.onChanged, this.color}) : super(key: key);

  @override
  _GCWColorHexCodeState createState() => _GCWColorHexCodeState();
}

class _GCWColorHexCodeState extends State<GCWColorHexCode> {
  String _currentHexCode = '#F0F0F0';

  var _controller;

  var _maskInputFormatter = WrapperForMaskTextInputFormatter(mask: '#......', filter: {".": RegExp(r'[A-Fa-f0-9]')});

  @override
  void initState() {
    super.initState();

    if (widget.color != null) {
      _currentHexCode = widget.color.hexCode;
    }
    _controller = TextEditingController(text: '#' + _currentHexCode);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.color != null) {
      _currentHexCode = widget.color.hexCode;
    }

    return Column(
      children: [
        GCWTextField(
          controller: _controller,
          inputFormatters: [_maskInputFormatter],
          onChanged: (text) {
            _currentHexCode = text;
            _emitOnChange();
          },
        )
      ],
    );
  }

  _emitOnChange() {
    widget.onChanged(HexCode(_currentHexCode));
  }
}
