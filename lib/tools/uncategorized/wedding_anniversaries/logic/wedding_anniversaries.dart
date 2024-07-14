part 'package:gc_wizard/tools/uncategorized/wedding_anniversaries/logic/wedding_anniversaries_data.dart';

enum WeddingCountry { DE, UK, US, NL, DK, SW, FR, IT, ES }

Map<String, List<String>> _countryAnniversaries (WeddingCountry country) {
  switch (country) {
    case WeddingCountry.DE:
      return _anniversariesDE;
    case WeddingCountry.UK:
      return _anniversariesUK;
    case WeddingCountry.US:
      return _anniversariesUS;
    case WeddingCountry.NL:
      return _anniversariesNL;
    case WeddingCountry.DK:
      return _anniversariesDK;
    case WeddingCountry.SW:
      return _anniversariesSW;
    case WeddingCountry.FR:
      return _anniversariesFR;
    case WeddingCountry.IT:
      return _anniversariesIT;
    case WeddingCountry.ES:
      return _anniversariesES;
  }
}

String getItems(WeddingCountry country, String year) {
  var anniversaryList = _countryAnniversaries(country);
  var items = anniversaryList[year];
  return (items != null) ? items.join(", ") : '';
}

String getAllItems (String year) {
  List<String> allItems = [];
  for (WeddingCountry country in WeddingCountry.values) {
    var items = getItems(country, year);
    if (items.isNotEmpty) {
      allItems.add("${country.name}: $items");
    }
  }
  return allItems.join("\n");
}

Iterable<String> getAvailableYears(WeddingCountry country) {
  return _countryAnniversaries(country).keys;
}

String getYearFromItem(WeddingCountry country, String item) {
  var anniversaryList = _countryAnniversaries(country);
  List<String> years = [];
  for (var entry in anniversaryList.entries){
    if (entry.value.contains(item)) {
      years.add(entry.key);
    }
  }
  return years.join(", ");
}
