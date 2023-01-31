import 'package:fluttertoast/fluttertoast.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/utils/common_widget_utils.dart';

showToast(String text, {int duration = 3}) {
  const _MAX_LENGTH = 800;

  Fluttertoast.showToast(
      msg: text.length > _MAX_LENGTH ? text.substring(0, _MAX_LENGTH) + '...' : text,
      timeInSecForIosWeb: duration,
      toastLength: Toast.LENGTH_LONG,
      webShowClose: true,
      webPosition: 'center',
      fontSize: defaultFontSize(),
      backgroundColor: themeColors().mainFont(),
      textColor: themeColors().primaryBackground());
}
