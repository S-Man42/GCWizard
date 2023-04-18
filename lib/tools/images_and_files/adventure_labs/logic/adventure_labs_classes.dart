part of 'package:gc_wizard/tools/images_and_files/adventure_labs/logic/adventure_labs.dart';

class Adventures {
  final List<AdventureData> AdventureList;
  final String httpCode;
  final String httpMessage;
  final String httpBody;

  Adventures({
    required this.AdventureList,
    required this.httpCode,
    required this.httpMessage,
    required this.httpBody,
  });
}

class AdventureData {
  final String AdventureGuid;
  final String Id;
  final String Title;
  final String KeyImageUrl;
  final String DeepLink;
  final String Description;
  final String OwnerPublicGuid;
  final String RatingsAverage;
  final String RatingsTotalCount;
  final String Latitude;
  final String Longitude;
  final String AdventureThemes;
  final String OwnerUsername;
  final String OwnerId;
  final List<AdventureStages> Stages;
  AdventureData(
      {
        this.AdventureGuid = '',
        this.Id = '',
        this.Title = '',
        this.KeyImageUrl = '',
        this.DeepLink = '',
        this.Description = '',
        this.OwnerPublicGuid = '',
        this.RatingsAverage = '',
        this.RatingsTotalCount = '',
        this.Latitude = '',
        this.Longitude = '',
        this.AdventureThemes = '',
        this.OwnerUsername = '',
        this.OwnerId = '',
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

