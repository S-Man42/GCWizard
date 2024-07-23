import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/text_widget_utils.dart';
import 'package:intl/intl.dart';

enum ToolLicenseType {
  FREE_TO_USE,
  AL, // Artistic License
  APACHE2, // Apache 2.0
  BSD, // BSD
  BSD2, // BSD2
  BSD3, // BSD v3
  CCBY4, // Creative Commons CC BY 4.0
  CCBYSA4, // Creative Commons CC BY-SA 4.0
  CCBYSA3, // Creative Commons CC BY-SA 2.0
  CCBYSA2, // Creative Commons CC BY-SA 2.0
  CCNC25, // Creative Commons CC NC 2.5
  CC0_1, // Creative Commons CC0 1.0
  MIT, // MIT
  GPL3, //GNU GPL v3.0
  GITHUB_DEFAULT, //Github Default
  GFDL, // GNU Free Documentation License
  PUBLIC_DOMAIN, // Public Domain
}

String _licenseType(BuildContext context, ToolLicenseType licenseType) {
  switch (licenseType) {
    case ToolLicenseType.FREE_TO_USE: return i18n(context, 'toollicenses_freetouse');
    case ToolLicenseType.AL: return 'Artistic License';
    case ToolLicenseType.APACHE2: return 'Apache 2.0 License';
    case ToolLicenseType.BSD: return 'BSD License';
    case ToolLicenseType.BSD2: return 'BSD-2-Clause';
    case ToolLicenseType.BSD3: return 'BSD-3-Clause';
    case ToolLicenseType.CCBY4: return 'Creative Commons CC BY 4.0';
    case ToolLicenseType.CCBYSA4: return 'Creative Commons CC BY-SA 4.0';
    case ToolLicenseType.CCBYSA3: return 'Creative Commons CC BY-SA 3.0';
    case ToolLicenseType.CCBYSA2: return 'Creative Commons CC BY-SA 2.0';
    case ToolLicenseType.CCNC25: return 'Creative Commons CC NC 2.5';
    case ToolLicenseType.CC0_1: return 'Creative Commons CC0 1.0';
    case ToolLicenseType.MIT: return 'MIT License';
    case ToolLicenseType.GPL3: return 'GNU GPL v3.0 License';
    case ToolLicenseType.GITHUB_DEFAULT: return 'Github Default License';
    case ToolLicenseType.GFDL: return 'GNU Free Documentation License';
    case ToolLicenseType.PUBLIC_DOMAIN: return 'Public Domain';
  }
}

Column toolLicenseEntry(List<Object> output) {
  return Column(
    children: output.map((element) {
      if (element is String) {
        return GCWText(text: element);
      } else {
        return Container(
          alignment: Alignment.topLeft,
          child: element as Widget,
        );
      }
    }).toList(),
  );
}

String toolLicenseTypeString(BuildContext context, ToolLicenseEntry toolLicense) {
  if (toolLicense is ToolLicenseOfflineBook) return i18n(context, 'toollicenses_offlinebook');
  if (toolLicense is ToolLicenseOnlineBook) return i18n(context, 'toollicenses_onlinebook');
  if (toolLicense is ToolLicenseOfflineArticle) return i18n(context, 'toollicenses_offlinearticle');
  if (toolLicense is ToolLicenseOnlineArticle) return i18n(context, 'toollicenses_onlinearticle');
  if (toolLicense is ToolLicensePrivatePermittedDigitalSource) return i18n(context, 'toollicenses_privatepermitteddigitalsource');
  if (toolLicense is ToolLicenseCodeLibrary) return i18n(context, 'toollicenses_codelibrary');
  if (toolLicense is ToolLicensePortedCode) return i18n(context, 'toollicenses_portedcode');
  if (toolLicense is ToolLicenseImage) return i18n(context, 'toollicenses_image');
  if (toolLicense is ToolLicenseFont) return i18n(context, 'toollicenses_font');
  if (toolLicense is ToolLicenseAPI) return i18n(context, 'toollicenses_api');

  return '';
}

abstract class ToolLicenseEntry {
  final BuildContext context;
  final String author;
  final String title;
  final String? customComment;

  const ToolLicenseEntry({required this.context, required this.author, required this.title, this.customComment});

  List<Object> toRow();
}

abstract class _ToolLicenseTextSource extends ToolLicenseEntry {
  final int? year;
  final int? month; // 01-12
  final int? day;
  final String? publisher;

  const _ToolLicenseTextSource({required BuildContext context, required String author, required String title, this.year, this.month, this.day, this.publisher, String? customComment})
      : super(context: context, author: author, title: title, customComment: customComment);
}

