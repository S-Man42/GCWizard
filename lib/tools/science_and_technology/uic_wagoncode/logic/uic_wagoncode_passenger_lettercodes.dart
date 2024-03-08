const Map<String, String> UICWagenCodesPassengerLetterCodesCategories = {
  'A': 'Sitzwagen erster Klasse',
  'B': 'Sitzwagen zweiter Klasse',
  'AB': 'Sitzwagen erster und zweiter Klasse',
  'AR': 'Halbspeisewagen mit Sitzplätzen erster Klasse sowie Küche und Speiseraum',
  'BR': 'Halbspeisewagen mit Sitzplätzen zweiter Klasse sowie Küche und Speiseraum',
  'AD': 'Halbgepäckwagen mit Sitzplätzen erster Klasse und Gepäckraum',
  'BD': 'Halbgepäckwagen mit Sitzplätzen zweiter Klasse und Gepäckraum',
  'D' :'Gepäckwagen',
  'DD': 'bei Autoreisezügen: Doppelstock-Autotransportwagen der Reisezugwagen-Bauart',
  'S':'Salonwagen',
  'Salon':'Salonwagen',
  'SR': 'Gesellschaftswagen',  
  'WLA': 'Schlafwagen erster Klasse',
  'WLB':'Schlafwagen zweiter Klasse',
  'WLAB': 'Schlafwagen erster und zweiter Klasse',
  'WR': 'Speisewagen',
  'KA': 'Schmalspurwagen erster Klasse',
  'KB': 'Schmalspurwagen zweiter Klasse' ,
  'KD': 'Schmalspurgepäckwagen',
  'Z': 'Gefangenentransportwagen / Zellenwagen',
};

const Map<String, Map<String, String>> UICWagenCodesPassengeCategoriesCountries = {
'50': {
  'DD': 'Doppelstock-Gepäckwagen',
  },
  '74': {
    'F': 'Gepäckwagen',
    'R': 'Speisewagen',
  },
  '76': {
    'FR': 'Speisewagen mit Gepäckraum',
  },
  '80': {
    'DA': 'Doppelstockwagen erster Klasse',
    'DB': 'Doppelstockwagen zweiter Klasse',
    'DAB':'Doppelstockwagen erster und zweiter Klasse',
    'Post': 'Postwagen',
    'BPost': 'Sitzwagen zweiter Klasse mit Postabteil',
    'DPost': 'Gepäckwagen mit Postabteil',
    'WG': 'Gesellschaftswagen ("Tanzwagen")' ,
    'WGS': 'Sondergesellschaftswagen ("Salonwagen")' ,
  },
  '81': {
    'F': 'Postwagen',
    'Post': 'Postwagen',
  },
  '85': {
    'S': 'Sonderwagen',
    'Z': 'Postwagen',
  }
};

