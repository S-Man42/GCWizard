// https://www.geocaching.com/geocache/GC8PJEQ
//
// ASSDWW.DSAWSSDW.WWDSSA.WWA.WDSASDW
//
// SDWSS.AWDSSA.SAWDWAS.ASSDWA.DWWASS
//

import 'dart:math';

enum WASD_TYPE  {WASD, IJKM, ESDF, CUSTOM}

Map<WASD_TYPE, String> KEYBOARD_CONTROLS = {
  WASD_TYPE.WASD: 'wasd_keyboard_wasd',
  WASD_TYPE.IJKM: 'wasd_keyboard_ijkm',
  WASD_TYPE.ESDF: 'wasd_keyboard_esdf',
  WASD_TYPE.CUSTOM: 'wasd_keyboard_custom',
};

final Map<String, List<String>> WASD_ENCODE = {
  '0' : ['ASSDWW', 'SSDWWA', 'SDWWAS', 'DWWASS', 'WWASSD', 'WASSDW', 'WWDSSA', 'WDSSAW', 'DSSAWW', 'SSAWWD', 'SAWWDS', 'AWWDSS'],
  '1' : ['WW', 'SS'],
  '2' : ['DSASD', 'AWDWS'],
  '3' : ['DSADSA', 'DWADWA'],
  '4' : ['SDWSS', 'SDSWW', 'WWSAW', 'SSWAD'],
  '5' : ['DWAWD', 'ASDSA'],
  '6' : ['ASSDWA', 'SSDWA', 'DSAWWD', 'DSAWW', 'ASDSAW', 'SDWAWD', 'SDWAW', 'SDSAW'],
  '7' : ['WWA', 'DSS'],
  '8' : ['DSAWSSDW', 'WDSASDW', 'SAWDWAS'],
  '9' : ['ASDSWW', 'AWDSS', 'WASDS', 'AWDSSA', 'WASDSA', 'ASDSADWW', 'SSWAWS', 'WWASD', 'WAWDS', 'DWWASD', 'DWAWDS', 'SSADWAWD'],
  ' ' : [' ']
};

final Map<String, String> WASD_DECODE = {
  'ASSDWW' : '0',
  'SSDWWA' : '0',
  'SDWWAS' : '0',
  'DWWASS' : '0',
  'WWASSD' : '0',
  'WASSDW' : '0',
  'WWDSSA' : '0',
  'WDSSAW' : '0',
  'DSSAWW' : '0',
  'SSAWWD' : '0',
  'SAWWDS' : '0',
  'AWWDSS' : '0',
  'WW' : '1',
  'SS' : '1',
  'DSASD' : '2',
  'AWDWS' : '2',
  'DSADSA' : '3',
  'DWADWA' : '3',
  'SDWSS' : '4',
  'SDSWW' : '4',
  'WWSAW' : '4',
  'SSWAD' : '4',
  'DWAWD' : '5',
  'ASDSA' : '5',
  'ASSDWA' : '6',
  'SSDWA' : '6',
  'DSAWW' : '6',
  'DSAWWD' : '6',
  'ASDSAW' : '6',
  'SDWAWD' : '6',
  'SDWAW' : '6',
  'SDSAW' : '6',
  'WWA' : '7',
  'DSS' : '7',
  'DSAWSSDW' : '8',
  'WDSASDW' : '8',
  'SAWDWAS' : '8',
  'WASDSAW' : '8',
  'SDWAWDS' : '8',
  'ASDSWW' : '9',
  'AWDSS' : '9',
  'WASDS' : '9',
  'AWDSSA' : '9',
  'WASDSA' : '9',
  'ASDSADWW' : '9',
  'SSWAWS' : '9',
  'WWASD' : '9',
  'WAWDS' : '9',
  'DWWASD' : '9',
  'DWAWDS': '9',
  'SSADWAWD': '9',
  ' ' : ' '
};

String decodeWASD(String input, WASD_TYPE controls, List<String> controlSet){
  if (input == '' || input == null)
    return '';

  String decode = '';
  switch (controls) {
    case WASD_TYPE.IJKM : decode = input.replaceAll('W', 'I').replaceAll('A', 'J').replaceAll('S', 'M').replaceAll('D', 'K');
      break;
    case WASD_TYPE.ESDF : decode = input.replaceAll('W', 'E').replaceAll('A', 'S').replaceAll('S', 'D').replaceAll('D', 'F');
      break;
    case WASD_TYPE.CUSTOM : decode = input.replaceAll('W', controlSet[0]).replaceAll('A', controlSet[1]).replaceAll('S', controlSet[2]).replaceAll('D', controlSet[3]);
      break;
  }
  List<String> result = [];
  decode.split(' ').forEach((element) {
    if (WASD_DECODE[element] == null)
      result.add(UNKNOWW_ELEMENT);
    else
    result.add(WASD_DECODE[element]);
  });
  return result.join(' ');
}

String encodeWASD(String input, WASD_TYPE controls, List<String> controlSet){
  if (input == '' || input == null)
    return '';

  Random rnd = new Random();
  List<String> result = [];
  input.split('').forEach((element) {
    if (WASD_ENCODE[element] == null)
      result.add('');
    else
      result.add(WASD_ENCODE[element][rnd.nextInt(WASD_ENCODE[element].length)].toString());
  });
  switch (controls) {
    case WASD_TYPE.IJKM : return result.join(' ').replaceAll('W', 'I').replaceAll('A', 'J').replaceAll('S', 'M').replaceAll('D', 'K');
    break;
    case WASD_TYPE.ESDF : return result.join(' ').replaceAll('W', 'E').replaceAll('D', 'F').replaceAll('S', 'D').replaceAll('A', 'S');
    break;
    case WASD_TYPE.CUSTOM : return result.join(' ').replaceAll('W', controlSet[0]).replaceAll('A', controlSet[1]).replaceAll('S', controlSet[2]).replaceAll('D', controlSet[3]);
    break;
    default: return result.join(' ');
  }
}

String decodeWASDGraphic(String input, WASD_TYPE controls, List<String> controlSet){
  if (input == '' || input == null)
    return '';
print('deocde graphic');
  return '11111111111111111111111111111111111111111111111111';
}