abstract class _ToolLicenseOnlineTextSource extends _ToolLicenseTextSource {
  final String sourceUrl;
  final String? licenseUrl;
  final ToolLicenseType? licenseType;

  const _ToolLicenseOnlineTextSource({required BuildContext context, required String author, required String title, int? year, int? month, int? day, String? publisher, String? customComment, required this.sourceUrl, this.licenseType, this.licenseUrl})
      : super(context: context, author: author, title: title, year: year, month: month, day: day, publisher: publisher, customComment: customComment);
}

String? _getDate(BuildContext context, int? year, int? month, int? day) {
  String? out;
  if (year == null) return out;

  out = year.toString();
  if (month == null) return out;

  out += '/' + month.toString().padLeft(2, '0');
  if (day == null) return out;

  var dateFormat = DateFormat('yMd', Localizations.localeOf(context).toString());
  return dateFormat.format(DateTime(year, month, day));
}

/*
 Real book, not online available -> cite with:
    author == author(s) and/or organisation(s);
    title == book title, maybe with chapter name if available; (My Great Book, Chapter 21: All or Nothing);
    year, date, month == if available
    isbn == ISBN if available
    publisher == publisher (Verlag) if available
    customComment == whatever, maybe a page number; license clarifications, ...
 */
class ToolLicenseOfflineBook extends _ToolLicenseTextSource {
  final String? isbn;

  const ToolLicenseOfflineBook({required BuildContext context, required String author, required String title, int? year, int? month, int? day, String? customComment, this.isbn, String? publisher})
      : super(context: context, author: author, title: title, year: year, month: month, day: day, customComment: customComment);

  @override
  List<Object> toRow() {
    var out = <Object>[author, title];
    var date = _getDate(context, year, month, day);
    if (date != null) out.add(date);
    if (isbn != null) out.add('ISBN: ' + isbn!);
    if (publisher != null) out.add(publisher!);
    if (customComment != null) out.add(customComment!);

    return out;
  }
}

/*
 Real book, online available -> cite with:
    author == author(s) and/or organisation(s);
    title == book title, maybe with chapter name if available; (My Great Book, Chapter 21: All or Nothing)
    year, date, month == if available
    isbn == ISBN if available
    publisher == publisher (Verlag) if available
    customComment == whatever, maybe a page number; license clarifications, ...
    sourceUrl == main URL of the source (in best case: Internet Archive snapshot)
    licenseType == if available: which license is the used source
    licenseUrl == if available: url of the license (in best case: Internet Archive snapshot)
 */
class ToolLicenseOnlineBook extends _ToolLicenseOnlineTextSource {
  final String? isbn;

  const ToolLicenseOnlineBook({required BuildContext context, required String author, required String title, int? year, int? month, int? day, required String sourceUrl, String? licenseUrl, ToolLicenseType? licenseType, String? customComment, this.isbn, String? publisher})
      : super(context: context, author: author, title: title, year: year, month: month, day: day, publisher: publisher, sourceUrl: sourceUrl, licenseType: licenseType, licenseUrl: licenseUrl, customComment: customComment);

  @override
  List<Object> toRow() {
    var out = <Object>[author];
    var _title = title;
    out.add(buildUrl(_title, sourceUrl));
    var date = _getDate(context, year, month, day);
    if (date != null) out.add(date);
    if (isbn != null) out.add('ISBN: ' + isbn!);
    if (publisher != null) out.add(publisher!);
    if (customComment != null) out.add(customComment!);

    Object? _license;
    if (licenseType != null) {
      var _lType = _licenseType(context, licenseType!);
      if (licenseUrl != null) {
        _license = buildUrl(_lType, licenseUrl!);
      } else {
        _license = _lType;
      }
    }
    if (_license != null) out.add(_license);

    return out;
  }
}

/*
 Article from magazines, newspaper, ... -> cite with:
    author == author(s) and/or organisation(s);
    title == magazine title and issue and article title (Time Magazine 2003/04, Best Geocaching Spots Alive)
    year, date, month == if available
    publisher == publisher (Verlag) if available
    customComment == whatever, maybe a page number; license clarifications, ...
 */
class ToolLicenseOfflineArticle extends _ToolLicenseTextSource {

  const ToolLicenseOfflineArticle({required BuildContext context, required String author, required String title, int? year, int? month, int? day, String? customComment, String? publisher})
      : super(context: context, author: author, title: title, year: year, month: month, day: day, publisher: publisher, customComment: customComment);

  @override
  List<Object> toRow() {
    var out = <Object>[author, title];
    var date = _getDate(context, year, month, day);
    if (date != null) out.add(date);
    if (publisher != null) out.add(publisher!);
    if (customComment != null) out.add(customComment!);

    return out;
  }
}

