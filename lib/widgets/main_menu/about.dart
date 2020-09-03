import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_divider.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/main_menu/gcw_mainmenuentry_stub.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

final ABOUT_MAINTAINER = 'Mark \'S-Man42\' Lorenz';

class About extends StatefulWidget {
  @override
  AboutState createState() => AboutState();
}

class AboutState extends State<About> {

  var packageInfo = PackageInfo();

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = info;
    });
  }

  _buildUrl(String key) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: GCWText(
              text: i18n(context, 'about_${key}')
            ),
            flex: 2
          ),
          Expanded(
            child: InkWell(
              child: Text(
                i18n(context, 'about_${key}_url_text'),
                style: gcwHyperlinkTextStyle(),
              ),
              onTap: () {
                launch(i18n(context, 'about_${key}_url'));
              },
            ),
            flex: 3
          )
        ]
      ),
      padding: EdgeInsets.only(
        top: 15,
        bottom: 10
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    var content = Column(
      children: <Widget>[
        Text(
          'GC Wizard - Geocache Wizard',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: defaultFontSize()),
        ),
        GCWDivider(),
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: GCWText(
                  text: i18n(context, 'about_version')
                ),
                flex: 2
              ),
              Expanded(
                child: GCWText(
                  text: '${packageInfo.version} (Build: ${packageInfo.buildNumber})'
                ),
                flex: 3
              )
            ]
          ),
          padding: EdgeInsets.only(
            top: 15
          )
        ),
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: GCWText(
                  text: i18n(context, 'about_maintainer')
                ),
                flex: 2
              ),
              Expanded(
                child: GCWText(
                  text: ABOUT_MAINTAINER
                ),
                flex: 3
              )
            ]
          ),
          padding: EdgeInsets.only(
            top: 15,
            bottom: 10
          )
        ),
        GCWDivider(),
        _buildUrl('contact_email'),
        _buildUrl('faq'),
        _buildUrl('blog'),
        _buildUrl('twitter'),
        _buildUrl('facebook'),
        _buildUrl('webversion'),
        GCWDivider(),
        _buildUrl('license'),
        _buildUrl('github'),
        GCWDivider(),
        _buildUrl('privacypolicy'),
        GCWDivider(),
        Container(
          child: Column(
            children: <Widget>[
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: i18n(context, 'about_specialthanks') + '\n',
                      style: TextStyle(fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: 'Daniel \'Eisbehr\' K. (Maintainer GCC)'
                        + '\n'
                    )
                  ],
                  style: TextStyle(fontSize: defaultFontSize())
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: i18n(context, 'about_specialsupport') + '\n',
                      style: TextStyle(fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: 'Andy \'Puma66\''
                        + '\n'
                    )
                  ],
                  style: TextStyle(fontSize: defaultFontSize())
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: i18n(context, 'about_contributors') + '\n',
                      style: TextStyle(fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text:
                        [
                          '\'\xc4ggsb\xe4rde\' (Symbol Tables)',
                          '\'capoaira\' (Code)',
                          'Dennis \'dennistreysa\' (Code)',
                          '\'Geo-Link\' (Hardware & Symbol Tables)',
                          'Karl B. (Coords Algorithms)',
                          'Michael D. (Symbol Tables)',
                          'Mike B. (Symbol Tables)',
                          '\'moenk\' (GK Coords)',
                          '\'Schnatt\' (Symbol Tables)',
                          '\'TeamBirdy2404\' (Symbol Tables)',
                          'Thomas \'TMZ\' Z. (Code & Symbol Tables)',
                          'Udo J. (Code)',
                          '\'wollpirat\' (Food, Tea & more)'
                        ].join('\n') + '\n'
                    )
                  ],
                  style: TextStyle(fontSize: defaultFontSize())
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: i18n(context, 'about_testers') + '\n',
                      style: TextStyle(fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text:
                        [
                          'Andreas E.',
                          '\'Headbanger-Berlin\'',
                          'Felix Z.',
                          '\'Filu - Aye, Käppn! - 43\' & \'Stormi - Aaarrh - 2061\'',
                          'Frank \'Wizardland\' (podKst.de)',
                          'Franz K.',
                          'Johannes C.',
                          '\'Klumpenkukuk\'',
                          '\'LupiMus\'',
                          '\'mahoplus\'',
                          'Martin Sch.',
                          '\'Schnatt\'',
                          'Palk \'geogedoens.de\'',
                          '\'Pamakaru\'',
                          'Paweł B.',
                          '\'radioscout\'',
                          '\'radlerandi\'',
                          '\'Sechsfüssler\'',
                          'Stefan J.',
                          '\'tebarius\'',
                          '\'tomcat06\'',
                        ].join(', ')
                    )
                  ],
                  style: TextStyle(fontSize: defaultFontSize())
                ),
              ),
            ],
          ),
          padding: EdgeInsets.only(
            top: 15,
            bottom: 10
          ),
        ),
        GCWDivider(),
        Container(
          child: GCWText(
            align: Alignment.center,
            textAlign: TextAlign.center,
            text: i18n(context, 'about_notfornazis')
          ),
          padding: EdgeInsets.only(
            top: 15,
            bottom: 10
          ),
        )

      ],
    );

    return GCWMainMenuEntryStub(
      content: content
    );
  }
}