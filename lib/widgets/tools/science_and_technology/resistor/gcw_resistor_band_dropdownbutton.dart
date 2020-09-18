import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/resistor.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';

class GCWResistorBandDropDownButton extends StatefulWidget {
  final Function onChanged;
  final ResistorBandType type;
  final int numberBands;
  final ResistorBandColor color;

  const GCWResistorBandDropDownButton({
    Key key,
    this.color,
    this.type,
    this.numberBands,
    this.onChanged
  }) : super(key: key);

  @override
  GCWResistorBandDropDownButtonState createState() => GCWResistorBandDropDownButtonState();
}

class GCWResistorBandDropDownButtonState extends State<GCWResistorBandDropDownButton> {

  final _colorAttributes = {
    ResistorBandColor.PINK: _ResistorColorAttributes('common_color_pink', Color(0xffffb6c1), Colors.black),
    ResistorBandColor.SILVER: _ResistorColorAttributes('common_color_silver', Color(0xffd3d3d3), Colors.black),
    ResistorBandColor.GOLD: _ResistorColorAttributes('common_color_gold', Color(0xffdaa520), Colors.black),
    ResistorBandColor.BLACK: _ResistorColorAttributes('common_color_black', Color(0xff000000), Colors.white),
    ResistorBandColor.BROWN: _ResistorColorAttributes('common_color_brown', Color(0xffa0522d), Colors.white),
    ResistorBandColor.RED: _ResistorColorAttributes('common_color_red', Color(0xffff0000), Colors.white),
    ResistorBandColor.ORANGE: _ResistorColorAttributes('common_color_orange', Color(0xffff8c00), Colors.black),
    ResistorBandColor.YELLOW: _ResistorColorAttributes('common_color_yellow', Color(0xffffff00), Colors.black),
    ResistorBandColor.GREEN: _ResistorColorAttributes('common_color_green', Color(0xff32cd32), Colors.black),
    ResistorBandColor.BLUE: _ResistorColorAttributes('common_color_blue', Color(0xff4169e1), Colors.white),
    ResistorBandColor.VIOLET: _ResistorColorAttributes('common_color_violet', Color(0xff9400d3), Colors.white),
    ResistorBandColor.GREY: _ResistorColorAttributes('common_color_grey', Color(0xff808080), Colors.white),
    ResistorBandColor.WHITE: _ResistorColorAttributes('common_color_white', Color(0xffffffff), Colors.black),
  };

  var _colors;
  Map<ResistorBandColor, double> _colorValues;

  var _currentValue = ResistorBandColor.BROWN;

  @override
  void initState() {
    super.initState();

    if (widget.color != null)
      _currentValue = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    _colors = getResistorColorsByBandType(widget.type);
    _colorValues = getResistorBandValues(widget.numberBands, widget.type, _colors);

    return GCWDropDownButton(
      value: _currentValue,
      items: _colorValues.entries
        .map((colorValue) {
          var textStyle = TextStyle(
            color: _colorAttributes[colorValue.key].textColor
          );

          return DropdownMenuItem(
            value: colorValue.key,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    color: _colorAttributes[colorValue.key].backgroundColor,
                    child: Row(
                      children: [
                        Expanded(
                          child: GCWText(
                            text: i18n(context, _colorAttributes[colorValue.key].name) + ':',
                            style: textStyle
                          ),
                          flex: 1
                        ),
                        Expanded(
                          child: Text(
                            _formatValue(colorValue.value),
                            style: textStyle
                          ),
                          flex: 2
                        )
                      ],
                    )
                  )
                )
              ]
            ),
          );
        })
        .toList(),
      onChanged: (value) {
        setState(() {
          _currentValue = value;
          _setCurrentValueAndEmitOnChange();
        });
      },
    );
  }

  _setCurrentValueAndEmitOnChange() {
    widget.onChanged(_currentValue);
  }

  _formatValue(value) {
    switch(widget.type) {
      case ResistorBandType.FIRST:
      case ResistorBandType.SECOND:
      case ResistorBandType.THIRD:
        return formatResistorValue(value);
      case ResistorBandType.MULTIPLIER:
        return formatResistorMultiplier(value);
      case ResistorBandType.TOLERANCE:
        return formatResistorTolerance(value);
      case ResistorBandType.TEMPERATURE_COEFFICIENT:
        return formatResistorTemperatureCoefficient(value);
    }
  }
}

class _ResistorColorAttributes {
  String name;
  Color backgroundColor;
  Color textColor;

  _ResistorColorAttributes(this.name, this.backgroundColor, this.textColor);
}