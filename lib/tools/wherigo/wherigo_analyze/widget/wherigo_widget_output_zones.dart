part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/widget/wherigo_analyze.dart';

List<List<String>> buildOutputListOfZoneData(BuildContext context, WherigoZoneData data) {
  List<List<String>> result = [];
  if (wherigoExpertMode)
    result = buildOutputListOfZoneDataExpertMode(context, data);
  else
    result = buildOutputListOfZoneDataUserMode(context, data);

  data.ZonePoints.forEach((point) {
    result.add(
        ['', formatCoordOutput(LatLng(point.Latitude, point.Longitude), defaultCoordFormat(), defaultEllipsoid())]);
  });
  return result;
}

List<List<String>> buildOutputListOfZoneDataUserMode(BuildContext context, WherigoZoneData data) {
  return [
    [i18n(context, 'wherigo_output_name'), data.ZoneName],
    [i18n(context, 'wherigo_output_description'), data.ZoneDescription],
    [
      i18n(context, 'wherigo_output_originalpoint'),
      formatCoordOutput(LatLng(data.ZoneOriginalPoint.Latitude, data.ZoneOriginalPoint.Longitude), defaultCoordFormat(),
          defaultEllipsoid())
    ],
    [i18n(context, 'wherigo_output_zonepoints'), ''],
  ];
}

List<List<String>> buildOutputListOfZoneDataExpertMode(BuildContext context, WherigoZoneData data) {
  return [
    [i18n(context, 'wherigo_output_luaname'), data.ZoneLUAName],
    [i18n(context, 'wherigo_output_id'), data.ZoneID],
    [i18n(context, 'wherigo_output_name'), data.ZoneName],
    [i18n(context, 'wherigo_output_description'), data.ZoneDescription],
    [i18n(context, 'wherigo_output_visible'), i18n(context, 'common_' + data.ZoneVisible)],
    [
      i18n(context, 'wherigo_output_medianame'),
      data.ZoneMediaName +
          (data.ZoneMediaName != ''
              ? (NameToObject[data.ZoneMediaName] != null ? ' ⬌ ' + NameToObject[data.ZoneMediaName]!.ObjectName : '')
              : '')
    ],
    [
      i18n(context, 'wherigo_output_iconname'),
      data.ZoneIconName +
          (data.ZoneIconName != ''
              ? (NameToObject[data.ZoneIconName] != null ? ' ⬌ ' + NameToObject[data.ZoneIconName]!.ObjectName : '')
              : '')
    ],
    [i18n(context, 'wherigo_output_active'), i18n(context, 'common_' + data.ZoneActive)],
    [i18n(context, 'wherigo_output_showobjects'), data.ZoneShowObjects],
    [i18n(context, 'wherigo_output_distancerange'), data.ZoneDistanceRange],
    [i18n(context, 'wherigo_output_distancerangeuom'), data.ZoneDistanceRangeUOM],
    [i18n(context, 'wherigo_output_proximityrange'), data.ZoneProximityRange],
    [i18n(context, 'wherigo_output_proximityrangeuom'), data.ZoneProximityRangeUOM],
    [i18n(context, 'wherigo_output_outofrange'), data.ZoneOutOfRange],
    [i18n(context, 'wherigo_output_inrange'), data.ZoneInRange],
    [
      i18n(context, 'wherigo_output_originalpoint'),
      formatCoordOutput(LatLng(data.ZoneOriginalPoint.Latitude, data.ZoneOriginalPoint.Longitude), defaultCoordFormat(),
          defaultEllipsoid())
    ],
    [i18n(context, 'wherigo_output_zonepoints'), ''],
  ];
}
