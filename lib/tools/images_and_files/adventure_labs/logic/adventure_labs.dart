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
  if (jobData?.parameters is! AdventureLabJobData) {
    return Future.value(Adventures(
        AdventureList: [], resultCode: ANALYSE_RESULT_STATUS.NONE, httpCode: '', httpMessage: '', httpBody: ''));
  }
  var adventure = jobData!.parameters as AdventureLabJobData;
  var output = await getAdventureData(adventure.jobDataCoordinate.toLatLng(), adventure.jobDataRadius,
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
  String httpBody = '';

  ANALYSE_RESULT_STATUS resultCode = ANALYSE_RESULT_STATUS.NONE;

  late AdventureData adventure;

  List<AdventureStages> Stages = [];
  try {
    final bodyData = {
      'Origin': {'Latitude': coordinate!.latitude, 'Longitude': coordinate.longitude},
      'RadiusInMeters': radius
    };
    String body = jsonEncode(bodyData);
    final response = await http.post(Uri.parse(SEARCH_ADDRESSV4), headers: HEADERS, body: body);

    httpCode = response.statusCode.toString();
    httpMessage = response.reasonPhrase!;
    httpBody = response.body;

    final Map<String, dynamic> responseJson = json.decode(response.body) as Map<String, dynamic>;
    int totalCount = responseJson["TotalCount"] as int;
    if (httpCode == '200' || totalCount > 0) {
      resultCode = ANALYSE_RESULT_STATUS.OK;
      httpCode = '200';
      List<AdventureData> AdventureList = [];
      List<dynamic> responseItems = responseJson["Items"] as List<dynamic>;
      for (int i = 0; i < totalCount; i++) {
        Map<String, dynamic> item = responseItems[i] as Map<String, dynamic>;

        String AdventureGuid = item["AdventureGuid"].toString();
        String Id = item["Id"].toString();
        String Title = item["Title"].toString();
        String KeyImageUrl = item["KeyImageUrl"].toString();
        String SmartLink = item["SmartLink"].toString();
        String DeepLink = item["DeepLink"].toString();
        String FirebaseDynamicLink = item["FirebaseDynamicLink"].toString();
        String MedianTimeToComplete = item["MedianTimeToComplete"].toString();
        String Description = item["Description"].toString();
        String OwnerPublicGuid = item["OwnerPublicGuid"].toString();
        String OwnerId = item["OwnerId"].toString();
        String Visibility = item["Visibility"].toString();
        String CreatedUtc = item["CreatedUtc"].toString();
        String PublishedUtc = item["PublishedUtc"].toString();
        String IsArchived = item["IsArchived"].toString();
        String RatingsAverage = item["RatingsAverage"].toString();
        String RatingsTotalCount = item["RatingsTotalCount"].toString();
        String Latitude = item["Location"]["Latitude"].toString();
        String Longitude = item["Location"]["Longitude"].toString();
        String StagesTotalCount = item["StagesTotalCount"].toString();
        String IsTest = item["IsTest"].toString();
        String IsComplete = item["IsComplete"].toString();
        String IsFeatured = item["IsFeatured"].toString();
        String AdventureType = item["AdventureType"].toString();
        String CompletionStatus = item["CompletionStatus"].toString();
        String AdventureThemes = item["AdventureThemes"].join(', ') as String;
        String IanaTimezoneId = item["IanaTimezoneId"].toString();

        AdventureList.add(AdventureData(
          AdventureGuid: AdventureGuid,
          Id: Id,
          Title: Title,
          KeyImageUrl: KeyImageUrl,
          SmartLink: SmartLink,
          DeepLink: DeepLink,
          FirebaseDynamicLink: FirebaseDynamicLink,
          Description: Description,
          MedianTimeToComplete: MedianTimeToComplete,
          OwnerPublicGuid: OwnerPublicGuid,
          Visibility: Visibility,
          CreatedUtc: CreatedUtc,
          PublishedUtc: PublishedUtc,
          IsArchived: IsArchived,
          StagesTotalCount: StagesTotalCount,
          IsTest: IsTest,
          IsComplete: IsComplete,
          IsFeatured: IsFeatured,
          AdventureType: AdventureType,
          CompletionStatus: CompletionStatus,
          IanaTimezoneId: IanaTimezoneId,
          RatingsAverage: RatingsAverage,
          RatingsTotalCount: RatingsTotalCount,
          Latitude: Latitude,
          Longitude: Longitude,
          AdventureThemes: AdventureThemes,
          OwnerId: OwnerId,
          OwnerUsername: '',
          Stages: [],
        ));
      }
      for (int i = 0; i < totalCount; i++) {
        adventure = AdventureList[i];
        try {
          // get Details for LabCache with ID
          final responseStages = await http.get(
            Uri.parse(DETAIL_ADDRESS + '?id=' + adventure.Id),
            headers: HEADERS,
          );
          final Map<String, dynamic> responseJsonStages = json.decode(responseStages.body) as Map<String, dynamic>;
          httpCodeStages = responseStages.statusCode.toString();
          httpBody = responseStages.body;
          if (httpCodeStages == '200') {
            String Description = responseJsonStages["Description"].toString();
            String OwnerId = responseJsonStages["OwnerId"].toString();
            String OwnerUsername = responseJsonStages["OwnerUsername"].toString();

            Stages = [];
            var GeocacheSummaries = responseJsonStages["GeocacheSummaries"];
            for (int i = 0; i < (GeocacheSummaries.length as int); i++) {
              var stage = GeocacheSummaries[i];
              Stages.add(AdventureStages(
                Id: stage["Id"].toString(),
                Title: stage["Title"].toString(),
                KeyImageUrl: stage["KeyImageUrl"].toString(),
                AwardImageUrl: stage["AwardImageUrl"].toString(),
                AwardVideoYouTubeId: stage["AwardVideoYouTubeId"].toString(),
                CompletionAwardMessage: stage["CompletionAwardMessage"].toString(),
                Description: stage["Description"].toString(),
                Latitude: stage["Location"]["Latitude"].toString(),
                Longitude: stage["Location"]["Longitude"].toString(),
                GeofencingRadius: stage["GeofencingRadius"].toString(),
                Question: stage["Question"].toString(),
                CompletionCode: stage["CompletionCode"].toString(),
                KeyImage: stage["KeyImage"].toString(),
                MultiChoiceOptions: stage["MultiChoiceOptions"].toString(),
                FindCodeHashBase16: stage["FindCodeHashBase16"].toString(),
                FindCodeHashBase16v2: stage["FindCodeHashBase16v2"].toString(),
                IsComplete: stage["IsComplete"].toString(),
                ChallengeType: stage["ChallengeType"].toString(),
                IsFinal: stage["IsFinal"].toString(),
                UnlockingStages: stage["UnlockingStages"].toString(),
                LastUpdateDateTimeUtc: stage["LastUpdateDateTimeUtc"].toString(),
                DescriptionVideoYouTubeId: stage["DescriptionVideoYouTubeId"].toString(),
                AwardImageAsBase64String: stage["AwardImageAsBase64String"].toString(),
                KeyImageAsBase64String: stage["KeyImageAsBase64String"].toString(),
                DeleteAwardImage: stage["DeleteAwardImage"].toString(),
              ));
            }

            AdventureList[i] = AdventureData(
              AdventureGuid: adventure.AdventureGuid,
              Id: adventure.Id,
              Title: adventure.Title,
              KeyImageUrl: adventure.KeyImageUrl,
              SmartLink: adventure.SmartLink,
              DeepLink: adventure.DeepLink,
              FirebaseDynamicLink: adventure.FirebaseDynamicLink,
              Description: Description,
              MedianTimeToComplete: adventure.MedianTimeToComplete,
              OwnerPublicGuid: adventure.OwnerPublicGuid,
              Visibility: adventure.Visibility,
              CreatedUtc: adventure.CreatedUtc,
              PublishedUtc: adventure.PublishedUtc,
              IsArchived: adventure.IsArchived,
              StagesTotalCount: adventure.StagesTotalCount,
              IsTest: adventure.IsTest,
              IsComplete: adventure.IsComplete,
              IsFeatured: adventure.IsFeatured,
              AdventureType: adventure.AdventureType,
              CompletionStatus: adventure.CompletionStatus,
              IanaTimezoneId: adventure.IanaTimezoneId,
              RatingsAverage: adventure.RatingsAverage,
              RatingsTotalCount: adventure.RatingsTotalCount,
              Latitude: adventure.Latitude,
              Longitude: adventure.Longitude,
              AdventureThemes: adventure.AdventureThemes,
              OwnerId: OwnerId,
              OwnerUsername: OwnerUsername,
              Stages: Stages,
            );

          }
        } catch (exception) {
          httpCode = 'adventure_labs_lab_other_exception_stage';
          httpMessage = exception.toString();
          return Adventures(
              AdventureList: AdventureList,
              resultCode: ANALYSE_RESULT_STATUS.ERROR_OTHER,
              httpCode: httpCode,
              httpMessage: httpMessage,
              httpBody: httpBody);
        }
      }
      return Adventures(
          AdventureList: AdventureList,
          resultCode: resultCode,
          httpCode: httpCode,
          httpMessage: httpMessage,
          httpBody: httpBody);
    } else {
      return Adventures(
          AdventureList: [], resultCode: resultCode, httpCode: httpCode, httpMessage: httpMessage, httpBody: httpBody);
    }
  } catch (exception) {
    httpCode = 'adventure_labs_lab_other_exception_adventure';
    httpMessage = exception.toString();
    return Adventures(
        AdventureList: [],
        resultCode: ANALYSE_RESULT_STATUS.ERROR_OTHER,
        httpCode: httpCode,
        httpMessage: httpMessage,
        httpBody: httpBody);
  } // end catch exception
}
