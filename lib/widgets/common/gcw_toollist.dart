import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/favorites.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';

class GCWToolList extends StatefulWidget {
  final toolList;
  final Function onChangedFavorite;

  const GCWToolList({Key key, this.toolList, this.onChangedFavorite}) : super(key: key);

  _GCWToolListState createState() => _GCWToolListState();
}

class _GCWToolListState extends State<GCWToolList> {
  @override
  Widget build(BuildContext context) {
    return _buildItems();
  }

  Widget _buildItems() {
    return ListView.separated(
      itemCount: widget.toolList.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (BuildContext context, int i) {
        return _buildRow(context, widget.toolList[i]);
      },
    );
  }

  Widget _buildRow(BuildContext context, GCWToolWidget tool) {
    Future _navigateToSubPage(context) async {
      Navigator.push(context, NoAnimationMaterialPageRoute(builder: (context) => tool));
    }

    return ListTile(
      title: Text(
        tool.toolName,
        style: TextStyle(fontSize: defaultFontSize()),
      ),
      onTap: () {
        _navigateToSubPage(context);
      },
      leading: tool.icon,
      trailing: IconButton(
        icon: tool.isFavorite ?? false ? Icon(Icons.star) : Icon(Icons.star_border),
        color: ThemeColors.gray,
        onPressed: () {
          setState(() {
            tool.isFavorite = !tool.isFavorite;
            Favorites.update(tool, tool.isFavorite ? FavoriteChangeStatus.add : FavoriteChangeStatus.remove);
          });
        },
      ),
    );
  }
}