import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_delete_alertdialog.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/favorites.dart';
import 'package:gc_wizard/widgets/utils/AppBuilder.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';
import 'package:prefs/prefs.dart';

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
      subtitle: _buildSubtitle(context, tool),
      onTap: () {
        _navigateToSubPage(context);
      },
      leading: tool.icon,
      trailing: IconButton(
        icon: tool.isFavorite ?? false ? Icon(Icons.star) : Icon(Icons.star_border),
        color: ThemeColors.gray,
        onPressed: () {
          if (tool.isFavorite) {
            showDeleteAlertDialog(context, tool.toolName, () {
              tool.isFavorite = false;
              Favorites.update(tool, FavoriteChangeStatus.remove);

              setState(() {
                AppBuilder.of(context).rebuild();
              });
            });
          } else {
            setState(() {
              tool.isFavorite = true;
              Favorites.update(tool, FavoriteChangeStatus.add);

              AppBuilder.of(context).rebuild();
            });
          }
        },
      ),
    );
  }

  _buildSubtitle(BuildContext context, GCWToolWidget tool) {
    var descriptionText;
    if (Prefs.getBool('toollist_show_descriptions') && tool.description != null && tool.description.length > 0) {
      descriptionText = IgnorePointer(
        child: GCWText(
          text: tool.description,
          style: gcwDescriptionTextStyle(),
        )
      );
    }

    var exampleText;
    if (Prefs.getBool('toollist_show_examples') && tool.example != null && tool.example.length > 0) {
      exampleText = IgnorePointer(
        child: GCWText(
          text: tool.example,
          style: gcwDescriptionTextStyle()
        )
      );
    }

    var content;
    if (exampleText != null && descriptionText != null) {
      content = Column(
        children: [
          descriptionText,
          Container(
            child: exampleText,
            padding: EdgeInsets.only(
              top: 10.0
            )
          )
        ],
      );
    } else if (exampleText != null) {
      content = exampleText;
    } else if (descriptionText != null) {
      content = descriptionText;
    }

    return (exampleText ?? descriptionText) != null ? Container(
      child: content,
      padding: EdgeInsets.only(
        left: 10.0
      ),
    ) : null;
  }
}