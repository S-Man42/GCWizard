import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';

int specialSortNoteNames(Map<String, String> a, Map<String, String> b) {
  var keyA = a.values.first.split('/').last.split('.').first; // get filename from path without suffix
  var keyB = b.values.first.split('/').last.split('.').first;

  var aSplit = keyA.split('_');
  var aMain = int.tryParse(aSplit[0]);
  var aSign = '';
  if (aSplit.length > 1)
    aSign = aSplit[1];

  var bSplit = keyB.split('_');
  var bMain = int.tryParse(bSplit[0]);
  var bSign = '';
  if (bSplit.length > 1)
    bSign = bSplit[1];

  var compareSign = aSign.compareTo(bSign);
  if (compareSign != 0)
    return compareSign;

  return aMain.compareTo(bMain);
}

int specialSortNoteValues(Map<String, String> a, Map<String, String> b) {
  var keyA = a.keys.first;
  var keyB = b.keys.first;

  var aSplitSlash = keyA.split('/').toList();
  var bSplitSlash = keyB.split('/').toList();

  var aCounter = int.tryParse(aSplitSlash[0]);
  var aDenominator = 1;
  if (aSplitSlash.length > 1)
    aDenominator = int.tryParse(aSplitSlash[1]);

  var bCounter = int.tryParse(bSplitSlash[0]);
  var bDenominator = 1;
  if (bSplitSlash.length > 1)
    bDenominator = int.tryParse(bSplitSlash[1]);

  var compare = aCounter.compareTo(bCounter);
  if (compare != 0)
    return compare;

  return aDenominator.compareTo(bDenominator);
}

int specialSortTrafficSignsGermany(Map<String, String> a, Map<String, String> b) {
  var keyA = a.keys.first;
  var keyB = b.keys.first;

  var aSplitDash = keyA.split('-').toList();
  var bSplitDash = keyB.split('-').toList();
  var aSplitDot = aSplitDash[0].split('.').toList();
  var bSplitDot = bSplitDash[0].split('.').toList();

  var aMain = int.tryParse(aSplitDot[0]);
  var aDot = 0;
  if (aSplitDot.length > 1)
    aDot = int.tryParse(aSplitDot[1]);
  var aDash = 0;
  if (aSplitDash.length > 1)
    aDash = int.tryParse(aSplitDash[1]);

  var bMain = int.tryParse(bSplitDot[0]);
  var bDot = 0;
  if (bSplitDot.length > 1)
    bDot = int.tryParse(bSplitDot[1]);
  var bDash = 0;
  if (bSplitDash.length > 1)
    bDash = int.tryParse(bSplitDash[1]);

  var compareMain = aMain.compareTo(bMain);
  if (compareMain != 0)
    return compareMain;

  var compareDot = aDot.compareTo(bDot);
  if (compareDot != 0)
    return compareDot;

  var compareDash = aDash.compareTo(bDash);
  if (compareDash != 0)
    return compareDash;

  return 0;
}