/*
 Online Article (blogs, Wikipedia, ...) ...  -> cite with:
    author == author(s) and/or organisation(s);
    title == website title and article title (Time Magazine 2003/04, Best Geocaching Spots Alive)
    year, date, month == if available
    publisher == publisher (Verlag) if available
    customComment == whatever, maybe a page number; license clarifications, ...
    sourceUrl == main URL of the source (in best case: Internet Archive snapshot or explicit Wikipedia history version)
    licenseType == if available: which license is the used source
    licenseUrl == if available: url of the license (in best case: Internet Archive snapshot)
 */
class ToolLicenseOnlineArticle extends _ToolLicenseOnlineTextSource {

  const ToolLicenseOnlineArticle({
    required BuildContext context,
    required String author,
    required String title,
    int? year, int? month, int? day,
    required String sourceUrl,
    String? licenseUrl,
    ToolLicenseType? licenseType,
    String? customComment,
    String? publisher
  })
      : super(context: context, author: author, title: title, year: year, month: month, day: day, publisher: publisher, sourceUrl: sourceUrl, licenseType: licenseType, licenseUrl: licenseUrl, customComment: customComment);

  @override
  List<Object> toRow() {
    var out = <Object>[author];
    var _title = title;
    out.add(buildUrl(_title, sourceUrl));
    var date = _getDate(context, year, month, day);
    if (date != null) out.add(date);
    if (publisher != null) out.add(publisher!);
    if (customComment != null) out.add(customComment!);

    Object? _license;
    if (licenseType != null) {
      var _lType = _licenseType(context, licenseType!);
      if (licenseUrl != null) {
        _license = buildUrl(_lType, licenseUrl!);
      } else {
        _license = _lType;
      }
    }
    if (_license != null) out.add(_license);

    return out;
  }
}

abstract class _ToolLicenseDigitalSource extends ToolLicenseEntry {
  final String? version;

  const _ToolLicenseDigitalSource({required BuildContext context, required String author, required String title, this.version, String? customComment})
      : super(context: context, author: author, title: title, customComment: customComment);
}

/*
 Privately permitted usage (i.e. author explicitly allow usage via e-mail)  -> cite with:
    author == author(s) and/or organisation(s);
    title == source title
    version == if available
    medium == how was use granted (e-mail, web forum, chat, ...)
    permissionYear, permissionMonth, permissionDay == at least the year: when was use granted
    customComment == whatever, maybe license clarifications, ...
 */
class ToolLicensePrivatePermittedDigitalSource extends _ToolLicenseDigitalSource {
  final String medium;
  final int permissionYear;
  final int? permissionMonth; // 01-12
  final int? permissionDay;
  final String? sourceUrl;

  const ToolLicensePrivatePermittedDigitalSource({required BuildContext context, required String author, required String title, required this.medium, required this.permissionYear, this.permissionMonth, this.permissionDay, String? version, this.sourceUrl, String? customComment})
      : super(context: context, author: author, title: title, version: version, customComment: customComment);

  @override
  List<Object> toRow() {
    var out = <Object>[author];
    var _title = title;
    if (version != null) _title += ' (' + version! + ')';
    if (sourceUrl != null) {
      out.add(buildUrl(_title, sourceUrl!));
    } else {
      out.add(_title);
    }
    if (customComment != null) out.add(customComment!);

    var _medium = i18n(context, 'toollicenses_usepermission') + ' ' + medium + ' (' + _getDate(context, permissionYear, permissionMonth, permissionDay)! + ')';
    out.add(_medium);
    return out;
  }
}

abstract class _ToolLicensePublicDigitalSource extends _ToolLicenseDigitalSource {
  final String sourceUrl;
  final String? licenseUrl;
  final ToolLicenseType licenseType;

  const _ToolLicensePublicDigitalSource({required BuildContext context, required String author, required String title, required this.sourceUrl, this.licenseUrl, required this.licenseType, String? version, String? customComment})
      : super(context: context, author: author, title: title, version: version, customComment: customComment);

  @override
  List<Object> toRow() {
    var out = <Object>[author];
    var _title = title;
    if (version != null) _title += ' (' + version! + ')';
    out.add(buildUrl(_title, sourceUrl));
    if (customComment != null) out.add(customComment!);

    Object _license;
    if (licenseUrl != null) {
      _license = buildUrl(_licenseType(context, licenseType), licenseUrl!);
    } else {
      _license = _licenseType(context, licenseType);
    }
    out.add(_license);

    return out;
  }
}

