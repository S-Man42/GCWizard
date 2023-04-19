part of 'package:gc_wizard/tools/images_and_files/adventure_labs/logic/adventure_labs.dart';

class Adventures {
  final List<AdventureData> AdventureList;
  final ANALYSE_RESULT_STATUS resultCode;
  final String httpCode;
  final String httpMessage;
  final String httpBody;

  Adventures({
    required this.AdventureList,
    required this.httpCode,
    required this.resultCode,
    required this.httpMessage,
    required this.httpBody,
  });
}

class AdventureData {
  final String AdventureGuid;
  final String Id;
  final String Title;
  final String KeyImageUrl;
  final String SmartLink;
  final String DeepLink;
  final String FirebaseDynamicLink;
  final String MedianTimeToComplete;
  final String Description;
  final String OwnerPublicGuid;
  final String RatingsAverage;
  final String RatingsTotalCount;
  final String CreatedUtc;
  final String PublishedUtc;
  final String IsArchived;
  final String Latitude;
  final String Longitude;
  final String AdventureType;
  final String AdventureThemes;
  final String OwnerUsername;
  final String OwnerId;
  final String Visibility;
  final String IsTest;
  final String IsComplete;
  final String CompletionStatus;
  final String IsFeatured;
  final String IanaTimezoneId;
  final String StagesTotalCount;
  final List<AdventureStages> Stages;

  AdventureData(
      { this.CreatedUtc = '',
        this.PublishedUtc = '',
        this.IsArchived = 'false',
        this.AdventureType = '0',
        this.IsTest = 'false',
        this.IsComplete = 'false',
        this.AdventureGuid = '',
        this.Id = '',
        this.Title = '',
        this.KeyImageUrl = '',
        this.SmartLink = '',
        this.DeepLink = '',
        this.FirebaseDynamicLink = '',
        this.MedianTimeToComplete = '',
        this.Description = '',
        this.OwnerPublicGuid = '',
        this.RatingsAverage = '',
        this.RatingsTotalCount = '',
        this.Latitude = '',
        this.Longitude = '',
        this.AdventureThemes = '',
        this.OwnerUsername = '',
        this.OwnerId = '',
        this.Visibility = '',
        this.IanaTimezoneId = '',
        this.IsFeatured = 'false',
        this.CompletionStatus = '0',
        this.StagesTotalCount = '0',
        required this.Stages,
      });
}

class AdventureStages {
  final String Id;
  final String Title;
  final String Description;
  final String KeyImageUrl;
  final String Latitude;
  final String Longitude;
  final String AwardImageUrl;
  final String AwardVideoYouTubeId;
  final String CompletionAwardMessage;
  final String GeofencingRadius;
  final String Question;
  final String CompletionCode;
  final String MultiChoiceOptions;
  final String KeyImage;
  final String FindCodeHashBase16;
  final String FindCodeHashBase16v2;
  final String IsComplete;
  final String ChallengeType;
  final String IsFinal;
  final String UnlockingStages;
  final String LastUpdateDateTimeUtc;
  final String DescriptionVideoYouTubeId;
  final String AwardImageAsBase64String;
  final String KeyImageAsBase64String;
  final String DeleteAwardImage;


  AdventureStages({
    this.Id = '',
    this.Title = '',
    this.Description = '',
    this.KeyImageUrl = '',
    this.Latitude = '',
    this.Longitude = '',
    this.AwardImageUrl = '',
    this.AwardVideoYouTubeId = '',
    this.CompletionAwardMessage = '',
    this.GeofencingRadius = '',
    this.Question = '',
    this.CompletionCode = '',
    this.MultiChoiceOptions = '',
    this.KeyImage = '',
    this.FindCodeHashBase16 = '',
    this.FindCodeHashBase16v2 = '',
    this.IsComplete = '',
    this.ChallengeType = '',
    this.IsFinal = '',
    this.UnlockingStages = '',
    this.LastUpdateDateTimeUtc = '',
    this.DescriptionVideoYouTubeId = '',
    this.AwardImageAsBase64String = '',
    this.KeyImageAsBase64String = '',
    this.DeleteAwardImage = '',
  });
}

class AdventureLabJobData {
  final BaseCoordinate jobDataCoordinate;
  final int jobDataRadius;

  AdventureLabJobData({
    required this.jobDataCoordinate,
    required this.jobDataRadius,
  });
}

