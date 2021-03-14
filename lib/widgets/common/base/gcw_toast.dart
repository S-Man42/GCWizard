import 'package:fluttertoast/fluttertoast.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

showToast(String text) {
  Fluttertoast.showToast(
    msg: text,
    timeInSecForIosWeb: 3,
    toastLength: Toast.LENGTH_LONG,
    webShowClose: true,
    webPosition: 'center',
    fontSize: defaultFontSize(),
    backgroundColor: themeColors().mainFont(),
    textColor: themeColors().primaryBackground()
  );
}