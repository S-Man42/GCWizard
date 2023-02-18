part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/widget/wherigo_analyze.dart';

GCWFile? getFileFrom(BuildContext context, String resourceName) {
  Uint8List? filedata;
  String? filename;
  int fileindex = 0;
  try {
    if (WherigoCartridgeGWCData.MediaFilesContents.length > 1) {
      WherigoCartridgeLUAData.Media.forEach((element) {
        if (element.MediaLUAName == resourceName) {
          filename = element.MediaFilename;
          filedata = WherigoCartridgeGWCData.MediaFilesContents[fileindex + 1].MediaFileBytes;
        }
        fileindex++;
      });
      if (filedata != null)
        return GCWFile(bytes: filedata!, name: filename);
    } else
      return null;
  } catch (exception) {
    errorMsg_MediaFiles = [];
    errorMsg_MediaFiles.add('');
    errorMsg_MediaFiles.add(i18n(context, 'wherigo_error_runtime_widget'));
    errorMsg_MediaFiles.add(i18n(context, 'wherigo_error_runtime'));
    errorMsg_MediaFiles.add(i18n(context, 'wherigo_error_runtime_exception'));
    errorMsg_MediaFiles.add(exception.toString());
    errorMsg_MediaFiles.add(i18n(context, 'wherigo_error_gwc_mediafiles'));
    errorMsg_MediaFiles.add(i18n(context, 'wherigo_error_hint_2'));
    showToast(
        i18n(context, 'wherigo_error_runtime') +
            '\n' +
            i18n(context, 'wherigo_error_runtime_exception') +
            '\n' +
            i18n(context, 'wherigo_error_gwc_mediafiles') +
            '\n' +
            exception.toString() +
            '\n\n' +
            i18n(context, 'wherigo_error_hint_2'),
        duration: 45);
  }
}

String resolveLUAName(String chiffre) {
  String resolve(List<String> chiffreList, String joinPattern) {
    if (NameToObject[chiffreList[0]] == null)
      return '';

    List<String> result = [];
    result.add(NameToObject[chiffreList[0]]!.ObjectType.toString().split('.')[1] +
        ' ' +
        NameToObject[chiffreList[0]]!.ObjectName);
    for (int i = 1; i < chiffreList.length; i++) result.add(chiffreList[i]);
    return result.join(joinPattern);
  }

  if (chiffre.split('.').length > 1) {
    List<String> listChiffre = chiffre.split('.');
    if (NameToObject[listChiffre[0]] != null) {
      return resolve(listChiffre, '.');
    } else
      return chiffre;
  } else if (chiffre.split(':').length > 1) {
    List<String> listChiffre = chiffre.split(':');
    if (NameToObject[listChiffre[0]] != null) {
      return resolve(listChiffre, ':');
    } else
      return chiffre;
  } else
    return chiffre;
}

buildImageView(BuildContext context, bool condition, String fileSource) {
  if (!condition) return Container();

  var file = getFileFrom(context, fileSource);

  if (file == null) return Container();


  return GCWImageView(
    imageData: GCWImageViewData(file),
    suppressedButtons: {GCWImageViewButtons.ALL},
  );
}


void getErrorMessagesFromLUAAnalyzation(List<String> _errorMsg, BuildContext context) {
  if (WherigoCartridgeLUAData.ResultStatus == WHERIGO_ANALYSE_RESULT_STATUS.OK) {
    _errorMsg.add(i18n(context, 'wherigo_error_runtime_lua'));
    _errorMsg.add(i18n(context, 'wherigo_error_no_error'));
  } else {
    _errorMsg.add(i18n(context, 'wherigo_error_runtime_lua'));
    for (int i = 0; i < WherigoCartridgeLUAData.ResultsLUA.length; i++)
      if (WherigoCartridgeLUAData.ResultsLUA[i].startsWith('wherigo'))
        _errorMsg.add(i18n(context, WherigoCartridgeLUAData.ResultsLUA[i]));
      else
        _errorMsg.add(WherigoCartridgeLUAData.ResultsLUA[i]);
  }
}

void getErrorMessagesFromGWCAnalyzation(List<dynamic> _errorMsg, BuildContext context) {
  if (WherigoCartridgeGWCData.ResultStatus == WHERIGO_ANALYSE_RESULT_STATUS.OK) {
    _errorMsg.add(i18n(context, 'wherigo_error_runtime_gwc'));
    _errorMsg.add(i18n(context, 'wherigo_error_no_error'));
    _errorMsg.add('');
  } else {
    _errorMsg.add(i18n(context, 'wherigo_error_runtime_gwc'));
    for (int i = 0; i < WherigoCartridgeGWCData.ResultsGWC.length; i++)
      if (WherigoCartridgeGWCData.ResultsGWC[i].startsWith('wherigo'))
        _errorMsg.add(i18n(context, WherigoCartridgeGWCData.ResultsGWC[i]));
      else
        _errorMsg.add(WherigoCartridgeGWCData.ResultsGWC[i]);
  }
}


String getCreationDate(BuildContext context, int duration) {
  // Date of creation   ; Seconds since 2004-02-10 01:00:00
  if (duration == null) return formatDate(context, DateTime(2004, 2, 1, 1, 0, 0, 0).toString());
  return formatDate(context, DateTime(2004, 2, 1, 1, 0, 0, 0).add(Duration(seconds: duration)).toString());
}

String formatDate(BuildContext context, String datetime) {
  String loc = Localizations.localeOf(context).toString();
  return (datetime == null) ? DateTime.parse(WHERIGO_NULLDATE).toString() : DateFormat.yMd(loc).add_jms().format(DateTime.parse(datetime)).toString();
}
