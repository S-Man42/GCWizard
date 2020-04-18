enum _ResistorType {THREE_BAND, FOUR_BAND, FIVE_BAND, SIX_BAND}

enum _ResistorBandType {FIRST, SECOND, THIRD, MULTIPLIER, TOLERANCE, TEMPERATURE_COEFFICIENT}

// source: https://en.wikipedia.org/wiki/Electronic_color_code#cite_note-IEC_60062_2016ECC-7
enum ResistorBandColor{PINK, SILVER, GOLD, BLACK, BROWN, RED, ORANGE, YELLOW, GREEN, BLUE, VIOLET, GREY, WHITE}

// source: https://de.wikipedia.org/wiki/Widerstand_(Bauelement)#Angaben_auf_Widerst%C3%A4nden
final Map<ResistorBandColor, Map<_ResistorBandType, double>> _RESISTOR_VALUES_THREE_AND_FOUR_BANDS = {
  ResistorBandColor.PINK: {
    _ResistorBandType.MULTIPLIER: 1e-3
  },
  ResistorBandColor.SILVER: {
    _ResistorBandType.MULTIPLIER: 1e-2,
    _ResistorBandType.TOLERANCE: 0.1
  },
  ResistorBandColor.GOLD: {
    _ResistorBandType.MULTIPLIER: 1e-1,
    _ResistorBandType.TOLERANCE: 0.05
  },
  ResistorBandColor.BLACK: {
    _ResistorBandType.SECOND: 0,
    _ResistorBandType.MULTIPLIER: 1
  },
  ResistorBandColor.BROWN : {
    _ResistorBandType.FIRST: 10,
    _ResistorBandType.SECOND: 1,
    _ResistorBandType.MULTIPLIER: 10,
    _ResistorBandType.TOLERANCE: 0.01
  },
  ResistorBandColor.RED : {
    _ResistorBandType.FIRST: 20,
    _ResistorBandType.SECOND: 2,
    _ResistorBandType.MULTIPLIER: 1e2,
    _ResistorBandType.TOLERANCE: 0.02
  },
  ResistorBandColor.ORANGE : {
    _ResistorBandType.FIRST: 30,
    _ResistorBandType.SECOND: 3,
    _ResistorBandType.MULTIPLIER: 1e3
  },
  ResistorBandColor.YELLOW : {
    _ResistorBandType.FIRST: 40,
    _ResistorBandType.SECOND: 4,
    _ResistorBandType.MULTIPLIER: 1e4
  },
  ResistorBandColor.GREEN : {
    _ResistorBandType.FIRST: 50,
    _ResistorBandType.SECOND: 5,
    _ResistorBandType.MULTIPLIER: 1e5,
    _ResistorBandType.TOLERANCE: 0.005
  },
  ResistorBandColor.BLUE : {
    _ResistorBandType.FIRST: 60,
    _ResistorBandType.SECOND: 6,
    _ResistorBandType.MULTIPLIER: 1e6,
    _ResistorBandType.TOLERANCE: 0.0025
  },
  ResistorBandColor.VIOLET : {
    _ResistorBandType.FIRST: 70,
    _ResistorBandType.SECOND: 7,
    _ResistorBandType.MULTIPLIER: 1e7,
    _ResistorBandType.TOLERANCE: 0.001
  },
  ResistorBandColor.GREY : {
    _ResistorBandType.FIRST: 80,
    _ResistorBandType.SECOND: 8,
    _ResistorBandType.MULTIPLIER: 1e8,
    _ResistorBandType.TOLERANCE: 0.0005
  },
  ResistorBandColor.WHITE : {
    _ResistorBandType.FIRST: 90,
    _ResistorBandType.SECOND: 9,
    _ResistorBandType.MULTIPLIER: 1e9
  }
};

