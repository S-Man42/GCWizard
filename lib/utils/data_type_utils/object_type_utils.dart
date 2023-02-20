bool isDouble(Object? value) {
  if (value == null) return false;

  return (value is double);
}

bool isInt(Object? value) {
  if (value == null) return false;

  return (value is int);
}

bool isBool(Object? value) {
  if (value == null) return false;

  return (value is bool);
}

bool isString(Object? value) {
  if (value == null) return false;

  return (value is String);
}

bool isObjectList(Object? value) {
  if (value == null) return false;

  return (value is List<Object?>);
}

double? toDoubleOrNull(Object? value) {
  if (isDouble(value))
    return value as double;
  else if (isInt(value))
    return (value as int).toDouble();

  return null;
}

int? toIntOrNull(Object? value) {
  if (isInt(value))
    return value as int;
  else if (isDouble(value)) {
    double val = value as double;
    if (val == val.toInt())
      return val.toInt();
  }

  return null;
}

bool? toBoolOrNull(Object? value) {
  if (isBool(value))
    return value as bool;

  return null;
}

String? toStringOrNull(Object? value) {
  if (isString(value))
    return value as String;

  return null;
}

List<String>? toStringListOrNull(Object? value) {
  if (!isObjectList(value)) return null;

  var list = value as List<Object?>;
  var stringList = <String>[];
  for (var i = 0; i < list.length; i++) {
    stringList.add(toStringOrNull(list[i]) ?? '');
  }

  return stringList;
}

List<String?>? toStringListWithNullableContentOrNull(Object? value) {
  if (!isObjectList(value)) return null;

  var list = value as List<Object?>;
  var stringList = <String?>[];
  for (var i = 0; i < list.length; i++) {
    stringList.add(toStringOrNull(list[i]));
  }

  return stringList;
}

List<Object?>? toObjectWithNullableContentListOrNull(Object? value) {
  if (!isObjectList(value)) return null;

  var list = value as List<Object?>;
  var objectList = <Object?>[];
  for (var i = 0; i < list.length; i++) {
    objectList.add(list[i]);
  }

  return objectList;
}