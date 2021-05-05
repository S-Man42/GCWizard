class PhoneCaseStateModel{}

enum PhoneInputLanguage {EXTENDED, ALL, ENGLISH, GERMAN, PORTUGUESE, FRENCH, ITALIAN, TURKISH, BULGARIAN, SERBIAN, GREEK, CROATIAN, ROMANIAN, DUTCH, DANISH, NORWEGIAN, SWEDISH, FINNISH, SPANISH, CATALAN, SLOVENIAN}

// enum PhoneModel {
//   SIEMENS_ME45, SIEMENS_C75, SIEMENS_S35, SIEMENS_S55, SIEMENS_A65,
//   NOKIA_3120, NOKIA_3330, NOKIA_1650, NOKIA_6230,
//   SAMSUNG_GT_E1170, SAMSUNG_E1120,
//   SONY_ERICSSON_K700I, SONY_ERICSSON_T300,
//   MOTOROLA_CD930, MOTOROLA_V600, MOTOROLA_RAZR_V3,
//   SAGEM_MY_X_3
// }

enum PhoneCaseMode {LOWER_CASE, UPPER_CASE, CAMEL_CASE, NUMBERS, SPECIAL_CHARACTERS}

class PhoneModel {
  String name;
  PhoneCaseStateModel defaultCaseStateModel;
  Map<PhoneInputLanguage, PhoneCaseStateModel> specificCaseStateModels;
  List<Map<PhoneCaseMode, Map<String, String>>> characterMap;
  List<List<PhoneInputLanguage>> languages;

  PhoneModel(this.name, String defaultCaseStateModelPath, Map<PhoneInputLanguage, String> specificCaseStateModelIds, this.characterMap, this.languages) {
    this.defaultCaseStateModel = _initializeCaseStateModel(defaultCaseStateModelPath);
    if (specificCaseStateModels != null && specificCaseStateModels.length > 0) {
      this.specificCaseStateModels = specificCaseStateModelIds.map((key, value) {
        return MapEntry(key, _initializeCaseStateModel(value));
      });
    }
  };
}

PhoneCaseStateModel _initializeCaseStateModel(String assetName) {
  await DefaultAssetBundle.of(context).loadString(quadgrams.assetLocation);
}

