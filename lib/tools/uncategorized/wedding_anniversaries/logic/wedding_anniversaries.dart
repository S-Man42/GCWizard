import 'dart:core';

part 'package:gc_wizard/tools/uncategorized/wedding_anniversaries/logic/wedding_anniversaries_data.dart';

enum WeddingCountry { DE, UK, US, NL, DK, SW, FR, IT, ES }

Map<String, List<String>> _countryAnniversaries (WeddingCountry country) {
  switch (country) {
    case WeddingCountry.DE:
      return _anniversariesDE;
      break;
    case WeddingCountry.UK:
      return _anniversariesDE;
      break;
    case WeddingCountry.US:
      return _anniversariesDE;
      break;
    case WeddingCountry.NL:
      return _anniversariesDE;
      break;
    case WeddingCountry.DK:
      return _anniversariesDE;
      break;
    case WeddingCountry.SW:
      return _anniversariesDE;
      break;
    case WeddingCountry.FR:
      return _anniversariesDE;
      break;
    case WeddingCountry.IT:
      return _anniversariesDE;
      break;
    case WeddingCountry.ES:
      return _anniversariesDE;
      break;
  }
}

String getItems (WeddingCountry country, String year) {
  var aniversaryList = _countryAnniversaries(country);
  var items = aniversaryList[year];

  return (items != null) ? items.join(", ") : '';
}