const Map<String, Map<String, String>> UICWagenCodesPassengerLetterCodesClassifications = {
  '50': {
    'b': 'Behelfsreisezugwagen der Baujahre 1943 bis 1945',
    'f': 'Behelfssteuerwagen (Befehlswagen) für den Wendezugbetrieb',
    'tr': 'Wagen mit Traglastenabteil',
    'v': 'vierteilige Doppelstockeinheit, vorher DB13',
    'w': 'leichte Durchgangswagen bis 32 Tonnen Eigenmasse',
    'z': 'zweiteilige Doppelstockeinheit, vorher DB7',
  },
  '80': {
    'a': 'Wagen ist für das technikbasierte Abfertigungsverfahren ausgerüstet.',
    'aa': 'zweiachsiger Reisezugwagen',
    'b': 'Wagen mit behindertengerechter Ausrüstung',
    'c': 'Wagen mit Abteilen, in denen die Sitzplätze in Liegeplätze (Couchettes) umgewandelt werden können (Liegewagen)',
    'd': 'Wagen mit Mehrzweckraum oder Fahrradstellplätzen',
    'e': 'Wagen mit elektrischer Heizung',
    'ee': 'Wagen mit Energieversorgung aus der Zugsammelschiene.',
    'f': 'Steuerwagen mit 36-poliger Steuerleitung oder zeitmultiplexer Wendezugsteuerung; zusätzlich zu u: Steuerwagen mit 34-poliger Leitung oder zeitmultiplexer Wendezugsteuerung',
    'g': 'Reisezugwagen mit Gummiwulstübergängen, bei Sitz-, Liege- und Schlafwagen für den Schnellzugdienst zusätzlich mit Seitengang',
    'h': 'Wagen, der sowohl über Zugsammelschiene als auch eigene Achsgeneratoren mit Strom versorgt werden kann; außerdem: Kennzeichen nicht umgebauter Nahverkehrswagen der DR-Bauart (Großraumwagen mit Gummiwulstübergängen und Mittelgang)',
    'i': 'zusätzlich zu m: ehemalige Interregio-Wagen',
    'k': 'Wagen mit Bistro-/Kiosk- oder Küchenabteil oder Warenautomaten',
    'l': 'Wagen wie m-Wagen, jedoch ohne Seitengang (derzeit nicht in Gebrauch)',
    'm': 'Personenverkehrswagen mit einer Länge von mehr als 24,5 Metern und Gummiwulstübergängen (außer bei DDm)',
    'mm': 'modernisierter m-Wagen (m: Personenverkehrswagen mit einer Länge von mehr als 24,5 Metern und Gummiwulstübergängen)',
    'n': 'Nahverkehrswagen mit einer Länge von mehr als 24,5 Metern, Großraum mit Mittelgang in der zweiten Klasse (zwölf fiktive Abteile), Mittel- oder Seitengang in der ersten Klasse, zwei Mitteleinstiege, geeignet für Wendezugbetrieb (36-polige Steuerleitung)',
    'o': 'zusätzlich zu m: weniger Abteile und ohne Klimaanlage',
    'p': 'Wagen mit Großraum und Mittelgang ("pullman-artig"), klimatisiert',
    'q': 'Steuerwagen mit konventioneller Wendezugsteuerung mit 34-poliger Steuerleitung (nur nichtmodernisierte Fahrzeuge, die nicht das n oder y tragen)',
    'r': 'Wagen mit Hochleistungs-Bremse (Rapid-Bremse) KE-GPR. Nur in Verbindung mit n oder bei Postwagen verwendet.',
    's': 'bei Gepäckwagen und Halbgepäckwagen: Seitengang\nbei Schlafwagen: Bauart Spezial (kleine Ein- oder Zweibettabteile)\nbei Abteilwagen: Service-Abteil',
    'u': 'Wagen mit 34-poliger Wendezugsteuerleitung (DR-Bauart)',
    'uu': 'Wagen mit 36-poliger Wendezugsteuerleitung (DB-Bauart) (n schließt dieses Merkmal ein)',
    'v': 'Fernverkehrswagen mit verringerter Abteilanzahl (11 statt 12 bei Bm, 6/4 statt 6/5 bei ABm, 9 statt 10 bei Am)',
    'w': 'Fernverkehrswagen mit erheblich verringerter Abteilanzahl (9 statt 12 bei Bm)',
    'x': 'S-Bahn-Wagen mit Großraum mit Mittelgang, Zugsammelschiene zur Stromversorgung, Mitteleinstiegen und Hochleistungsbremse',
    'y': 'Nahverkehrswagen mit einer Länge von mehr als 24,5 m, Großraum mit Mittelgang in der zweiten Klasse (elf fiktive Abteile), zwei Mitteleinstiegen, geeignet für Wendezugbetrieb (34-polige Steuerleitung)',
    'z': 'Wagen mit Energieversorgung aus der Zugsammelschiene (ohne Achsgeneratoren)',
  },
  '81': {
    'b': 'behindertengerecht(e Toilette)',
    'c': 'Liegewagen (Couchette)',
    'e': 'Gepäckwagen mit Seitengang',
    'f': 'Steuerwagen',
    'h': 'Wagen mit elektrischer Heizung (entfällt ab 1968 ausgen. bei Triebwagen und Schmalspurfahrzeugen)',
    'i': 'Wagen mit Mittelgang, offenen Plattformen und offenen Übergangsbrücken',
    'ip': 'Wagen mit Mittelgang, geschlossenen Plattformen und offenen Übergangsbrücken',
    'l': 'Triebwagenanhänger mit Steuerleitung',
    'm': 'Wagen mit mehr als 24 Metern Länge',
    'o': 'Wagen ohne Dampfheizung',
    'p': 'Wagen mit Großraum und Mittelgang',
    's': 'Gepäckwagen mit Seitengang',
    'ü': 'Wagen mit geschlossenem Übergan',
    'v': 'Wagen mit reduzierter Abteil-Anzahl',
    'w': 'Wagen mit Webasto-Eigenheizung (bei Triebwagenanhängern nicht angeschrieben)',
    'x': 'Gepäckwagen für Expressgut',
    'y': 'Wagen mit Buffetabteil',
    'z': 'Wagen mit Energieversorgung ausschließlich aus der Zugsammelschiene',
    '-dl': 'Doppelstockwagen mit Steuerleitung (entfällt bei aktuellen Auslieferungen und Umzeichnungen)',
    '-ds': 'Doppelstockwagen-Steuerwagen (entfällt bei aktuellen Auslieferungen und Umzeichnungen)',
    '-k': 'Wagen mit Zugführerkabine',
    '-l': 'Wagen mit Steuerleitung für Wendezugbetrieb',
    '-s': 'Steuerwagen für Wendezugbetrieb',
    '/s': 'Schmalspurwagen',
    '/sz': 'Wagen für die schmalspurigen Zahnradbahnen',
    'T': 'Triebwagenbeiwagen',
    'ET': 'Elektrotriebwagen',
    'ES': 'Steuerwagen für Elektrotriebwagen',
    'VT': 'Verbrennungstriebwagen',
    'VS': 'Steuerwagen für Verbrennungstriebwagen',
  },
  '85': {
    'b': 'Begleitwagen (nur in der Kombination Db)',
    'c': 'Liegewagen (Couchette)',
    'i': 'Wagen mit offenen Plattformen bzw. Wagen mit behindertengerechter Toilette (nur bei RhB und MGB)',
    'm': 'Wagen mit mehr als 24 Metern Länge für den internationalen Verkehr',
    'p': 'Wagen mit Großraum und Mittelgang für den internationalen Verkehr (ab 1980)',
    'r': 'Wagen mit Restaurationsabteil (gleichbedeutend manchmal auch R geschrieben)',
    's': 'Gepäckwagen mit Seitengang',
    't': 'Steuerwagen für Pendelzüge',
    'ü': 'Wagen mit geschlossenem Übergang (bis 1968) ',
  }
};

