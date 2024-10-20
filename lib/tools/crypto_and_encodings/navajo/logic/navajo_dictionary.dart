// https://www.history.navy.mil/research/library/online-reading-room/title-list-alphabetically/n/navajo-code-talker-dictionary.html
// https://www.ancestrycdn.com/aa-k12/1112/assets/Navajo-Code-Talkers-dictionary.pdf

part of 'package:gc_wizard/tools/crypto_and_encodings/navajo/logic/navajo.dart';

const List<MapEntry<String, String>> _NAVAJO_ALPHABET = [
  MapEntry<String, String>('.', '.'),
  MapEntry<String, String>('A', 'WOL-LA-CHEE'),
  MapEntry<String, String>('A', 'BE-LA-SANA'),
  MapEntry<String, String>('A', 'TSE-NILL'),
  MapEntry<String, String>('B', 'SHUSH'),
  MapEntry<String, String>('B', 'NA-HASH-CHID'),
  MapEntry<String, String>('B', 'TOISH-JEH'),
  MapEntry<String, String>('C', 'MOASI'),
  MapEntry<String, String>('C', 'TLA-GIN'),
  MapEntry<String, String>('C', 'BA-GOSHI'),
  MapEntry<String, String>('D', 'BE'),
  MapEntry<String, String>('D', 'CHINDI'),
  MapEntry<String, String>('D', 'LHA-CHA-EH'),
  MapEntry<String, String>('E', 'DZEH'),
  MapEntry<String, String>('E', 'AH-JAH'),
  MapEntry<String, String>('E', 'AH-NAH'),
  MapEntry<String, String>('F', 'MA-E'),
  MapEntry<String, String>('F', 'CHUO'),
  MapEntry<String, String>('F', 'TSA-E-DONIN-EE'),
  MapEntry<String, String>('G', 'KLIZZIE'),
  MapEntry<String, String>('G', 'AH-TAD'),
  MapEntry<String, String>('G', 'JEHA'),
  MapEntry<String, String>('H', 'LIN'),
  MapEntry<String, String>('H', 'TSE-GAH'),
  MapEntry<String, String>('H', 'CHA'),
  MapEntry<String, String>('I', 'TKIN'),
  MapEntry<String, String>('I', 'YEH-HES'),
  MapEntry<String, String>('I', 'A-CHI'),
  MapEntry<String, String>('J', 'TKELE-CHO-G'),
  MapEntry<String, String>('J', 'AH-YA-TSINNE'),
  MapEntry<String, String>('J', 'YIL-DOI'),
  MapEntry<String, String>('K', 'KLIZZIE-YAZZIE'),
  MapEntry<String, String>('K', 'JAD-HO-LONI'),
  MapEntry<String, String>('K', 'BA-AH-NE-DI-TININ'),
  MapEntry<String, String>('L', 'DIBEH-YAZZIE'),
  MapEntry<String, String>('L', 'AH-JAD'),
  MapEntry<String, String>('L', 'NASH-DOIE-TSO'),
  MapEntry<String, String>('M', 'NA-AS-TSO-SI'),
  MapEntry<String, String>('M', 'TSIN-TLITI'),
  MapEntry<String, String>('M', 'BE-TAS-TNI'),
  MapEntry<String, String>('N', 'NESH-CHEE'),
  MapEntry<String, String>('N', 'TSAH'),
  MapEntry<String, String>('N', 'A-CHIN'),
  MapEntry<String, String>('O', 'NE-AHS-JAH'),
  MapEntry<String, String>('O', 'A-KHA'),
  MapEntry<String, String>('O', 'TLO-CHIN'),
  MapEntry<String, String>('P', 'BI-SO-DIH'),
  MapEntry<String, String>('P', 'CLA-GI-AIH'),
  MapEntry<String, String>('P', 'NE-ZHONI'),
  MapEntry<String, String>('Q', 'CA-YEILTH'),
  MapEntry<String, String>('R', 'GAH'),
  MapEntry<String, String>('R', 'DAH-NES-TSA'),
  MapEntry<String, String>('R', 'AH-LOSZ'),
  MapEntry<String, String>('S', 'DIBEH'),
  MapEntry<String, String>('S', 'KLESH'),
  MapEntry<String, String>('T', 'THAN-ZIE'),
  MapEntry<String, String>('T', 'D-AH'),
  MapEntry<String, String>('T', 'A-WOH'),
  MapEntry<String, String>('U', 'NO-DA-IH'),
  MapEntry<String, String>('U', 'SHI-DA'),
  MapEntry<String, String>('V', 'A-KEH-DI-GLINI'),
  MapEntry<String, String>('W', 'GLOE-IH'),
  MapEntry<String, String>('X', 'AL-NA-AS-DZOH'),
  MapEntry<String, String>('Y', 'TSAH-AS-ZIH'),
  MapEntry<String, String>('Z', 'BESH-DO-TLIZ'),
];

