abstract class Unit{
  String name;
  String symbol;
  bool isReferenceUnit;
  Function toReference;
  Function fromReference;

  Unit(this.name, this.symbol, this.isReferenceUnit, this.toReference, this.fromReference) {
    if (this.isReferenceUnit) {
      toReference = (e) => e;
      fromReference = (e) => e;
    }
  }
}

Unit getUnitBySymbol(List<Unit> units, String symbol) {
  return units.firstWhere((unit) => unit.symbol == symbol);
}

Unit getReferenceUnit(List<Unit> units) {
  return units.firstWhere((unit) => unit.isReferenceUnit == true);
}