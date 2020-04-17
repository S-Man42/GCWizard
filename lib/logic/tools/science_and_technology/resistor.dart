enum ResistorBandType {FIRST, SECOND, THIRD, MULTIPLIER, TOLERANCE, TEMPERATURE_COEFFICIENT}

// source: https://en.wikipedia.org/wiki/Electronic_color_code#cite_note-IEC_60062_2016ECC-7
enum ResistorBandColor{PINK, SILVER, GOLD, BLACK, BROWN, RED, ORANGE, YELLOW, GREEN, BLUE, VIOLET, GREY, WHITE}

// source: https://de.wikipedia.org/wiki/Widerstand_(Bauelement)#Angaben_auf_Widerst%C3%A4nden
final Map<ResistorBandColor, Map<ResistorBandType, double>> RESISTOR_VALUES_THREE_FOUR_BANDS = {
  ResistorBandColor.PINK: {
    ResistorBandType.MULTIPLIER: 10e-3
  },
  ResistorBandColor.SILVER: {
    ResistorBandType.MULTIPLIER: 10e-2,
    ResistorBandType.TOLERANCE: 0.1
  },
  ResistorBandColor.GOLD: {
    ResistorBandType.MULTIPLIER: 10e-1,
    ResistorBandType.TOLERANCE: 0.05
  },
  ResistorBandColor.BLACK: {
    ResistorBandType.SECOND: 0,
    ResistorBandType.MULTIPLIER: 1
  },
  ResistorBandColor.BROWN : {
    ResistorBandType.FIRST: 10,
    ResistorBandType.SECOND: 1,
    ResistorBandType.MULTIPLIER: 10,
    ResistorBandType.TOLERANCE: 0.01
  },
  ResistorBandColor.RED : {
    ResistorBandType.FIRST: 20,
    ResistorBandType.SECOND: 2,
    ResistorBandType.MULTIPLIER: 10e2,
    ResistorBandType.TOLERANCE: 0.02
  },
  ResistorBandColor.ORANGE : {
    ResistorBandType.FIRST: 30,
    ResistorBandType.SECOND: 3,
    ResistorBandType.MULTIPLIER: 10e3
  },
  ResistorBandColor.YELLOW : {
    ResistorBandType.FIRST: 40,
    ResistorBandType.SECOND: 4,
    ResistorBandType.MULTIPLIER: 10e4
  },
  ResistorBandColor.GREEN : {
    ResistorBandType.FIRST: 50,
    ResistorBandType.SECOND: 5,
    ResistorBandType.MULTIPLIER: 10e5,
    ResistorBandType.TOLERANCE: 0.005
  },
  ResistorBandColor.BLUE : {
    ResistorBandType.FIRST: 60,
    ResistorBandType.SECOND: 6,
    ResistorBandType.MULTIPLIER: 10e6,
    ResistorBandType.TOLERANCE: 0.0025
  },
  ResistorBandColor.VIOLET : {
    ResistorBandType.FIRST: 70,
    ResistorBandType.SECOND: 7,
    ResistorBandType.MULTIPLIER: 10e7,
    ResistorBandType.TOLERANCE: 0.001
  },
  ResistorBandColor.GREY : {
    ResistorBandType.FIRST: 80,
    ResistorBandType.SECOND: 8,
    ResistorBandType.MULTIPLIER: 10e8,
    ResistorBandType.TOLERANCE: 0.0005
  },
  ResistorBandColor.WHITE : {
    ResistorBandType.FIRST: 90,
    ResistorBandType.SECOND: 9,
    ResistorBandType.MULTIPLIER: 10e9
  }
};

