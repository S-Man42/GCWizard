import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/main_menu/about.dart';
import 'package:gc_wizard/widgets/main_menu/gcw_mainmenuentry_stub.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';
import 'package:url_launcher/url_launcher.dart';

class CallForContribution extends StatefulWidget {
  @override
  CallForContributionState createState() => CallForContributionState();
}

class CallForContributionState extends State<CallForContribution> {
  @override
  Widget build(BuildContext context) {

    var content = RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: i18n(context, 'callforcontribution_1'),
            style: TextStyle(fontWeight: FontWeight.bold)
          ),
          TextSpan(
            text: i18n(context, 'callforcontribution_2')
          ),
          TextSpan(
            text: i18n(context, 'callforcontribution_3'),
            style: TextStyle(fontWeight: FontWeight.bold)
          ),
          TextSpan(
            text: i18n(context, 'callforcontribution_4')
          ),
          TextSpan(
            text: i18n(context, 'callforcontribution_5'),
            style: TextStyle(fontWeight: FontWeight.bold)
          ),
          TextSpan(
            text: i18n(context, 'callforcontribution_6'),
          ),
          TextSpan(
            text: i18n(context, 'callforcontribution_7'),
            recognizer: new TapGestureRecognizer()
              ..onTap = () {
                launch('https://github.com/S-Man42/GCWizard');
              },
            style: gcwHyperlinkTextStyle()
          ),
          TextSpan(
            text: i18n(context, 'callforcontribution_8'),
          ),
          TextSpan(
            text: i18n(context, 'callforcontribution_9'),
            style: TextStyle(fontWeight: FontWeight.bold)
          ),
          TextSpan(
            text: i18n(context, 'callforcontribution_10'),
          ),
          TextSpan(
              text: i18n(context, 'callforcontribution_11'),
              style: TextStyle(fontWeight: FontWeight.bold)
          ),
          TextSpan(
            text: i18n(context, 'callforcontribution_12'),
          ),
          TextSpan(
            text: i18n(context, 'callforcontribution_13'),
          ),
          TextSpan(
              text: i18n(context, 'callforcontribution_14'),
              style: TextStyle(fontWeight: FontWeight.bold)
          ),
          TextSpan(
            text: i18n(context, 'callforcontribution_15'),
          ),
          TextSpan(
              text: i18n(context, 'callforcontribution_16'),
              style: TextStyle(fontWeight: FontWeight.bold)
          ),
          TextSpan(
            text: i18n(context, 'callforcontribution_17'),
          ),
          TextSpan(
              text: i18n(context, 'callforcontribution_18'),
              style: TextStyle(fontWeight: FontWeight.bold)
          ),
          TextSpan(
            text: i18n(context, 'callforcontribution_19'),
          ),
          TextSpan(
              text: i18n(context, 'callforcontribution_20'),
              style: TextStyle(fontWeight: FontWeight.bold)
          ),
          TextSpan(
            text: i18n(context, 'callforcontribution_21'),
          ),
          TextSpan(
              text: i18n(context, 'callforcontribution_22'),
              style: TextStyle(fontWeight: FontWeight.bold)
          ),
          TextSpan(
            text: i18n(context, 'callforcontribution_23'),
          ),
          TextSpan(
            text: i18n(context, 'callforcontribution_24'),
            recognizer: new TapGestureRecognizer()
              ..onTap = () {
                Navigator.of(context).push(NoAnimationMaterialPageRoute(
                    builder: (context) => Registry.toolList.firstWhere((tool) => className(tool.tool) == className(About())))
                );
              },
            style: gcwHyperlinkTextStyle()
          ),
          TextSpan(
            text: i18n(context, 'callforcontribution_25'),
            style: TextStyle(fontWeight: FontWeight.bold)
          ),
        ],
        style: TextStyle(fontSize: defaultFontSize())
      ),
    );

    return GCWMainMenuEntryStub(
      content: content
    );
  }
}