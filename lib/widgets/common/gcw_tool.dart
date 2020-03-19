import 'package:flutter/material.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:prefs/prefs.dart';

class GCWToolWidget extends StatefulWidget {
  final Widget tool;
  final String toolName;
  final autoScroll;
  final iconPath;
  final String searchStrings;

  var icon;
  var _id = '';
  var _isFavorite = false;

  GCWToolWidget({
    Key key,
    this.tool,
    this.toolName,
    this.autoScroll: true,
    this.iconPath,
    this.searchStrings: ''
  }) : super(key: key) {
    this._id = className(tool);
    this._isFavorite = Prefs.getStringList('favorites').contains('$_id');
    if (iconPath != null)
      this.icon = Image.asset(iconPath, width: defaultListIconSize);
  }

  bool get isFavorite {
    return this._isFavorite;
  }

  void set isFavorite(bool isFavorite) {
    _isFavorite = isFavorite;

    var _favorites = Prefs.getStringList('favorites');
    if (isFavorite && !_favorites.contains(_id)) {
      _favorites.add(_id);
    } else if (!isFavorite) {
      while (_favorites.contains(_id))
        _favorites.remove(_id);
    }
    Prefs.setStringList('favorites', _favorites);
  }

  @override
  _GCWToolWidgetState createState() => _GCWToolWidgetState();
}

class _GCWToolWidgetState extends State<GCWToolWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.toolName),
      ),
      body: _buildBody()
    );
  }

  Widget _buildBody() {
    if (widget.tool is GCWSelection)
      return widget.tool;

    if (widget.autoScroll == false)
      return widget.tool;

    return SingleChildScrollView(
        child: Padding(
          child: widget.tool,
          padding: EdgeInsets.only(
            left: 10,
            right: 10
          ),
        )
    );
  }
}

