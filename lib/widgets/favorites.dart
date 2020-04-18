import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/registry.dart';

enum FavoriteChangeStatus {
  add, remove
}

class Favorites {
  static List<GCWToolWidget> toolList;

  static update(GCWToolWidget _tool, FavoriteChangeStatus change) {
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
    toolList.sort((a, b) {
      return a.toolName.compareTo(b.toolName);
    });
  }

  static initialize() {
    toolList = Registry.toolList.where((widget) => widget.isFavorite).toList();
    _sortList();
  }
}