final List<PhoneModel> phoneModels = [
  PhoneModel(
      'Motorola CD930', 'assets/vanity_multitap_workflows/motorola_cd930.puml', null,
      [
        // The weird lower cases are correct, the ß at 2 too.
        // Change to lower case change is long press, so not supported.
        {
          PhoneCaseMode.UPPER_CASE: {
            "1": " .1?!,@_&:\"()'¿¡%£\$",
            "2": "ABC2ÄÅàÆßç",
            "3": "DEF3ΔÉèΦ",
            "4": "GHI4Γì",
            "5": "JKL5Λ",
            "6": "MNO6ÑöØòΩ",
            "7": "PQRS7ΠßΣ",
            "8": "TUV8ΘÜù",
            "9": "WXYZ9ΞΨ",
            "0": "+-0×*/=><#"
          }
        }
      ],
      [
        [PhoneInputLanguage.ALL]
      ]
  ),
  PhoneModel(
      'Motorola RAZR V3', 'assets/vanity_multitap_workflows/motorola_razr_v3.puml', null,
      [
        {
          PhoneCaseMode.LOWER_CASE : {
            "1": ".?!,@'-_:;()&\"~10¿¡%£\$¥¤€+×*/\\[]=><#§",
            "2": "abc2ä",
            "3": "def3",
            "4": "ghi4",
            "5": "jkl5",
            "6": "mno6ö",
            "7": "pqrs7ß",
            "8": "tuv8ü",
            "9": "wxyz9",
            "*": " "
          },
          PhoneCaseMode.UPPER_CASE : {
            "1": ".?!,@'-_:;()&\"~10¿¡%£\$¥¤€+×*/\\[]=><#§",
            "2": "ABC2Ä",
            "3": "DEF3",
            "4": "GHI4",
            "5": "JKL5",
            "6": "MNO6Ö",
            "7": "PQRS7ß",
            "8": "TUV8Ü",
            "9": "WXYZ9",
            "*": " "
          }
        },
        {
          PhoneCaseMode.LOWER_CASE : {
            "1": ".?!,@'-_:;()&\"~10¿¡%£\$¥¤€+×*/\\[]=><#§",
            "2": "абвг2",
            "3": "дежз3",
            "4": "ийкл4",
            "5": "мноп5",
            "6": "рсту6",
            "7": "фхцч7",
            "8": "шщъь8",
            "9": "юя9",
            "*": " "
          },
          PhoneCaseMode.UPPER_CASE : {
            "1": ".?!,@'-_:;()&\"~10¿¡%£\$¥¤€+×*/\\[]=><#§",
            "2": "АБВГ2",
            "3": "ДЕЖЗ3",
            "4": "ИЙКЛ4",
            "5": "МНОП5",
            "6": "РСТУ6",
            "7": "ФХЦЧ7",
            "8": "ШЩЪЬ8",
            "9": "ЮЯ9",
            "*": " "
          }
        },
        {
          PhoneCaseMode.LOWER_CASE : {
            "1": ".?!,@'-_:;()&\"~10¿¡%£\$¥¤€+×*/\\[]=><#§",
            "2": "abc2абвг",
            "3": "def3дђежз",
            "4": "ghi4ијклљ",
            "5": "jkl5мнњоп",
            "6": "mno6рстћу",
            "7": "pqrs7фхцчџ",
            "8": "tuv8ш",
            "9": "wxyz9",
            "*": " "
          },
          PhoneCaseMode.UPPER_CASE : {
            "1": ".?!,@'-_:;()&\"~10¿¡%£\$¥¤€+×*/\\[]=><#§",
            "2": "ABC2АБВГ",
            "3": "DEF3ДЂЕЖЗ",
            "4": "GHI4ИЈКЛЉ",
            "5": "JKL5МНЊОП",
            "6": "MNO6РСТЋУ",
            "7": "PQRS7ФХЦЧЏ",
            "8": "TUV8Ш",
            "9": "WXYZ9",
            "*": " "
          }
        },
        {
          PhoneCaseMode.LOWER_CASE : {
            "1": ".?!,@'-_:;()&\"~10¿¡%£\$¥¤€+×*/\\[]=><#§",
            "2": "abc2",
            "3": "def3",
            "4": "ghi4",
            "5": "jkl5",
            "6": "mno6",
            "7": "pqrs7",
            "8": "tuv8",
            "9": "wxyz9",
            "*": " "
          },
          PhoneCaseMode.UPPER_CASE : {
            "1": ".?!,@'-_:;()&\"~10¿¡%£\$¥¤€+×*/\\[]=><#§",
            "2": "ABC2",
            "3": "DEF3",
            "4": "GHI4",
            "5": "JKL5",
            "6": "MNO6",
            "7": "PQRS7",
            "8": "TUV8",
            "9": "WXYZ9",
            "*": " "
          }
        },
        {
          PhoneCaseMode.LOWER_CASE : {
            "1": ".?!,@'-_:;()&\"~10¿¡%£\$¥¤€+×*/\\[]=><#§",
            "2": "abc2čć",
            "3": "def3đ",
            "4": "ghi4",
            "5": "jkl5",
            "6": "mno6",
            "7": "pqrs7š",
            "8": "tuv8",
            "9": "wxyz9ž",
            "*": " "
          },
          PhoneCaseMode.UPPER_CASE : {
            "1": ".?!,@'-_:;()&\"~10¿¡%£\$¥¤€+×*/\\[]=><#§",
            "2": "ABC2ČĆ",
            "3": "DEF3Đ",
            "4": "GHI4",
            "5": "JKL5",
            "6": "MNO6",
            "7": "PQRS7Š",
            "8": "TUV8",
            "9": "WXYZ9Ž",
            "*": " "
          }
        },
        {
          PhoneCaseMode.LOWER_CASE : {
            "1": ".?!,@'-_:;()&\"~10¿¡%£\$¥¤€+×*/\\[]=><#§",
            "2": "abc2ăâ",
            "3": "def3",
            "4": "ghi4î",
            "5": "jkl5",
            "6": "mno6",
            "7": "pqrs7ș",
            "8": "tuv8ț",
            "9": "wxyz9",
            "*": " "
          },
          PhoneCaseMode.UPPER_CASE : {
            "1": ".?!,@'-_:;()&\"~10¿¡%£\$¥¤€+×*/\\[]=><#§",
            "2": "ABC2ĂÂ",
            "3": "DEF3",
            "4": "GHI4Î",
            "5": "JKL5",
            "6": "MNO6",
            "7": "PQRS7Ș",
            "8": "TUV8Ț",
            "9": "WXYZ9",
            "*": " "
          }
        },
        {
          PhoneCaseMode.LOWER_CASE: {
            "1": ".?!,@'-_:;()&\"~10¿¡%£\$¥¤€+×*/\\[]=><#§",
            "2": "abc2č",
            "3": "def3",
            "4": "ghi4",
            "5": "jkl5",
            "6": "mno6",
            "7": "pqrs7š",
            "8": "tuv8",
            "9": "wxyz9ž",
            "*": " "
          },
          PhoneCaseMode.UPPER_CASE: {
            "1": ".?!,@'-_:;()&\"~10¿¡%£\$¥¤€+×*/\\[]=><#§",
            "2": "ABC2Č",
            "3": "DEF3",
            "4": "GHI4",
            "5": "JKL5",
            "6": "MNO6",
            "7": "PQRS7Š",
            "8": "TUV8",
            "9": "WXYZ9Ž",
            "*": " "
          }
        }
      ],
    [
      [PhoneInputLanguage.GERMAN],
      [PhoneInputLanguage.BULGARIAN],
      [PhoneInputLanguage.SERBIAN],
      [PhoneInputLanguage.ENGLISH],
      [PhoneInputLanguage.CROATIAN],
      [PhoneInputLanguage.ROMANIAN],
      [PhoneInputLanguage.SLOVENIAN],
    ]
  ),
  PhoneModel('Motorola V600', 'assets/vanity_multitap_workflows/motorola_razr_v3.puml', null,
      [
        {
          PhoneCaseMode.LOWER_CASE : {
            "1": ".?!,@'-_:;()&\"~10¿¡%£\$¥¤€+×*/\\[]=><#§",
            "2": "abc2ä",
            "3": "def3",
            "4": "ghi4",
            "5": "jkl5",
            "6": "mno6ö",
            "7": "pqrs7ß",
            "8": "tuv8ü",
            "9": "wxyz9",
            "*": " "
          },
          PhoneCaseMode.UPPER_CASE : {
            "1": ".?!,@'-_:;()&\"~10¿¡%£\$¥¤€+×*/\\[]=><#§",
            "2": "ABC2Ä",
            "3": "DEF3",
            "4": "GHI4",
            "5": "JKL5",
            "6": "MNO6Ö",
            "7": "PQRS7ß",
            "8": "TUV8Ü",
            "9": "WXYZ9",
            "*": " "
          }
        },
        {
          PhoneCaseMode.LOWER_CASE : {
            "1": ".?!,@'-_:;()&\"~10¿¡%£\$¥¤€+×*/\\[]=><#§",
            "2": "abc2äáàâãç",
            "3": "def3éèêë",
            "4": "ghi4ğıíìîï",
            "5": "jkl5",
            "6": "mno6ñóòôöõœ",
            "7": "pqrs7şß",
            "8": "tuv8úùûü",
            "9": "wxyz9",
            "*": " "
          },
          PhoneCaseMode.UPPER_CASE : {
            "1": ".?!,@'-_:;()&\"~10¿¡%£\$¥¤€+×*/\\[]=><#§",
            "2": "ABC2ÄÁÀÂÃÇ",
            "3": "DEF3ÉÈÊË",
            "4": "GHI4ĞÍÌÎÏ",
            "5": "JKL5",
            "6": "MNO6ÑÓÒÔÖÕŒ",
            "7": "PQRS7Şß",
            "8": "TUV8ÚÙÛÜ",
            "9": "WXYZ9",
            "*": " "
          }
        }
      ],
      [
        [PhoneInputLanguage.GERMAN],
        [PhoneInputLanguage.EXTENDED]
      ]
  ),
  PhoneModel('Nokia 1650', 'assets/vanity_multitap_workflows/nokia_1650.puml', null,
      [
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": " 0\n",
            "1": ".,'?!\"1-()@/:_",
            "2": "abc2äæåàáâãç",
            "3": "def3èéêëð",
            "4": "ghi4ìíîï",
            "5": "jkl5£",
            "6": "mno6öøòóôõñ",
            "7": "pqrs7ß\$",
            "8": "tuv8ùúûü",
            "9": "wxyz9ýþ",
            "*": ".,'?!\"-()/:_;+&%*=<>£€\$¥¤[]{}\\~^`¡¿§#|\n"
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": " 0\n",
            "1": ".,'?!\"1-()@/:_",
            "2": "ABC2ÄÆÅÀÁÂÃÇ",
            "3": "DEF3ÈÉÊËÐ",
            "4": "GHI4ÌÍÎÏ",
            "5": "JKL5£",
            "6": "MNO6ÖØÒÓÔÕÑ",
            "7": "PQRS7\$",
            "8": "TUV8ÙÚÛÜ",
            "9": "WXYZ9ÝÞ",
            "*": ".,'?!\"-()/:_;+&%*=<>£€\$¥¤[]{}\\~^`¡¿§#|\n"
          }
        },
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": " 0\n",
            "1": ".,?!'\"1-()@/:_",
            "2": "abc2äàáãâåæç",
            "3": "def3èéëêð",
            "4": "ghi4ìíîï",
            "5": "jkl5£",
            "6": "mno6öòóôõøñ",
            "7": "pqrs7ß\$",
            "8": "tuv8üùúû",
            "9": "wxyz9ýþ",
            "*": ".,'?!\"-()/:_;+&%*=<>£€\$¥¤[]{}\\~^`¡¿§#|\n"
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": " 0\n",
            "1": ".,?!'\"1-()@/:_",
            "2": "ABC2ÄÀÁÃÂÅÆÇ",
            "3": "DEF3ÈÉËÊÐ",
            "4": "GHI4ÌÍÎÏ",
            "5": "JKL5£",
            "6": "MNO6ÖÒÓÔÕØÑ",
            "7": "PQRS7\$",
            "8": "TUV8ÜÙÚÛ",
            "9": "WXYZ9ÝÞ",
            "*": ".,'?!\"-()/:_;+&%*=<>£€\$¥¤[]{}\\~^`¡¿§#|\n"
          }
        },
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": " 0\n",
            "1": ".,?!'\"1-()@/:_",
            "2": "abc2àâæçäáã",
            "3": "def3éèêë",
            "4": "ghi4ïîìíğı",
            "5": "jkl5",
            "6": "mno6ôœöñòóø",
            "7": "pqrs7\$ß",
            "8": "tuv8ûùüú",
            "9": "wxyz9",
            "*": ".,'?!\"-()/:_;+&%*=<>£€\$¥¤[]{}\\~^`¡¿§#|\n"
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": " 0\n",
            "1": ".,?!'\"1-()@/:_",
            "2": "ABC2ÀÂÆÇÄÁÃ",
            "3": "DEF3ÉÈÊË",
            "4": "GHI4ÏÎÌÍĞİ",
            "5": "JKL5",
            "6": "MNO6ÔŒÖÑÒÓØ",
            "7": "PQRS7\$",
            "8": "TUV8ÛÙÜÚ",
            "9": "WXYZ9",
            "*": ".,'?!\"-()/:_;+&%*=<>£€\$¥¤[]{}\\~^`¡¿§#|\n"
          }
        }
      ],
      [
        [PhoneInputLanguage.ENGLISH],
        [PhoneInputLanguage.GERMAN, PhoneInputLanguage.TURKISH],
        [PhoneInputLanguage.FRENCH]
      ]
  ),
  PhoneModel('Nokia 3210', 'assets/vanity_multitap_workflows/nokia_3210.puml', null,
      [
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": " 0",
            "1": ".,?!-&1",
            "2": "abc2äâàæ",
            "3": "def3éè",
            "4": "ghi4ì",
            "5": "jkl5£",
            "6": "mno6öøòñ",
            "7": "pqrs7\$ß",
            "8": "tuv8üù",
            "9": "wxyz9",
            "*": ".,?!:;-+#*()'\"_@&\$£%/<>¿¡§=¤€¥"
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": " 0",
            "1": ".,'?!-&1@/",
            "2": "ABC2ÄÂÆÇ",
            "3": "DEF3É",
            "4": "GHI4",
            "5": "JKL5£",
            "6": "MNO6ÖØÑ",
            "7": "PQRS7\$",
            "8": "TUV8Ü",
            "9": "WXYZ9",
            "*": ".,?!:;-+#*()'\"_@&\$£%/<>¿¡§=¤€¥"
          }
        }
      ],
      [
        [PhoneInputLanguage.ENGLISH, PhoneInputLanguage.GERMAN, PhoneInputLanguage.FRENCH, PhoneInputLanguage.ITALIAN, PhoneInputLanguage.SPANISH, PhoneInputLanguage.DUTCH, PhoneInputLanguage.PORTUGUESE, PhoneInputLanguage.DANISH, PhoneInputLanguage.SWEDISH, PhoneInputLanguage.NORWEGIAN, PhoneInputLanguage.FINNISH]
      ]
  ),
  PhoneModel('Nokia 3330', 'assets/vanity_multitap_workflows/nokia_3330.puml', null,
    [
      {
        PhoneCaseMode.LOWER_CASE : {
          "0": " 0",
          "1": ".,?!-&1",
          "2": "abc2äàáãâæç",
          "3": "def3èéëê",
          "4": "ghi4ìíîïığ",
          "5": "jkl5£",
          "6": "mno6öòóôøñ",
          "7": "pqrs7ß\$",
          "8": "tuv8üùúû",
          "9": "wxyz9ý",
          "*": ".,?!:;-+#*()'\"_@&\$£%/<>¿¡§=¤€¥"
        },
        PhoneCaseMode.UPPER_CASE : {
          "0": " 0",
          "1": ".,'?!-&1@/",
          "2": "ABC2ÄÀÁÃÂÆÇ",
          "3": "DEF3ÈÉËÊ",
          "4": "GHI4ÌÍÎÏİĞ",
          "5": "JKL5£",
          "6": "MNO6ÖÒÓÕØÑ",
          "7": "PQRS7\$",
          "8": "TUV8ÜÙÚÛ",
          "9": "WXYZ9",
          "*": ".,?!:;-+#*()'\"_@&\$£%/<>¿¡§=¤€¥"
        }
      }
    ],
    [
      [PhoneInputLanguage.ENGLISH, PhoneInputLanguage.GERMAN, PhoneInputLanguage.FRENCH, PhoneInputLanguage.ITALIAN, PhoneInputLanguage.DUTCH, PhoneInputLanguage.TURKISH]
    ]
  ),
  PhoneModel('Nokia 6230', 'assets/vanity_multitap_workflows/nokia_6230.puml', null,
      [
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": " 0\n",
            "1": ".,'?!\"1-()@/:_",
            "2": "abc2äæåàáâãç",
            "3": "def3èéêëð",
            "4": "ghi4ìíîï",
            "5": "jkl5£",
            "6": "mno6öøòóôõñ",
            "7": "pqrs7ß\$",
            "8": "tuv8ùúûü",
            "9": "wxyz9ýþ",
            "*": ".,'?!\"-()/:_;+&%*=<>£€\$¥¤[]{}\\~^`¡¿§#| \n"
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": " 0\n",
            "1": ".,'?!\"1-()@/:_",
            "2": "ABC2ÄÆÅÀÁÂÃÇ",
            "3": "DEF3ÈÉÊËÐ",
            "4": "GHI4ÌÍÎÏ",
            "5": "JKL5£",
            "6": "MNO6ÖØÒÓÔÕÑ",
            "7": "PQRS7\$",
            "8": "TUV8ÙÚÛÜ",
            "9": "WXYZ9ÝÞ",
            "*": ".,'?!\"-()/:_;+&%*=<>£€\$¥¤[]{}\\~^`¡¿§#| \n"
          }
        },
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": " 0\n",
            "1": ".,?!'\"1-()@/:_",
            "2": "abc2äàáãâåæç",
            "3": "def3èéëêð",
            "4": "ghi4ìíîï",
            "5": "jkl5£",
            "6": "mno6öòóôõøñ",
            "7": "pqrs7ß\$",
            "8": "tuv8üùúû",
            "9": "wxyz9ýþ",
            "*": ".,'?!\"-()/:_;+&%*=<>£€\$¥¤[]{}\\~^`¡¿§#| \n"
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": " 0\n",
            "1": ".,?!'\"1-()@/:_",
            "2": "ABC2ÄÀÁÃÂÅÆÇ",
            "3": "DEF3ÈÉËÊÐ",
            "4": "GHI4ÌÍÎÏ",
            "5": "JKL5£",
            "6": "MNO6ÖÒÓÔÕØÑ",
            "7": "PQRS7\$",
            "8": "TUV8ÜÙÚÛ",
            "9": "WXYZ9ÝÞ",
            "*": ".,'?!\"-()/:_;+&%*=<>£€\$¥¤[]{}\\~^`¡¿§#| \n"
          }
        },
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": " 0\n",
            "1": ".,?!'\"1-()@/:_",
            "2": "abc2àâæçäáã",
            "3": "def3éèêë",
            "4": "ghi4ïîìíğı",
            "5": "jkl5",
            "6": "mno6ôœöñòóø",
            "7": "pqrs7\$ß",
            "8": "tuv8ûùüú",
            "9": "wxyz9",
            "*": ".,'?!\"-()/:_;+&%*=<>£€\$¥¤[]{}\\~^`¡¿§#| \n"
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": " 0\n",
            "1": ".,?!'\"1-()@/:_",
            "2": "ABC2ÀÂÆÇÄÁÃ",
            "3": "DEF3ÉÈÊË",
            "4": "GHI4ÏÎÌÍĞİ",
            "5": "JKL5",
            "6": "MNO6ÔŒÖÑÒÓØ",
            "7": "PQRS7\$",
            "8": "TUV8ÛÙÜÚ",
            "9": "WXYZ9",
            "*": ".,'?!\"-()/:_;+&%*=<>£€\$¥¤[]{}\\~^`¡¿§#| \n"
          }
        },
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": " 0\n",
            "1": ".,?!'\"1-()@/:_",
            "2": "abc2àáäâãåæç",
            "3": "def3èéëêð",
            "4": "ghi4ìíïî",
            "5": "jkl5£",
            "6": "mno6òºóöôõøñ",
            "7": "pqrs7ß\$",
            "8": "tuv8ùúüû",
            "9": "wxyz9ýþ",
            "*": ".,'?!\"-()/:_;+&%*=<>£€\$¥¤[]{}\\~^`¡¿§#| \n"
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": " 0\n",
            "1": ".,?!'\"1-()@/:_",
            "2": "ABC2ÀÁÄÂÃÅÆÇ",
            "3": "DEF3ÈÉËÊÐ",
            "4": "GHI4ÌÍÏÎ",
            "5": "JKL5£",
            "6": "MNO6ÒºÓÖÔÕØÑ",
            "7": "PQRS7\$",
            "8": "TUV8ÙÚÜÛ",
            "9": "WXYZ9ÝÞ",
            "*": ".,'?!\"-()/:_;+&%*=<>£€\$¥¤[]{}\\~^`¡¿§#| \n"
          }
        },
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": " 0\n",
            "1": ".,?!'\"1-()@/:_",
            "2": "abc2äàáâãåæç",
            "3": "def3éèëêð",
            "4": "ghi4îïìí",
            "5": "jkl5£",
            "6": "mno6öôòóõøñ",
            "7": "pqrs7ß\$",
            "8": "tuv8üùûú",
            "9": "wxyz9ýþ",
            "*": ".,'?!\"-()/:_;+&%*=<>£€\$¥¤[]{}\\~^`¡¿§#| \n"
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": " 0\n",
            "1": ".,?!'\"1-()@/:_",
            "2": "ABC2ÄÀÁÂÃÅÆÇ",
            "3": "DEF3ÉÈËÊÐ",
            "4": "GHI4ÎÏÌÍ",
            "5": "JKL5£",
            "6": "MNO6ÖÔÒÓÕØÑ",
            "7": "PQRS7\$",
            "8": "TUV8ÜÙÛÚ",
            "9": "WXYZ9ÝÞ",
            "*": ".,'?!\"-()/:_;+&%*=<>£€\$¥¤[]{}\\~^`¡¿§#| \n"
          }
        },
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": " 0\n",
            "1": ".,¿?¡!'\"1-()@/:_",
            "2": "abc2áªàâãäåæç",
            "3": "def3éèëêð",
            "4": "ghi4íîïì",
            "5": "jkl5£",
            "6": "mnño6óºöôòõø",
            "7": "pqrs7ß\$",
            "8": "tuv8úüùû",
            "9": "wxyz9ýþ",
            "*": ".,'?!\"-()/:_;+&%*=<>£€\$¥¤[]{}\\~^`¡¿§#| \n"
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": " 0\n",
            "1": ".,¿?¡!'\"1-()@/:_",
            "2": "ABC2ÁªÀÂÃÄÅÆÇ",
            "3": "DEF3ÉÈËÊÐ",
            "4": "GHI4ÍÎÏÌ",
            "5": "JKL5£",
            "6": "MNÑO6ÓºÖÔÒÕØ",
            "7": "PQRS7\$",
            "8": "TUV8ÚÜÙÛ",
            "9": "WXYZ9ÝÞ",
            "*": ".,'?!\"-()/:_;+&%*=<>£€\$¥¤[]{}\\~^`¡¿§#| \n"
          }
        },
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": " 0\n",
            "1": ".,?!'\"1-()@/:_",
            "2": "abcç2âäàáãæ",
            "3": "def3èéëê",
            "4": "gğhıi4îïìí",
            "5": "jkl5£",
            "6": "mno6öôòóøñ",
            "7": "pqrsş7ß\$",
            "8": "tuv8üùûú",
            "9": "wxyz9",
            "*": ".,'?!\"-()/:_;+&%*=<>£€\$¥¤[]{}\\~^`¡¿§#| \n"
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": " 0\n",
            "1": ".,?!'\"1-()@/:_",
            "2": "ABCÇ2ÂÄÀÁÃÆ",
            "3": "DEF3ÈÉËÊ",
            "4": "GĞHİI4ÎÏÌÍ",
            "5": "JKL5£",
            "6": "MNO6ÖÔÒÓØÑ",
            "7": "PQRSŞ7\$",
            "8": "TUV8ÜÙÛÚ",
            "9": "WXYZ9",
            "*": ".,'?!\"-()/:_;+&%*=<>£€\$¥¤[]{}\\~^`¡¿§#| \n"
          }
        },
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": " 0\n",
            "1": ".,?!'\"1-()@/:_",
            "2": "abc2ãáàâªäåæç",
            "3": "def3éêèëð",
            "4": "ghi4íìîï",
            "5": "jkl5£",
            "6": "mno6õóôºòöøñ",
            "7": "pqrs7ß\$",
            "8": "tuv8úüùû",
            "9": "wxyz9ýþ",
            "*": ".,'?!\"-()/:_;+&%*=<>£€\$¥¤[]{}\\~^`¡¿§#| \n"
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": " 0\n",
            "1": ".,?!'\"1-()@/:_",
            "2": "ABC2ÃÁÀÂªÄÅÆÇ",
            "3": "DEF3ÉÊÈËÐ",
            "4": "GHI4ÍÌÎÏ",
            "5": "JKL5£",
            "6": "MNO6ÕÓÔºÒÖØÑ",
            "7": "PQRS7\$",
            "8": "TUV8ÚÜÙÛ",
            "9": "WXYZ9ÝÞ",
            "*": ".,'?!\"-()/:_;+&%*=<>£€\$¥¤[]{}\\~^`¡¿§#| \n"
          }
        }
      ],
      [
        [PhoneInputLanguage.ENGLISH],
        [PhoneInputLanguage.GERMAN],
        [PhoneInputLanguage.FRENCH],
        [PhoneInputLanguage.ITALIAN],
        [PhoneInputLanguage.DUTCH],
        [PhoneInputLanguage.SPANISH],
        [PhoneInputLanguage.TURKISH],
        [PhoneInputLanguage.PORTUGUESE],
      ]
  ),
  PhoneModel('Sagem My X-3', 'assets/vanity_multitap_workflows/sagem_my_x-3.puml', null,
      [
        //The change of letters on this device is a long press, so not supported - that's why only the first is returned,
        {
          PhoneCaseMode.LOWER_CASE : {
            "1": ".",
            "2": "a",
            "3": "d",
            "4": "g",
            "5": "j",
            "6": "m",
            "7": "p",
            "8": "t",
            "9": "w",
            "0": " "
          },
          PhoneCaseMode.UPPER_CASE : {
            "1": ".",
            "2": "A",
            "3": "D",
            "4": "G",
            "5": "J",
            "6": "M",
            "7": "P",
            "8": "T",
            "9": "W",
            "0": " "
          }
        }
      ],
      [
        [PhoneInputLanguage.FRENCH, PhoneInputLanguage.ENGLISH, PhoneInputLanguage.GERMAN, PhoneInputLanguage.DUTCH, PhoneInputLanguage.TURKISH]
      ]
  ),
  PhoneModel('Samsung E1120', 'assets/vanity_multitap_workflows/samsung_e1120.puml', null,
      [
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": "+=<>€£\$%&¥¤0",
            "1": ".,-?!@:()/1",
            "2": "abc2",
            "3": "def3",
            "4": "ghi4",
            "5": "jkl5",
            "6": "mno6",
            "7": "pqrs7",
            "8": "tuv8",
            "9": "wxyz9",
            "#": " "
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": "+=<>€£\$%&¥¤0",
            "1": ".,-?!@:()/1",
            "2": "ABC2",
            "3": "DEF3",
            "4": "GHI4",
            "5": "JKL5",
            "6": "MNO6",
            "7": "PQRS7",
            "8": "TUV8",
            "9": "WXYZ9",
            "#": " "
          },
          PhoneCaseMode.NUMBERS : {
            "0": "0",
            "1": "1",
            "2": "2",
            "3": "3",
            "4": "4",
            "5": "5",
            "6": "6",
            "7": "7",
            "8": "8",
            "9": "9",
            "#": " "
          }
        },
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": "+=<>€£\$%&¥¤0",
            "1": ".,-?!@:()/1",
            "2": "abcäáà2",
            "3": "deféè3",
            "4": "ghi4",
            "5": "jkl5",
            "6": "mnoö6",
            "7": "pqrsß7",
            "8": "tuvü8",
            "9": "wxyz9",
            "#": " "
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": "+=<>€£\$%&¥¤0",
            "1": ".,-?!@:()/1",
            "2": "ABCÄÁÀ2",
            "3": "DEFÉÈ3",
            "4": "GHI4",
            "5": "JKL5",
            "6": "MNOÖ6",
            "7": "PQRS7",
            "8": "TUVÜ8",
            "9": "WXYZ9",
            "#": " "
          },
          PhoneCaseMode.NUMBERS : {
            "0": "0",
            "1": "1",
            "2": "2",
            "3": "3",
            "4": "4",
            "5": "5",
            "6": "6",
            "7": "7",
            "8": "8",
            "9": "9",
            "#": " "
          }
        },
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": "+=<>€£\$%&¥¤0",
            "1": ".,-?!@:()/1",
            "2": "abcçäáàâ2",
            "3": "defëéèê3",
            "4": "ghiïíìî4",
            "5": "jkl5",
            "6": "mnoöóòô6",
            "7": "pqrsß7",
            "8": "tuvüúûù8",
            "9": "wxyz9",
            "#": " "
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": "+=<>€£\$%&¥¤0",
            "1": ".,-?!@:()/1",
            "2": "ABCÇÄÁÀÂ2",
            "3": "DEFËÉÈÊ3",
            "4": "GHIÏÍÌÎ4",
            "5": "JKL5",
            "6": "MNOÖÓÒÔ6",
            "7": "PQRS7",
            "8": "TUVÜÚÛÙ8",
            "9": "WXYZ9",
            "#": " "
          },
          PhoneCaseMode.NUMBERS : {
            "0": "0",
            "1": "1",
            "2": "2",
            "3": "3",
            "4": "4",
            "5": "5",
            "6": "6",
            "7": "7",
            "8": "8",
            "9": "9",
            "#": " "
          }
        }
      ],
      [
        [PhoneInputLanguage.ENGLISH],
        [PhoneInputLanguage.GERMAN],
        [PhoneInputLanguage.DUTCH]
      ]
  ),
  PhoneModel('Samsung GT-E1170', 'assets/vanity_multitap_workflows/samsung_gt-e1170.puml', null,
      [
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": " 0\n",
            "1": ".,?!1@'\"-()/:_;",
            "2": "abc2",
            "3": "def3",
            "4": "ghi4",
            "5": "jkl5",
            "6": "mno6",
            "7": "pqrs7",
            "8": "tuv8",
            "9": "wxyz9",
            "*": ".,-!?@~_\n\\/&\"';^|:()<{}>[]=€\$£§%¥*+¿¡¤¢«»®©°"
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": " 0\n",
            "1": ".,?!1@'\"-()/:_;",
            "2": "ABC2",
            "3": "DEF3",
            "4": "GHI4",
            "5": "JKL5",
            "6": "MNO6",
            "7": "PQRS7",
            "8": "TUV8",
            "9": "WXYZ9",
            "*": ".,-!?@~_\n\\/&\"';^|:()<{}>[]=€\$£§%¥*+¿¡¤¢«»®©°"
          },
          PhoneCaseMode.NUMBERS : {
            "0": "0",
            "1": "1",
            "2": "2",
            "3": "3",
            "4": "4",
            "5": "5",
            "6": "6",
            "7": "7",
            "8": "8",
            "9": "9",
            "*": ".,-!?@~_\n\\/&\"';^|:()<{}>[]=€\$£§%¥*+¿¡¤¢«»®©°"
          }
        },
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": " 0\n",
            "1": ".,?!1@'\"-()/:_;",
            "2": "abcäáà2",
            "3": "deféè3",
            "4": "ghi4",
            "5": "jkl5",
            "6": "mnoö6",
            "7": "pqrsß7",
            "8": "tuvü8",
            "9": "wxyz9",
            "*": ".,-!?@~_\n\\/&\"';^|:()<{}>[]=€\$£§%¥*+¿¡¤¢«»®©°"
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": " 0\n",
            "1": ".,?!1@'\"-()/:_;",
            "2": "ABCÄÁÀ2",
            "3": "DEFÉÈ3",
            "4": "GHI4",
            "5": "JKL5",
            "6": "MNOÖ6",
            "7": "PQRS7",
            "8": "TUVÜ8",
            "9": "WXYZ9",
            "*": ".,-!?@~_\n\\/&\"';^|:()<{}>[]=€\$£§%¥*+¿¡¤¢«»®©°"
          },
          PhoneCaseMode.NUMBERS : {
            "0": "0",
            "1": "1",
            "2": "2",
            "3": "3",
            "4": "4",
            "5": "5",
            "6": "6",
            "7": "7",
            "8": "8",
            "9": "9",
            "*": ".,-!?@~_\n\\/&\"';^|:()<{}>[]=€\$£§%¥*+¿¡¤¢«»®©°"
          }
        },
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": " 0\n",
            "1": ".,?!1@'\"-()/:_;",
            "2": "abcà2",
            "3": "defèé3",
            "4": "ghiì4",
            "5": "jkl5",
            "6": "mnoò6",
            "7": "pqrs7",
            "8": "tuvù8",
            "9": "wxyz9",
            "*": ".,-!?@~_\n\\/&\"';^|:()<{}>[]=€\$£§%¥*+¿¡¤¢«»®©°"
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": " 0\n",
            "1": ".,?!1@'\"-()/:_;",
            "2": "ABCÀ2",
            "3": "DEFÈÉ3",
            "4": "GHIÌ4",
            "5": "JKL5",
            "6": "MNOÒ6",
            "7": "PQRS7",
            "8": "TUVÙ8",
            "9": "WXYZ9",
            "*": ".,-!?@~_\n\\/&\"';^|:()<{}>[]=€\$£§%¥*+¿¡¤¢«»®©°"
          },
          PhoneCaseMode.NUMBERS : {
            "0": "0",
            "1": "1",
            "2": "2",
            "3": "3",
            "4": "4",
            "5": "5",
            "6": "6",
            "7": "7",
            "8": "8",
            "9": "9",
            "*": ".,-!?@~_\n\\/&\"';^|:()<{}>[]=€\$£§%¥*+¿¡¤¢«»®©°"
          }
        },
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": " 0\n",
            "1": ".,?!1@'\"-()/:_;",
            "2": "abcçàâáä2",
            "3": "deféèêë3",
            "4": "ghiîïí4",
            "5": "jkl5",
            "6": "mnoôóöñ6",
            "7": "pqrsß7",
            "8": "tuvùûúü8",
            "9": "wxyz9",
            "*": ".,-!?@~_\n\\/&\"';^|:()<{}>[]=€\$£§%¥*+¿¡¤¢«»®©°"
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": " 0\n",
            "1": ".,?!1@'\"-()/:_;",
            "2": "ABCÇÀÂÁÄ2",
            "3": "DEFÉÈÊË3",
            "4": "GHIÎÏÍ4",
            "5": "JKL5",
            "6": "MNOÔÓÖÑ6",
            "7": "PQRS7",
            "8": "TUVÙÛÚÜ8",
            "9": "WXYZ9",
            "*": ".,-!?@~_\n\\/&\"';^|:()<{}>[]=€\$£§%¥*+¿¡¤¢«»®©°"
          },
          PhoneCaseMode.NUMBERS : {
            "0": "0",
            "1": "1",
            "2": "2",
            "3": "3",
            "4": "4",
            "5": "5",
            "6": "6",
            "7": "7",
            "8": "8",
            "9": "9",
            "*": ".,-!?@~_\n\\/&\"';^|:()<{}>[]=€\$£§%¥*+¿¡¤¢«»®©°"
          }
        },
      ],
      [
        [PhoneInputLanguage.ENGLISH],
        [PhoneInputLanguage.GERMAN],
        [PhoneInputLanguage.ITALIAN],
        [PhoneInputLanguage.FRENCH]
      ]
  ),
  PhoneModel('Siemens A65', 'assets/vanity_multitap_workflows/siemens_a65.puml',
      {
        PhoneInputLanguage.GREEK: 'assets/vanity_multitap_workflows/siemens_a65_greek.puml'
      },
      [
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": ".,?!'\"0-()@/:_",
            "1": " \n1",
            "2": "abc2äàæåç",
            "3": "def3éè",
            "4": "ghi4ì",
            "5": "jkl5",
            "6": "mno6öøòñ",
            "7": "pqrs7ß",
            "8": "tuv8üù",
            "9": "wxyz9",
            "*": "\n¿¡_;.,?!+-\"':*/()¤¥\$£€@\\&#[]{}%~<=>|^`§ΓΔΘΛΞΠΣΦΨΩ"
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": ".,?!'\"0-()@/:_",
            "1": " \n1",
            "2": "ABC2ÄÆÅ",
            "3": "DEF3É",
            "4": "GHI4",
            "5": "JKL5",
            "6": "MNO6ÖØÑ",
            "7": "PQRS7",
            "8": "TUV8Ü",
            "9": "WXYZ9",
            "*": "\n¿¡_;.,?!+-\"':*/()¤¥\$£€@\\&#[]{}%~<=>|^`§ΓΔΘΛΞΠΣΦΨΩ"
          },
          PhoneCaseMode.NUMBERS : {
            "0": "0",
            "1": "1",
            "2": "2",
            "3": "3",
            "4": "4",
            "5": "5",
            "6": "6",
            "7": "7",
            "8": "8",
            "9": "9",
            "*": "\n¿¡_;.,?!+-\"':*/()¤¥\$£€@\\&#[]{}%~<=>|^`§ΓΔΘΛΞΠΣΦΨΩ"
          }
        },
        {
          PhoneCaseMode.UPPER_CASE : {
            "0": ".,?!'\"0-()@/:_",
            "1": " \n1",
            "2": "ΑΒC2ÄÆÅ",
            "3": "ΔΕΘDF3É",
            "4": "ΓΗΙG4",
            "5": "ΚΛJL5",
            "6": "ΜΝΟΩ6ÖØÑ",
            "7": "ΠΡΣΨQRS7",
            "8": "ΘΤUV8Ü",
            "9": "ΖΞΥΧW9",
            "*": "\n¿¡_;.,?!+-\"':*/()¤¥\$£€@\\&#[]{}%~<=>|^`§ΓΔΘΛΞΠΣΦΨΩ"
          },
          PhoneCaseMode.NUMBERS : {
            "0": "0",
            "1": "1",
            "2": "2",
            "3": "3",
            "4": "4",
            "5": "5",
            "6": "6",
            "7": "7",
            "8": "8",
            "9": "9",
            "*": "\n¿¡_;.,?!+-\"':*/()¤¥\$£€@\\&#[]{}%~<=>|^`§ΓΔΘΛΞΠΣΦΨΩ"
          }
        }
      ],
      [
        [PhoneInputLanguage.ENGLISH, PhoneInputLanguage.GERMAN, PhoneInputLanguage.FRENCH, PhoneInputLanguage.ITALIAN, PhoneInputLanguage.DUTCH, PhoneInputLanguage.TURKISH],
        [PhoneInputLanguage.GREEK]
      ]
  ),
  PhoneModel('Siemens C75', 'assets/vanity_multitap_workflows/siemens_c75.puml',
      {
        PhoneInputLanguage.GREEK: 'assets/vanity_multitap_workflows/siemens_c75_greek.puml'
      },
      [
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": ".,?!'\"0+-()@/:_",
            "1": " \n1",
            "2": "abc2äàæåç",
            "3": "def3éè",
            "4": "ghi4ì",
            "5": "jkl5",
            "6": "mno6öøòñ",
            "7": "pqrs7ß",
            "8": "tuv8üù",
            "9": "wxyz9",
            "*": "\n¿¡_;.,?!+-\"':*/()¤¥\$£€@\\&#[]{}%~<=>|^`§ΓΔΘΛΞΠΣΦΨΩ"
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": ".,?!'\"0+-()@/:_",
            "1": " \n1",
            "2": "ABC2ÄÆÅ",
            "3": "DEF3É",
            "4": "GHI4",
            "5": "JKL5",
            "6": "MNO6ÖØÑ",
            "7": "PQRS7",
            "8": "TUV8Ü",
            "9": "WXYZ9",
            "*": "\n¿¡_;.,?!+-\"':*/()¤¥\$£€@\\&#[]{}%~<=>|^`§ΓΔΘΛΞΠΣΦΨΩ"
          },
          PhoneCaseMode.NUMBERS : {
            "0": "0",
            "1": "1",
            "2": "2",
            "3": "3",
            "4": "4",
            "5": "5",
            "6": "6",
            "7": "7",
            "8": "8",
            "9": "9",
            "*": "\n¿¡_;.,?!+-\"':*/()¤¥\$£€@\\&#[]{}%~<=>|^`§ΓΔΘΛΞΠΣΦΨΩ"
          }
        },
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": ".,?!'\"0+-()@/:_",
            "1": " \n1",
            "2": "abc2çâ",
            "3": "def3",
            "4": "ghi4ğı",
            "5": "jkl5",
            "6": "mno6ö",
            "7": "pqrs7ş",
            "8": "tuv8üû",
            "9": "wxyz9",
            "*": "\n¿¡_;.,?!+-\"':*/()¤¥\$£€@\\&#[]{}%~<=>|^`§ΓΔΘΛΞΠΣΦΨΩ"
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": ".,?!'\"0+-()@/:_",
            "1": " \n1",
            "2": "ABC2ÇÂ",
            "3": "DEF3",
            "4": "GHI4Ğİ",
            "5": "JKL5",
            "6": "MNO6Ö",
            "7": "PQRS7Ş",
            "8": "TUV8ÜÛ",
            "9": "WXYZ9",
            "*": "\n¿¡_;.,?!+-\"':*/()¤¥\$£€@\\&#[]{}%~<=>|^`§ΓΔΘΛΞΠΣΦΨΩ"
          },
          PhoneCaseMode.NUMBERS : {
            "0": "0",
            "1": "1",
            "2": "2",
            "3": "3",
            "4": "4",
            "5": "5",
            "6": "6",
            "7": "7",
            "8": "8",
            "9": "9",
            "*": "\n¿¡_;.,?!+-\"':*/()¤¥\$£€@\\&#[]{}%~<=>|^`§ΓΔΘΛΞΠΣΦΨΩ"
          }
        },
        {
          PhoneCaseMode.UPPER_CASE : {
            "0": ".,?!'\"0+-()@/:_",
            "1": " \n1",
            "2": "ΑΒ2ABC",
            "3": "ΔΕΘ3DEF",
            "4": "ΓΗΙ4GHI",
            "5": "ΚΛ5JKL",
            "6": "ΜΝΟΩ6MNO",
            "7": "ΠΡΣΨ7PQRS",
            "8": "ΘΤ8TUV",
            "9": "ΖΞΥΧ9WXYZ",
            "*": "\n¿¡_;.,?!+-\"':*/()¤¥\$£€@\\&#[]{}%~<=>|^`§ΓΔΘΛΞΠΣΦΨΩ"
          },
          PhoneCaseMode.NUMBERS : {
            "0": "0",
            "1": "1",
            "2": "2",
            "3": "3",
            "4": "4",
            "5": "5",
            "6": "6",
            "7": "7",
            "8": "8",
            "9": "9",
            "*": "\n¿¡_;.,?!+-\"':*/()¤¥\$£€@\\&#[]{}%~<=>|^`§ΓΔΘΛΞΠΣΦΨΩ"
          }
        }
      ],
      [
        [PhoneInputLanguage.ENGLISH, PhoneInputLanguage.GERMAN, PhoneInputLanguage.FRENCH, PhoneInputLanguage.ITALIAN, PhoneInputLanguage.SPANISH, PhoneInputLanguage.CATALAN, PhoneInputLanguage.PORTUGUESE],
        [PhoneInputLanguage.TURKISH],
        [PhoneInputLanguage.GREEK]
      ]
  ),
  PhoneModel('Siemens ME45', 'assets/vanity_multitap_workflows/siemens_me45.puml',
      {
        PhoneInputLanguage.GREEK: 'assets/vanity_multitap_workflows/siemens_me45_greek.puml'
      },
      [
        // fast double click on * gives a further special character selection, but not supported here
        // (difference of two fast ** to two slow ** cannot be easily recognized...)
        // in non-greek # is T9 on/off, the special characters on fast double click as well...
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": ".,?!0+-¿¡\"';_",
            "1": " 1€£\$¥¤",
            "2": "abc2äàçæå",
            "3": "def3éè",
            "4": "ghi4ì",
            "5": "jkl5",
            "6": "mno6öñòø",
            "7": "pqrs7ß",
            "8": "tuv8üù",
            "9": "wxyz9"
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": ".,?!0+-¿¡\"';_",
            "1": " 1€£\$¥¤",
            "2": "ABC2ÄÆÅ",
            "3": "DEF3É",
            "4": "GHI4",
            "5": "JKL5",
            "6": "MNO6ÖÑØ",
            "7": "PQRS7",
            "8": "TUV8Ü",
            "9": "WXYZ9"
          },
          PhoneCaseMode.NUMBERS : {
            "0": "0",
            "1": "1",
            "2": "2",
            "3": "3",
            "4": "4",
            "5": "5",
            "6": "6",
            "7": "7",
            "8": "8",
            "9": "9",
            "#": "#"
          }
        },
        {
          PhoneCaseMode.UPPER_CASE : {
            "0": ".,?!0+-¿¡\"';_",
            "1": " 1€£\$¥¤",
            "2": "ΑΒC2ÄÆÅ",
            "3": "ΔΕΘDF3É",
            "4": "ΓΗΙG4",
            "5": "ΚΛJL5",
            "6": "ΜΝΟΩ6ÖÑØ",
            "7": "ΠΡΣΨQRS7",
            "8": "ΘΤUV8Ü",
            "9": "ΖΞΥΧW9",
            "#": "#@\\&§"
          },
          PhoneCaseMode.NUMBERS : {
            "0": "0",
            "1": "1",
            "2": "2",
            "3": "3",
            "4": "4",
            "5": "5",
            "6": "6",
            "7": "7",
            "8": "8",
            "9": "9",
            "#": "#"
          }
        }
      ],
      [
        [PhoneInputLanguage.ENGLISH, PhoneInputLanguage.GERMAN, PhoneInputLanguage.FRENCH, PhoneInputLanguage.ITALIAN],
        [PhoneInputLanguage.GREEK]
      ]
  ),
  PhoneModel('Siemens S35', 'assets/vanity_multitap_workflows/siemens_s35.puml', null,
      [
        // fast double click on * or # gives a further special character selection, but not supported here
        // (difference of two fast ** to two slow ** cannot be easily recognized...)
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": "+0-.,:?¿!¡\"';_",
            "1": " 1€£\$¥",
            "2": "abc2äà",
            "3": "def3éè",
            "4": "ghi4ì",
            "5": "jkl5",
            "6": "mno6öñò",
            "7": "pqrs7ß",
            "8": "tuv8üù",
            "9": "wxyz9æøå"
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": "+0-.,:?¿!¡\"';_",
            "1": " 1€£\$¥",
            "2": "ABC2ÄÇ",
            "3": "DEF3É",
            "4": "GHI4",
            "5": "JKL5",
            "6": "MNO6ÖÑ",
            "7": "PQRS7",
            "8": "TUV8Ü",
            "9": "WXYZ9ÆØÅ"
          },
          PhoneCaseMode.NUMBERS : {
            "0": "0",
            "1": "1",
            "2": "2",
            "3": "3",
            "4": "4",
            "5": "5",
            "6": "6",
            "7": "7",
            "8": "8",
            "9": "9"
          }
        }
      ],
      [
        [PhoneInputLanguage.ENGLISH, PhoneInputLanguage.GERMAN, PhoneInputLanguage.FRENCH, PhoneInputLanguage.ITALIAN, PhoneInputLanguage.DUTCH]
      ]
  ),
  PhoneModel('Siemens S55', 'assets/vanity_multitap_workflows/siemens_s55.puml',
      {
        PhoneInputLanguage.GREEK: 'assets/vanity_multitap_workflows/siemens_s55_greek.puml'
      },
      [
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": ".,?!'\"0-()@/:_",
            "1": " \n1",
            "2": "abc2äàæåç",
            "3": "def3éè",
            "4": "ghi4ì",
            "5": "jkl5",
            "6": "mno6öøòñ",
            "7": "pqrs7ß",
            "8": "tuv8üù",
            "9": "wxyz9",
            "*": "\n¿¡_;.,?!+-\"':*/()¤¥\$£€@\\&#[]{}%~<=>|^`§ΓΔΘΛΞΠΣΦΨΩ"
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": ".,?!'\"0-()@/:_",
            "1": " \n1",
            "2": "ABC2ÄÆÅ",
            "3": "DEF3É",
            "4": "GHI4",
            "5": "JKL5",
            "6": "MNO6ÖØÑ",
            "7": "PQRS7",
            "8": "TUV8Ü",
            "9": "WXYZ9",
            "*": "\n¿¡_;.,?!+-\"':*/()¤¥\$£€@\\&#[]{}%~<=>|^`§ΓΔΘΛΞΠΣΦΨΩ"
          },
          PhoneCaseMode.NUMBERS : {
            "0": "0",
            "1": "1",
            "2": "2",
            "3": "3",
            "4": "4",
            "5": "5",
            "6": "6",
            "7": "7",
            "8": "8",
            "9": "9",
            "*": "\n¿¡_;.,?!+-\"':*/()¤¥\$£€@\\&#[]{}%~<=>|^`§ΓΔΘΛΞΠΣΦΨΩ"
          }
        },
        {
          PhoneCaseMode.UPPER_CASE : {
            "0": ".,?!'\"0-()@/:_",
            "1": " \n1",
            "2": "ΑΒC2ÄÆÅ",
            "3": "ΔΕΘDF3É",
            "4": "ΓΗΙG4",
            "5": "ΚΛJL5",
            "6": "ΜΝΟΩ6ÖØÑ",
            "7": "ΠΡΣΨQRS7",
            "8": "ΘΤUV8Ü",
            "9": "ΖΞΥΧW9",
            "*": "\n¿¡_;.,?!+-\"':*/()¤¥\$£€@\\&#[]{}%~<=>|^`§ΓΔΘΛΞΠΣΦΨΩ"
          },
          PhoneCaseMode.NUMBERS : {
            "0": "0",
            "1": "1",
            "2": "2",
            "3": "3",
            "4": "4",
            "5": "5",
            "6": "6",
            "7": "7",
            "8": "8",
            "9": "9",
            "*": "\n¿¡_;.,?!+-\"':*/()¤¥\$£€@\\&#[]{}%~<=>|^`§ΓΔΘΛΞΠΣΦΨΩ"
          }
        }
      ],
      [
        [PhoneInputLanguage.ENGLISH, PhoneInputLanguage.GERMAN, PhoneInputLanguage.FRENCH, PhoneInputLanguage.ITALIAN, PhoneInputLanguage.DUTCH, PhoneInputLanguage.TURKISH],
        [PhoneInputLanguage.GREEK]
      ]
  ),
  PhoneModel('Sony Ericsson K700i', 'assets/vanity_multitap_workflows/sony_ericsson_k700i.puml', null,
      [
        //The weird cases are correct, e.g. the Ç in the lower case 2 or the è in upper case 3
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": "+0ΘΞΨΩ",
            "1": ".,-?!'@:;/()1",
            "2": "abcåäæàÇ2Γ",
            "3": "def3èéΔΦ",
            "4": "ghiì4",
            "5": "jkl5Λ",
            "6": "mnoñöøò6",
            "7": "pqrsß7ΠΣ",
            "8": "tuvüù8",
            "9": "wxyz9",
            "#": " \n¶#*"
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": "+0ΘΞΨΩ",
            "1": ".,-?!'@:;/()1",
            "2": "ABCÅÄÆàÇ2Γ",
            "3": "DEF3èÉΔΦ",
            "4": "GHIì4",
            "5": "JKL5Λ",
            "6": "MNOÑÖØò6",
            "7": "PQRSß7ΠΣ",
            "8": "TUVÜù8",
            "9": "WXYZ9",
            "#": " \n¶#*"
          }
        },
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": "+0",
            "1": ".,-?!'@:;/()1",
            "2": "abc2",
            "3": "def3",
            "4": "ghi4",
            "5": "jkl5",
            "6": "mno6",
            "7": "pqrs7",
            "8": "tuv8",
            "9": "wxyz9",
            "#": " \n¶"
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": "+0",
            "1": ".,-?!'@:;/()1",
            "2": "ABC2",
            "3": "DEF3",
            "4": "GHI4",
            "5": "JKL5",
            "6": "MNO6",
            "7": "PQRS7",
            "8": "TUV8",
            "9": "WXYZ9",
            "#": " \n¶"
          }
        }
      ],
      [
        [PhoneInputLanguage.GERMAN, PhoneInputLanguage.FRENCH, PhoneInputLanguage.TURKISH],
        [PhoneInputLanguage.ENGLISH]
      ]
  ),
  PhoneModel('Sony Ericsson T300', 'assets/vanity_multitap_workflows/sony_ericsson_t300.puml', null,
      [
        //The weird cases are correct, e.g. the Ç in the lower case 2 or the è in upper case 3
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": "+&@/¤%\$€£¥\\§¿¡0ΘΞΨΩ",
            "1": "-?!,.:;\"'<=>()_1",
            "2": "abcåäæàÇ2Γ",
            "3": "def3èéΔΦ",
            "4": "ghiì4",
            "5": "jkl5Λ",
            "6": "mnoñöøò6",
            "7": "pqrsß7ΠΣ",
            "8": "tuvüù8",
            "9": "wxyz9",
            "#": " #*\n¶"
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": "+&@/¤%\$€£¥\\§¿¡0ΘΞΨΩ",
            "1": "-?!,.:;\"'<=>()_1",
            "2": "ABCÅÄÆàÇ2Γ",
            "3": "DEF3èÉΔΦ",
            "4": "GHIì4",
            "5": "JKL5Λ",
            "6": "MNOÑÖØò6",
            "7": "PQRSß7ΠΣ",
            "8": "TUVÜù8",
            "9": "WXYZ9",
            "#": " #*\n¶"
          }
        },
        {
          PhoneCaseMode.LOWER_CASE : {
            "0": "+&@/¤%\$€£¥\\§¿¡0",
            "1": "-?!,.:;\"'<=>()_1",
            "2": "abc2",
            "3": "def3",
            "4": "ghi4",
            "5": "jkl5",
            "6": "mno6",
            "7": "pqrs7",
            "8": "tuv8",
            "9": "wxyz9",
            "#": " #*\n¶"
          },
          PhoneCaseMode.UPPER_CASE : {
            "0": "+&@/¤%\$€£¥\\§¿¡0",
            "1": "-?!,.:;\"'<=>()_1",
            "2": "ABC2",
            "3": "DEF3",
            "4": "GHI4",
            "5": "JKL5",
            "6": "MNO6",
            "7": "PQRS7",
            "8": "TUV8",
            "9": "WXYZ9",
            "#": " #*\n¶"
          }
        }
      ],
      [
        [PhoneInputLanguage.GERMAN, PhoneInputLanguage.FRENCH],
        [PhoneInputLanguage.ENGLISH]
      ]
  ),
];