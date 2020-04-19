import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/resistor.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/resistor/gcw_resistor_band_dropdownbutton.dart';

class Resistor extends StatefulWidget {
  @override
  ResistorState createState() => ResistorState();
}

class ResistorState extends State<Resistor> {
  var _currentNumberBands = 3;
  List<GCWResistorBandDropDownButton> _currentBands = [];
  List<ResistorBandColor> _currentBandColors = [
    ResistorBandColor.BROWN,
    ResistorBandColor.BROWN,
    ResistorBandColor.BROWN,
    ResistorBandColor.BROWN,
    ResistorBandColor.BROWN,
    ResistorBandColor.BROWN,
  ];


  Widget _bands = Column();
  var _output = '';

  var _resistorBandDropDownButton_fourBands_first;
  var _resistorBandDropDownButton_fourBands_second;
  var _resistorBandDropDownButton_fourBands_multiplier;
  var _resistorBandDropDownButton_fourBands_tolerance;
  var _resistorBandDropDownButton_sixBands_first;
  var _resistorBandDropDownButton_sixBands_second;
  var _resistorBandDropDownButton_sixBands_third;
  var _resistorBandDropDownButton_sixBands_multiplier;
  var _resistorBandDropDownButton_sixBands_tolerance;
  var _resistorBandDropDownButton_sixBands_temperatureCoefficient;

  @override
  void initState() {
    super.initState();

    _resistorBandDropDownButton_fourBands_first = GCWResistorBandDropDownButton(
      color: _currentBandColors[0],
      type: ResistorBandType.FIRST,
      numberBands: 4,
      onChanged: (color) {
        setState(() {
          _currentBandColors[0] = color;
        });
      },
    );

    _resistorBandDropDownButton_fourBands_second = GCWResistorBandDropDownButton(
      color: _currentBandColors[1],
      type: ResistorBandType.SECOND,
      numberBands: 4,
      onChanged: (color) {
        setState(() {
          _currentBandColors[1] = color;
        });
      },
    );

    _resistorBandDropDownButton_fourBands_multiplier = GCWResistorBandDropDownButton(
      color: _currentBandColors[2],
      type: ResistorBandType.MULTIPLIER,
      numberBands: 4,
      onChanged: (color) {
        setState(() {
          _currentBandColors[2] = color;
        });
      },
    );

    _resistorBandDropDownButton_fourBands_tolerance = GCWResistorBandDropDownButton(
      color: _currentBandColors[3],
      type: ResistorBandType.TOLERANCE,
      numberBands: 4,
      onChanged: (color) {
        setState(() {
          _currentBandColors[3] = color;
        });
      },
    );

    _resistorBandDropDownButton_sixBands_first = GCWResistorBandDropDownButton(
      color: _currentBandColors[0],
      type: ResistorBandType.FIRST,
      numberBands: 6,
      onChanged: (color) {
        setState(() {
          _currentBandColors[0] = color;
        });
      },
    );

    _resistorBandDropDownButton_sixBands_second = GCWResistorBandDropDownButton(
      color: _currentBandColors[1],
      type: ResistorBandType.SECOND,
      numberBands: 6,
      onChanged: (color) {
        setState(() {
          _currentBandColors[1] = color;
        });
      },
    );

    _resistorBandDropDownButton_sixBands_third = GCWResistorBandDropDownButton(
      color: _currentBandColors[2],
      type: ResistorBandType.THIRD,
      numberBands: 6,
      onChanged: (color) {
        setState(() {
          _currentBandColors[2] = color;
        });
      },
    );

    _resistorBandDropDownButton_sixBands_multiplier = GCWResistorBandDropDownButton(
      color: _currentBandColors[3],
      type: ResistorBandType.MULTIPLIER,
      numberBands: 6,
      onChanged: (color) {
        setState(() {
          _currentBandColors[3] = color;
        });
      },
    );

    _resistorBandDropDownButton_sixBands_tolerance = GCWResistorBandDropDownButton(
      color: _currentBandColors[4],
      type: ResistorBandType.TOLERANCE,
      numberBands: 6,
      onChanged: (color) {
        setState(() {
          _currentBandColors[4] = color;
        });
      },
    );

    _resistorBandDropDownButton_sixBands_temperatureCoefficient = GCWResistorBandDropDownButton(
      color: _currentBandColors[5],
      type: ResistorBandType.TEMPERATURE_COEFFICIENT,
      numberBands: 6,
      onChanged: (color) {
        setState(() {
          _currentBandColors[5] = color;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWIntegerSpinner(
          title: 'Number Bands',
          min: 3,
          max: 6,
          value: 3,
          onChanged: (value) {
            setState(() {
              _currentNumberBands = value;
              AppBuilde
            });
          },
        ),
        _buildBands(),
        GCWDefaultOutput(
          text: _output
        )
      ],
    );
  }

  _buildBands() {
    while (_currentBandColors.length < _currentNumberBands) {
      if (_currentBandColors.length == 4)
        _currentBandColors.insert(2, defaultResistorBandColor);
      else
        _currentBandColors.add(defaultResistorBandColor);
    }

    while (_currentBandColors.length > _currentNumberBands) {
      if (_currentBandColors.length == 5)
        _currentBandColors.removeAt(2);
      else
        _currentBandColors.removeLast();
    }

    print(_currentBandColors);

    _currentBands = [];
    switch (_currentNumberBands) {
      case 3:
      case 4:
        _currentBands.add(_resistorBandDropDownButton_fourBands_first);
        _currentBands.add(_resistorBandDropDownButton_fourBands_second);
        _currentBands.add(_resistorBandDropDownButton_fourBands_multiplier);

        if (_currentNumberBands == 4)
          _currentBands.add(_resistorBandDropDownButton_fourBands_tolerance);

        break;
      case 5:
      case 6:
        _currentBands.add(_resistorBandDropDownButton_sixBands_first);
        _currentBands.add(_resistorBandDropDownButton_sixBands_second);
        _currentBands.add(_resistorBandDropDownButton_sixBands_third);
        _currentBands.add(_resistorBandDropDownButton_sixBands_multiplier);
        _currentBands.add(_resistorBandDropDownButton_sixBands_tolerance);

        if (_currentNumberBands == 6)
          _currentBands.add(_resistorBandDropDownButton_sixBands_temperatureCoefficient);

        break;
    }

    print(_currentBands);

    return Padding(
      child: Column(
        children: _currentBands,
      ),
      padding: EdgeInsets.only(
        top: 10
      ),
    );
  }

  _calculateOutput() {
    _output = _currentBandColors.toString();
  }
}