import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gc_wizard/i18n/app_language.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/i18n/supported_locales.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/utils/default_settings.dart';
import 'package:gc_wizard/widgets/common/gcw_clipboard_editor.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/main_view.dart';
import 'package:gc_wizard/widgets/tools/coords/utils/navigation_service.dart';
import 'package:gc_wizard/widgets/utils/AppBuilder.dart';
import 'package:prefs/prefs.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Prefs.init();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  initDefaultSettings();

  runApp(App(
    appLanguage: appLanguage,
  ));
}

class App extends StatelessWidget {
  final AppLanguage appLanguage;

  App({this.appLanguage});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLanguage>(
        create: (_) => appLanguage,
        child: Consumer<AppLanguage>(builder: (context, model, child) {
          return AppBuilder(builder: (context) {
            return MaterialApp(
              title: 'GC Wizard',
              supportedLocales: SUPPORTED_LOCALES.keys,
              locale: model.appLocal,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              theme: buildTheme(),
              debugShowCheckedModeBanner: false,
              home: MainView(),
              navigatorKey: NavigationService.instance.navigationKey,
              routes: {
                // Required extra way because normal Navigator.of(context) way
                // crashes because of some NULL problems on TextSelectionControls menu
                'clipboard_editor': (BuildContext context) => GCWTool(
                    tool: GCWClipboardEditor(), toolName: i18n(context, 'clipboardeditor_title'), i18nPrefix: '')
              },
            );
          });
        }));
  }
}
