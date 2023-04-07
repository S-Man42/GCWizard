part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

bool _halt = false;
String _errorMessage = '';
int _errorPosition = 0;

// internal representation of the GCW Script error types
const SYNTAXERROR = 0;
const UNBALANCEDPARENTHESES = 1;
const NOEXPRESSION = 2;
const DIVISIONBYZERO = 3;
const EQUALEXPECTED = 4;
const NOTAVARIABLE = 5;
const LABELTABLEFULL = 6;
const DUPLICATEABEL = 7;
const LABELNOTDEFINED = 8;
const THENEXPECTED = 9;
const TOEXPECTED = 10;
const NEXTWITHOUTFOR = 11;
const RETURNWITHOUTGOSUB = 12;
const MISSINGQUOTE = 13;
const FILENOTFOUND = 14;
const FILEIOERROR = 15;
const INPUTIOERROR = 16;
const SYNTAX_VARIABLE = 17;
const INPUTMISSING = 18;
const INVALIDTYPECAST = 19;
const INVALIDSTRINGOPERATION = 20;
const UNTILWITHOUTREPEAT = 21;
const WENDWITHOUTWHILE = 22;
const WHILEWITHOUTWEND = 23;
const MISSINGPARAMETER = 24;
const LOCATIONPERMISSIONDENIED = 25;
const DATAOUTOFRANGE = 26;
const INVALIDSCREEN = 27;
const INFINITELOOP = 28;
const INVALIDLATITUDE = 29;
const INVALIDLONGITUDE = 30;
const RANGEERROR = 31;
const INVALIDBASETYPE = 32;
const INVALIDHASHTYPE = 33;
const INVALIDHASHBITRATE = 34;
const MISSINGENDIF = 35;
const SWITCHWITHOUTEND = 36;
const REPEATWITHOUTUNTIL = 37;
const FORWITHOUTNEXT = 38;

List<String> _errorMessages = [
  "gcwizard_script_syntax_error",
  "gcwizard_script_unbalanced_parentheses",
  "gcwizard_script_no_expression_present",
  "gcwizard_script_division_by_zero",
  "gcwizard_script_equal_sign_expected",
  "gcwizard_script_not_a_variable",
  "gcwizard_script_label_table_full",
  "gcwizard_script_duplicate_label",
  "gcwizard_script_undefined_label",
  "gcwizard_script_then_expected",
  "gcwizard_script_to expected",
  "gcwizard_script_next_without_for",
  "gcwizard_script_return_without_gosub",
  "gcwizard_script_closing_quotes_needed",
  "gcwizard_script_file_not_found",
  "gcwizard_script_io_error_while_loading_file",
  "gcwizard_script_io_error_on_input_statement",
  "gcwizard_script_syntax_error_on_input_statement",
  "gcwizard_script_io_error_input_missing",
  "gcwizard_script_casting_error",
  "gcwizard_script_invalid_string_operation",
  "gcwizard_script_until_without_repeat",
  "gcwizard_script_wend_without_while",
  "gcwizard_script_while_without_wend",
  "gcwizard_script_parameter_missing",
  "gcwizard_script_location_permission_denied",
  "gcwizard_script_data_outofrange",
  "gcwizard_script_invalidscreen",
  "gcwizard_script_infiniteloop",
  "gcwizard_script_invalid_lat",
  "gcwizard_script_invalid_lon",
  "gcwizard_script_range_error",
  "gcwizard_script_invalid_basetype",
  "gcwizard_script_invalid_hashtype",
  "gcwizard_script_invalid_hashbitrate",
  "gcwizard_script_syntax_error_missing_endif",
  "gcwizard_script_syntax_error_missing_endswitch",
  "gcwizard_script_syntax_error_repeat_without_until",
  "gcwizard_script_syntax_error_for_without_next",
];

void _handleError(int error) {
  _halt = true;
  _errorMessage = _errorMessages[error];
  _errorPosition = _scriptIndex;
}