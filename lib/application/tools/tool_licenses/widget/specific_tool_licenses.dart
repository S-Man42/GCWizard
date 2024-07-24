part of 'package:gc_wizard/application/registry.dart';

class _SpecificToolLicenses {
  final BuildContext context;
  _SpecificToolLicenses(this.context);

  BuildContext get _context {
    return context;
  }

  ToolLicenseEntry get _toolLicenseJanMeeus {
    return ToolLicenseOfflineBook(
      context: _context,
      author: 'Jean Meeus',
      title: 'Astronomical Algorithms',
      isbn: '978-0943396613',
      publisher: 'Atlantic Books',
      year: 1998,
      month: 12,
      day: 1
    );
  }

  ToolLicenseEntry get _toolLicenseGeographicLib {
    return ToolLicensePortedCode(
      context: _context,
      author: 'Charles Karney',
      title: 'GeographicLib',
      licenseType: ToolLicenseType.MIT,
      licenseUrl: 'https://github.com/S-Man42/geographiclib/blob/23bd797bf2b1fa894ca30b69a9cf998e00f4a663/LICENSE.txt',
      sourceUrl: 'https://github.com/S-Man42/geographiclib/tree/23bd797bf2b1fa894ca30b69a9cf998e00f4a663'
    );
  }

  ToolLicenseEntry get _toolLicensePointyCastle {
    return ToolLicenseCodeLibrary(
      context: _context,
      author: 'Legion of the Bouncy Castle Inc',
      title: 'Pointy Castle',
      licenseType: ToolLicenseType.MIT,
      licenseUrl: 'https://github.com/S-Man42/pc-dart/blob/c7009dbf7785f4ff865ddb4eefdaed8c18ef3baa/LICENSE',
      sourceUrl: 'https://github.com/S-Man42/pc-dart/tree/c7009dbf7785f4ff865ddb4eefdaed8c18ef3baa'
    );
  }

  ToolLicenseEntry get _toolLicenseFAA8260 {
    return ToolLicenseOnlineArticle(
      context: _context,
      author: 'U.S. Department of Transportation (FAA)',
      title: 'Article: FAA Order 8260.58A CHG 2, Appendix E: Geospatial Standard',
      year: 2018, month: 11, day: 9,
      sourceUrl: 'https://web.archive.org/web/20240118214508/https://www.faa.gov/documentLibrary/media/Order/FAA_Order_8260.58A_Including_Change_1_and_2.pdf'
    );
  }

  ToolLicenseEntry get _toolLicenseMitre {
    return ToolLicensePortedCode(
      context: _context,
      author: 'The MITRE Corporation',
      title: 'Geodetic Library',
      licenseType: ToolLicenseType.APACHE2,
      licenseUrl: 'https://github.com/S-Man42/geodetic_library/blob/e2fd776eec8f7591d98022682137de0f74a4a0d7/LICENSE',
      sourceUrl: 'https://github.com/S-Man42/geodetic_library/tree/e2fd776eec8f7591d98022682137de0f74a4a0d7'
    );
  }

  ToolLicenseEntry get _toolLicenseGeoMidpoint {
    return ToolLicenseOnlineArticle(
      context: _context,
      author: 'Geo Midpoint (geomidpoint.com)',
      title: 'Calculation Methods: A. Geographic midpoint',
      sourceUrl: 'https://web.archive.org/web/20240606083622/http://www.geomidpoint.com/calculation.html'
    );
  }

  ToolLicenseEntry get _toolLicenseNASADeltaT {
    return ToolLicenseOnlineArticle(
      context: _context,
      author: 'NASA',
      title: 'Polynomial Expressions for Delta T (ΔT)',
      sourceUrl: 'https://web.archive.org/web/20240601113536/http://eclipse.gsfc.nasa.gov/SEcat5/deltatpoly.html'
    );
  }


  ToolLicenseEntry get _toolLicenseAstronomieInfo {
    return ToolLicensePortedCode(
      context: _context,
      author: 'Helmut Lehmeyer, Arnold Barmettler\n(astronomie.info)',
      title: 'Astronomical Calculations',
      licenseType: ToolLicenseType.GPL3,
      licenseUrl: 'http://web.archive.org/web/20180502230101/http://lexikon.astronomie.info/java/sunmoon/progs/Astronomy.java',
      sourceUrl: 'http://web.archive.org/web/20180502230101/http://lexikon.astronomie.info/java/sunmoon/progs/Astronomy.java'
    );
  }

  ToolLicenseEntry get _toolLicensePracticalAstronomy {
    return ToolLicenseOfflineBook(
      context: _context,
      author: 'Peter Duffett-Smith',
      title: 'Practical Astronomy with your Calculator',
      isbn: '978-0521356992',
      year: 1989, month: 3, day: 1,
      publisher: 'Cambridge University Press'
    );
  }

