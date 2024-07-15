class FormatInfo {
  final String size;
  final String area;

  const FormatInfo(this.size, this.area);
}

const Map<String, FormatInfo> DINA_FORMAT = {
  'A0': FormatInfo('841 x 1189 mm', '1 m²'),
  'A1': FormatInfo('594 x 841 mm', '0,5 m²'),
  'A2': FormatInfo('420 x 594 mm', '0,25 m²'),
  'A3': FormatInfo('297 x 420 mm', '0,12 m²'),
  'A4': FormatInfo('210 x 297 mm', '624 cm²'),
  'A5': FormatInfo('148 x 210 mm', '311,1 cm²'),
  'A6': FormatInfo('105 x 148 mm', '155,4 cm²'),
  'A7': FormatInfo('74 x 105 mm', '77,8 cm²'),
  'A8': FormatInfo('52 x 74 mm', '38,5 cm²'),
  'A9': FormatInfo('37 x 52 mm', '19,2 cm²'),
  'A10':FormatInfo('26 x 37 mm', '9,6 cm²'),
};

const Map<String, FormatInfo> DINB_FORMAT = {
  'B0': FormatInfo('1000 x 1414 mm', '1,4 m²'),
  'B1': FormatInfo('707 x 1000 mm', '0,7 m²'),
  'B2': FormatInfo('500 x 707 mm', '0,35 m²'),
  'B3': FormatInfo('353 x 500 mm', '0,18 m²'),
  'B4': FormatInfo('250 x 353 mm', '886 cm²'),
  'B5': FormatInfo('176 x 250 mm', '440 cm²'),
  'B6': FormatInfo('125 x 176 mm', '220 cm²'),
  'B7': FormatInfo('88 x 125 mm', '110 cm²'),
  'B8': FormatInfo('62 x 88 mm', '54,6 cm²'),
  'B9': FormatInfo('44 x 62 mm', '27,3 cm²'),
  'B10': FormatInfo('31 x 44 mm', '13,6 cm²'),
};

const Map<String, FormatInfo> DINC_FORMAT = {
  'C0': FormatInfo('917 x 1297 mm', '1,19 m²'),
  'C1': FormatInfo('648 x 917 mm', '0,59 m²'),
  'C2': FormatInfo('458 x 648 mm', '0,30 m²'),
  'C3': FormatInfo('324 x 458 mm', '0,15 m²'),
  'C4': FormatInfo('229 x 324 mm', '742 cm²'),
  'C5': FormatInfo('162 x 229 mm', '371 cm²'),
  'C6': FormatInfo('114 x 162 mm', '184,7 cm²'),
  'C7': FormatInfo('81 x 114 mm', '92,3 cm²'),
  'C8': FormatInfo('57 x 81 mm', '46,2 cm²'),
  'C9': FormatInfo('40 x 57 mm', '22,8 cm²'),
  'C10': FormatInfo( '28 x 40 mm', '11,2 cm²'),
};

const Map<String, FormatInfo> DIND_FORMAT = {
  'D0': FormatInfo('771 x 1090 mm', '0,84 m²'),
  'D1': FormatInfo('545 x 771 mm', '0,42 m²'),
  'D2': FormatInfo('385 x 545 mm', '0,21 m²'),
  'D3': FormatInfo('272 x 385 mm', '0,10 m²'),
  'D4': FormatInfo('192 x 272 mm', '522 cm²'),
  'D5': FormatInfo('136 x 192 mm', '261,1 cm²'),
  'D6': FormatInfo('96 x 136 mm', '130,6 cm²'),
  'D7': FormatInfo('68 x 96 mm', '65,3 cm²'),
  'D8': FormatInfo('48 x 68 mm', '32,6 cm²'),
  'D9': FormatInfo('34 x 48 mm', '16,3 cm²'),
  'D10': FormatInfo( '24 x 34 mm', '8,2 cm²'),
};
