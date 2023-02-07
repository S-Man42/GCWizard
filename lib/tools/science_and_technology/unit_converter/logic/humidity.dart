import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/unit.dart';

class Humidity extends Unit {
  late Function toDegree;
  late Function fromDegree;

  Humidity({required String name, required String symbol, bool isReference: false, required double inDegree})
      : super(name, symbol, isReference, (e) => e * inDegree, (e) => e / inDegree) {
    toDegree = this.toReference;
    fromDegree = this.fromReference;
  }
}

final HUMIDITY = Humidity(
  name: 'common_unit_humidity_name',
  symbol: '%',
  inDegree: 1.0,
  isReference: true,
);

final List<Unit> humidity = [HUMIDITY];