const List<MapEntry<String, String>> _NAVAJO_DICTIONARY = [
  MapEntry<String, String>('CORPS', 'DIN-NEH-IH'),
  MapEntry<String, String>('DIVISION', 'ASHIH-HI'),
  MapEntry<String, String>('REGIMENT', 'TABAHA'),
  MapEntry<String, String>('BATTALION', 'TACHEENE'),
  MapEntry<String, String>('COMPANY', 'NAKIA'),
  MapEntry<String, String>('PLATOON', 'HAS-CLISH-NIH'),
  MapEntry<String, String>('SECTION', 'YO-IH'),
  MapEntry<String, String>('SQUAD', 'DEBEH-LI-ZINI'),
  MapEntry<String, String>('COMMANDINGGEN', 'BIH-KEH-HE'),
  MapEntry<String, String>('MAJORGEN', 'SO-NA-KIH'),
  MapEntry<String, String>('BRIGADIERGEN', 'SO-A-LA-IH'),
  MapEntry<String, String>('COLONEL', 'ATSAH-BESH-LE-GAI'),
  MapEntry<String, String>('LTCOLONEL', 'CHE-CHIL-BE-TAH-BESH-LEGAI'),
  MapEntry<String, String>('MAJOR', 'CHE-CHIL-BE-TAH-OLA'),
  MapEntry<String, String>('CAPTAIN', 'BESH-LEGAI-NAH-KIH'),
  MapEntry<String, String>('LIEUTENANT', 'BESH-LEGAI-A-LAH-IH'),
  MapEntry<String, String>('COMMANDINGOFFICER', 'HASH-KAY-GI-NA-TAH'),
  MapEntry<String, String>('EXECUTIVEOFFICER', 'BIH-DA-HOL-NEHI'),
  MapEntry<String, String>('AFRICA', 'ZHIN-NI'),
  MapEntry<String, String>('ALASKA', 'BEH-HGA'),
  MapEntry<String, String>('AMERICA', 'NE-HE-MAH'),
  MapEntry<String, String>('AUSTRALIA', 'CHA-YES-DESI'),
  MapEntry<String, String>('BRITAIN', 'TOH-TA'),
  MapEntry<String, String>('CHINA', 'CEH-YEHS-BESI'),
  MapEntry<String, String>('FRANCE', 'DA-GHA-HI'),
  MapEntry<String, String>('GERMANY', 'BESH-BE-CHA-HE'),
  MapEntry<String, String>('ICELAND', 'TKIN-KE-YAH'),
  MapEntry<String, String>('INDIA', 'AH-LE-GAI'),
  MapEntry<String, String>('ITALY', 'DOH-HA-CHI-YALI-TCHI'),
  MapEntry<String, String>('JAPAN', 'BEH-NA-ALI-TSOSIE'),
  MapEntry<String, String>('PHILIPPINE', 'KE-YAH-DA-NA-LHE'),
  MapEntry<String, String>('RUSSIA', 'SILA-GOL-CHI-IH'),
  MapEntry<String, String>('SOUTHAMERICA', 'SHA-DE-AH-NE-HI-MAH'),
  MapEntry<String, String>('SPAIN', 'DEBA-DE-NIH'),
  // name of airplanes
  MapEntry<String, String>('PLANES', 'WO-TAH-DE-NE-IH'),
  MapEntry<String, String>('DIVEBOMBER', 'GINI'),
  MapEntry<String, String>('TORPEDOPLANE', 'TAS-CHIZZIE'),
  MapEntry<String, String>('OBSPLAN', 'NE-AS-JAH'),
  MapEntry<String, String>('FIGHTERPLANE', 'DA-HE-TIH-HI'),
  MapEntry<String, String>('BOMBERPLANE', 'JAY-SHO'),
  MapEntry<String, String>('PATROLPLANE', 'GA-GIH'),
  MapEntry<String, String>('TRANSPORT', 'ATSAH'),
  MapEntry<String, String>('TRANSPORT', 'DINEH-NAY-YE-HI'),
  // name of ships
  MapEntry<String, String>('SHIPS', 'TOH-DINEH-IH'),
  MapEntry<String, String>('BATTLESHIP', 'LO-TSO'),
  MapEntry<String, String>('AIRCRAFT', 'TSIDI-MOFFA-YE-HI'),
  MapEntry<String, String>('SUBMARINE', 'BESH-LO'),
  MapEntry<String, String>('MINESWEEPER', 'CHA'),
  MapEntry<String, String>('DESTROYER', 'CA-LO'),
  MapEntry<String, String>('CRUISER', 'LO-TSO-YAZZIE'),
  MapEntry<String, String>('MOSQUITOBOAT', 'TSE-E'),
  MapEntry<String, String>('JANUARY', 'ATSAH-BE-YAZ'),
  MapEntry<String, String>('FEBRUARY', 'WOZ-CHEIND'),
  MapEntry<String, String>('MARCH', 'TAH-CHILL'),
  MapEntry<String, String>('APRIL', 'TAH-TSO'),
  MapEntry<String, String>('MAY', 'TAH-TSOSIE'),
  MapEntry<String, String>('JUNE', 'BE-NE-EH-EH-JAH-TSO'),
  MapEntry<String, String>('JULY', 'BE-NE-TA-TSOSIE'),
  MapEntry<String, String>('AUGUST', 'BE-NEEN-TA-TSO'),
  MapEntry<String, String>('SEPTEMBER', 'GHAW-JIH'),
  MapEntry<String, String>('OCTOBER', 'NIL-CHI-TSOSIE'),
  MapEntry<String, String>('NOVEMBER', 'NIL-CHI-TSO'),
  MapEntry<String, String>('DECEMBER', 'YAS-NIL-TES'),
  MapEntry<String, String>('ABANDON', 'YE-TSAN'),
  MapEntry<String, String>('ABOUT', 'WOLA-CHI-A-MOFFA-GAHN'),
  MapEntry<String, String>('ABREAST', 'WOLA-CHEE-BE-YIED'),
  MapEntry<String, String>('ACCOMPLISH', 'UL-SO'),
  MapEntry<String, String>('ACCORDING', 'BE-KA-HO'),
  MapEntry<String, String>('ACKNOWLEDGE', 'HANOT-DZIED'),
  MapEntry<String, String>('ACTION', 'AH-HA-TINH'),
  MapEntry<String, String>('ACTIVITY', 'AH-HA-TINH-Y'),
  MapEntry<String, String>('ADEQUATE', 'BEH-GHA'),
  MapEntry<String, String>('ADDITION', 'IH-HE-DE-NDEL'),
  MapEntry<String, String>('ADDRESS', 'YI-CHIN-HA-TSE'),
  MapEntry<String, String>('ADJACENT', 'BE-GAHI'),
  MapEntry<String, String>('ADJUST', 'HAS-TAI-NEL-KAD'),
  MapEntry<String, String>('ADVANCE', 'NAS-SEY'),
  MapEntry<String, String>('ADVISE', 'NA-NETIN'),
  MapEntry<String, String>('AERIAL', 'BE-ZONZ'),
  MapEntry<String, String>('AFFIRMATIVE', 'LANH'),
  MapEntry<String, String>('AFTER', 'BI-KHA-DI'),
  MapEntry<String, String>('AGAINST', 'BE-NA-GNISH'),
  MapEntry<String, String>('AID', 'EDA-ELE-TSOOD'),
  MapEntry<String, String>('AIR', 'NILCHI'),
  MapEntry<String, String>('AIRDOME', 'NILCHI-BEGHAN'),
  MapEntry<String, String>('ALERT', 'HA-IH-DES-EE'),
  MapEntry<String, String>('ALL', 'TA-A-TAH'),
  MapEntry<String, String>('ALLIES', 'NIH-HI-CHO'),
  MapEntry<String, String>('ALONG', 'WOLACHEE-SNEZ'),
  MapEntry<String, String>('ALSO', 'EH-DO'),
  MapEntry<String, String>('ALTERNATE', 'NA-KEE-GO-NE-NAN-DEY-HE'),
  MapEntry<String, String>('AMBUSH', 'KHAC-DA'),
  MapEntry<String, String>('AMMUNITION', 'BEH-ELI-DOH-BE-CAH-ALI-TAS-AI'),
  MapEntry<String, String>('AMPHIBIOUS', 'CHAL'),
  MapEntry<String, String>('AND', 'DO'),
  MapEntry<String, String>('ANGLE', 'DEE-CAHN'),
  MapEntry<String, String>('ANNEX', 'IH-NAY-TANI'),
  MapEntry<String, String>('ANNOUNCE', 'BEH-HA-O-DZE'),
  MapEntry<String, String>('ANTI', 'WOL-LA-CHEE-TSIN'),
  MapEntry<String, String>('ANTICIPATE', 'NI-JOL-LIH'),
  MapEntry<String, String>('ANY', 'TAH-HA-DAH'),
  MapEntry<String, String>('APPEAR', 'YE-KA-HA-YA'),
  MapEntry<String, String>('APPROACH', 'BI-CHI-OL-DAH'),
  MapEntry<String, String>('APPROXIMATE', 'TO-KUS-DAN'),
  MapEntry<String, String>('ARE', 'GAH-TSO BIG'),
  MapEntry<String, String>('AREA', 'HAZ-A-GIH'),
  MapEntry<String, String>('ARMOR', 'BESH-YE-HA-DA-DI-TEH'),
  MapEntry<String, String>('ARMY', 'LEI-CHA-IH-YIL-KNEE-IH'),
  MapEntry<String, String>('ARRIVE', 'IL-DAY'),
  MapEntry<String, String>('ARTILLERY', 'BE-AL-DOH-TSO-LANI'),
  MapEntry<String, String>('AS', 'AHCE'),
  MapEntry<String, String>('ASSAULT', 'ALTSEH-E-JAH-HE'),
  MapEntry<String, String>('ASSEMBLE', 'DE-JI-KASH'),
  MapEntry<String, String>('ASSIGN', 'BAH-DEH-TAHN'),
  MapEntry<String, String>('AT', 'AH-DI'),
  MapEntry<String, String>('ATTACK', 'AL-TAH-JE-JAY'),
  MapEntry<String, String>('ATTEMPT', 'BO-O-NE-TAH'),
  MapEntry<String, String>('ATTENTION', 'GIHA'),
  MapEntry<String, String>('AUTHENTICATOR', 'HANI-BA-AH-HO-ZIN'),
  MapEntry<String, String>('AUTHORIZE', 'BE-BO-HO-SNEE'),
  MapEntry<String, String>('AVAILABLE', 'TA-SHOZ-TEH-IH'),
  MapEntry<String, String>('BAGGAGE', 'KLAILH'),
  MapEntry<String, String>('BANZAI', 'NE-TAH'),
  MapEntry<String, String>('BARGE', 'BESH-NA-ELT'),
  MapEntry<String, String>('BARRAGE', 'BESH-BA-WA-CHIND'),
  MapEntry<String, String>('BARRIER', 'BIH-CHAN-NI-AH'),
  MapEntry<String, String>('BASE', 'BIH-TSEE-DIH'),
  MapEntry<String, String>('BATTERY', 'BIH-BE-AL-DOH-TKA-IH'),
  MapEntry<String, String>('BATTLE', 'DA-AH-HI-DZI-TSIO'),
  MapEntry<String, String>('BAY', 'TOH-AH-HI-GHINH'),
  MapEntry<String, String>('BAZOOKA', 'AH-ZHOL'),
  MapEntry<String, String>('BE', 'TSES-NAH'),
  MapEntry<String, String>('BEACH', 'TAH-BAHN'),
  MapEntry<String, String>('BEEN', 'TSES-NAH-NES-CHEE'),
  MapEntry<String, String>('BEFORE', 'BIH-TSE-DIH'),
  MapEntry<String, String>('BEGIN', 'HA-HOL-ZIZ'),
  MapEntry<String, String>('BELONG', 'TSES-NAH-SNEZ'),
  MapEntry<String, String>('BETWEEN', 'BI-TAH-KIZ'),
  MapEntry<String, String>('BEYOND', 'BILH-LA DI'),
  MapEntry<String, String>('BIVOUAC', 'EHL-NAS-TEH'),
  MapEntry<String, String>('BOMB', 'A-YE-SHI'),
  MapEntry<String, String>('BOOBYTRAP', 'DINEH-BA-WHOA-BLEHI'),
  MapEntry<String, String>('BORNE', 'YE-CHIE-TSAH'),
  MapEntry<String, String>('BOUNDARY', 'KA-YAH-BI-NA-HAS-DZOH'),
  MapEntry<String, String>('BULLDOZER', 'DOLA-ALTH-WHOSH'),
  MapEntry<String, String>('BUNKER', 'TSAS-KA'),
  MapEntry<String, String>('BUT', 'NEH-DIH'),
  MapEntry<String, String>('BY', 'BE-GHA'),
  MapEntry<String, String>('CABLE', 'BESH-LKOH'),
  MapEntry<String, String>('CALIBER', 'NAHL-KIHD'),
  MapEntry<String, String>('CAMP', 'TO-ALTSEH-HOGAN'),
  MapEntry<String, String>('CAMOUFLAGE', 'DI-NES-IH'),
  MapEntry<String, String>('CAN', 'YAH-DI-ZINI'),
  MapEntry<String, String>('CANNONEER', 'BE-AL-DOH-TSO-DEY-DIL-DON-IGI'),
  MapEntry<String, String>('CAPACITY', 'BE-NEL-AH'),
  MapEntry<String, String>('CAPTURE', 'YIS-NAH'),
  MapEntry<String, String>('CARRY', 'YO-LAILH'),
  MapEntry<String, String>('CASE', 'BIT-SAH'),
  MapEntry<String, String>('CASUALTY', 'BIH-DIN-NE-DEY'),
  MapEntry<String, String>('CAUSE', 'BI-NIH-NANI'),
  MapEntry<String, String>('CAVE', 'TSA-OND'),
  MapEntry<String, String>('CEILING', 'DA-TEL-JAY'),
  MapEntry<String, String>('CEMETARY', 'JISH-CHA'),
  MapEntry<String, String>('CENTER', 'ULH-NE-IH'),
  MapEntry<String, String>('CHANGE', 'THLA-GO-A-NAT-ZAH'),
  MapEntry<String, String>('CHANNEL', 'HA-TALHI-YAZZIE'),
  MapEntry<String, String>('CHARGE', 'AH-TAH-GI-JAH'),
  MapEntry<String, String>('CHEMICAL', 'TA-NEE'),
  MapEntry<String, String>('CIRCLE', 'NAS-PAS'),
  MapEntry<String, String>('CIRCUIT', 'AH-HEH-HA-DAILH'),
  MapEntry<String, String>('CLASS', 'ALTH-AH-A-TEH'),
  MapEntry<String, String>('CLEAR', 'YO-AH-HOL-ZHOD'),
  MapEntry<String, String>('CLIFF', 'TSE-YE-CHEE'),
  MapEntry<String, String>('CLOSE', 'UL-CHI-UH-NAL-YAH'),
  MapEntry<String, String>('COASTGUARD', 'TA-BAS-DSISSI'),
  MapEntry<String, String>('CODE', 'YIL-TAS'),
  MapEntry<String, String>('COLON', 'NAKI-ALH--DEH-DA-AL-ZHIN'),
  MapEntry<String, String>('COLUMN', 'ALTH-KAY-NE-ZIH'),
  MapEntry<String, String>('COMBAT', 'DA-AH-HI-JIH-GANH'),
  MapEntry<String, String>('COMBINATION', 'AL-TKAS-EI'),
  MapEntry<String, String>('COME', 'HUC-QUO'),
  MapEntry<String, String>('COMMA', 'TSA-NA-DAHL'),
  MapEntry<String, String>('COMMERCIAL', 'NAI-EL-NE-HI'),
  MapEntry<String, String>('COMMIT', 'HUC-QUO-LA-JISH'),
  MapEntry<String, String>('COMMUNICATION', 'HA-NEH-AL-ENJI'),
  MapEntry<String, String>('CONCEAL', 'BE-KI-ASZ-JOLE'),
  MapEntry<String, String>('CONCENTRATION', 'TA-LA-HI-JIH'),
  MapEntry<String, String>('CONCUSSION', 'WHE-HUS-DIL'),
  MapEntry<String, String>('CONDITION', 'AH-HO-TAI'),
  MapEntry<String, String>('CONFERENCE', 'BE-KE-YA-TI'),
  MapEntry<String, String>('CONFIDENTIAL', 'NA-NIL-IN'),
  MapEntry<String, String>('CONFIRM', 'TA-A-NEH'),
  MapEntry<String, String>('CONQUER', 'A-KEH-DES-DLIN'),
  MapEntry<String, String>('CONSIDER', 'NE-TSA-CAS'),
  MapEntry<String, String>('CONSIST', 'BILH'),
  MapEntry<String, String>('CONSOLIDATE', 'AH-HIH-HI-NIL'),
  MapEntry<String, String>('CONSTRUCT', 'AHL-NEH'),
  MapEntry<String, String>('CONTACT', 'AH-HI-DI-DAIL'),
  MapEntry<String, String>('CONTINUE', 'TA-YI-TEH'),
  MapEntry<String, String>('CONTROL', 'NAI-GHIZ'),
  MapEntry<String, String>('CONVOY', 'TKAL-KAH-O-NEL'),
  MapEntry<String, String>('COORDINATE', 'BEH-EH-HO-ZIN-NA-AS-DZOH'),
  MapEntry<String, String>('COUNTERATTACK', 'WOLTAH-AL-KI-GI-JEH'),
  MapEntry<String, String>('COURSE', 'CO-JI-GOH'),
  MapEntry<String, String>('CRAFT', 'AH-TOH'),
  MapEntry<String, String>('CREEK', 'TOH-NIL-TSANH'),
  MapEntry<String, String>('CROSS', 'AL-N-AS-DZOH'),
  MapEntry<String, String>('CUB', 'SHUSH-YAHZ'),
  MapEntry<String, String>('DASH', 'US-DZOH'),
  MapEntry<String, String>('DAWN', 'HA-YELI-KAHN'),
  MapEntry<String, String>('DEFENSE', 'AH-KIN-CIL-TOH'),
  MapEntry<String, String>('DEGREE', 'NAHL-KIHD'),
  MapEntry<String, String>('DELAY', 'BE-SITIHN'),
  MapEntry<String, String>('DELIVER', 'BE-BIH-ZIHDE'),
  MapEntry<String, String>('DEMOLITION', 'AH-DEEL-TAHI'),
  MapEntry<String, String>('DENSE', 'HO-DILH-CLA'),
  MapEntry<String, String>('DEPART', 'DA-DE-YAH'),
  MapEntry<String, String>('DEPARTMENT', 'HOGAN'),
  MapEntry<String, String>('DESIGNATE', 'YE-KHI-DEL-NEI'),
  MapEntry<String, String>('DESPERATE', 'AH-DA-AH-HO-DZAH'),
  MapEntry<String, String>('DETACH', 'AL-CHA-NIL'),
  MapEntry<String, String>('DETAIL', 'BE-BEH-SHA'),
  MapEntry<String, String>('DETONATOR', 'AH-DEEL-TAHI'),
  MapEntry<String, String>('DIFFICULT', 'NA-NE-KLAH'),
  MapEntry<String, String>('DIGIN', 'LE-EH-GADE'),
  MapEntry<String, String>('DIRECT', 'AH-JI-GO'),
  MapEntry<String, String>('DISEMBARK', 'EH-HA-JAY'),
  MapEntry<String, String>('DISPATCH', 'LA-CHAI-EN-SEIS-BE-JAY'),
  MapEntry<String, String>('DISPLACE', 'HIH-DO-NAL'),
  MapEntry<String, String>('DISPLAY', 'BE-SEIS-NA-NEH'),
  MapEntry<String, String>('DISPOSITION', 'A-HO-TEY'),
  MapEntry<String, String>('DISTRIBUTE', 'NAH-NEH'),
  MapEntry<String, String>('DISTRICT', 'BE-THIN-YA-NI-CHE'),
  MapEntry<String, String>('DO', 'TSE-LE'),
  MapEntry<String, String>('DOCUMENT', 'BEH-EH-HO-ZINZ'),
  MapEntry<String, String>('DRIVE', 'AH-NOL-KAHL'),
  MapEntry<String, String>('DUD', 'DI-GISS-YAHZIE'),
  MapEntry<String, String>('DUMMY', 'DI-GISS-TSO'),
  MapEntry<String, String>('EACH', 'TA-LAHI-NE-ZINI-GO'),
  MapEntry<String, String>('ECHELON', 'WHO-DZAH'),
  MapEntry<String, String>('EDGE', 'BE-BA-HI'),
  MapEntry<String, String>('EFFECTIVE', 'BE-DELH-NEED'),
  MapEntry<String, String>('EFFORT', 'YEA-GO'),
  MapEntry<String, String>('ELEMENT', 'AH-NA-NAI'),
  MapEntry<String, String>('ELEVATE', 'ALI-KHI-HO-NE-OHA'),
  MapEntry<String, String>('ELIMINATE', 'HA-BEH-TO-DZIL'),
  MapEntry<String, String>('EMBARK', 'EH-HO-JAY'),
  MapEntry<String, String>('EMERGENCY', 'HO-NEZ-CLA'),
  MapEntry<String, String>('EMPLACEMENT', 'LA-AZ-NIL'),
  MapEntry<String, String>('ENCIRCLE', 'YE-NAS-TEH'),
  MapEntry<String, String>('ENCOUNTER', 'BI-KHANH'),
  MapEntry<String, String>('ENGAGE', 'A-HA-NE-HO-TA'),
  MapEntry<String, String>('ENGINE', 'CHIDI-BI-TSI-TSINE'),
  MapEntry<String, String>('ENGINEER', 'DAY-DIL-JAH-HE'),
  MapEntry<String, String>('ENLARGE', 'NIH-TSA-GOH-AL-NEH'),
  MapEntry<String, String>('ENLIST', 'BIH-ZIH-A-DA-YI-LAH'),
  MapEntry<String, String>('ENTIRE', 'TA-A-TAH'),
  MapEntry<String, String>('ENTRENCH', 'E-GAD-AH-NE-LIH'),
  MapEntry<String, String>('ENVELOP', 'A-ZAH-GI-YA'),
  MapEntry<String, String>('EQUIPMENT', 'YA-HA-DE-TAHI'),
  MapEntry<String, String>('ERECT', 'YEH-ZIHN'),
  MapEntry<String, String>('ESCAPE', 'A-ZEH-HA-GE-YAH'),
  MapEntry<String, String>('ESTABLISH', 'HAS-TAY-DZAH'),
  MapEntry<String, String>('ESTIMATE', 'BIH-KE-TSE-HOD-DES-KEZ'),
  MapEntry<String, String>('EVACUATE', 'HA-NA'),
  MapEntry<String, String>('EXCEPT', 'NA-WOL-NE'),
  MapEntry<String, String>('EXCEPT', 'NEH-DIH'),
  MapEntry<String, String>('EXCHANGE', 'ALH-NAHL-YAH'),
  MapEntry<String, String>('EXECUTE', 'A-DO-NIL'),
  MapEntry<String, String>('EXPLOSIVE', 'AH-DEL-TAHI'),
  MapEntry<String, String>('EXPEDITE', 'SHIL-LOH'),
  MapEntry<String, String>('EXTEND', 'NE-TDALE'),
  MapEntry<String, String>('EXTREME', 'AL-TSAN-AH-BAHM'),
  MapEntry<String, String>('FAIL', 'CHA-AL-EIND'),
  MapEntry<String, String>('FAILURE', 'YEES-GHIN'),
  MapEntry<String, String>('FARM', 'MAI-BE-HE-AHGAN'),
  MapEntry<String, String>('FEED', 'DZEH-CHI-YON'),
  MapEntry<String, String>('FIELD', 'CLO-DIH'),
  MapEntry<String, String>('FIERCE', 'TOH-BAH-HA-ZSID'),
  MapEntry<String, String>('FILE', 'BA-EH-CHEZ'),
  MapEntry<String, String>('FINAL', 'TAH-AH-KWO-DIH'),
  MapEntry<String, String>('FLAMETHROWER', 'COH-AH-GHIL-TLID'),
  MapEntry<String, String>('FLANK', 'DAH-DI-KAD'),
  MapEntry<String, String>('FLARE', 'WO-CHI'),
  MapEntry<String, String>('FLIGHT', 'MA-E-AS-ZLOLI'),
  MapEntry<String, String>('FORCE', 'TA-NA-NE-LADI'),
  MapEntry<String, String>('FORM', 'BE-CHA'),
  MapEntry<String, String>('FORMATION', 'BE-CHA-YE-LAILH'),
  MapEntry<String, String>('FORTIFICATION', 'AH-NA-SOZI'),
  MapEntry<String, String>('FORTIFY', 'AH-NA-SOZI-YAZZIE'),
  MapEntry<String, String>('FORWARD', 'TEHI'),
  MapEntry<String, String>('FRAGMENTATION', 'BESH-YAZZIE'),
  MapEntry<String, String>('FREQUENCY', 'HA-TALHI-TSO'),
  MapEntry<String, String>('FRIENDLY', 'NEH-HECHO-DA-NE'),
  MapEntry<String, String>('FROM', 'BI-TSAN-DEHN'),
  MapEntry<String, String>('FURNISH', 'YEAS-NIL'),
  MapEntry<String, String>('FURTHER', 'WO-NAS-DI'),
  MapEntry<String, String>('GARRISON', 'YAH-A-DA-HAL-YON-IH'),
  MapEntry<String, String>('GASOLINE', 'CHIDI-BI-TOH'),
  MapEntry<String, String>('GRENADE', 'NI-MA-SI'),
  MapEntry<String, String>('GUARD', 'NI-DIH-DA-HI'),
  MapEntry<String, String>('GUIDE', 'NAH-E-THLAI'),
  MapEntry<String, String>('HALL', 'LHI-TA-A-TA'),
  MapEntry<String, String>('HALFTRACK', 'ALH-NIH-JAH-A-QUHE'),
  MapEntry<String, String>('HALT', 'TA-AKWAI-I'),
  MapEntry<String, String>('HANDLE', 'BET-SEEN'),
  MapEntry<String, String>('HAVE', 'JO'),
  MapEntry<String, String>('HEADQUARTER', 'NA-HA-TAH-TA-BA-HOGAN'),
  MapEntry<String, String>('HELD', 'WO-TAH-TA-EH-DAHN-OH'),
  MapEntry<String, String>('HIGH', 'WO-TAH'),
  MapEntry<String, String>('HIGHEXPLOSIVE', 'BE-AL-DOH-BE-CA-BIH-DZIL-IGI'),
  MapEntry<String, String>('HIGHWAY', 'WO-TAH-HO-NE-TEH'),
  MapEntry<String, String>('HOLD', 'WO-TKANH'),
  MapEntry<String, String>('HOSPITAL', 'A-ZEY-AL-IH'),
  MapEntry<String, String>('HOSTILE', 'A-NAH-NE-DZIN'),
  MapEntry<String, String>('HOWITZER', 'BE-EL-DON-TS-QUODI'),
  MapEntry<String, String>('ILLUMINATE', 'WO-CHI'),
  MapEntry<String, String>('IMMEDIATELY', 'SHIL-LOH'),
  MapEntry<String, String>('IMPACT', 'A-HE-DIS-GOH'),
  MapEntry<String, String>('IMPORTANT', 'BA-HAS-TEH'),
  MapEntry<String, String>('IMPROVE', 'HO-DOL-ZHOND'),
  MapEntry<String, String>('INCLUDE', 'EL-TSOD'),
  MapEntry<String, String>('INCREASE', 'HO-NALH'),
  MapEntry<String, String>('INDICATE', 'BA-HAL-NEH'),
  MapEntry<String, String>('INFANTRY', 'TA-NEH-NAL-DAHI'),
  MapEntry<String, String>('INFILTRATE', 'YE-GHA-NE-JEH'),
  MapEntry<String, String>('INITIAL', 'BEH-ED-DE-DLID'),
  MapEntry<String, String>('INSTALL', 'EHD-TNAH'),
  MapEntry<String, String>('INSTALLATION', 'NAS-NIL'),
  MapEntry<String, String>('INSTRUCT', 'NA-NE-TGIN'),
  MapEntry<String, String>('INTELLIGENCE', 'HO-YA'),
  MapEntry<String, String>('INTENSE', 'DZEEL'),
  MapEntry<String, String>('INTERCEPT', 'YEL-NA-ME-JAH'),
  MapEntry<String, String>('INTERFERE', 'AH-NILH-KHLAI'),
  MapEntry<String, String>('INTERPRET', 'AH-TAH-HA-NE'),
  MapEntry<String, String>('INVESTIGATE', 'NA-ALI-KA'),
  MapEntry<String, String>('INVOLVE', 'A-TAH'),
  MapEntry<String, String>('IS', 'SEIS'),
  MapEntry<String, String>('ISLAND', 'SEIS-KEYAH'),
  MapEntry<String, String>('ISOLATE', 'BIH-TSA-NEL-KAD'),
  MapEntry<String, String>('JUNGLE', 'WOH-DI-CHIL'),
  MapEntry<String, String>('KILL', 'NAZ-TSAID'),
  MapEntry<String, String>('KILOCYCLE', 'NAS-TSAID-A-KHA-AH-YEH-HA-DILH'),
  MapEntry<String, String>('LABOR', 'NA-NISH'),
  MapEntry<String, String>('LAND', 'KAY-YAH'),
  MapEntry<String, String>('LAUNCH', 'TKA-GHIL-ZHOD'),
  MapEntry<String, String>('LEADER', 'AH-NA-GHAI'),
  MapEntry<String, String>('LEAST', 'DE-BE-YAZIE-HA-A-AH'),
  MapEntry<String, String>('LEAVE', 'DAH-DE-YAH'),
  MapEntry<String, String>('LEFT', 'NISH-CLA-JIH-GOH'),
  MapEntry<String, String>('LESS', 'BI-OH'),
  MapEntry<String, String>('LEVEL', 'DIL-KONH'),
  MapEntry<String, String>('LIAISON', 'DA-A-HE-GI-ENEH'),
  MapEntry<String, String>('LIMIT', 'BA-HAS-AH'),
  MapEntry<String, String>('LITTER', 'NI-DAS-TON'),
  MapEntry<String, String>('LOCATE', 'A-KWE-EH'),
  MapEntry<String, String>('LOSS', 'UT-DIN'),
  MapEntry<String, String>('MACHINEGUN', 'A-KNAH-AS-DONIH'),
  MapEntry<String, String>('MAGNETIC', 'NA-E-LAHI'),
  MapEntry<String, String>('MANAGE', 'HASTNI-BEH-NA-HAI'),
  MapEntry<String, String>('MANEUVER', 'NA-NA-O-NALTH'),
  MapEntry<String, String>('MAP', 'KAH-YA-NESH-CHAI'),
  MapEntry<String, String>('MAXIMUM', 'BEL-DIL-KHON'),
  MapEntry<String, String>('MECHANIC', 'CHITI-A-NAYL-INIH'),
  MapEntry<String, String>('MECHANIZED', 'CHIDI-DA-AH-HE-GONI'),
  MapEntry<String, String>('MEDICAL', 'A-ZAY'),
  MapEntry<String, String>('MEGACYCLE', 'MIL-AH-HEH-AH-DILH'),
  MapEntry<String, String>('MERCHANTSHIP', 'NA-EL-NEHI-TSIN-NA-AILH'),
  MapEntry<String, String>('MESSAGE', 'HANE-AL-NEH'),
  MapEntry<String, String>('MILITARY', 'SILAGO-KEH-GOH'),
  MapEntry<String, String>('MILLIMETER', 'NA-AS-TSO-SI-A-YE-DO-TISH'),
  MapEntry<String, String>('MINE', 'HA-GADE'),
  MapEntry<String, String>('MINIMUM', 'BE-OH'),
  MapEntry<String, String>('MINUTE', 'AH-KHAY-EL-KIT-YAZZIE'),
  MapEntry<String, String>('MISSION', 'AL-NESHODI'),
  MapEntry<String, String>('MISTAKE', 'O-ZHI'),
  MapEntry<String, String>('MOPPING', 'HA-TAO-DI'),
  MapEntry<String, String>('MORE', 'THLA-NA-NAH'),
  MapEntry<String, String>('MORTAR', 'BE-AL-DOH-CID-DA-HI'),
  MapEntry<String, String>('MOTION', 'NA-HOT-NAH'),
  MapEntry<String, String>('MOTOR', 'CHIDE-BE-TSE-TSEN'),
  MapEntry<String, String>('NATIVE', 'KA-HA-TENI'),
  MapEntry<String, String>('NAVY', 'TAL-KAH-SILAGO'),
  MapEntry<String, String>('NECESSARY', 'YE-NA-ZEHN'),
  MapEntry<String, String>('NEGATIVE', 'DO-YA-SHO-DA'),
  MapEntry<String, String>('NET', 'NA-NES-DIZI'),
  MapEntry<String, String>('NEUTRAL', 'DO-NEH-LINI'),
  MapEntry<String, String>('NORMAL', 'DOH-A-TA-H-DAH'),
  MapEntry<String, String>('NOT', 'NI-DAH-THAN-ZIE'),
  MapEntry<String, String>('NOTICE', 'NE-DA-TAZI-THIN'),
  MapEntry<String, String>('NOW', 'KUT'),
  MapEntry<String, String>('NUMBER', 'BEH-BIH-KE-AS-CHINIGH'),
  MapEntry<String, String>('OBJECTIVE', 'BI-NE-YEI'),
  MapEntry<String, String>('OBSERVE', 'HAL-ZID'),
  MapEntry<String, String>('OBSTACLE', 'DA-HO-DESH-ZHA'),
  MapEntry<String, String>('OCCUPY', 'YEEL-TSOD'),
  MapEntry<String, String>('OF', 'TOH-NI-TKAL-LO'),
  MapEntry<String, String>('OFFENSIVE', 'BIN-KIE-JINH-JIH-DEZ-JAY'),
  MapEntry<String, String>('ONCE', 'TA-LAI-DI'),
  MapEntry<String, String>('ONLY', 'TA-EI-TAY-A-YAH'),
  MapEntry<String, String>('OPERATE', 'YE-NAHL-NISH'),
  MapEntry<String, String>('OPPORTUNITY', 'ASH-GA-ALIN'),
  MapEntry<String, String>('OPPOSITION', 'NE-HE-TSAH-JIH-SHIN'),
  MapEntry<String, String>('OR', 'EH-DO-DAH-GOH'),
  MapEntry<String, String>('ORANGE', 'TCHIL-LHE-SOI'),
  MapEntry<String, String>('ORDER', 'BE-EH-HO-ZINI'),
  MapEntry<String, String>('ORDNANCE', 'LEI-AZ-JAH'),
  MapEntry<String, String>('ORIGINATE', 'DAS-TEH-DO'),
  MapEntry<String, String>('OTHER', 'LA-E-CIH'),
  MapEntry<String, String>('OUT', 'CLO-DIH'),
  MapEntry<String, String>('OVERLAY', 'BE-KA-HAS-TSOZ'),
  MapEntry<String, String>('PARENTHESIS', 'ATSANH'),
  MapEntry<String, String>('PARTICULAR', 'A-YO-AD-DO-NEH'),
  MapEntry<String, String>('PARTY', 'DA-SHA-JAH'),
  MapEntry<String, String>('PAY', 'NA-ELI-YA'),
  MapEntry<String, String>('PENALIZE', 'TAH-NI-DES-TANH'),
  MapEntry<String, String>('PERCENT', 'YAL'),
  MapEntry<String, String>('PERIOD', 'DA-AHL-ZHIN'),
  MapEntry<String, String>('PERIODIC', 'DA-AL-ZHIN-THIN-MOASI'),
  MapEntry<String, String>('PERMIT', 'GOS-SHI-E'),
  MapEntry<String, String>('PERSONNEL', 'DA-NE-LEI'),
  MapEntry<String, String>('PHOTOGRAPH', 'BEH-CHI-MA-HAD-NIL'),
  MapEntry<String, String>('PILLBOX', 'BI-SO-DIH-DOT-SAHI-BI-TSAH'),
  MapEntry<String, String>('PINNEDDOWN', 'BIL-DAH-HAS-TANH-YA'),
  MapEntry<String, String>('PLANE', 'TSIDI'),
  MapEntry<String, String>('PLASMA', 'DIL-DI-GHILI'),
  MapEntry<String, String>('POINT', 'BE-SO-DE-DEZ-AHE'),
  MapEntry<String, String>('PONTOON', 'TKOSH-JAH-DA-NA-ELT'),
  MapEntry<String, String>('POSITION', 'BILH-HAS-AHN'),
  MapEntry<String, String>('POSSIBLE', 'TA-HA-AH-TAY'),
  MapEntry<String, String>('POST', 'SAH-DEI'),
  MapEntry<String, String>('PREPARE', 'HASH-TAY-HO-DIT-NE'),
  MapEntry<String, String>('PRESENT', 'KUT'),
  MapEntry<String, String>('PREVIOUS', 'BIH-TSE-DIH'),
  MapEntry<String, String>('PRIMARY', 'ALTSEH-NAN-DAY-HI-GIH'),
  MapEntry<String, String>('PRIORITY', 'HANE-PESODI'),
  MapEntry<String, String>('PROBABLE', 'DA-TSI'),
  MapEntry<String, String>('PROBLEM', 'NA-NISH-TSOH'),
  MapEntry<String, String>('PROCEED', 'NAY-NIH-JIH'),
  MapEntry<String, String>('PROGRESS', 'NAH-SAI'),
  MapEntry<String, String>('PROTECT', 'AH-CHANH'),
  MapEntry<String, String>('PROVIDE', 'YIS-NIL'),
  MapEntry<String, String>('PURPLE', 'DINL-CHI'),
  MapEntry<String, String>('PYROTECHNIC', 'COH-NA-CHANH'),
  MapEntry<String, String>('QUESTION', 'AH-JAH'),
  MapEntry<String, String>('QUICK', 'SHIL-LOH'),
  MapEntry<String, String>('RADAR', 'ESAT-TSANH'),
  MapEntry<String, String>('RAID', 'DEZJAY'),
  MapEntry<String, String>('RAILHEAD', 'A-DE-GEH-HI'),
  MapEntry<String, String>('RAILROAD', 'KONH-NA-AL-BANSI-BI-THIN'),
  MapEntry<String, String>('RALLYING', 'A-LAH-NA-O-GLALIH'),
  MapEntry<String, String>('RANGE', 'AN-ZAH'),
  MapEntry<String, String>('RATE', 'GAH-EH-YAHN'),
  MapEntry<String, String>('RATION', 'NA-A-JAH'),
  MapEntry<String, String>('RAVINE', 'CHUSH-KA'),
  MapEntry<String, String>('REACH', 'IL-DAY'),
  MapEntry<String, String>('READY', 'KUT'),
  MapEntry<String, String>('REAR', 'BE-KA-DENH'),
  MapEntry<String, String>('RECEIPT', 'SHOZ-TEH'),
  MapEntry<String, String>('RECOMMEND', 'CHE-HO-TAI-TAHN'),
  MapEntry<String, String>('RECONNAISSANCE', 'HA-A-CIDI'),
  MapEntry<String, String>('RECONNOITER', 'TA-HA-NE-AL-YA'),
  MapEntry<String, String>('RECORD', 'GAH-AH-NAH-KLOLI'),
  MapEntry<String, String>('RED', 'LI-CHI'),
  MapEntry<String, String>('REEF', 'TSA-ZHIN'),
  MapEntry<String, String>('REEMBARK', 'EH-NA-COH'),
  MapEntry<String, String>('REFIRE', 'NA-NA-COH'),
  MapEntry<String, String>('REGULATE', 'NA-YEL-N'),
  MapEntry<String, String>('REINFORCE', 'NAL-DZIL'),
  MapEntry<String, String>('RELIEF', 'AGANH-TOL-JAY'),
  MapEntry<String, String>('RELIEVE', 'NAH-JIH-CO-NAL-YA'),
  MapEntry<String, String>('REORGANIZE', 'HA-DIT-ZAH'),
  MapEntry<String, String>('REPLACEMENT', 'NI-NA-DO-NIL'),
  MapEntry<String, String>('REPORT', 'WHO-NEH'),
  MapEntry<String, String>('REPRESENTATIVE', 'TKA-NAZ-NILI'),
  MapEntry<String, String>('REQUEST', 'JO-KAYED-GOH'),
  MapEntry<String, String>('RESERVE', 'HESH-J-E'),
  MapEntry<String, String>('RESTRICT', 'BA-HO-CHINI'),
  MapEntry<String, String>('RETIRE', 'AH-HOS-TEEND'),
  MapEntry<String, String>('RETREAT', 'JI-DIN-NES-CHANH'),
  MapEntry<String, String>('RETURN', 'NA-DZAH'),
  MapEntry<String, String>('REVEAL', 'WHO-NEH'),
  MapEntry<String, String>('REVERT', 'NA-SI-YIZ'),
  MapEntry<String, String>('REVETMENT', 'BA-NAS-CLA'),
  MapEntry<String, String>('RIDGE', 'GAH-GHIL-KEID'),
  MapEntry<String, String>('RIFLEMAN', 'BE-AL-DO-HOSTEEN'),
  MapEntry<String, String>('RIVER', 'TOH-YIL-KAL'),
  MapEntry<String, String>('ROBOTBOMB', 'A-YE-SHI-NA-TAH-IH'),
  MapEntry<String, String>('ROCKET', 'LESZ-YIL-BESHI'),
  MapEntry<String, String>('ROLL', 'YEH-MAS'),
  MapEntry<String, String>('ROUND', 'NAZ-PAS'),
  MapEntry<String, String>('ROUTE', 'GAH-BIH-TKEEN'),
  MapEntry<String, String>('RUNNER', 'NIH-DZID-TEIH'),
  MapEntry<String, String>('SABOTAGE', 'A-TKEL-YAH'),
  MapEntry<String, String>('SABOTEUR', 'A-TKEL-EL-INI'),
  MapEntry<String, String>('SAILOR', 'CHA-LE-GAI'),
  MapEntry<String, String>('SALVAGE', 'NA-HAS-GLAH'),
  MapEntry<String, String>('SAT', 'BIH-LA-SANA-CID-DA-HI'),
  MapEntry<String, String>('SCARLET', 'REDLHE-CHI'),
  MapEntry<String, String>('SCHEDULE', 'BEH-EH-HO-ZINI'),
  MapEntry<String, String>('SCOUT', 'HA-A-SID-AL-SIZI-GIH'),
  MapEntry<String, String>('SCREEN', 'BESH-NA-NES-DIZI'),
  MapEntry<String, String>('SEAMAN', 'TKAL-KAH-DINEH-IH'),
  MapEntry<String, String>('SECRET', 'BAH-HAS-TKIH'),
  MapEntry<String, String>('SECTOR', 'YOEHI'),
  MapEntry<String, String>('SECURE', 'YE-DZHE-AL-TSISI'),
  MapEntry<String, String>('SEIZE', 'YEEL-STOD'),
  MapEntry<String, String>('SELECT', 'BE-TAH-HAS-GLA'),
  MapEntry<String, String>('SEMICOLON', 'DA-AHL-ZHIN-BI-TSA-NA-DAHL'),
  MapEntry<String, String>('SET', 'DZEH-CID-DA-HI'),
  MapEntry<String, String>('SHACKLE', 'DI-BAH-NESH-GOHZ'),
  MapEntry<String, String>('SHELL', 'BE-AL-DOH-BE-CA'),
  MapEntry<String, String>('SHORE', 'TAH-BAHN'),
  MapEntry<String, String>('SHORT', 'BOSH-KEESH'),
  MapEntry<String, String>('SIDE', 'BOSH-KEESH'),
  MapEntry<String, String>('SIGHT', 'YE-EL-TSANH'),
  MapEntry<String, String>('SIGNAL', 'NA-EH-EH-GISH'),
  MapEntry<String, String>('SIMPLEX', 'ALAH-IH-NE-TIH'),
  MapEntry<String, String>('SIT', 'TKIN-CID-DA-HI'),
  MapEntry<String, String>('SITUATE', 'A-HO-TAY'),
  MapEntry<String, String>('SMOKE', 'LIT'),
  MapEntry<String, String>('SNIPER', 'OH-BEHI'),
  MapEntry<String, String>('SPACE', 'BE-TKAH'),
  MapEntry<String, String>('SPECIAL', 'E-YIH-SIH'),
  MapEntry<String, String>('SPEED', 'YO-ZONS'),
  MapEntry<String, String>('SPORADIC', 'AH-NA-HO-NEIL'),
  MapEntry<String, String>('SPOTTER', 'EEL-TSAY-I'),
  MapEntry<String, String>('SPRAY', 'KLESH-SO-DILZIN'),
  MapEntry<String, String>('SQUADRON', 'NAH-GHIZI'),
  MapEntry<String, String>('STORM', 'NE-OL'),
  MapEntry<String, String>('STRAFF', 'NA-WO-GHI-GOID'),
  MapEntry<String, String>('STRAGGLER', 'CHY-NE-DE-DAHE'),
  MapEntry<String, String>('STRATEGY', 'NA-HA-TAH'),
  MapEntry<String, String>('STREAM', 'TOH-NI-LIH'),
  MapEntry<String, String>('STRENGTH', 'DZHEL'),
  MapEntry<String, String>('STRETCH', 'DESZ-TSOOD'),
  MapEntry<String, String>('STRIKE', 'NAY-DAL-GHAL'),
  MapEntry<String, String>('STRIP', 'HA-TIH-JAH'),
  MapEntry<String, String>('STUBBORN', 'NIL-TA'),
  MapEntry<String, String>('SUBJECT', 'NA-NISH-YAZZIE'),
  MapEntry<String, String>('SUBMERGE', 'TKAL-CLA-YI-YAH'),
  MapEntry<String, String>('SUBMIT', 'A-NIH-LEH'),
  MapEntry<String, String>('SUBORDINATE', 'AL-KHI-NAL-DZL'),
  MapEntry<String, String>('SUCCEED', 'YAH-TAY-GO-E-ELAH'),
  MapEntry<String, String>('SUCCESS', 'UT-ZAH'),
  MapEntry<String, String>('SUCCESSFUL', 'UT-ZAH-HA-DEZ-BIN'),
  MapEntry<String, String>('SUCCESSIVE', 'UT-ZAH-SID'),
  MapEntry<String, String>('SUCH', 'YIS-CLEH'),
  MapEntry<String, String>('SUFFER', 'TO-HO-NE'),
  MapEntry<String, String>('SUMMARY', 'SHIN-GO-BAH'),
  MapEntry<String, String>('SUPPLEMENTARY', 'TKA-GO-NE-NAN-DEY-HE'),
  MapEntry<String, String>('SUPPLY', 'NAL-YEH-HI'),
  MapEntry<String, String>('SUPPLYSHIP', 'NALGA-HI-TSIN-NAH-AILH'),
  MapEntry<String, String>('SUPPORT', 'BA-AH-HOT-GLI'),
  MapEntry<String, String>('SURRENDER', 'NE-NA-CHA'),
  MapEntry<String, String>('SURROUND', 'NAZ-PAS'),
  MapEntry<String, String>('SURVIVE', 'YIS-DA-YA'),
  MapEntry<String, String>('SYSTEM', 'DI-BA-TSA-AS-ZHI-BI-TSIN'),
  MapEntry<String, String>('TACTICAL', 'E-CHIHN'),
  MapEntry<String, String>('TAKE', 'GAH-TAHN'),
  MapEntry<String, String>('TANK', 'CHAY-DA-GAHI'),
  MapEntry<String, String>('TANKDESTROYER', 'CHAY-DA-GAHI-NAIL-TSAIDI'),
  MapEntry<String, String>('TARGET', 'WOL-DONI'),
  MapEntry<String, String>('TASK', 'TAZI-NA-EH-DIL-KID'),
  MapEntry<String, String>('TEAM', 'DEH-NA-AS-TSO-SI'),
  MapEntry<String, String>('TERRACE', 'ALI-KHI-HO-NE-OHA'),
  MapEntry<String, String>('TERRAIN', 'TASHI-NA-HAL-THIN'),
  MapEntry<String, String>('TERRITORY', 'KA-YAH'),
  MapEntry<String, String>('THAT', 'TAZI-CHA'),
  MapEntry<String, String>('THE', 'CHA-GEE'),
  MapEntry<String, String>('THEIR', 'BIH'),
  MapEntry<String, String>('THEREAFTER', 'TA-ZI-KWA-I-BE-KA-DI'),
  MapEntry<String, String>('THESE', 'CHA-GI-O-EH'),
  MapEntry<String, String>('THEY', 'CHA-GEE'),
  MapEntry<String, String>('THIS', 'DI'),
  MapEntry<String, String>('TOGETHER', 'TA-BILH'),
  MapEntry<String, String>('TORPEDO', 'LO-BE-CA'),
  MapEntry<String, String>('TOTAL', 'TA-AL-SO'),
  MapEntry<String, String>('TRACER', 'BEH-NA-AL-KAH-HI'),
  MapEntry<String, String>('TRAFFICDIAGRAM', 'HANE-BA-NA-AS-DZOH'),
  MapEntry<String, String>('TRAIN', 'COH-NAI-ALI-BAHN-SI'),
  MapEntry<String, String>('TRANSPORTATION', 'A-HAH-DA-A-CHA'),
  MapEntry<String, String>('TRENCH', 'E-GADE'),
  MapEntry<String, String>('TRIPLE', 'TKA-IH'),
  MapEntry<String, String>('TROOP', 'NAL-DEH-HI'),
  MapEntry<String, String>('TRUCK', 'CHIDO-TSO'),
  MapEntry<String, String>('TYPE', 'ALTH-AH-A-TEH'),
  MapEntry<String, String>('UNDER', 'BI-YAH'),
  MapEntry<String, String>('UNIDENTIFIED', 'DO-BAY-HOSEN-E'),
  MapEntry<String, String>('UNIT', 'DA-AZ-JAH'),
  MapEntry<String, String>('UNSHACKLE', 'NO-DA-EH-NESH-GOHZ'),
  MapEntry<String, String>('UNTIL', 'UH-QUO-HO'),
  MapEntry<String, String>('VICINITY', 'NA-HOS-AH-GIH'),
  MapEntry<String, String>('VILLAGE', 'CHAH-HO-OH-LHAN-IH'),
  MapEntry<String, String>('VISIBILITY', 'NAY-ES-TEE'),
  MapEntry<String, String>('VITAL', 'TA-EH-YE-SY'),
  MapEntry<String, String>('WARNING', 'BILH-HE-NEH'),
  MapEntry<String, String>('WAS', 'NE-TEH'),
  MapEntry<String, String>('WATER', 'TKOH'),
  MapEntry<String, String>('WAVE', 'YILH-KOLH'),
  MapEntry<String, String>('WEAPON', 'BEH-DAH-A-HI-JIH-GANI'),
  MapEntry<String, String>('WELL', 'TO-HA-HA-DLAY'),
  MapEntry<String, String>('WHEN', 'GLOE-EH-NA-AH-WO-HAI'),
  MapEntry<String, String>('WHERE', 'GLOE-IH-QUI-AH'),
  MapEntry<String, String>('WHICH', 'GLOE-IH-A-HSI-TLON'),
  MapEntry<String, String>('WILL', 'GLOE-IH-DOT-SAHI'),
  MapEntry<String, String>('WIRE', 'BESH-TSOSIE'),
  MapEntry<String, String>('WITH', 'BILH'),
  MapEntry<String, String>('WITHIN', 'BILH-BIGIH'),
  MapEntry<String, String>('WITHOUT', 'TA-GAID'),
  MapEntry<String, String>('WOOD', 'CHIZ'),
  MapEntry<String, String>('WOUND', 'CAH-DA-KHI'),
  MapEntry<String, String>('YARD', 'A-DEL-TAHL'),
  MapEntry<String, String>('ZONE', 'BIH-NA-HAS-DZOH'),
];

