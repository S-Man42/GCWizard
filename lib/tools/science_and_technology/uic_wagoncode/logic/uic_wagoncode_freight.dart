part of 'package:gc_wizard/tools/science_and_technology/uic_wagoncode/logic/uic_wagoncode.dart';

enum UICWagonCodeFreightGaugeType {FIXED, VARIABLE, BOTH_POSSIBLE, INVALID}
enum UICWagonCodeFreightAxes {SINGLE, DREHGESTELLE, INVALID}
enum UICWagonCodeFreightTypes {NORMAL_PPW, NORMAL_TEN_RIV, NORMAL_TEN_INTERFRIGO, MAINTENANCE, MISC, NOT_IN_EU_REGISTERED, INVALID, FRIDGE_LEGACY}
const Map<String, String> UICWagonCodeFreightCategory = {
  // https://de.wikipedia.org/wiki/UIC-Bauart-Bezeichnungssystem_f%C3%BCr_G%C3%BCterwagen
  // https://en.wikipedia.org/wiki/UIC_classification_of_goods_wagons
  '0': 'uic_typecode_freightwagon_category_0',
  '1': 'uic_typecode_freightwagon_category_1',
  '2': 'uic_typecode_freightwagon_category_2',
  '3': 'uic_typecode_freightwagon_category_3',
  '4': 'uic_typecode_freightwagon_category_4',
  '5': 'uic_typecode_freightwagon_category_5',
  '6': 'uic_typecode_freightwagon_category_6',
  '7': 'uic_typecode_freightwagon_category_7',
  '8': 'uic_typecode_freightwagon_category_8',
  '9': 'uic_typecode_freightwagon_category_9',
};