// source: Temperature coefficient: https://web.archive.org/web/20180723125246/https://www.sis.se/api/document/preview/8021442/
final Map<ResistorBandColor, Map<_ResistorBandType, double>> _RESISTOR_VALUES_FIVE_AND_SIX_BANDS = {
  ResistorBandColor.PINK: {
    _ResistorBandType.MULTIPLIER: 1e-3
  },
  ResistorBandColor.SILVER: {
    _ResistorBandType.MULTIPLIER: 1e-2,
    _ResistorBandType.TOLERANCE: 0.1
  },
  ResistorBandColor.GOLD: {
    _ResistorBandType.MULTIPLIER: 1e-1,
    _ResistorBandType.TOLERANCE: 0.05
  },
  ResistorBandColor.BLACK: {
    _ResistorBandType.SECOND: 0,
    _ResistorBandType.THIRD: 0,
    _ResistorBandType.MULTIPLIER: 1,
    _ResistorBandType.TEMPERATURE_COEFFICIENT: 250
  },
  ResistorBandColor.BROWN : {
    _ResistorBandType.FIRST: 100,
    _ResistorBandType.SECOND: 10,
    _ResistorBandType.THIRD: 1,
    _ResistorBandType.MULTIPLIER: 10,
    _ResistorBandType.TOLERANCE: 0.01,
    _ResistorBandType.TEMPERATURE_COEFFICIENT: 100
  },
  ResistorBandColor.RED : {
    _ResistorBandType.FIRST: 200,
    _ResistorBandType.SECOND: 20,
    _ResistorBandType.THIRD: 2,
    _ResistorBandType.MULTIPLIER: 1e2,
    _ResistorBandType.TOLERANCE: 0.02,
    _ResistorBandType.TEMPERATURE_COEFFICIENT: 50
  },
  ResistorBandColor.ORANGE : {
    _ResistorBandType.FIRST: 300,
    _ResistorBandType.SECOND: 30,
    _ResistorBandType.THIRD: 3,
    _ResistorBandType.MULTIPLIER: 1e3,
    _ResistorBandType.TEMPERATURE_COEFFICIENT: 15
  },
  ResistorBandColor.YELLOW : {
    _ResistorBandType.FIRST: 400,
    _ResistorBandType.SECOND: 40,
    _ResistorBandType.THIRD: 4,
    _ResistorBandType.MULTIPLIER: 1e4,
    _ResistorBandType.TEMPERATURE_COEFFICIENT: 25
  },
  ResistorBandColor.GREEN : {
    _ResistorBandType.FIRST: 500,
    _ResistorBandType.SECOND: 50,
    _ResistorBandType.THIRD: 5,
    _ResistorBandType.MULTIPLIER: 1e5,
    _ResistorBandType.TOLERANCE: 0.005,
    _ResistorBandType.TEMPERATURE_COEFFICIENT: 20
  },
  ResistorBandColor.BLUE : {
    _ResistorBandType.FIRST: 600,
    _ResistorBandType.SECOND: 60,
    _ResistorBandType.THIRD: 6,
    _ResistorBandType.MULTIPLIER: 1e6,
    _ResistorBandType.TOLERANCE: 0.0025,
    _ResistorBandType.TEMPERATURE_COEFFICIENT: 10
  },
  ResistorBandColor.VIOLET : {
    _ResistorBandType.FIRST: 700,
    _ResistorBandType.SECOND: 70,
    _ResistorBandType.THIRD: 7,
    _ResistorBandType.MULTIPLIER: 1e7,
    _ResistorBandType.TOLERANCE: 0.001,
    _ResistorBandType.TEMPERATURE_COEFFICIENT: 5
  },
  ResistorBandColor.GREY : {
    _ResistorBandType.FIRST: 800,
    _ResistorBandType.SECOND: 80,
    _ResistorBandType.THIRD: 8,
    _ResistorBandType.MULTIPLIER: 1e8,
    _ResistorBandType.TOLERANCE: 0.0005,
    _ResistorBandType.TEMPERATURE_COEFFICIENT: 1
  },
  ResistorBandColor.WHITE : {
    _ResistorBandType.FIRST: 900,
    _ResistorBandType.SECOND: 90,
    _ResistorBandType.THIRD: 9,
    _ResistorBandType.MULTIPLIER: 1e9
  }
};

class ResistorValue{
  final double value;
  final double tolerance;
  final double temperatureCoefficient;

  const ResistorValue(this.value, this.tolerance, {this.temperatureCoefficient});

  List<double> get tolerancedValueInterval {
    return [value - value * tolerance, value + value * tolerance];
  }
}

double _getResistorValueByTypeAndColor(_ResistorType type, _ResistorBandType bandType, ResistorBandColor color, ) {
  switch (type) {
    case _ResistorType.THREE_BAND:
    case _ResistorType.FOUR_BAND:
      var colorValues = _RESISTOR_VALUES_THREE_AND_FOUR_BANDS[color];
      return colorValues == null ? null : colorValues[bandType];
    case _ResistorType.FIVE_BAND:
    case _ResistorType.SIX_BAND:
      var colorValues = _RESISTOR_VALUES_FIVE_AND_SIX_BANDS[color];
      return colorValues == null ? null : colorValues[bandType];
  }
}

ResistorValue _getThreeOrFourBandResistorValue(_ResistorType type, List<ResistorBandColor> colors) {
  var value = (_getResistorValueByTypeAndColor(type, _ResistorBandType.FIRST, colors[0]) ?? 0.0)
      + (_getResistorValueByTypeAndColor(type, _ResistorBandType.SECOND, colors[1]) ?? 0.0);

  value *= _getResistorValueByTypeAndColor(type, _ResistorBandType.MULTIPLIER, colors[2]);

  var tolerance = 0.2;
  if (type == _ResistorType.FOUR_BAND) {
    tolerance = _getResistorValueByTypeAndColor(type, _ResistorBandType.TOLERANCE, colors[3]);
  }

  return ResistorValue(value, tolerance);
}

ResistorValue _getFiveOrSixBandResistorValue(_ResistorType type, List<ResistorBandColor> colors) {
  var value = (_getResistorValueByTypeAndColor(type, _ResistorBandType.FIRST, colors[0]) ?? 0.0)
      + (_getResistorValueByTypeAndColor(type, _ResistorBandType.SECOND, colors[1]) ?? 0.0)
      + (_getResistorValueByTypeAndColor(type, _ResistorBandType.THIRD, colors[2]) ?? 0.0);

  value *= _getResistorValueByTypeAndColor(type, _ResistorBandType.MULTIPLIER, colors[3]);

  var tolerance = _getResistorValueByTypeAndColor(type, _ResistorBandType.TOLERANCE, colors[4]);

  var temperaturCoefficient = null;
  if (type == _ResistorType.SIX_BAND) {
    temperaturCoefficient = _getResistorValueByTypeAndColor(type, _ResistorBandType.TEMPERATURE_COEFFICIENT, colors[5]);
  }

  return ResistorValue(value, tolerance, temperatureCoefficient: temperaturCoefficient);
}

ResistorValue getResistorValue(List<ResistorBandColor> colors) {
  if (colors == null)
    return null;

  switch (colors.length) {
    case 3: return _getThreeOrFourBandResistorValue(_ResistorType.THREE_BAND, colors);
    case 4: return _getThreeOrFourBandResistorValue(_ResistorType.FOUR_BAND, colors);
    case 5: return _getFiveOrSixBandResistorValue(_ResistorType.FIVE_BAND, colors);
    case 6: return _getFiveOrSixBandResistorValue(_ResistorType.SIX_BAND, colors);
  }

  return null;
}