const Map<String, String> _NAVAJO_FOLD_MAP = {
  'COMMANDING GEN.': 'COMMANDINGGEN',
  'MAJOR GEN.': 'MAJORGEN',
  'BRIGADIER GEN.': 'BRIGADIERGEN',
  'LT. COLONEL': 'LTCOLONEL',
  'COMMANDING OFFICER': 'COMMANDINGOFFICER',
  'EXECUTIVE OFFICER': 'EXECUTIVEOFFICER',
  'SOUTH AMERICA': 'SOUTHAMERICA',
  'DIVE BOMBER': 'DIVEBOMBER',
  'TORPEDO PLANE': 'TORPEDOPLANE',
  'OBS. PLAN': 'OBSPLAN',
  'FIGHTER PLANE': 'FIGHTERPLANE',
  'BOMBER PLANE': 'BOMBERPLANE',
  'PATROL PLANE': 'PATROLPLANE',
  'MINE SWEEPER': 'MINESWEEPER',
  'MOSQUITO BOAT': 'MOSQUITOBOAT',
  'BOOBY TRAP': 'BOOBYTRAP',
  'BULL DOZER': 'BULLDOZER',
  'COAST GUARD': 'COASTGUARD',
  'COUNTER ATTACK ': 'COUNTERATTACK ',
  'DIG IN': 'DIGIN',
  'FLAME THROWER': 'FLAMETHROWER',
  'HALF TRACK': 'HALFTRACK',
  'HIGH EXPLOSIVE': 'HIGHEXPLOSIVE',
  'MACHINE GUN': 'MACHINEGUN',
  'MERCHANT SHIP': 'MERCHANTSHIP',
  'PILL BOX': 'PILLBOX',
  'PINNED DOWN': 'PINNEDDOWN',
  'ROBOT BOMB': 'ROBOTBOMB',
  'SEMI COLON': 'SEMICOLON',
  'SUPPLY SHIP': 'SUPPLYSHIP',
  'TANK DESTROYER': 'TANKDESTROYER',
  'TRAFFIC DIAGRAM': 'TRAFFICDIAGRAM',
};