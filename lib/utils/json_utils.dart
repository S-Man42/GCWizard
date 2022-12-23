
double jsonDouble(dynamic value) {
  if (value is double)
    return value;
  else if (value is int)
    return (value as int).toDouble();

  return null;
}

int jsonInt(dynamic value) {
  if (value is int)
    return value;
  else if (value is double)
    // .0 check
    if ((value as double) == (value as double).toInt())
      return (value as double).toInt();

  return null;
}

bool jsonBool(dynamic value) {
  if (value is bool)
    return value;

  return null;
}

String jsonString(dynamic value) {
  return (value == null) ? null : value.toString();
}

List<String> jsonStringList(List<dynamic> list) {
  if (list == null) return null;

  var stringList =<String>[];
  for (var i = 0; i < list.length; i++)
    stringList.add(jsonString(list[i]));

  return stringList;
}
