import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords.dart';
import 'package:gc_wizard/common_widgets/coordinates/gcw_coords_export_dialog.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/gcw_expandable.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_dropdown_spinner.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_text_formatter.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/map_view/logic/map_geometries.dart';
import 'package:gc_wizard/tools/coords/map_view/widget/gcw_mapview.dart';
import 'package:gc_wizard/tools/images_and_files/adventure_labs/logic/adventure_labs.dart';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:prefs/prefs.dart';

class AdventureLabs extends StatefulWidget {
  const AdventureLabs({Key? key}) : super(key: key);

  @override
  AdventureLabsState createState() => AdventureLabsState();
}

class AdventureLabsState extends State<AdventureLabs> {
  var _currentCoords = defaultBaseCoordinate;
  var _currentRadius = 1000;
  List<AdventureData> _adventureList = [];
  var _currentAdventureIndex = 0;
  var _currentAdventureList = [];

  late Adventures _outData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWCoords(
          title: i18n(context, 'adventure_labs_start'),
          coordsFormat: _currentCoords.format,
          onChanged: (ret) {
            setState(() {
              _currentCoords = ret;
            });
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'adventure_labs_radius'),
        ),
        GCWIntegerSpinner(
          min: 0,
          max: 9999,
          value: _currentRadius,
          onChanged: (value) {
            setState(() {
              _currentRadius = value;
            });
          },
        ),
        GCWButton(
          text: i18n(context, 'adventure_labs_search'),
          onPressed: () {
            setState(() {
              _getAdventureDataAsync();
            });
          },
        ),
        _buildOutput(),
      ],
    );
  }


  void _getAdventureDataAsync() async {
    await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: SizedBox(
            height: 220,
            width: 150,
            child: GCWAsyncExecuter<Adventures>(
              isolatedFunction: getAdventureDataAsync,
              parameter: _buildAdventureJobData,
              onReady: (data) => _showAdventuresOutput(data),
              isOverlay: true,
            ),
          ),
        );
      },
    );
  }

  Future<GCWAsyncExecuterParameters?> _buildAdventureJobData() async {
    return GCWAsyncExecuterParameters(AdventureLabJobData(jobDataCoordinate: _currentCoords, jobDataRadius: _currentRadius));
  }

  void _showAdventuresOutput(Adventures output) {
    _outData = output;

    _adventureList = _outData.AdventureList;
    _currentAdventureList.clear();
    _adventureList.forEach((element) {
      _currentAdventureList.add(element.Title);
    });
    // outData != null

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  void _openInMap(List<GCWMapPoint> points) {
    Navigator.push(
        context,
        MaterialPageRoute<GCWTool>(
            builder: (context) => GCWTool(
                tool: GCWMapView(
                  points: List<GCWMapPoint>.from(points),
                  isEditable: false, // false: open in Map
                  // true:  open in FreeMap
                ),
                id: 'coords_map_view',
                autoScroll: false,
                suppressToolMargin: true)));
  }

  Future<void> _exportCoordinates(BuildContext context, List<GCWMapPoint> points) async {
    showCoordinatesExportDialog(context, points, []);
  }

  List<GCWMapPoint> _getPoints(AdventureData adventure) {
    List<GCWMapPoint> result = [];
    result.add(GCWMapPoint(
        uuid: 'OriginalPoint',
        markerText: adventure.Title,
        point: LatLng(double.parse(adventure.Latitude), double.parse(adventure.Longitude)),
        color: Colors.red));
    adventure.Stages.forEach((stage) {
      result.add(GCWMapPoint(
          uuid: 'StagePoint',
          markerText: adventure.Title + '\n' + stage.Title,
          point: LatLng(double.parse(stage.Latitude), double.parse(stage.Longitude)),
          color: Colors.black));
    });

    return result;
  }

  List<GCWMapPoint> _getAllPoints(List<AdventureData> adventures) {
    List<GCWMapPoint> result = [];
    adventures.forEach((adventure) {
      result.add(GCWMapPoint(
          uuid: 'OriginalPoint',
          markerText: adventure.Title,
          point: LatLng(double.parse(adventure.Latitude), double.parse(adventure.Longitude)),
          color: Colors.red));
      adventure.Stages.forEach((stage) {
        result.add(GCWMapPoint(
            uuid: 'StagePoint',
            markerText:
                (adventure.Title.length > 27 ? adventure.Title.substring(0, 27) : adventure.Title) + '\n' + stage.Title,
            point: LatLng(double.parse(stage.Latitude), double.parse(stage.Longitude)),
            color: Colors.black));
      });
    });

    return result;
  }

  List<List<dynamic>> _outputAdventureData(AdventureData adventure) {
    List<List<dynamic>> result = [
      [i18n(context, 'adventure_labs_lab_id'), adventure.Id],
      [i18n(context, 'adventure_labs_lab_keyImageUrl'), adventure.KeyImageUrl],
      [i18n(context, 'adventure_labs_lab_deeplink'), adventure.DeepLink],
      [i18n(context, 'adventure_labs_lab_description'), adventure.Description],
      [i18n(context, 'adventure_labs_lab_ownerusername'), adventure.OwnerUsername],
      [i18n(context, 'adventure_labs_lab_ratingsaverage'), adventure.RatingsAverage],
      [i18n(context, 'adventure_labs_lab_ratingstotalcount'), adventure.RatingsTotalCount],
      [
        i18n(context, 'adventure_labs_lab_location'),
        formatCoordOutput(LatLng(double.parse(adventure.Latitude), double.parse(adventure.Longitude)),
            {'format': Prefs.get('coord_default_format')} as CoordinateFormat, defaultEllipsoid)
      ],
      [i18n(context, 'adventure_labs_lab_adventurethemes'), adventure.AdventureThemes],
    ];

    return result;
  }

  List<List<dynamic>> _outputAdventureStageCompletionData(AdventureStages stage) {
    List<List<dynamic>> result = [
      [i18n(context, 'adventure_labs_lab_stages_awardvideoyoutubeid'), stage.AwardVideoYouTubeId],
      [i18n(context, 'adventure_labs_lab_stages_completioncode'), stage.CompletionCode],
    ];
    return result;
  }

  List<List<dynamic>> _outputAdventureStageExpertData(AdventureStages stage) {
    List<List<dynamic>> result = [
      [i18n(context, 'adventure_labs_lab_id'), stage.Id],
      [i18n(context, 'adventure_labs_lab_stages_awardimageurl'), stage.AwardImageUrl],
      [i18n(context, 'adventure_labs_lab_stages_multichoiceoptions'), stage.MultiChoiceOptions],
      [i18n(context, 'adventure_labs_lab_stages_keyimage'), stage.KeyImage],
      [i18n(context, 'adventure_labs_lab_keyImageUrl'), stage.KeyImageUrl],
    ];
    return result;
  }

  List<List<dynamic>> _outputAdventureStageData(AdventureStages stage) {
    List<List<dynamic>> result = [
      [i18n(context, 'adventure_labs_lab_description'), stage.Description],
      [
        i18n(context, 'adventure_labs_lab_location'),
        formatCoordOutput(LatLng(double.parse(stage.Latitude), double.parse(stage.Longitude)),
            {'format': Prefs.get('coord_default_format')} as CoordinateFormat, defaultEllipsoid)
      ],
      [i18n(context, 'adventure_labs_lab_stages_geofencingradius'), stage.GeofencingRadius],
      [i18n(context, 'adventure_labs_lab_stages_question'), stage.Question],
      [i18n(context, 'adventure_labs_lab_stages_completionawardmessage'), stage.CompletionAwardMessage],
    ];
    return result;
  }

  List<Widget> _buildOutputAdventureStagesData(AdventureStages stage) {
    List<Widget> result = [];
    if (stage.KeyImageUrl != 'null') {
      result.add(
        Image.network(
          stage.KeyImageUrl,
          fit: BoxFit.cover,
        ),
      );
    }
    result.add(GCWColumnedMultilineOutput(
      data: _outputAdventureStageData(stage),
      flexValues: [1, 3],
    ));
    if (stage.AwardImageUrl != 'null') {
      result.add(
        Image.network(
          stage.AwardImageUrl,
          fit: BoxFit.cover,
        ),
      );
    }
    result.add(GCWColumnedMultilineOutput(
      data: _outputAdventureStageCompletionData(stage),
      flexValues: [1, 3],
    ));
    result.add(
      GCWColumnedMultilineOutput(data: _outputAdventureStageExpertData(stage), flexValues: [1, 3]),
    );
    return result;
  }

  Widget _buildOutputAdventureStages(List<AdventureStages> stages) {
    List<Widget> result = [];
    result.add(GCWTextDivider(
      text: i18n(context, 'adventure_labs_lab_stages'),
    ));
    stages.forEach((stage) {
      result.add(
        GCWExpandableTextDivider(
          expanded: false,
          text: stage.Title,
          child: Column(children: _buildOutputAdventureStagesData(stage)),
        ),
      );
    });
    return Column(
      children: result,
    );
  }

  Widget _buildOutputAdventureMain(AdventureData adventure) {
    List<Widget> result = [];
    result.add(GCWTextDivider(
      text: i18n(context, 'adventure_labs_lab_location'),
      trailing: Row(children: <Widget>[
        GCWIconButton(
          icon: Icons.my_location,
          size: IconButtonSize.SMALL,
          iconColor: themeColors().mainFont(),
          onPressed: () {
            _openInMap(_getPoints(adventure));
          },
        ),
        GCWIconButton(
          icon: Icons.save,
          size: IconButtonSize.SMALL,
          iconColor: themeColors().mainFont(),
          onPressed: () {
            _exportCoordinates(context, _getPoints(adventure));
          },
        ),
      ]),
    ));
    result.add(
      GCWExpandableTextDivider(
        expanded: false,
        text: i18n(context, 'adventure_labs_lab'),
        child: Column(children: _buildOutputAdventureMainData(adventure)),
      ),
    );

    return Column(
      children: result,
    );
  }

  List<Widget> _buildOutputAdventureMainData(AdventureData adventure) {
    List<Widget> result = [];
    if (adventure.KeyImageUrl != 'null') {
      result.add(
        Image.network(
          adventure.KeyImageUrl,
          fit: BoxFit.cover,
        ),
      );
    }
    result.add(GCWColumnedMultilineOutput(
      data: _outputAdventureData(adventure),
      flexValues: [1, 3],
    ));
    return result;
  }

  Widget _buildOutput() {
    return Column(
      children: [
        if (_currentAdventureList.isNotEmpty)
          Column(children: <Widget>[
            GCWTextDivider(
              text: i18n(context, 'adventure_labs_lab_all_location'),
              trailing: Row(children: <Widget>[
                GCWIconButton(
                  icon: Icons.my_location,
                  size: IconButtonSize.SMALL,
                  iconColor: themeColors().mainFont(),
                  onPressed: () {
                    _openInMap(_getAllPoints(_adventureList));
                  },
                ),
                GCWIconButton(
                  icon: Icons.save,
                  size: IconButtonSize.SMALL,
                  iconColor: themeColors().mainFont(),
                  onPressed: () {
                    _exportCoordinates(context, _getAllPoints(_adventureList));
                  },
                ),
              ]),
            ),
            GCWDropDownSpinner(
              index: _currentAdventureIndex,
              items: _currentAdventureList.map((item) => Text(item.toString(), style: gcwTextStyle())).toList(),
              onChanged: (value) {
                setState(() {
                  _currentAdventureIndex = value;
                });
              },
            ),
            _buildOutputAdventureMain(_adventureList[_currentAdventureIndex]),
            _buildOutputAdventureStages(_adventureList[_currentAdventureIndex].Stages),
          ])
        else
          Container()
      ],
    );
  }
}
