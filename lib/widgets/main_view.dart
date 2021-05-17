import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/favorites.dart';
import 'package:gc_wizard/widgets/main_menu.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/babylon_numbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/base_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/bcd_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/beaufort_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/ccitt1_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/ccitt2_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/cistercian_numbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/coords_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/cryptography_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/e_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/easter_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/games_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/general_codebreakers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/hash_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/icecodes_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/imagesandfiles_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/maya_numbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/numeral_words_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/phi_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/pi_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/primes_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/resistor_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/rsa_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/scienceandtechnology_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/silverratio_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/symbol_table_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/tomtom_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/vanity_selection.dart';
import 'package:gc_wizard/widgets/tools/coords/antipodes.dart';
import 'package:gc_wizard/widgets/tools/coords/center_three_points.dart';
import 'package:gc_wizard/widgets/tools/coords/center_two_points.dart';
import 'package:gc_wizard/widgets/tools/coords/coordinate_averaging.dart';
import 'package:gc_wizard/widgets/tools/coords/cross_bearing.dart';
import 'package:gc_wizard/widgets/tools/coords/distance_and_bearing.dart';
import 'package:gc_wizard/widgets/tools/coords/ellipsoid_transform.dart';
import 'package:gc_wizard/widgets/tools/coords/equilateral_triangle.dart';
import 'package:gc_wizard/widgets/tools/coords/format_converter.dart';
import 'package:gc_wizard/widgets/tools/coords/intersect_bearing_and_circle.dart';
import 'package:gc_wizard/widgets/tools/coords/intersect_bearings.dart';
import 'package:gc_wizard/widgets/tools/coords/intersect_four_points.dart';
import 'package:gc_wizard/widgets/tools/coords/intersect_three_circles.dart';
import 'package:gc_wizard/widgets/tools/coords/intersect_two_circles.dart';
import 'package:gc_wizard/widgets/tools/coords/intersection.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/map_view.dart';
import 'package:gc_wizard/widgets/tools/coords/resection.dart';
import 'package:gc_wizard/widgets/tools/coords/variable_coordinate/variable_coordinate_formulas.dart';
import 'package:gc_wizard/widgets/tools/coords/waypoint_projection.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/abaddon.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/adfgvx.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/affine.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/alphabet_values.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/amsco.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/ascii_values.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/atbash.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bacon.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bifid.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/book_cipher.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/burrows_wheeler.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/caesar.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/chao.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/cipher_wheel.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/enclosed_areas.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/enigma/enigma.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/esoteric_programming_languages/beatnik_language.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/esoteric_programming_languages/brainfk.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/esoteric_programming_languages/chef_language.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/esoteric_programming_languages/deadfish.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/esoteric_programming_languages/malbolge.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/esoteric_programming_languages/ook.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/esoteric_programming_languages/whitespace_language.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/gade.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/gc_code.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/multi_decoder.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/substitution_breaker.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/vigenere_breaker.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/gray.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/gronsfeld.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/hashes/hash_breaker.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/homophone.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/kamasutra.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/kenny.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/language_games/chicken_language.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/language_games/duck_speak.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/language_games/pig_latin.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/language_games/robber_language.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/language_games/spoon_language.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/mexican_army_cipher_wheel.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/morse.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/one_time_pad.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/playfair.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/polybios.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rail_fence.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rc4.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/reverse.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/roman_numbers/chronogram.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/roman_numbers/roman_numbers.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rotation/rot13.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rotation/rot18.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rotation/rot47.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rotation/rot5.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rotation/rotation_general.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/skytale.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/solitaire.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/straddling_checkerboard.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/substitution.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/tap_code.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/tapir.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/trifid.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/trithemius.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/vigenere.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/z22.dart';
import 'package:gc_wizard/widgets/tools/formula_solver/formula_solver_formulagroups.dart';
import 'package:gc_wizard/widgets/tools/games/catan.dart';
import 'package:gc_wizard/widgets/tools/games/scrabble.dart';
import 'package:gc_wizard/widgets/tools/games/sudoku/sudoku_solver.dart';
import 'package:gc_wizard/widgets/tools/images_and_files/hexstring2file.dart';
import 'package:gc_wizard/widgets/tools/images_and_files/stegano.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/apparent_temperature/heat_index.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/apparent_temperature/humidex.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/apparent_temperature/summer_simmer.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/apparent_temperature/windchill.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/astronomy/moon_position.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/astronomy/moon_rise_set.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/astronomy/seasons.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/astronomy/sun_position.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/astronomy/sun_rise_set.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/binary.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/colors/colors.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/combinatorics/combination.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/combinatorics/combination_permutation.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/combinatorics/permutation.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/cross_sums/cross_sum.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/cross_sums/cross_sum_range.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/cross_sums/cross_sum_range_frequency.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/cross_sums/iterated_cross_sum_range.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/cross_sums/iterated_cross_sum_range_frequency.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/date_and_time/day_calculator.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/date_and_time/time_calculator.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/date_and_time/weekday.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/decabit.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/dna/dna_aminoacids.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/dna/dna_aminoacids_table.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/dna/dna_nucleicacidsequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/dtmf.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/hexadecimal.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/keyboard.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/numeralbases.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/periodic_table/atomic_numbers_to_text.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/periodic_table/periodic_table.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/periodic_table/periodic_table_data_view.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/projectiles.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/fourteen_segments.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/seven_segments.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/sixteen_segments.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/unit_converter.dart';
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

    final List<GCWTool> _toolList = Registry.toolList.where((element) {
      return [
        className(Abaddon()),
        className(ADFGVX()),
        className(Affine()),
        className(AlphabetValues()),
        className(Amsco()),
        className(Antipodes()),
        className(ASCIIValues()),
        className(Atbash()),
        className(AtomicNumbersToText()),
        className(BabylonNumbersSelection()),
        className(Bacon()),
        className(BaseSelection()),
        className(BCDSelection()),
        className(Beatnik()),
        className(BeaufortSelection()),
        className(Bifid()),
        className(Binary()),
        className(BookCipher()),
        className(Brainfk()),
        className(BurrowsWheeler()),
        className(Caesar()),
        className(Catan()),
        className(CCITT1Selection()),
        className(CCITT2Selection()),
        className(CenterThreePoints()),
        className(CenterTwoPoints()),
        className(Chao()),
        className(Chef()),
        className(ChickenLanguage()),
        className(Chronogram()),
        className(CipherWheel()),
        className(CistercianNumbersSelection()),
        className(ColorPicker()),
        className(Combination()),
        className(CombinationPermutation()),
        className(CoordinateAveraging()),
        className(CrossBearing()),
        className(CrossSum()),
        className(CrossSumRange()),
        className(CrossSumRangeFrequency()),
        className(DayCalculator()),
        className(Deadfish()),
        className(Decabit()),
        className(DistanceBearing()),
        className(DTMF()),
        className(DNAAminoAcids()),
        className(DNAAminoAcidsTable()),
        className(DNANucleicAcidSequence()),
        className(SilverRatioSelection()),
        className(DuckSpeak()),
        className(EasterSelection()),
        className(EllipsoidTransform()),
        className(EnclosedAreas()),
        className(Enigma()),
        className(EquilateralTriangle()),
        className(ESelection()),
        className(FormatConverter()),
        className(FormulaSolverFormulaGroups()),
        className(FourteenSegments()),
        className(Gade()),
        className(GCCode()),
        className(Gray()),
        className(Gronsfeld()),
        className(HeatIndex()),
        className(HashBreaker()),
        className(HashSelection()),
        className(Hexadecimal()),
        className(HexString2File()),
        className(Homophone()),
        className(Humidex()),
        className(IceCodesSelection()),
        className(IntersectBearings()),
        className(IntersectFourPoints()),
        className(IntersectGeodeticAndCircle()),
        className(Intersection()),
        className(IntersectThreeCircles()),
        className(IntersectTwoCircles()),
        className(IteratedCrossSumRange()),
        className(IteratedCrossSumRangeFrequency()),
        className(Kamasutra()),
        className(Kenny()),
        className(Keyboard()),
        className(Malbolge()),
        className(MapView()),
        className(MayaNumbersSelection()),
        className(MexicanArmyCipherWheel()),
        className(MoonPosition()),
        className(MoonRiseSet()),
        className(Morse()),
        className(NumberSequenceSelection()),
        className(MultiDecoder()),
        className(NumeralBases()),
        className(NumeralWordsSelection()),
        className(OneTimePad()),
        className(Ook()),
        className(PeriodicTable()),
        className(PeriodicTableDataView()),
        className(Permutation()),
        className(PhiSelection()),
        className(PiSelection()),
        className(PigLatin()),
        className(Playfair()),
        className(Polybios()),
        className(PrimesSelection()),
        className(Projectiles()),
        className(RailFence()),
        className(RC4()),
        className(Resection()),
        className(ResistorSelection()),
        className(Reverse()),
        className(RobberLanguage()),
        className(RomanNumbers()),
        className(Rot13()),
        className(Rot18()),
        className(Rot5()),
        className(Rot47()),
        className(RotationGeneral()),
        className(RSASelection()),
        className(Scrabble()),
        className(Seasons()),
        className(SevenSegments()),
        className(SixteenSegments()),
        className(Skytale()),
        className(Solitaire()),
        className(SpoonLanguage()),
        className(Stegano()),
        className(StraddlingCheckerboard()),
        className(Substitution()),
        className(SubstitutionBreaker()),
        className(SudokuSolver()),
        className(SummerSimmerIndex()),
        className(SunPosition()),
        className(SunRiseSet()),
        className(SymbolTableSelection()),
        className(TapCode()),
        className(Tapir()),
        className(TimeCalculator()),
        className(TomTomSelection()),
        className(Trifid()),
        className(Trithemius()),
        className(UnitConverter()),
        className(VanitySelection()),
        className(VariableCoordinateFormulas()),
        className(Vigenere()),
        className(VigenereBreaker()),
        className(Weekday()),
        className(WhitespaceLanguage()),
        className(WaypointProjection()),
        className(Windchill()),
        className(Z22()),
      ].contains(className(element.tool));
    }).toList();

    _toolList.sort((a, b) {
      return a.toolName.toLowerCase().compareTo(b.toolName.toLowerCase());
    });

    final List<GCWTool> _categoryList = Registry.toolList.where((element) {
      return [
        className(CoordsSelection()),
        className(CryptographySelection()),
        className(FormulaSolverFormulaGroups()),
        className(GamesSelection()),
        className(GeneralCodebreakersSelection()),
        className(ImagesAndFilesSelection()),
        className(ScienceAndTechnologySelection()),
        className(SymbolTableSelection()),
      ].contains(className(element.tool));
    }).toList();

    _categoryList.sort((a, b) {
      return a.toolName.toLowerCase().compareTo(b.toolName.toLowerCase());
    });

    return DefaultTabController(
      length: 3,
      initialIndex:
          Prefs.getBool('tabs_use_default_tab') ? Prefs.get('tabs_default_tab') : Prefs.get('tabs_last_viewed_tab'),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            bottom: TabBar(
              onTap: (value) {
                Prefs.setInt('tabs_last_viewed_tab', value);
              },
              tabs: [
                Tab(icon: Icon(Icons.category)),
                Tab(icon: Icon(Icons.list)),
                Tab(icon: Icon(Icons.star)),
              ],
            ),
            leading: _buildIcon(),
            title: _buildTitleAndSearchTextField(),
            actions: <Widget>[_buildSearchActionButton()]),
        drawer: buildMainMenu(context),
        body: TabBarView(
          children: [
            GCWToolList(toolList: _isSearching && _searchText.length > 0 ? _getSearchedList() : _categoryList),
            GCWToolList(toolList: _isSearching && _searchText.length > 0 ? _getSearchedList() : _toolList),
            GCWToolList(toolList: _isSearching && _searchText.length > 0 ? _getSearchedList() : Favorites.toolList),
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
            icon: Icon(Icons.search, color: themeColors().mainFont()),
            hintText: i18n(context, 'common_search_hint'))
        : Text(i18n(context, 'common_app_title'));
  }

  _buildIcon() {
    return IconButton(
        icon: Image.asset(
          'assets/logo/circle_border_128.png',
          width: 35.0,
          height: 35.0,
        ),
        onPressed: () => _scaffoldKey.currentState.openDrawer());
  }

  List<GCWTool> _getSearchedList() {
    var list = Registry.toolList;
    String searchstring = '';

    list = list.where((tool) {
      searchstring = tool.searchStrings.join(' ').toLowerCase();
      if (searchstring == null || searchstring.length == 0) return false;

      var found = true;

      //Search result as AND result of separated words
      _searchText.toLowerCase().split(RegExp(r'[\s,]')).forEach((word) {
        var searchStrings = searchstring;
        if (!searchStrings.contains(word) &&
            !searchStrings.contains(removeAccents(word))) //search with and without accents
          found = false;
      });

      return found;
    }).toList();

    list.sort((a, b) => a.toolName.toLowerCase().compareTo(b.toolName.toLowerCase()));

    return list;
  }
}
