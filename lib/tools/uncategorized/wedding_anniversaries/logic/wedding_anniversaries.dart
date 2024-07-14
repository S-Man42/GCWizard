part 'package:gc_wizard/tools/uncategorized/wedding_anniversaries/logic/wedding_anniversaries_data.dart';

enum WeddingCountries { DE, UK, US, NL, DK, SW, FR, IT, ES }

Map<String, List<String>> countryAnniversaries (WeddingCountries country) {
  switch (country) {
    case WeddingCountries.DE:
      return _anniversariesDE;
    case WeddingCountries.UK:
      return _anniversariesUK;
    case WeddingCountries.US:
      return _anniversariesUS;
    case WeddingCountries.NL:
      return _anniversariesNL;
    case WeddingCountries.DK:
      return _anniversariesDK;
    case WeddingCountries.SW:
      return _anniversariesSW;
    case WeddingCountries.FR:
      return _anniversariesFR;
    case WeddingCountries.IT:
      return _anniversariesIT;
    case WeddingCountries.ES:
      return _anniversariesES;
  }
}

String getItems(WeddingCountries country, String year) {
  var anniversaryList = countryAnniversaries(country);
  var items = anniversaryList[year];
  return (items != null) ? items.join(", ") : '';
}

String getAllItems (String year) {
  List<String> allItems = [];
  for (WeddingCountries country in WeddingCountries.values) {
    var items = getItems(country, year);
    if (items.isNotEmpty) {
      allItems.add("${country.name}: $items");
    }
  }
  return allItems.join("\n");
}

Iterable<String> getAvailableYears(WeddingCountries country) {
  return countryAnniversaries(country).keys;
}

String getYearFromItem(WeddingCountries country, String item) {
  var anniversaryList = countryAnniversaries(country);
  List<String> years = [];
  for (var entry in anniversaryList.entries){
    if (entry.value.contains(item)) {
      years.add(entry.key);
    }
  }
  return years.join(", ");
}