const Map<String, Map<String, List<String>>> UICWagonCodeFreightTechnicalDetails = {
  'a': {
    'uic_freight_codes_a_1': ['E', 'F', 'G', 'H', 'I', 'T', 'U', 'Z'],
    'uic_freight_codes_a_2': ['L', 'O'],
    'uic_freight_codes_a_3': ['S'],
  },
  'aa': {
    'uic_freight_codes_aa_1': ['E', 'F', 'G', 'H', 'T', 'U', 'Z'],
    'uic_freight_codes_aa_2': ['L'],
    'uic_freight_codes_aa_3': ['S'],
  },
  'b': {
    'uic_freight_codes_b_1': ['F'],
    'uic_freight_codes_b_2': ['G'],
    'uic_freight_codes_b_3': ['H'],
    'uic_freight_codes_b_4': ['T'],
    'uic_freight_codes_b_5': ['Ga', 'Ta'],
    'uic_freight_codes_b_6': ['Ha'],
    'uic_freight_codes_b_7': ['I'],
    'uic_freight_codes_b_8': ['K'],
    'uic_freight_codes_b_9': ['L', 'S'],
  },
  'bb': {
    'uic_freight_codes_bb_1': ['H'],
    'uic_freight_codes_bb_2': ['Ha'],
    'uic_freight_codes_bb_3': ['I'],
  },
  'c': {
    'uic_freight_codes_c_1': ['E'],
    'uic_freight_codes_c_2': ['F'],
    'uic_freight_codes_c_3': ['H', 'T'],
    'uic_freight_codes_c_4': ['I'],
    'uic_freight_codes_c_5': ['L', 'S'],
    'uic_freight_codes_c_6': ['U', 'Z'],
  },
  'cc': {
    'uic_freight_codes_cc_1': ['F'],
    'uic_freight_codes_cc_2': ['H'],
  },
  'd': {
    'uic_freight_codes_d_1': ['H'],
    'uic_freight_codes_d_2': ['I'],
    'uic_freight_codes_d_3': ['L', 'S'],
    'uic_freight_codes_d_4': ['T', 'U'],
  },
  'dd': {
    'uic_freight_codes_dd_1': ['T', 'U'],
  },
  'e': {
    'uic_freight_codes_e_1': ['H'],
    'uic_freight_codes_e_2': ['I'],
    'uic_freight_codes_e_3': ['L', 'S'],
    'uic_freight_codes_e_4': ['R'],
    'uic_freight_codes_e_5': ['T'],
    'uic_freight_codes_e_6': ['Z'],
  },
  'ee': {
    'uic_freight_codes_ee_1': ['H'],
  },
  'f': {
    'uic_freight_codes_f_1': [],
  },
  'ff': {
    'uic_freight_codes_ff_1': [],
  },
  'fff': {
    'uic_freight_codes_fff_1': [],
  },
  'g': {
    'uic_freight_codes_g_1': ['G', 'H', 'T', 'U'],
    'uic_freight_codes_g_2': ['I'],
    'uic_freight_codes_g_3': ['K', 'L', 'R'],
    'uic_freight_codes_g_4': ['S'],
    'uic_freight_codes_g_5': ['Z'],
  },
  'gg': {
    'uic_freight_codes_gg_1': ['I'],
    'uic_freight_codes_gg_2': ['S'],
  },
  'h': {
    'uic_freight_codes_h_1': ['G', 'H'],
    'uic_freight_codes_h_2': ['I'],
    'uic_freight_codes_h_3': ['L', 'R', 'S', 'T'],
  },
  'hh': {
    'uic_freight_codes_hh_1': ['L', 'R', 'S', 'T'],
  },
  'i': {
    'uic_freight_codes_i_1': ['H','T'],
    'uic_freight_codes_i_2': ['I'],
    'uic_freight_codes_i_3': ['K', 'L', 'R', 'S'],
    'uic_freight_codes_i_4': ['U'],
    'uic_freight_codes_i_5': ['Z'],
  },
  'ii': {
    'uic_freight_codes_i_1': ['H'],
    'uic_freight_codes_ii_2': ['I'],
  },
  'j': {
    'uic_freight_codes_j_1': [],
  },
  'k': {
    'uic_freight_codes_k_1': ['E', 'F', 'G', 'H', 'K', 'L', 'La', 'O', 'T', 'U', 'Z'],
    'uic_freight_codes_k_2': ['Ea', 'Fa', 'Ga', 'Ha', 'Laa', 'R', 'S', 'Ta', 'Ua', 'Za'],
    'uic_freight_codes_k_3': ['Eaa', 'Faa', 'Gaa', 'Haa', 'Sa', 'Saa', 'Taa', 'Uaa', 'Zaa'],
    'uic_freight_codes_k_4': ['I'],
    'uic_freight_codes_k_5': ['Ia'],
  },
  'kk': {
    'uic_freight_codes_kk_1': ['E', 'F', 'G', 'H', 'K', 'L', 'La', 'O', 'T', 'U', 'Z'],
    'uic_freight_codes_kk_2': ['Ea', 'Fa', 'Ga', 'Ha', 'Laa', 'R', 'S', 'Ta', 'Ua', 'Za'],
    'uic_freight_codes_kk_3': ['Eaa', 'Faa', 'Gaa', 'Haa', 'Sa', 'Saa', 'Taa', 'Uaa', 'Zaa'],
  },
  'l': {
    'uic_freight_codes_l_1': ['E'],
    'uic_freight_codes_l_2': ['F', 'T', 'U'],
    'uic_freight_codes_l_3': ['G'],
    'uic_freight_codes_l_4': ['H'],
    'uic_freight_codes_l_5': ['I'],
    'uic_freight_codes_l_6': ['K', 'L', 'O', 'R', 'S'],
  },
  'll': {
    'uic_freight_codes_ll_1': ['F','T','U'],
    'uic_freight_codes_ll_2': ['H'],
  },
  'm': {
    'uic_freight_codes_m_1': ['E'],
    'uic_freight_codes_m_2': ['Ea', 'Eaa'],
    'uic_freight_codes_m_3': ['G', 'H', 'T'],
    'uic_freight_codes_m_4': ['Ga', 'Gaa', 'Ha', 'Haa', 'Ta', 'Taa'],
    'uic_freight_codes_m_5': ['I'],
    'uic_freight_codes_m_6': ['Ia'],
    'uic_freight_codes_m_7': ['K', 'O', 'L'],
    'uic_freight_codes_m_8': ['R', 'S'],
    'uic_freight_codes_m_9': ['La', 'Laa', 'Sa', 'Saa'],
    'uic_freight_codes_m_10': ['Sr'],
  },
  'mm': {
    'uic_freight_codes_a_1': ['K', 'O', 'L'],
    'uic_freight_codes_a_2': ['R', 'S'],
    'uic_freight_codes_a_3': ['La', 'Laa', 'Sa', 'Saa'],
  },
  'n': {
    'uic_freight_codes_n_1': ['I'],
    'uic_freight_codes_n_2': ['H'],
    'uic_freight_codes_n_3': ['E', 'G', 'K', 'L', 'O', 'T'],
    'uic_freight_codes_n_4': ['F', 'U', 'Z'],
    'uic_freight_codes_n_5': ['Ia', 'La', 'Oa'],
    'uic_freight_codes_n_6': ['Ea', 'Fa', 'Ga', 'Ha', 'Laa', 'R', 'S', 'Ta', 'Ua', 'Za'],
    'uic_freight_codes_n_7': ['Eaa', 'Faa', 'Gaa', 'Haa', 'Sa', 'Saa', 'Taa', 'Uaa', 'Zaa'],
  },
  'o': {
    'uic_freight_codes_o_1': ['E'],
    'uic_freight_codes_o_2': ['F', 'T', 'U'],
    'uic_freight_codes_o_3': ['G', 'H'],
    'uic_freight_codes_o_4': ['I'],
    'uic_freight_codes_o_5': ['K'],
    'uic_freight_codes_o_6': ['R'],
    'uic_freight_codes_o_7': ['S'],
  },
  'oo': {
    'uic_freight_codes_oo_1': ['F', 'T', 'U'],
    'uic_freight_codes_oo_2': ['R'],
  },
  'p': {
    'uic_freight_codes_p_1': ['F', 'T', 'U'],
    'uic_freight_codes_p_2': ['I'],
    'uic_freight_codes_p_3': ['K', 'L', 'S'],
    'uic_freight_codes_p_4': ['R'],
  },
  'pp': {
    'uic_freight_codes_pp_1': ['F', 'T', 'U'],
    'uic_freight_codes_pp_2': ['K', 'R'],
  },
  'q': {
    'uic_freight_codes_q_1': [],
  },
  'qq': {
    'uic_freight_codes_qq_1': [],
  },
  'r': {
    'uic_freight_codes_r_1': ['E', 'F', 'G', 'H', 'I', 'K', 'L', 'O', 'T', 'U', 'Z'],
    'uic_freight_codes_r_2': ['S'],
  },
  'rr': {
    'uic_freight_codes_rr_1': [],
  },
  's': {
    'uic_freight_codes_s_1': [],
  },
  'ss': {
    'uic_freight_codes_ss_1': [],
  },
};

