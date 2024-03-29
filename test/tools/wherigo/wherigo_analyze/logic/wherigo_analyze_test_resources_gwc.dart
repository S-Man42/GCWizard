import 'package:flutter_test/flutter_test.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze.dart';

WherigoCartridgeGWC testOutputGWC = const WherigoCartridgeGWC(
    Signature: '',
    NumberOfObjects: 0,
    MediaFilesHeaders: [],
    MediaFilesContents: [],
    HeaderLength: 0,
    Splashscreen: 0,
    SplashscreenIcon: 0,
    Latitude: 0.0,
    Longitude: 0.0,
    Altitude: 0.0,
    DateOfCreation: 0,
    TypeOfCartridge: '',
    Player: '',
    PlayerID: 0,
    CartridgeLUAName: '',
    CartridgeGUID: '',
    CartridgeDescription: '',
    StartingLocationDescription: '',
    Version: '',
    Author: '',
    Company: '',
    RecommendedDevice: '',
    LengthOfCompletionCode: 0,
    CompletionCode: '',
    ResultStatus: WHERIGO_ANALYSE_RESULT_STATUS.NONE,
    ResultsGWC: []);

void expectGWC(
  WherigoCartridgeGWC actual,
  WherigoCartridgeGWC expected,
) {
  expect(actual.Signature, expected.Signature);
  expect(actual.NumberOfObjects, expected.NumberOfObjects);
  expect(actual.MediaFilesHeaders, expected.MediaFilesHeaders);
  expect(actual.MediaFilesContents, expected.MediaFilesContents);
  expect(actual.HeaderLength, expected.HeaderLength);
  expect(actual.Splashscreen, expected.Splashscreen);
  expect(actual.SplashscreenIcon, expected.SplashscreenIcon);
  expect(actual.Latitude, expected.Latitude);
  expect(actual.Longitude, expected.Longitude);
  expect(actual.Altitude, expected.Altitude);
  expect(actual.DateOfCreation, expected.DateOfCreation);
  expect(actual.TypeOfCartridge, expected.TypeOfCartridge);
  expect(actual.Player, expected.Player);
  expect(actual.PlayerID, expected.PlayerID);
  expect(actual.CartridgeLUAName, expected.CartridgeLUAName);
  expect(actual.CartridgeGUID, expected.CartridgeGUID);
  expect(actual.CartridgeDescription, expected.CartridgeDescription);
  expect(actual.StartingLocationDescription, expected.StartingLocationDescription);
  expect(actual.Version, expected.Version);
  expect(actual.Author, expected.Author);
  expect(actual.Company, expected.Company);
  expect(actual.RecommendedDevice, expected.RecommendedDevice);
  expect(actual.LengthOfCompletionCode, expected.LengthOfCompletionCode);
  expect(actual.CompletionCode, expected.CompletionCode);
  expect(actual.ResultStatus, expected.ResultStatus);
  expect(actual.ResultsGWC, expected.ResultsGWC);
}
