import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';

class CoordsValue{
  CoordsFormatValue format;
  BaseCoordinates value;

  CoordsValue(this.format, this.value);
}

class CoordsFormatValue{
  final CoordFormatKey format;
  final CoordFormatKey? subtype;

  CoordsFormatValue(this.format, [this.subtype]);
}