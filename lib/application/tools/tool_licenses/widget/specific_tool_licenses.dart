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
}

