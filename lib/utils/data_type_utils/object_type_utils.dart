double? toDoubleOrNull(Object? value) {
  if (value is double)
    return value;
  else if (value is int)
    return (value).toDouble();

  return null;
}

int? toIntOrNull(Object? value) {
  if (value is int)
    return value;
  else if (value is double)
    // .0 check
    if (value == (value).toInt())
      return (value).toInt();

  return null;
}

bool? toBoolOrNull(Object? value) {
  if (value is bool)
    return value;

  return null;
}

String? toStringOrNull(Object? value) {
  return (value == null) ? null : value.toString();
}

List<String>? toStringListOrNull(List<Object?>? list) {
  if (list == null) return null;

  var stringList = <String>[];
  for (var i = 0; i < list.length; i++) {
    stringList.add(toStringOrNull(list[i]) ?? '');
  }

  return stringList;
}

List<String?>? toStringListWithNullableContentOrNull(List<Object?>? list) {
  if (list == null) return null;

  var stringList = <String?>[];
  for (var i = 0; i < list.length; i++) {
    stringList.add(toStringOrNull(list[i]));
  }

  return stringList;
}