/*
 Code Dependency: A library or whatever directly used in the project (mainly Flutter/Dart libs from the pubspec.yaml)  -> cite with:
    author == author(s) and/or organisation(s);
    title == Library title
    version == if available
    customComment == whatever seems to be important..., license clarifications, ...
    sourceUrl == main URL of the source (in best case: Github fork or/and explicit repository commit)
    licenseType == if available: which license is the used source
    licenseUrl == if available: url of the license (in best case: Github fork or/and explicit repository commit)
 */
class ToolLicenseCodeLibrary extends _ToolLicensePublicDigitalSource {
  const ToolLicenseCodeLibrary({required BuildContext context, required String author, required String title, required String sourceUrl, String? licenseUrl, required ToolLicenseType licenseType, String? version, String? customComment})
      : super(context: context, author: author, title: title, version: version, sourceUrl: sourceUrl, licenseUrl: licenseUrl, licenseType: licenseType, customComment: customComment);
}

/*
 Ported Code: Code that was copied/ported from an external source (i.e. ported C++ code like GeographicLib)  -> cite with:
    author == author(s) and/or organisation(s);
    title == Source title
    version == if available
    customComment == whatever seems to be important..., license clarifications, ...
    sourceUrl == main URL of the source (in best case: Github fork or/and explicit repository commit)
    licenseType == if available: which license is the used source
    licenseUrl == if available: url of the license (in best case: Github fork or/and explicit repository commit)
 */
class ToolLicensePortedCode extends _ToolLicensePublicDigitalSource {
  const ToolLicensePortedCode({required BuildContext context, required String author, required String title, required String sourceUrl, String? licenseUrl, required ToolLicenseType licenseType, String? version, String? customComment})
      : super(context: context, author: author, title: title, version: version, sourceUrl: sourceUrl, licenseUrl: licenseUrl, licenseType: licenseType, customComment: customComment);
}

/*
 Image: Images/Graphics/Pictures that are used from external sources (NOT images that we generated from fonts -> see Fonts) -> cite with:
    author == author(s) and/or organisation(s);
    title == Source title
    version == if available
    customComment == whatever seems to be important..., license clarifications, ...
    sourceUrl == main URL of the source (in best case: Github fork or/and explicit repository commit)
    licenseType == if available: which license is the used source
    licenseUrl == if available: url of the license (in best case: Github fork or/and explicit repository commit)
 */
class ToolLicenseImage extends _ToolLicensePublicDigitalSource {
  const ToolLicenseImage({required BuildContext context, required String author, required String title, required String sourceUrl, String? licenseUrl, required ToolLicenseType licenseType, String? version, String? customComment})
      : super(context: context, author: author, title: title, version: version, sourceUrl: sourceUrl, licenseUrl: licenseUrl, licenseType: licenseType, customComment: customComment);
}

/*
 Font: Fonts that are used directly (e.g. Roboto as the main font of the app) or from which images were created (e.g. for symbol tables) -> cite with:
    author == author(s) and/or organisation(s);
    title == Source title
    version == if available
    customComment == whatever seems to be important..., license clarifications, ...
    sourceUrl == main URL of the source (in best case: Github fork or/and explicit repository commit)
    licenseType == if available: which license is the used source
    licenseUrl == if available: url of the license (in best case: Github fork or/and explicit repository commit)
 */
class ToolLicenseFont extends _ToolLicensePublicDigitalSource {
  const ToolLicenseFont({required BuildContext context, required String author, required String title, required String sourceUrl, String? licenseUrl, required ToolLicenseType licenseType, String? version, String? customComment})
      : super(context: context, author: author, title: title, version: version, sourceUrl: sourceUrl, licenseUrl: licenseUrl, licenseType: licenseType, customComment: customComment);
}

/*
 API: Public API that is used (e.g. the geo.crox.net API for the Dow Jones)
    author == author(s) and/or organisation(s);
    title == Source title
    version == if available
    customComment == whatever seems to be important..., license clarifications, ...
    sourceUrl == API entry point (could be invalid without parameters, which is ok I think)
    licenseType == if available: which license is the used source
    licenseUrl == if available: url of the license (in best case: Github fork or/and explicit repository commit)
 */
class ToolLicenseAPI extends _ToolLicensePublicDigitalSource {
  const ToolLicenseAPI({required BuildContext context, required String author, required String title, required String sourceUrl, String? licenseUrl, required ToolLicenseType licenseType, String? version, String? customComment})
      : super(context: context, author: author, title: title, version: version, sourceUrl: sourceUrl, licenseUrl: licenseUrl, licenseType: licenseType, customComment: customComment);
}