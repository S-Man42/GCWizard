// Annotate with this class to enable reflection.
import 'package:reflectable/reflectable.dart';

class Reflector extends Reflectable {
  const Reflector()
      : super(
      invokingCapability,
  ); // Request the capability to invoke methods.
}

const reflector = const Reflector();