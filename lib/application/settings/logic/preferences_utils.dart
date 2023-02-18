import 'package:prefs/prefs.dart';

enum PrefType { STRING, STRINGLIST, INT, DOUBLE, BOOL }

PrefType getPrefType(String key) {
  try {
    String x = Prefs.getString(key);
    return PrefType.STRING;
  } catch (e) {}

  try {
    List<String> x = Prefs.getStringList(key);
    return PrefType.STRINGLIST;
  } catch (e) {}

  //TODO: Necessary? Where does this come from?
  // try {
  //   List<Object> x = Prefs.get(key);
  //   return PrefType.STRINGLIST;
  // } catch (e) {}

  try {
    int x = Prefs.getInt(key);
    return PrefType.INT;
  } catch (e) {}

  try {
    double x = Prefs.getDouble(key);
    return PrefType.DOUBLE;
  } catch (e) {}

  try {
    bool x = Prefs.getBool(key);
    return PrefType.BOOL;
  } catch (e) {}

  throw Exception('Unexpected Preference Type');
}

void setUntypedPref(String key, Object value) {
  switch (getPrefType(key)) {
    case PrefType.STRING:
      Prefs.setString(key, value.toString());
      break;
    case PrefType.INT:
      if (value is int) Prefs.setInt(key, value);
      break;
    case PrefType.DOUBLE:
      if (value is double) Prefs.setDouble(key, value);
      break;
    case PrefType.BOOL:
      if (value is bool) Prefs.setBool(key, value);
      break;
    case PrefType.STRINGLIST:

      if (value is List<String> || value is List<Object>) {
        var saveList = <String>[];
        if (value is List<String>) {
          saveList = value;
          saveList.removeWhere((element) => element.isEmpty);
        } else {
          (value as List<Object>).forEach((element) => saveList.add(element.toString()));
        }

        Prefs.setStringList(key, saveList);
      }
      break;
  }
}