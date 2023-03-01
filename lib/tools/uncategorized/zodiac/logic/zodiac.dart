const ZODIACSIGNS_ATTRIBUTE_DATE = 'zodiac_attribute_date';
const ZODIACSIGNS_ATTRIBUTE_HOUSE = 'zodiac_attribute_house';
const ZODIACSIGNS_ATTRIBUTE_ELEMENT = 'zodiac_attribute_element';
const ZODIACSIGNS_ATTRIBUTE_QUALITY = 'zodiac_attribute_quality';
const ZODIACSIGNS_ATTRIBUTE_POLARITY = 'zodiac_attribute_polarity';
const ZODIACSIGNS_ATTRIBUTE_PLANET = 'zodiac_attribute_planet';


const ZODIACSIGNS_ATTRIBUTE_ELEMENT_VALUE_EARTH = 'symboltables_alchemy_earth';
const ZODIACSIGNS_ATTRIBUTE_ELEMENT_VALUE_FIRE = 'symboltables_alchemy_fire';
const ZODIACSIGNS_ATTRIBUTE_ELEMENT_VALUE_WATER = 'symboltables_alchemy_water';
const ZODIACSIGNS_ATTRIBUTE_ELEMENT_VALUE_AIR = 'symboltables_alchemy_air';

const ZODIACSIGNS_ATTRIBUTE_POLARITY_VALUE_MASCULINE = 'zodiac_attribute_polarity_masculine';
const ZODIACSIGNS_ATTRIBUTE_POLARITY_VALUE_FEMININE = 'zodiac_attribute_polarity_feminine';

const ZODIACSIGNS_ATTRIBUTE_QUALITY_VALUE_CARDINAL = 'zodiac_attribute_quality_cardinal';
const ZODIACSIGNS_ATTRIBUTE_QUALITY_VALUE_FIXED = 'zodiac_attribute_quality_fixed';
const ZODIACSIGNS_ATTRIBUTE_QUALITY_VALUE_MUTABLE = 'zodiac_attribute_quality_mutable';

const ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_MARS = 'symboltables_planets_mars';
const ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_MERCURY = 'symboltables_planets_mercury';
const ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_VENUS = 'symboltables_planets_venus';
const ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_MOON = 'coords_ellipsoid_moon';
const ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_SUN = 'symboltables_planets_sun';
const ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_CHIRON = 'symboltables_planets_chiron';
const ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_JUPITER = 'symboltables_planets_jupiter';
const ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_NEPTUNE = 'symboltables_planets_neptune';
const ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_SATURN = 'symboltables_planets_saturn';
const ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_URANUS = 'symboltables_planets_uranus';
const ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_PLUTO = 'symboltables_planets_pluto';

class ZodiacDate {
  int start_month;
  int start_day;
  int end_month;
  int end_day;

  ZodiacDate({required this.start_month, required  this.start_day, required  this.end_month, required  this.end_day});
}

class ZodiacSign {
  ZodiacDate date;
  List<String> planet;
  int house;
  String element;
  String polarity;
  String quality;
  
  ZodiacSign({
    required this.date,
    required this.planet, 
    required this.house, 
    required this.element, 
    required this.polarity,
    required this.quality});

}

