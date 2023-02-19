part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/widget/wherigo_analyze.dart';

List<Widget> buildOutputListOfMessageData(BuildContext context, List<WherigoActionMessageElementData> data) {
  List<Widget> resultWidget = [];
  data.forEach((element) {
    switch (element.ActionMessageType) {
      case WHERIGO_ACTIONMESSAGETYPE.TEXT:
        resultWidget.add(Container(
          child: GCWOutput(
            child: element.ActionMessageContent,
            suppressCopyButton: false,
          ),
          padding: EdgeInsets.only(top: DOUBLE_DEFAULT_MARGIN, bottom: DOUBLE_DEFAULT_MARGIN),
        ));
        break;
      case WHERIGO_ACTIONMESSAGETYPE.IMAGE:
        var file = getFileFrom(context, element.ActionMessageContent);
        if (file == null) break;

        resultWidget.add(Container(
          child: GCWImageView(
            imageData: GCWImageViewData(file),
            suppressedButtons: {GCWImageViewButtons.ALL},
          ),
        ));
        break;
      case WHERIGO_ACTIONMESSAGETYPE.BUTTON:
        resultWidget.add(Container(
            child: Text(
                '\n' +
                    i18n(context, 'wherigo_output_action_btn') +
                    ' « ' +
                    element.ActionMessageContent +
                    ' »' +
                    '\n',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold))));
        break;
      case WHERIGO_ACTIONMESSAGETYPE.COMMAND:
        if (element.ActionMessageContent.startsWith('Wherigo.PlayAudio')) {
          String LUAName = element.ActionMessageContent.replaceAll('Wherigo.PlayAudio(', '').replaceAll(')', '');
          if (
          NameToObject[LUAName] == null ||
              NameToObject[LUAName]!.ObjectIndex >= WherigoCartridgeGWCData.MediaFilesContents.length
          )
            break;
          resultWidget.add(GCWSoundPlayer(
            file: GCWFile(
                bytes: WherigoCartridgeGWCData.MediaFilesContents[NameToObject[LUAName]!.ObjectIndex].MediaFileBytes,
                name: NameToObject[LUAName]!.ObjectMedia),
          ));
        } else
          resultWidget.add(GCWOutput(
            child: '\n' + resolveLUAName(element.ActionMessageContent) + '\n',
            suppressCopyButton: true,
          ));
        break;
    }
  });
  return resultWidget;
}


