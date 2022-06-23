import 'package:reflectable/reflectable.dart';

/************* Never Remove this import! *************/
import 'package:gc_wizard/configuration/reflectors/gcw_tool_reflected_classes.dart';

class GCWToolReflector extends Reflectable {
  const GCWToolReflector()
      : super(
      invokingCapability,
      subtypeQuantifyCapability
  ); // Request the capability to invoke methods.
}