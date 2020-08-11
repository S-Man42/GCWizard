import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/favorites.dart';
import 'package:gc_wizard/widgets/main_menu.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/astronomy_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/base_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/brainfk_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/combinatorics_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/coords_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/cryptography_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/dates_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/e_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/phi_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/pi_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/primes_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/resistor_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/rotation_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/scienceandtechnology_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/segmentdisplay_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/symbol_table_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/vanity_selection.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/abaddon.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/adfgvx.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/alphabet_values.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/ascii_values.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/atbash.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bacon.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bifid.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/caesar.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/ccitt1.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/ccitt2.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/chicken_language.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/deadfish.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/duck_speak.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/enigma/enigma.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/gc_code.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/gronsfeld.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/kamasutra.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/kenny.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/morse.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/one_time_pad.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/pig_latin.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/playfair.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/polybios.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rail_fence.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/reverse.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/robber_language.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/roman_numbers.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/scrabble.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/skytale.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/spoon_language.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/substitution.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/tap_code.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/tapir.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/tomtom.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/trithemius.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/vigenere.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/z22.dart';
import 'package:gc_wizard/widgets/tools/formula_solver/formula_solver_formulagroups.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/beaufort.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/binary.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/colors/colors.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/decabit.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/numeralbases.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/periodic_table.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/unit_converter.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/windchill.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:prefs/prefs.dart';
import 'package:url_launcher/url_launcher.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  var _isSearching = false;
  final _searchController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var _searchText = '';

  final _showSupportHintEveryN = 50;

  @override
  void initState() {
    super.initState();
    Prefs.init();

    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text.isEmpty ? '' : _searchController.text;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var countAppOpened = Prefs.getInt('app_count_opened');

      if (countAppOpened == 10 || countAppOpened % _showSupportHintEveryN == 0) {
        showGCWAlertDialog(
          context,
          i18n(context, 'common_support_title'),
          i18n(context, 'common_support_text', parameters: [Prefs.getInt('app_count_opened')]),
          () {
            launch(i18n(context, 'common_support_link'));
          },
        );
      }
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
          className(AlphabetValues()),
          className(ASCIIValues()),
          className(AstronomySelection()),
          className(Atbash()),
          className(Bacon()),
          className(BaseSelection()),
          className(Beaufort()),
          className(Bifid()),
          className(Binary()),
          className(BrainfkSelection()),
          className(Caesar()),
          className(CCITT1()),
          className(CCITT2()),
          className(ChickenLanguage()),
          className(CoordsSelection()),
          className(ColorPicker()),
          className(CombinatoricsSelection()),
          className(DatesSelection()),
          className(Deadfish()),
          className(Decabit()),
          className(DuckSpeak()),
          className(Enigma()),
          className(ESelection()),
          className(FormulaSolverFormulaGroups()),
          className(GCCode()),
          className(Gronsfeld()),
          className(Kamasutra()),
          className(Kenny()),
          className(Morse()),
          className(NumeralBases()),
          className(OneTimePad()),
          className(PeriodicTable()),
          className(PhiSelection()),
          className(PiSelection()),
          className(PigLatin()),
          className(Playfair()),
          className(Polybios()),
          className(PrimesSelection()),
          className(RailFence()),
          className(ResistorSelection()),
          className(Reverse()),
          className(RobberLanguage()),
          className(RomanNumbers()),
          className(RotationSelection()),
          className(Scrabble()),
          className(SegmentDisplaySelection()),
          className(Skytale()),
          className(SpoonLanguage()),
          className(Substitution()),
          className(SymbolTableSelection()),
          className(TapCode()),
          className(Tapir()),
          className(TomTom()),
          className(Trithemius()),
          className(UnitConverter()),
          className(VanitySelection()),
          className(Vigenere()),
          className(Windchill()),
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
        className(FormulaSolverFormulaGroups()),
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
          hintText: i18n(context, 'common_search_hint')
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