final Map<String, ZodiacSign> ZODIACSIGNS = {
  'astronomy_signs_aries': ZodiacSign (
    date: ZodiacDate (
      start_month: 3,
      start_day: 21,
      end_month: 4,
      end_day: 20,
    ),
    planet: [ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_MARS],
    house: 1,
    element: ZODIACSIGNS_ATTRIBUTE_ELEMENT_VALUE_FIRE,
    polarity: ZODIACSIGNS_ATTRIBUTE_POLARITY_VALUE_MASCULINE,
    quality: ZODIACSIGNS_ATTRIBUTE_QUALITY_VALUE_CARDINAL
  ),
  'astronomy_signs_taurus': ZodiacSign (
    date: ZodiacDate (
      start_month: 4,
      start_day: 21,
      end_month: 5,
      end_day: 20,
    ),
    planet: [ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_VENUS],
    house: 2,
    element: ZODIACSIGNS_ATTRIBUTE_ELEMENT_VALUE_EARTH,
    polarity: ZODIACSIGNS_ATTRIBUTE_POLARITY_VALUE_FEMININE,
    quality: ZODIACSIGNS_ATTRIBUTE_QUALITY_VALUE_FIXED
  ),
  'astronomy_signs_gemini': ZodiacSign (
    date: ZodiacDate (
      start_month: 5,
      start_day: 21,
      end_month: 6,
      end_day: 21,
    ),
    planet: [ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_MERCURY],
    house: 3,
    element: ZODIACSIGNS_ATTRIBUTE_ELEMENT_VALUE_AIR,
    polarity: ZODIACSIGNS_ATTRIBUTE_POLARITY_VALUE_MASCULINE,
    quality: ZODIACSIGNS_ATTRIBUTE_QUALITY_VALUE_MUTABLE
  ),
  'astronomy_signs_cancer': ZodiacSign (
    date: ZodiacDate (
      start_month: 6,
      start_day: 22,
      end_month: 7,
      end_day: 22,
    ),
    planet: [ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_MOON],
    house: 4,
    element: ZODIACSIGNS_ATTRIBUTE_ELEMENT_VALUE_WATER,
    polarity: ZODIACSIGNS_ATTRIBUTE_POLARITY_VALUE_FEMININE,
    quality: ZODIACSIGNS_ATTRIBUTE_QUALITY_VALUE_CARDINAL
  ),
  'astronomy_signs_leo': ZodiacSign (
    date: ZodiacDate (
      start_month: 7,
      start_day: 23,
      end_month: 8,
      end_day: 23,
    ),
    planet: [ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_SUN],
    house: 5,
    element: ZODIACSIGNS_ATTRIBUTE_ELEMENT_VALUE_FIRE,
    polarity: ZODIACSIGNS_ATTRIBUTE_POLARITY_VALUE_MASCULINE,
    quality: ZODIACSIGNS_ATTRIBUTE_QUALITY_VALUE_FIXED
  ),
  'astronomy_signs_virgo': ZodiacSign (
    date: ZodiacDate (
      start_month: 8,
      start_day: 24,
      end_month: 9,
      end_day: 23,
    ),
    planet: [
      ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_MERCURY,
      ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_CHIRON
    ],
    house: 6,
    element: ZODIACSIGNS_ATTRIBUTE_ELEMENT_VALUE_EARTH,
    polarity: ZODIACSIGNS_ATTRIBUTE_POLARITY_VALUE_FEMININE,
    quality: ZODIACSIGNS_ATTRIBUTE_QUALITY_VALUE_MUTABLE
  ),
  'astronomy_signs_libra': ZodiacSign (
    date: ZodiacDate (
      start_month: 9,
      start_day: 24,
      end_month: 10,
      end_day: 23,
    ),
    planet: [ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_VENUS],
    house: 7,
    element: ZODIACSIGNS_ATTRIBUTE_ELEMENT_VALUE_AIR,
    polarity: ZODIACSIGNS_ATTRIBUTE_POLARITY_VALUE_MASCULINE,
    quality: ZODIACSIGNS_ATTRIBUTE_QUALITY_VALUE_CARDINAL
  ),
  'astronomy_signs_scorpio': ZodiacSign (
    date: ZodiacDate (
      start_month: 10,
      start_day: 24,
      end_month: 11,
      end_day: 22,
    ),
    planet: [
      ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_PLUTO,
      ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_JUPITER
    ],
    house: 8,
    element: ZODIACSIGNS_ATTRIBUTE_ELEMENT_VALUE_WATER,
    polarity: ZODIACSIGNS_ATTRIBUTE_POLARITY_VALUE_FEMININE,
    quality: ZODIACSIGNS_ATTRIBUTE_QUALITY_VALUE_FIXED
  ),
  'astronomy_signs_sagittarius': ZodiacSign (
    date: ZodiacDate (
      start_month: 11,
      start_day: 23,
      end_month: 12,
      end_day: 21,
    ),
    planet: [ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_JUPITER],
    house: 9,
    element: ZODIACSIGNS_ATTRIBUTE_ELEMENT_VALUE_FIRE,
    polarity: ZODIACSIGNS_ATTRIBUTE_POLARITY_VALUE_MASCULINE,
    quality: ZODIACSIGNS_ATTRIBUTE_QUALITY_VALUE_MUTABLE
  ),
  'astronomy_signs_capricorn': ZodiacSign (
    date: ZodiacDate (
      start_month: 12,
      start_day: 22,
      end_month: 1,
      end_day: 20,
    ),
    planet: [ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_SATURN],
    house: 10,
    element: ZODIACSIGNS_ATTRIBUTE_ELEMENT_VALUE_EARTH,
    polarity: ZODIACSIGNS_ATTRIBUTE_POLARITY_VALUE_FEMININE,
    quality: ZODIACSIGNS_ATTRIBUTE_QUALITY_VALUE_CARDINAL
  ),
  'astronomy_signs_aquarius': ZodiacSign (
    date: ZodiacDate (
      start_month: 1,
      start_day: 21,
      end_month: 2,
      end_day: 19,
    ),
    planet: [
      ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_URANUS,
      ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_SATURN
    ],
    house: 11,
    element: ZODIACSIGNS_ATTRIBUTE_ELEMENT_VALUE_AIR,
    polarity: ZODIACSIGNS_ATTRIBUTE_POLARITY_VALUE_MASCULINE,
    quality: ZODIACSIGNS_ATTRIBUTE_QUALITY_VALUE_FIXED
  ),
  'astronomy_signs_pisces': ZodiacSign (
    date: ZodiacDate (
      start_month: 2,
      start_day: 20,
      end_month: 3,
      end_day: 20,
    ),
    planet: [
      ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_NEPTUNE,
      ZODIACSIGNS_ATTRIBUTE_PLANET_VALUE_JUPITER
    ],
    house: 12,
    element: ZODIACSIGNS_ATTRIBUTE_ELEMENT_VALUE_WATER,
    polarity: ZODIACSIGNS_ATTRIBUTE_POLARITY_VALUE_FEMININE,
    quality: ZODIACSIGNS_ATTRIBUTE_QUALITY_VALUE_MUTABLE
  ),
};