Map<String, String> uicPassengerWagonLetterCodes(String countryCode, String letters) {
  var categories = Map<String, String>.from(UICWagenCodesPassengerLetterCodesCategories);

  if (UICWagenCodesPassengeCategoriesCountries.containsKey(countryCode)) {
    if (countryCode == '50') {
      categories.addAll(UICWagenCodesPassengeCategoriesCountries['80']!);
    }
    categories.addAll(UICWagenCodesPassengeCategoriesCountries[countryCode]!);
  }

  var categoryKeys = List<String>.from(categories.keys);
  categoryKeys.sort((a, b) => b.length.compareTo(a.length));

  var out = <String, String>{};

  for (int i = 0; i < categoryKeys.length; i++) {
    var key = categoryKeys[i];
    if (letters.startsWith(key)) {
      out.putIfAbsent(key, () => categories[key]!);
      letters = letters.substring(key.length);
      break;
    }
  }

  var classifications = <String, String>{};
  var _letters = letters;
  var _letterHyphens = '';
  var _letterSlashes = '';

  if (UICWagenCodesPassengerLetterCodesClassifications.containsKey(countryCode)) {
    if (countryCode == '50') {
      classifications.addAll(UICWagenCodesPassengerLetterCodesClassifications['80']!);
    }
    classifications.addAll(UICWagenCodesPassengerLetterCodesClassifications[countryCode]!);

    if (countryCode == '81') {
      var _lettersParts = _letters.split('-');
      if (_lettersParts.length > 1) {
        _letters = _lettersParts[0];
        _letterHyphens = _lettersParts[1];

        _lettersParts = _letterHyphens.split('/');
        if (_lettersParts.length > 1) {
          _letterHyphens = _lettersParts[0];
          _letterSlashes = _lettersParts[1];
        }
      }
      _lettersParts = _letters.split('/');
      if (_lettersParts.length > 1) {
        _letters = _lettersParts[0];
        _letterSlashes = _lettersParts[1];

        _lettersParts = _letterSlashes.split('-');
        if (_lettersParts.length > 1) {
          _letterSlashes = _lettersParts[0];
          _letterHyphens = _lettersParts[1];
        }
      }
    }
  }

  var classificationKeys = List<String>.from(classifications.keys);
  classificationKeys.sort((a, b) => b.length.compareTo(a.length));

  var _classificationKeysHyphens = List<String>.from(classificationKeys.where((element) => element.startsWith('-')).map((e) => e.substring(1)));
  var _classificationKeysSlashes = List<String>.from(classificationKeys.where((element) => element.startsWith('/')).map((e) => e.substring(1)));
  classificationKeys.removeWhere((element) => element.startsWith('-') || element.startsWith('/'));

  void _translateLetterCodes(String letterCodes, List<String> keys, Map<String, String> classificationMap, String prefix, Map<String, String> output) {
    var i = 0;
    while (i < keys.length && letterCodes.isNotEmpty) {
      var key = keys[i];
      if (letterCodes.startsWith(key)) {
        output.putIfAbsent(prefix + key, () => classificationMap[prefix + key]!);
        letterCodes = letterCodes.substring(key.length);
        i = 0;
      } else {
        i++;
        if (i == keys.length) {
          i = 0;
          letterCodes = letterCodes.substring(1);
        }
      }
    }
  }

  _translateLetterCodes(_letters, classificationKeys, classifications, '', out);
  _translateLetterCodes(_letterHyphens, _classificationKeysHyphens, classifications, '-', out);
  _translateLetterCodes(_letterSlashes, _classificationKeysSlashes, classifications, '/', out);

  return out;
}