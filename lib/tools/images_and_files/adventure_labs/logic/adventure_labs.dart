// https://github.com/adv-lab/geocaching-adventure-labs-doc
// https://labs-api.geocaching.com/swagger/ui/index#!/Adventures/Adventures_SearchV3
// https://github.com/mirsch/lab2gpx/blob/master/index.php

import 'dart:convert';
import 'dart:isolate';
import 'dart:async';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

part 'package:gc_wizard/tools/images_and_files/adventure_labs/logic/adventure_labs_classes.dart';
part 'package:gc_wizard/tools/images_and_files/adventure_labs/logic/adventure_labs_data_types.dart';

Future<Adventures> getAdventureDataAsync(GCWAsyncExecuterParameters? jobData) async {
  if (jobData?.parameters is! AdventureLabJobData) return Future.value(Adventures(AdventureList: [], httpCode: '', httpMessage: ''));
  var adventure = jobData!.parameters as AdventureLabJobData;
  var output = await getAdventureData(
      adventure.jobDataCoordinate.toLatLng(),
      adventure.jobDataRadius,
      sendAsyncPort: jobData.sendAsyncPort as SendPort);

  if (jobData.sendAsyncPort != null) {
    jobData.sendAsyncPort?.send(output);
  }
  return output;
}

Future<Adventures> getAdventureData(LatLng? coordinate, int radius, {required SendPort sendAsyncPort}) async {
  String httpCode = '';
  String httpCodeStages = '';
  String httpMessage = '';
  var httpMessageStages = '';

  List<AdventureStages> Stages = [];
  try {
    final response = await http.get(
      Uri.parse(
        SEARCH_ADDRESSV4 +
            '?radiusMeters=' + radius.toString() +
            '&origin.latitude=' + coordinate!.latitude.toString() +
            '&origin.longitude=' + coordinate.longitude.toString()),
      headers: HEADERS,
    );
    final Map<String, dynamic> responseJson = json.decode(response.body) as Map<String, dynamic>;
    httpCode = response.statusCode.toString();
    httpMessage = response.reasonPhrase!;
    if (httpCode == '200') {
      List<AdventureData> AdventureList = [];
      int totalCount = responseJson["TotalCount"] as int;
      List<dynamic> responseItems = responseJson["Items"] as List<dynamic>;
      for (int i = 0; i < totalCount; i++) {
        Map<String, dynamic> item = responseItems[i] as Map<String, dynamic>;

        String AdventureGuid = item["AdventureGuid"].toString();
        String Id = item["Id"].toString();
        String Title = item["Title"].toString();
        String Description = item["Description"].toString();
        String KeyImageUrl = item["KeyImageUrl"].toString();
        String DeepLink = item["DeepLink"].toString();
        String OwnerPublicGuid = item["OwnerPublicGuid"].toString();
        String RatingsAverage = item["RatingsAverage"].toString();
        String RatingsTotalCount = item["RatingsTotalCount"].toString();
        String Latitude = item["Location"]["Latitude"].toString();
        String Longitude = item["Location"]["Longitude"].toString();
        String AdventureThemes = item["AdventureThemes"].join(', ') as String;
        String OwnerUsername = '';
        String OwnerId = '';

        // get Details for LabCache with ID
        final responseStages = await http.get(
          Uri.parse(DETAIL_ADDRESS + Id),
          headers: HEADERS,
        );
        final Map<String, dynamic> responseJsonStages = json.decode(responseStages.body) as Map<String, dynamic>;
        httpCodeStages = responseStages.statusCode.toString();
        httpMessageStages = responseStages.reasonPhrase!;

        if (httpCodeStages == '200') {
          Description = responseJsonStages["Description"].toString();
          OwnerUsername = responseJsonStages["OwnerUsername"].toString();
          OwnerId = responseJsonStages["OwnerId"].toString();

          Stages = [];
          responseJsonStages["GeocacheSummaries"].forEach((Map<String, dynamic> stage) {
            Stages.add(
                AdventureStages(
                  Id: stage["Id"].toString(),
                  Title: stage["Title"].toString(),
                  Description: stage["Description"].toString(),
                  AwardImageUrl: stage["AwardImageUrl"].toString(),
                  AwardVideoYouTubeId: stage["AwardVideoYouTubeId"].toString(),
                  CompletionAwardMessage: stage["CompletionAwardMessage"].toString(),
                  CompletionCode: stage["CompletionCode"].toString(),
                  GeofencingRadius: stage["GeofencingRadius"].toString(),
                  Question: stage["Question"].toString(),
                  KeyImage: stage["KeyImage"].toString(),
                  KeyImageUrl: stage["KeyImageUrl"].toString(),
                  Latitude: stage["Location"]["Latitude"].toString(),
                  Longitude: stage["Location"]["Longitude"].toString(),
                  MultiChoiceOptions: stage["MultiChoiceOptions"].toString(),
                )
            );
          });
        }

        AdventureList.add(
          AdventureData(
            AdventureGuid: AdventureGuid,
            Id: Id,
            Title: Title,
            KeyImageUrl: KeyImageUrl,
            DeepLink: DeepLink,
            Description: Description,
            OwnerPublicGuid: OwnerPublicGuid,
            RatingsAverage: RatingsAverage,
            RatingsTotalCount: RatingsTotalCount,
            Latitude: Latitude,
            Longitude: Longitude,
            AdventureThemes: AdventureThemes,
            OwnerId: OwnerId,
            OwnerUsername: OwnerUsername,
            Stages: Stages,
          )
        );
      }
      return Adventures(
            AdventureList: AdventureList,
            httpCode: httpCode,
            httpMessage: httpMessage);
    }
    else {
      print('NOT OK');
      print(httpCode);
      print(httpMessage);
      return Adventures(
            AdventureList: [],
            httpCode: httpCode,
            httpMessage: httpMessage);
    }
  } catch (exception) {
    httpCode = '503';
    httpMessage = exception.toString();
    return Adventures(
          AdventureList: [],
          httpCode: httpCode,
          httpMessage: httpMessage);
  } // end catch exception
}