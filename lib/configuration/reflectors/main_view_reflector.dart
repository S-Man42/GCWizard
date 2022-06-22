// Annotate with this class to enable reflection.
import 'package:reflectable/reflectable.dart';

class GCWToolReflector extends Reflectable {
  const GCWToolReflector()
      : super(
      invokingCapability,
      subtypeQuantifyCapability
  ); // Request the capability to invoke methods.
}

const gcwToolReflector = const GCWToolReflector();