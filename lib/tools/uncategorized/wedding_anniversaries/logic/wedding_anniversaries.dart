import 'dart:convert';
import 'dart:core';

import 'package:flutter/services.dart';

void main() {
  Future<void> loadJson() async {
    String jsonString = await rootBundle
        .loadString(
        "tools/uncategorized/wedding_anniversaries/assets/wedding_anniversaries.json");
    print(jsonString);
    // Map<String, Map<String, List<String>>>? jsonData = jsonDecode(jsonString);
  }

  loadJson();
}