const Map<String, Map<String, Map<String, List<String>>>> UICWagonCodeFreightTechnicalDetailsCountry = {
  't': {
    '50': {
      'uic_freight_codes_50_t_1': ['Gbkl', 'Hkr'],
    },
    '80': {
      'uic_freight_codes_80_t_1': ['H'],
      'uic_freight_codes_80_t_2': ['L'],
    },
    '85': {
      'uic_freight_codes_85_t_1': [],
    },
  },
  'tt': {
    '80': {
      'uic_freight_codes_80_tt_1': ['H'],
    },
  },
  'u': {
    '50': {
      'uic_freight_codes_50_u_1': ['E', 'G', 'K', 'R'],
    },
    '80': {
      'uic_freight_codes_80_u_1': ['E', 'F', 'S'],
      'uic_freight_codes_80_u_2': ['G', 'H', 'I', 'K', 'L', 'T']
    },
    '85': {
      'uic_freight_codes_85_u_1': ['F'],
      'uic_freight_codes_85_u_2': ['H']
    },
  },
  'v': {
    '50': {
      'uic_freight_codes_50_v_1': ['E', 'T'],
      'uic_freight_codes_50_v_2': ['G', 'H'],
      'uic_freight_codes_50_v_3': ['U'],
    },
    '80': {
      'uic_freight_codes_80_v_1': [],
    },
    '85': {
      'uic_freight_codes_85_v_1': [],
    },
  },
  'vv': {
    '80': {
      'uic_freight_codes_80_vv_1': [],
    },
  },
  'w': {
    '50': {
      'uic_freight_codes_50_w_1': ['U'],
      'uic_freight_codes_50_w_2': ['Z'],
    },
    '80': {
      'uic_freight_codes_80_w_1': ['G', 'H', 'S'],
    },
    '85': {
      'uic_freight_codes_85_w_1': ['R', 'S', 'U'],
    },
  },
  'ww': {
    '80': {
      'uic_freight_codes_80_ww_1': [],
    },
    '85': {
      'uic_freight_codes_85_ww_1': ['H'],
    },
  },
  'x': {
    '50': {
      'uic_freight_codes_50_x_1': ['E'],
      'uic_freight_codes_50_x_2': ['Uc'],
    },
    '80': {
      'uic_freight_codes_80_x_1': ['U'],
    },
    '85': {
      'uic_freight_codes_85_x_1': ['H'],
      'uic_freight_codes_85_x_2': ['S', 'L'],
    },
  },
  'y': {
    '50': {
      'uic_freight_codes_50_y_1': ['Uc'],
      'uic_freight_codes_50_y_2': ['T', 'U', 'Z'],
    },
    '85': {
      'uic_freight_codes_85_y_1': ['H'],
      'uic_freight_codes_85_y_2': ['F'],
      'uic_freight_codes_85_y_3': ['R', 'S'],
    },
  },
  'z': {
    '50': {
      'uic_freight_codes_50_z_1': ['K', 'L', 'R', 'S'],
      'uic_freight_codes_50_z_2': ['G', 'I'],
    },
    '80': {
      'uic_freight_codes_80_z_1': ['F'],
      'uic_freight_codes_80_z_2': ['H'],
      'uic_freight_codes_80_z_3': ['T'],
    },
    '85': {
      'uic_freight_codes_85_z_1': ['G', 'H'],
    },
  },
  'zz': {
    '50': {
      'uic_freight_codes_50_zz_1': ['F'],
    },
    '80': {
      'uic_freight_codes_80_zz_1': ['Fb'],
    },
  },
};

