import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/favorites.dart';
import 'package:gc_wizard/widgets/main_menu.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/base_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/brainfk_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/coords_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/dates_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/e_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/phi_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/pi_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/primes_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/rotation_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/symbol_table_selection.dart';
import 'package:gc_wizard/widgets/tools/crypto/adfgvx.dart';
import 'package:gc_wizard/widgets/tools/crypto/atbasch.dart';
import 'package:gc_wizard/widgets/tools/crypto/bacon.dart';
import 'package:gc_wizard/widgets/tools/crypto/caesar.dart';
import 'package:gc_wizard/widgets/tools/crypto/enigma/enigma.dart';
import 'package:gc_wizard/widgets/tools/crypto/gronsfeld.dart';
import 'package:gc_wizard/widgets/tools/crypto/kenny.dart';
import 'package:gc_wizard/widgets/tools/crypto/playfair.dart';
import 'package:gc_wizard/widgets/tools/crypto/polybios.dart';
import 'package:gc_wizard/widgets/tools/crypto/skytale.dart';
import 'package:gc_wizard/widgets/tools/crypto/substitution.dart';
import 'package:gc_wizard/widgets/tools/crypto/trithemius.dart';
import 'package:gc_wizard/widgets/tools/crypto/vigenere.dart';
import 'package:gc_wizard/widgets/tools/encodings/ascii_values.dart';
import 'package:gc_wizard/widgets/tools/encodings/letter_values.dart';
import 'package:gc_wizard/widgets/tools/encodings/morse.dart';
import 'package:gc_wizard/widgets/tools/encodings/roman_numbers.dart';
import 'package:gc_wizard/widgets/tools/encodings/scrabble.dart';
import 'package:gc_wizard/widgets/tools/formula_solver/formula_solver.dart';
import 'package:gc_wizard/widgets/tools/math_and_physics/numeralbases.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:prefs/prefs.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _isSearching = false;
  final _searchController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var _searchText = '';

  @override
  void initState() {
    super.initState();
    Prefs.init();

    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text.isEmpty ? '' : _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    Prefs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Registry.initialize(context);
    Favorites.initialize();

    final List<GCWToolWidget> _toolList =
      Registry.toolList.where((element) {
        return [
          className(ADFGVX()),
          className(ASCIIValues()),
          className(Atbash()),
          className(Bacon()),
          className(BaseSelection()),
          className(BrainfkSelection()),
          className(Caesar()),
          className(CoordsSelection()),
          className(DatesSelection()),
          className(Enigma()),
          className(ESelection()),
          className(FormulaSolver()),
          className(Gronsfeld()),
          className(Kenny()),
          className(LetterValues()),
          className(Morse()),
          className(NumeralBases()),
          className(PhiSelection()),
          className(PiSelection()),
          className(Playfair()),
          className(Polybios()),
          className(PrimesSelection()),
          className(RomanNumbers()),
          className(RotationSelection()),
          className(Scrabble()),
          className(Skytale()),
          className(Substitution()),
          className(SymbolTableSelection()),
          className(Trithemius()),
          className(Vigenere()),
        ].contains(className(element.tool));
      }).toList();

    _toolList.sort((a, b){
      return a.toolName.toLowerCase().compareTo(b.toolName.toLowerCase());
    });

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.list)
              ),
              Tab(
                icon: Icon(Icons.star),
              ),
            ],
          ),
          leading: _buildIcon(),
          title: _buildTitleAndSearchTextField(),
          actions: <Widget>[
            _buildSearchActionButton()
          ]
        ),
        drawer: buildMainMenu(context),
        body: TabBarView(
          children: [
            GCWToolList(
              toolList: _isSearching && _searchText.length > 0
                ? _getSearchedList(Registry.toolList)
                : _toolList
            ),
            GCWToolList(
              toolList: _isSearching && _searchText.length > 0
                ? _getSearchedList(Favorites.toolList)
                : Favorites.toolList
            ),
          ],
        ),
      ),
    );
  }
  _buildSearchActionButton() {
    return IconButton(
      icon: Icon(_isSearching ? Icons.close : Icons.search),
      onPressed: () {
        setState(() {
          if (_isSearching) {
            _searchController.clear();
            _searchText = '';
          }

          _isSearching = !_isSearching;
        });
      },
    );
  }

  _buildTitleAndSearchTextField() {
    return _isSearching
      ? GCWTextField(
          autofocus: true,
          controller: _searchController,
          icon: Icon(
            Icons.search,
            color: ThemeColors.gray
          ),
          hintText: i18n(context, 'common_common_search_hint')
        )
      : Text(i18n(context, 'common_app_title'));
  }

  _buildIcon() {
    return IconButton(
      icon: Image.asset(
        'assets/logo/circle_border_128.png',
        width: 35.0,
        height: 35.0,
      ),
      onPressed: () => _scaffoldKey.currentState.openDrawer()
    );
  }

  List<GCWToolWidget> _getSearchedList(List<GCWToolWidget> list) {
    list = list.where((tool) {
      if (tool.searchStrings == null || tool.searchStrings.length == 0)
        return false;

      var found = true;

      //Search result as AND result of separated words
      _searchText.toLowerCase().split(RegExp(r'[\s,]')).forEach((word) {
        var searchStrings = tool.searchStrings.toLowerCase();
        if (!searchStrings.contains(word) && !searchStrings.contains(removeAccents(word))) //search with and without accents
          found = false;
      });

      return found;
    }).toList();

    list.sort((a, b) => a.toolName.toLowerCase().compareTo(b.toolName.toLowerCase()));

    return list;
  }
}