import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/tools/utils/common_widget_utils/widget/common_widget_utils.dart';

enum FavoriteChangeStatus { add, remove }

class Favorites {
  static List<GCWTool> toolList;

  static update(GCWTool _tool, FavoriteChangeStatus change) {
    switch (change) {
      case FavoriteChangeStatus.add:
        toolList.add(_tool);
        break;
      case FavoriteChangeStatus.remove:
        toolList.remove(_tool);
        break;
    }

    _sortList();
  }

  static void _sortList() {
    toolList.sort((a, b) => sortToolListAlphabetically(a, b));
  }

  static initialize() {
    toolList = registeredTools.where((widget) => widget.isFavorite).toList();
    _sortList();
  }
}
