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
import 'package:gc_wizard/widgets/selector_lists/cryptography_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/dates_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/e_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/phi_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/pi_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/primes_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/rotation_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/scienceandtechnology_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/symbol_table_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/vanity_selection.dart';
import 'package:gc_wizard/widgets/tools/crypto/abaddon.dart';
import 'package:gc_wizard/widgets/tools/crypto/adfgvx.dart';
import 'package:gc_wizard/widgets/tools/crypto/atbash.dart';
import 'package:gc_wizard/widgets/tools/crypto/bacon.dart';
import 'package:gc_wizard/widgets/tools/crypto/caesar.dart';
import 'package:gc_wizard/widgets/tools/crypto/chicken_language.dart';
import 'package:gc_wizard/widgets/tools/crypto/enigma/enigma.dart';
import 'package:gc_wizard/widgets/tools/crypto/gronsfeld.dart';
import 'package:gc_wizard/widgets/tools/crypto/kamasutra.dart';
import 'package:gc_wizard/widgets/tools/crypto/kenny.dart';
import 'package:gc_wizard/widgets/tools/crypto/pig_latin.dart';
import 'package:gc_wizard/widgets/tools/crypto/playfair.dart';
import 'package:gc_wizard/widgets/tools/crypto/polybios.dart';
import 'package:gc_wizard/widgets/tools/crypto/reverse.dart';
import 'package:gc_wizard/widgets/tools/crypto/robber_language.dart';
import 'package:gc_wizard/widgets/tools/crypto/skytale.dart';
import 'package:gc_wizard/widgets/tools/crypto/spoon_language.dart';
import 'package:gc_wizard/widgets/tools/crypto/substitution.dart';
import 'package:gc_wizard/widgets/tools/crypto/tap_code.dart';
import 'package:gc_wizard/widgets/tools/crypto/tapir.dart';
import 'package:gc_wizard/widgets/tools/crypto/tomtom.dart';
import 'package:gc_wizard/widgets/tools/crypto/trithemius.dart';
import 'package:gc_wizard/widgets/tools/crypto/vigenere.dart';
import 'package:gc_wizard/widgets/tools/encodings/ascii_values.dart';
import 'package:gc_wizard/widgets/tools/encodings/ccitt1.dart';
import 'package:gc_wizard/widgets/tools/encodings/ccitt2.dart';
import 'package:gc_wizard/widgets/tools/encodings/letter_values.dart';
import 'package:gc_wizard/widgets/tools/encodings/morse.dart';
import 'package:gc_wizard/widgets/tools/encodings/roman_numbers.dart';
import 'package:gc_wizard/widgets/tools/encodings/scrabble.dart';
import 'package:gc_wizard/widgets/tools/encodings/z22.dart';
import 'package:gc_wizard/widgets/tools/formula_solver/formula_solver.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/colors/colors.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/decabit.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/numeralbases.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/periodic_table.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/resistor/resistor.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:prefs/prefs.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
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
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Registry.initialize(context);
    Favorites.initialize();

    final List<GCWToolWidget> _toolList =
      Registry.toolList.where((element) {
        return [
          className(Abaddon()),
          className(ADFGVX()),
          className(ASCIIValues()),
          className(Atbash()),
          className(Bacon()),
          className(BaseSelection()),
          className(BrainfkSelection()),
          className(Caesar()),
          className(CCITT1()),
          className(CCITT2()),
          className(ChickenLanguage()),
          className(CoordsSelection()),
          className(ColorPicker()),
          className(DatesSelection()),
          className(Decabit()),
          className(Enigma()),
          className(ESelection()),
          className(FormulaSolver()),
          className(Gronsfeld()),
          className(Kamasutra()),
          className(Kenny()),
          className(LetterValues()),
          className(Morse()),
          className(NumeralBases()),
          className(PeriodicTable()),
          className(PhiSelection()),
          className(PiSelection()),
          className(PigLatin()),
          className(Playfair()),
          className(Polybios()),
          className(PrimesSelection()),
          className(Resistor()),
          className(Reverse()),
          className(RobberLanguage()),
          className(RomanNumbers()),
          className(RotationSelection()),
          className(Scrabble()),
          className(Skytale()),
          className(SpoonLanguage()),
          className(Substitution()),
          className(SymbolTableSelection()),
          className(TapCode()),
          className(Tapir()),
          className(TomTom()),
          className(Trithemius()),
          className(VanitySelection()),
          className(Vigenere()),
          className(Z22()),
        ].contains(className(element.tool));
      }).toList();

    _toolList.sort((a, b){
      return a.toolName.toLowerCase().compareTo(b.toolName.toLowerCase());
    });

    final List<GCWToolWidget> _categoryList =
    Registry.toolList.where((element) {
      return [
        className(CoordsSelection()),
        className(CryptographySelection()),
        className(FormulaSolver()),
        className(ScienceAndTechnologySelection()),
        className(SymbolTableSelection()),
      ].contains(className(element.tool));
    }).toList();

    _categoryList.sort((a, b){
      return a.toolName.toLowerCase().compareTo(b.toolName.toLowerCase());
    });

    return DefaultTabController(
      length: 3,
      initialIndex: Prefs.getBool('tabs_use_default_tab') ? Prefs.get('tabs_default_tab') : Prefs.get('tabs_last_viewed_tab'),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          bottom: TabBar(
            onTap: (value) {
              Prefs.setInt('tabs_last_viewed_tab', value);
            },
            tabs: [
              Tab(
                icon: Icon(Icons.category)
              ),
              Tab(
                icon: Icon(Icons.list)
              ),
              Tab(
                icon: Icon(Icons.star)
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
                : _categoryList
            ),
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