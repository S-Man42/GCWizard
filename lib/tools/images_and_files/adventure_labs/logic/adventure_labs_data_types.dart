part of 'package:gc_wizard/tools/images_and_files/adventure_labs/logic/adventure_labs.dart';

enum ANALYSE_RESULT_STATUS { OK, ERROR_HTTP, NONE}

const Map<String, String> HTTP_STATUS = {
  '200': 'wherigo_http_code_200', // ok
  '401': 'wherigo_http_code_401', // Unauthorized
  '404': 'wherigo_http_code_404', // Not found
  '503': 'wherigo_http_code_503',
};

const CONSUMER_KEY = 'A01A9CA1-29E0-46BD-A270-9D894A527B91';
const SEARCH_ADDRESSV3 = 'https://labs-api.geocaching.com/Api/Adventures/SearchV3';
const SEARCH_ADDRESSV4 = 'https://labs-api.geocaching.com/Api/Adventures/SearchV4';
const DETAIL_ADDRESS = 'https://labs-api.geocaching.com/api/Adventures/';

const Map<String,String> HEADERS = {
  'Content-Type': 'application/json; charset=UTF-8',
  'Accept': 'application/json',
  'X-Consumer-Key': CONSUMER_KEY,
};