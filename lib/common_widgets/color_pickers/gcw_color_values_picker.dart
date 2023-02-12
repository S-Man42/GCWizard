part of 'package:gc_wizard/common_widgets/color_pickers/gcw_colors.dart';

class GCWColorValue {
  ColorSpaceKey colorSpace;
  GCWBaseColor color;

  GCWColorValue(this.colorSpace, this.color);
}

class _GCWColorValuesPicker extends StatefulWidget {
  final void Function(GCWColorValue) onChanged;
  final GCWColorValue colorsValue;

  const _GCWColorValuesPicker({Key? key, required this.onChanged, required this.colorsValue}) : super(key: key);

  @override
  _GCWColorValuesPickerState createState() => _GCWColorValuesPickerState();
}

class _GCWColorValuesPickerState extends State<_GCWColorValuesPicker> {
  var _currentColorsValue = GCWColorValue(defaultColorSpace, defaultColor);
  
  @override
  Widget build(BuildContext context) {
    _currentColorsValue = GCWColorValue(widget.colorsValue.colorSpace, widget.colorsValue.color);

    List<Map<String, dynamic>> _colorWidgets = [
      {
        'colorSpace': getColorSpaceByKey(ColorSpaceKey.RGB),
        'widget': _GCWColorRGB(
          color: _currentColorsValue.colorSpace == ColorSpaceKey.RGB ? _currentColorsValue.color as RGB : null,
          onChanged: (RGB newValue) {
            setState(() {
              _currentColorsValue.color = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(ColorSpaceKey.HEXCODE),
        'widget': _GCWColorHexCode(
          color: _currentColorsValue.colorSpace == ColorSpaceKey.HEXCODE ? _currentColorsValue.color as HexCode : null,
          onChanged: (HexCode newValue) {
            setState(() {
              _currentColorsValue.color = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(ColorSpaceKey.HSV),
        'widget': _ColorHSV(
          color: _currentColorsValue.colorSpace == ColorSpaceKey.HSV ? _currentColorsValue.color as HSV : null,
          onChanged: (HSV newValue) {
            setState(() {
              _currentColorsValue.color = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(ColorSpaceKey.HSL),
        'widget': _GCWColorHSL(
          color: _currentColorsValue.colorSpace == ColorSpaceKey.HSL ? _currentColorsValue.color as HSL : null,
          onChanged: (HSL newValue) {
            setState(() {
              _currentColorsValue.color = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(ColorSpaceKey.HSI),
        'widget': _GCWColorHSI(
          color: _currentColorsValue.colorSpace == ColorSpaceKey.HSI ? _currentColorsValue.color as HSI : null,
          onChanged: (HSI newValue) {
            setState(() {
              _currentColorsValue.color = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(ColorSpaceKey.CMYK),
        'widget': _GCWColorCMYK(
          color: _currentColorsValue.colorSpace == ColorSpaceKey.CMYK ? _currentColorsValue.color as CMYK : null,
          onChanged: (CMYK newValue) {
            setState(() {
              _currentColorsValue.color = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(ColorSpaceKey.CMY),
        'widget': _GCWColorCMY(
          color: _currentColorsValue.colorSpace == ColorSpaceKey.CMY ? _currentColorsValue.color as CMY : null,
          onChanged: (CMY newValue) {
            setState(() {
              _currentColorsValue.color = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(ColorSpaceKey.YUV),
        'widget': _GCWColorYUV(
          color: _currentColorsValue.colorSpace == ColorSpaceKey.YUV ? _currentColorsValue.color as YUV : null,
          onChanged: (YUV newValue) {
            setState(() {
              _currentColorsValue.color = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(ColorSpaceKey.YPBPR),
        'widget': _GCWColorYPbPr(
          color: _currentColorsValue.colorSpace == ColorSpaceKey.YPBPR ? _currentColorsValue.color as YPbPr : null,
          onChanged: (YPbPr newValue) {
            setState(() {
              _currentColorsValue.color = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(ColorSpaceKey.YCBCR),
        'widget': _GCWColorYCbCr(
          color: _currentColorsValue.colorSpace == ColorSpaceKey.YCBCR ? _currentColorsValue.color as YCbCr : null,
          onChanged: (YCbCr newValue) {
            setState(() {
              _currentColorsValue.color = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
      {
        'colorSpace': getColorSpaceByKey(ColorSpaceKey.YIQ),
        'widget': _GCWColorYIQ(
          color: _currentColorsValue.colorSpace == ColorSpaceKey.YIQ ? _currentColorsValue.color as YIQ: null,
          onChanged: (YIQ newValue) {
            setState(() {
              _currentColorsValue.color = newValue;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ),
      },
    ];

    List<ColorSpace> _onlyColorSpaces = _colorWidgets.map((entry) => entry['colorSpace'] as ColorSpace).toList();

    Column _widget = Column(
      children: <Widget>[
        GCWDropDown<ColorSpaceKey>(
          value: _currentColorsValue.colorSpace,
          onChanged: (ColorSpaceKey newValue) {
            setState(() {
              _currentColorsValue.color = convertColorSpace(_currentColorsValue.color, _currentColorsValue.colorSpace, newValue);
              _currentColorsValue.colorSpace = newValue;

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

    var _currentWidget = _colorWidgets.firstWhere((entry) => entry['colorSpace'].key == _currentColorsValue.colorSpace)['widget'];

    _widget.children.add(_currentWidget);

    return _widget;
  }

  _setCurrentValueAndEmitOnChange() {
    widget.onChanged(_currentColorsValue);
  }
}