// source: Temperature coefficient: https://web.archive.org/web/20180723125246/https://www.sis.se/api/document/preview/8021442/
final Map<ResistorBandColor, Map<ResistorBandType, double>> RESISTOR_VALUES_FIVE_SIX_BANDS = {
  ResistorBandColor.PINK: {
    ResistorBandType.MULTIPLIER: 10e-3
  },
  ResistorBandColor.SILVER: {
    ResistorBandType.MULTIPLIER: 10e-2,
    ResistorBandType.TOLERANCE: 0.1
  },
  ResistorBandColor.GOLD: {
    ResistorBandType.MULTIPLIER: 10e-1,
    ResistorBandType.TOLERANCE: 0.05
  },
  ResistorBandColor.BLACK: {
    ResistorBandType.SECOND: 0,
    ResistorBandType.THIRD: 0,
    ResistorBandType.MULTIPLIER: 1,
    ResistorBandType.TEMPERATURE_COEFFICIENT: 250
  },
  ResistorBandColor.BROWN : {
    ResistorBandType.FIRST: 100,
    ResistorBandType.SECOND: 10,
    ResistorBandType.THIRD: 1,
    ResistorBandType.MULTIPLIER: 10,
    ResistorBandType.TOLERANCE: 0.01,
    ResistorBandType.TEMPERATURE_COEFFICIENT: 100
  },
  ResistorBandColor.RED : {
    ResistorBandType.FIRST: 200,
    ResistorBandType.SECOND: 20,
    ResistorBandType.THIRD: 2,
    ResistorBandType.MULTIPLIER: 10e2,
    ResistorBandType.TOLERANCE: 0.02,
    ResistorBandType.TEMPERATURE_COEFFICIENT: 50
  },
  ResistorBandColor.ORANGE : {
    ResistorBandType.FIRST: 300,
    ResistorBandType.SECOND: 30,
    ResistorBandType.THIRD: 3,
    ResistorBandType.MULTIPLIER: 10e3,
    ResistorBandType.TEMPERATURE_COEFFICIENT: 15
  },
  ResistorBandColor.YELLOW : {
    ResistorBandType.FIRST: 400,
    ResistorBandType.SECOND: 40,
    ResistorBandType.THIRD: 4,
    ResistorBandType.MULTIPLIER: 10e4,
    ResistorBandType.TEMPERATURE_COEFFICIENT: 25
  },
  ResistorBandColor.GREEN : {
    ResistorBandType.FIRST: 500,
    ResistorBandType.SECOND: 50,
    ResistorBandType.THIRD: 5,
    ResistorBandType.MULTIPLIER: 10e5,
    ResistorBandType.TOLERANCE: 0.005,
    ResistorBandType.TEMPERATURE_COEFFICIENT: 20
  },
  ResistorBandColor.BLUE : {
    ResistorBandType.FIRST: 600,
    ResistorBandType.SECOND: 60,
    ResistorBandType.THIRD: 6,
    ResistorBandType.MULTIPLIER: 10e6,
    ResistorBandType.TOLERANCE: 0.0025,
    ResistorBandType.TEMPERATURE_COEFFICIENT: 10
  },
  ResistorBandColor.VIOLET : {
    ResistorBandType.FIRST: 700,
    ResistorBandType.SECOND: 70,
    ResistorBandType.THIRD: 7,
    ResistorBandType.MULTIPLIER: 10e7,
    ResistorBandType.TOLERANCE: 0.001,
    ResistorBandType.TEMPERATURE_COEFFICIENT: 5
  },
  ResistorBandColor.GREY : {
    ResistorBandType.FIRST: 800,
    ResistorBandType.SECOND: 80,
    ResistorBandType.THIRD: 8,
    ResistorBandType.MULTIPLIER: 10e8,
    ResistorBandType.TOLERANCE: 0.0005,
    ResistorBandType.TEMPERATURE_COEFFICIENT: 1
  },
  ResistorBandColor.WHITE : {
    ResistorBandType.FIRST: 900,
    ResistorBandType.SECOND: 90,
    ResistorBandType.THIRD: 9,
    ResistorBandType.MULTIPLIER: 10e9
  }
};