  ToolLicenseEntry get _toolLicenseWrixonGeheimsprachen {
    return ToolLicenseOfflineBook(
        context: context,
        author: 'Fred B. Wrixon',
        title: 'Geheimsprachen',
        publisher: 'Könemann Tandem Verlag GmbH',
        isbn: '978-3-8331-2562-1',
        year: 2006,
        );
  }

  ToolLicenseEntry get _toolLicenseMayaGlyphsWikisource {
    return ToolLicenseOnlineArticle(
      context: context,
      author: 'Sylvanus Griswold Morley',
      title: 'An Introduction to the Study of the Maya Hieroglyphs, Chapter 3',
      publisher: 'Wikisource',
      sourceUrl: 'https://en.wikisource.org/w/index.php?title=An_Introduction_to_the_Study_of_the_Maya_Hieroglyphs/Chapter_3&oldid=12772621',
    );
  }

  ToolLicenseEntry get _toolLicensePackageArchive {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'loki3d.com',
      title: 'archive',
      sourceUrl: 'https://pub.dev/packages/archive',
      licenseType: ToolLicenseType.MIT,
    );
  }

  ToolLicenseEntry get _toolLicensePackageAudioplayers {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'blue-fire.xyz',
      title: 'audioplayers',
      sourceUrl: 'https://pub.dev/packages/audioplayers',
      licenseType: ToolLicenseType.MIT,
    );
  }

  ToolLicenseEntry get _toolLicensePackageAutoSizeText {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'simc.com',
      title: 'auto_size_text',
      sourceUrl: 'https://pub.dev/packages/auto_size_text',
      licenseType: ToolLicenseType.MIT,
    );
  }

  ToolLicenseEntry get _toolLicensePackageBase32 {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'yuli.dev',
      title: 'base32',
      sourceUrl: 'https://pub.dev/packages/base32',
      licenseType: ToolLicenseType.MIT,
    );
  }

  ToolLicenseEntry get _toolLicensePackageCodeTextField {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'unverified uploader',
      title: 'code_text_field',
      sourceUrl: 'https://pub.dev/packages/code_text_field',
      licenseType: ToolLicenseType.MIT,
    );
  }

  ToolLicenseEntry get _toolLicensePackageDiacritic {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'agilord.com',
      title: 'diacritic',
      sourceUrl: 'https://pub.dev/packages/diacritic',
      licenseType: ToolLicenseType.BSD3,
    );
  }

  ToolLicenseEntry get _toolLicensePackageEncrypt {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'unverified uploader',
      title: 'encrypt',
      sourceUrl: 'https://pub.dev/packages/encrypt',
      licenseType: ToolLicenseType.BSD3,
    );
  }

  ToolLicenseEntry get _toolLicensePackageExif {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'unverified uploader',
      title: 'exif',
      sourceUrl: 'https://pub.dev/packages/exif',
      licenseType: ToolLicenseType.MIT,
    );
  }

  ToolLicenseEntry get _toolLicensePackageFlutterHighlight {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'unverified uploader',
      title: 'flutter_highlight',
      sourceUrl: 'https://pub.dev/packages/flutter_highlight',
      licenseType: ToolLicenseType.MIT,
    );
  }

  ToolLicenseEntry get _toolLicensePackageFlutterMap {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'fleaflet.dev',
      title: 'flutter_map',
      sourceUrl: 'https://pub.dev/packages/flutter_map',
      licenseType: ToolLicenseType.BSD3,
    );
  }

  ToolLicenseEntry get _toolLicensePackageFlutterMapMarkerPopup {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'balanci.ng',
      title: 'flutter_map_marker_popup',
      sourceUrl: 'https://pub.dev/packages/flutter_map_marker_popup',
      licenseType: ToolLicenseType.BSD3,
    );
  }

  ToolLicenseEntry get _toolLicensePackageFlutterMapTappablePolyLine {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'ownweb.fr',
      title: 'flutter_map_tappable_polyline',
      sourceUrl: 'https://pub.dev/packages/flutter_map_tappable_polyline',
      licenseType: ToolLicenseType.MIT,
    );
  }

  ToolLicenseEntry get _toolLicensePackageHighlight {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'unverified uploader',
      title: 'highlight',
      sourceUrl: 'https://pub.dev/packages/highlight',
      licenseType: ToolLicenseType.MIT,
    );
  }

  ToolLicenseEntry get _toolLicensePackageHttp {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'dart.dev',
      title: 'http',
      sourceUrl: 'https://pub.dev/packages/http',
      licenseType: ToolLicenseType.BSD3,
    );
  }

  ToolLicenseEntry get _toolLicensePackageHttpParser {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'dart.dev',
      title: 'http_parser',
      sourceUrl: 'https://pub.dev/packages/http_parser',
      licenseType: ToolLicenseType.BSD3,
    );
  }

  ToolLicenseEntry get _toolLicensePackageImage {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'loki3d.com',
      title: 'image',
      sourceUrl: 'https://pub.dev/packages/image',
      licenseType: ToolLicenseType.MIT,
    );
  }

  ToolLicenseEntry get _toolLicensePackageIntl {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'dart.dev',
      title: 'intl',
      sourceUrl: 'https://pub.dev/packages/intl',
      licenseType: ToolLicenseType.BSD3,
    );
  }

  ToolLicenseEntry get _toolLicensePackageLatlong2 {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'defylogic.dev',
      title: 'audioplayers',
      sourceUrl: 'https://pub.dev/packages/latlong2',
      licenseType: ToolLicenseType.APACHE2,
    );
  }

  ToolLicenseEntry get _toolLicensePackageMathExpressions {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'leonhardt.co.nz',
      title: 'math_expressions',
      sourceUrl: 'https://pub.dev/packages/math_expressions',
      licenseType: ToolLicenseType.MIT,
    );
  }

  ToolLicenseEntry get _toolLicensePackagePrefs {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'andrioussolutions.com',
      title: 'prefs',
      sourceUrl: 'https://pub.dev/packages/prefs',
      licenseType: ToolLicenseType.APACHE2,
    );
  }

  ToolLicenseEntry get _toolLicensePackageQr {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'kevmoo.com',
      title: 'qr',
      sourceUrl: 'https://pub.dev/packages/qr',
      licenseType: ToolLicenseType.BSD3,
    );
  }

  ToolLicenseEntry get _toolLicensePackageRscan {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'rhyme95.cn',
      title: 'r_scan',
      sourceUrl: 'https://pub.dev/packages/r_scan',
      licenseType: ToolLicenseType.BSD3,
    );
  }

  ToolLicenseEntry get _toolLicensePackageStack {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'unverified uploader',
      title: 'stack',
      sourceUrl: 'https://pub.dev/packages/stack',
      licenseType: ToolLicenseType.MIT,
    );
  }

  ToolLicenseEntry get _toolLicensePackageTouchable {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'unverified uploader',
      title: 'touchable',
      sourceUrl: 'https://pub.dev/packages/touchable',
      licenseType: ToolLicenseType.MPL2,
    );
  }

  ToolLicenseEntry get _toolLicensePackageTuple {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'google.dev',
      title: 'tuple',
      sourceUrl: 'https://pub.dev/packages/tuple',
      licenseType: ToolLicenseType.BSD2,
    );
  }

  ToolLicenseEntry get _toolLicensePackageUuid {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'yuli.dev',
      title: 'uuid',
      sourceUrl: 'https://pub.dev/packages/uuid',
      licenseType: ToolLicenseType.MIT,
    );
  }

  ToolLicenseEntry get _toolLicensePackageWeekOfYear {
    return ToolLicenseCodeLibrary(
      context: context,
      author: 'kada.se',
      title: 'week_of_year',
      sourceUrl: 'https://pub.dev/packages/week_of_year',
      licenseType: ToolLicenseType.BSD3,
    );
  }

  ToolLicenseEntry get _toolLicenseOnlineBookAlphabetumArabEgipt {
    return ToolLicenseOnlineBook(
      context: context,
      author: 'Giovanni Battista Palatino',
      title: 'Libro nuovo d\'imparare a scrivere',
      sourceUrl: 'https://archive.org/details/librodimgiovanba00pala/mode/2up',
      year: 1548,
      licenseType: ToolLicenseType.PUBLIC_DOMAIN,
    );
  }

  ToolLicenseEntry get _toolLicenseOnlineBookAlphabetumGoth {
    return ToolLicenseOnlineBook(
      context: context,
      author: 'Magnus Olaus',
      title: 'Historia de Gentibus Septentrionalibus',
      sourceUrl: 'https://archive.org/details/Historiaedegent00Olau',
      year: 1555,
      licenseType: ToolLicenseType.PUBLIC_DOMAIN,
    );
  }

  ToolLicenseEntry get _toolLicenseOfflineBook {
    return ToolLicenseOfflineBook(context: context,
        author: 'Cully Long',
        title: 'How to puzzle caches. Lessons, tips, tricks and hints for solving geocache puzzles',
      isbn: '978-0-9973488-9-7',
      publisher: 'single atom books',
      year: 2019,
    );
  }
}

