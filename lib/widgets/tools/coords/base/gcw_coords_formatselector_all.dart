import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_formatselector.dart';

class GCWCoordsFormatSelectorAll extends GCWCoordsFormatSelector {

  const GCWCoordsFormatSelectorAll({Key key, onChanged, format}) :
        super(key: key, onChanged: onChanged, format: format);

  @override
  List<GCWDropDownMenuItem> getDropDownItems(BuildContext context) {
    var items = super.getDropDownItems(context);
    items.insert(0, GCWDropDownMenuItem(
        value: keyCoordsALL, child: i18n(context, 'coords_formatconverter_all_formats')));
    return items;
  }
}

