part of 'package:gc_wizard/common_widgets/color_pickers/gcw_colors.dart';

class _GCWColorValuesPicker extends StatefulWidget {
  final void Function(Map<String, Object>) onChanged;
  final GCWColor color;
  final String colorSpace;

  const _GCWColorValuesPicker({Key? key, required this.onChanged, required this.colorSpace, required this.color}) : super(key: key);

  @override
  _GCWColorValuesPickerState createState() => _GCWColorValuesPickerState();
}

class _GCWColorValuesPickerState extends State<_GCWColorValuesPicker> {
  String _currentColorSpace = defaultColorSpace;
  GCWColor _currentColor = defaultColor;

  @override
  Widget build(BuildContext context) {
    _currentColorSpace = widget.colorSpace;
    _currentColor = widget.color;

    List<Map<String, dynamic>> _colorWidgets = [
      {
        'colorSpace': getColorSpaceByKey(keyColorSpaceRGB),
        'widget': _GCWColorRGB(
          color: _currentColorSpace == keyColorSpaceRGB ? _currentColor as RGB : null,
          onChanged: (RGB newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorSpaceHex),
        'widget': _GCWColorHexCode(
          color: _currentColorSpace == keyColorSpaceHex ? _currentColor as HexCode : null,
          onChanged: (HexCode newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorSpaceHSV),
        'widget': _ColorHSV(
          color: _currentColorSpace == keyColorSpaceHSV ? _currentColor as HSV : null,
          onChanged: (HSV newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorSpaceHSL),
        'widget': _GCWColorHSL(
          color: _currentColorSpace == keyColorSpaceHSL ? _currentColor as HSL : null,
          onChanged: (HSL newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorSpaceHSI),
        'widget': _GCWColorHSI(
          color: _currentColorSpace == keyColorSpaceHSI ? _currentColor as HSI : null,
          onChanged: (HSI newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorSpaceCMYK),
        'widget': _GCWColorCMYK(
          color: _currentColorSpace == keyColorSpaceCMYK ? _currentColor as CMYK : null,
          onChanged: (CMYK newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorSpaceCMY),
        'widget': _GCWColorCMY(
          color: _currentColorSpace == keyColorSpaceCMY ? _currentColor as CMY : null,
          onChanged: (CMY newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorSpaceYUV),
        'widget': _GCWColorYUV(
          color: _currentColorSpace == keyColorSpaceYUV ? _currentColor as YUV : null,
          onChanged: (YUV newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorSpaceYPbPr),
        'widget': _GCWColorYPbPr(
          color: _currentColorSpace == keyColorSpaceYPbPr ? _currentColor as YPbPr : null,
          onChanged: (YPbPr newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorSpaceYCbCr),
        'widget': _GCWColorYCbCr(
          color: _currentColorSpace == keyColorSpaceYCbCr ? _currentColor as YCbCr : null,
          onChanged: (YCbCr newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(keyColorSpaceYIQ),
        'widget': _GCWColorYIQ(
          color: _currentColorSpace == keyColorSpaceYIQ ? _currentColor as YIQ: null,
          onChanged: (YIQ newValue) {
            setState(() {
              _currentColor = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
    ];

    List<ColorSpace> _onlyColorSpaces = _colorWidgets.map((entry) => entry['colorSpace'] as ColorSpace).toList();

    Column _widget = Column(
      children: <Widget>[
        GCWDropDown(
          value: _currentColorSpace,
          onChanged: (newValue) {
            setState(() {
              _currentColor = convertColorSpace(_currentColor, _currentColorSpace, newValue);
              _currentColorSpace = newValue;

              _setCurrentValueAndEmitOnChange();
            });
          },
          items: _onlyColorSpaces.map((colorSpace) {
            return GCWDropDownMenuItem(
              value: colorSpace.key,
              child: i18n(context, colorSpace.name),
            );
          }).toList(),
        ),
      ],
    );

    var _currentWidget = _colorWidgets.firstWhere((entry) => entry['colorSpace'].key == _currentColorSpace)['widget'];

    _widget.children.add(_currentWidget);

    return _widget;
  }

  _setCurrentValueAndEmitOnChange() {
    widget.onChanged({'colorSpace': _currentColorSpace, 'color': _currentColor});
  }
}
