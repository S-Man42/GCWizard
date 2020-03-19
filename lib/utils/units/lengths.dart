class Length {
  final String unit;
  final double inMeters;

  Length(this.unit, this.inMeters);
}

final List<Length> allLengths = [
  Length('m', 1.0),
  Length('km', 1000.0),
  Length('nm', 1852.0),
  Length('ft', 0.3048),
];

Length getLengthByUnit(String unit) {
  return allLengths.firstWhere((l) => l.unit == unit);
}

final defaultLength = getLengthByUnit('m');