class UICWagonCodeFreight extends UICWagonCode {
  late UICWagonCodeFreightGaugeType gaugeType;
  late UICWagonCodeFreightAxes axes;
  late UICWagonCodeFreightTypes type;
  late String category;
  late String gattung;

  UICWagonCodeFreightTypes _getType(String number) {
    var number1 = int.parse(number[0]);
    var number2 = int.parse(number[1]);

    if ([0, 1, 2, 3].contains(number1)) {
      if (number2 == 0) return UICWagonCodeFreightTypes.INVALID;
      if ([0, 1].contains(number1) && [3, 4, 5, 6, 7, 8].contains(number2)) return UICWagonCodeFreightTypes.FRIDGE_LEGACY;
      if (number2 == 9) return UICWagonCodeFreightTypes.NORMAL_PPW;
      if ([0, 1].contains(number1)) return UICWagonCodeFreightTypes.NORMAL_TEN_INTERFRIGO;
      if ([2, 3].contains(number1)) return UICWagonCodeFreightTypes.NORMAL_TEN_RIV;
      return UICWagonCodeFreightTypes.INVALID;
    } else {
      if (number2 == 0) return UICWagonCodeFreightTypes.MAINTENANCE;
      if (number2 == 9) return UICWagonCodeFreightTypes.NOT_IN_EU_REGISTERED;
      return UICWagonCodeFreightTypes.MISC;
    }
  }

  String _getGattung(String number) {
    switch(number[4]) {
      case '0': return 'T';
      case '1': return 'G';
      case '2': return 'H';
      case '3': return 'K, O, R';
      case '4': return 'L, S';
      case '5': return 'E';
      case '6': return 'F';
      case '7': return 'Z';
      case '8': return 'I';
      case '9': return 'U';
      default: return '';
    }
  }

  UICWagonCodeFreightGaugeType _getSpurweite(String number) {
    var number1 = int.parse(number[0]);
    var number2 = int.parse(number[1]);

    if ([4, 8].contains(number1) && [0, 9].contains(number2)) return UICWagonCodeFreightGaugeType.BOTH_POSSIBLE;
    if ([0, 1].contains(number1) && [9].contains(number2))  return UICWagonCodeFreightGaugeType.VARIABLE;
    if ([2, 3].contains(number1) && [9].contains(number2))  return UICWagonCodeFreightGaugeType.FIXED;

    if ([2,4,6,8].contains(number2)) return UICWagonCodeFreightGaugeType.VARIABLE;
    if ([1, 3, 4, 5, 7].contains(number2)) return UICWagonCodeFreightGaugeType.FIXED;

    return UICWagonCodeFreightGaugeType.INVALID;
  }

  UICWagonCodeFreightAxes _getAxes(String number) {
    var number1 = int.parse(number[0]);

    if ([0,2,4].contains(number1)) return UICWagonCodeFreightAxes.SINGLE;
    if ([1, 3, 8].contains(number1)) return UICWagonCodeFreightAxes.DREHGESTELLE;

    return UICWagonCodeFreightAxes.INVALID;
  }

  UICWagonCodeFreight(String number) : super(number) {
    type = _getType(number);
    gaugeType = _getSpurweite(number);
    axes = _getAxes(number);
    category = UICWagonCodeFreightCategory[number[4]]!;
    gattung = _getGattung(number);
  }

}