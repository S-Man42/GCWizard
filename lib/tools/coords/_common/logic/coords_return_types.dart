import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';

class CoordsFormatValue{
  CoordFormatKey type;
  CoordFormatKey? subtype;

  CoordsFormatValue(this.type, [this.subtype]);
}