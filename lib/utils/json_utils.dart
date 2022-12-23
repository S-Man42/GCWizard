
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
    return (value as double).toInt();

  return null;
}

bool jsonBool(dynamic value) {
  if (value is bool)
    return value;

  return null;
}

String jsonString(dynamic value) {
    return value;
}

List<String> jsonStringList(List<dynamic> list) {
  if (list == null) return null;
  for (var i = 0; i < list.length; i++)
    list[i] = jsonString(list[i]);

  return list;
}
