import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/befunge.dart';

void main() {
  group("Befunge.interpretBefunge", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'code' : null, 'input' : null, 'expectedOutput' : BefungeOutput(Output: '', Error: '', BefungeStack: [], PC: [], Command: [], Mnemonic: [])},
      {'code' : null, 'input' : '', 'expectedOutput' : BefungeOutput(Output: '', Error: '', BefungeStack: [], PC: [], Command: [], Mnemonic: [])},
      {'code' : '', 'input' : '', 'expectedOutput' : BefungeOutput(Output: '', Error: '', BefungeStack: [], PC: [], Command: [], Mnemonic: [])},
      {'code' : 'ABC123;', 'input' : '', 'expectedOutput' : BefungeOutput(Output: '', Error: BEFUNGE_ERROR_INFINITE_LOOP, BefungeStack: [], PC: [], Command: [], Mnemonic: [])},

      // https://en.wikipedia.org/wiki/Befunge
      {'code' : '>:# 0# \\# g# ,# 1# +# :# 5# 9# *# -# _@ Quine', 'input' : '', 'expectedOutput' : BefungeOutput(Output: '>:# 0# \\# g# ,# 1# +# :# 5# 9# *# -# _@ Quine', Error: '', BefungeStack: [], PC: [], Command: [], Mnemonic: [])},
      {'code' : '>              v\n' +
                'v  ,,,,,"Hello"<\n' +
                '>48*,          v\n' +
                'v,,,,,,"World!"<\n' +
                '>25*,@',
        'input' : null,
        'expectedOutput' :
        BefungeOutput(
            Output: 'Hello World!\n',
            Error: '',
            BefungeStack: [], PC: [], Command: [], Mnemonic: [])},

/*
 >25*"!dlrow ,olleH":v
                  v:,_@
                  >  ^
* */
      {'code' : ' >25*"!dlrow ,olleH":v\n' +
                '                  v:,_@\n' +
                '                  >  ^\n',
        'input' : '',
        'expectedOutput' :
        BefungeOutput(
            Output: 'Hello, world!\n',
            Error: '',
            BefungeStack: [], PC: [], Command: [], Mnemonic: [])},
      // random number generator - does not work as a testcase
      //  {'code' : ' v>>>>>v\n' +
      //            '  12345\n' +
      //            '  ^?^\n' +
      //            ' > ? ?^\n' +
      //            '  v?v\n' +
      //            '  6789\n' +
      //            '  >>>> v\n' +
      //            ' ^    .<\n', 'input' : '', 'expectedOutput' : BefungeOutput(Output: '', Error: '', BefungeStack: [], PC: [], Command: [], Mnemonic: [])},

      // https://de.wikipedia.org/wiki/Befunge
      {'code' : '0.1>:#\.#g:#00#00#+p# <',
        'input' : '',
        'expectedOutput' :
        BefungeOutput(
            Output: '0 ',
            Error: 'befunge_error_infinite_loop',
            BefungeStack: [], PC: [], Command: [], Mnemonic: [])},

      {'code' : '0.1> #<:#<.#<:#<0#<0#<p#<+#<0#<0#<g#<\\# <',
        'input' : '',
        'expectedOutput' :
        BefungeOutput(
            Output: '0 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 6765 10946 17711 28657 46368 75025 121393 196418 317811 514229 832040 1346269 2178309 3524578 5702887 9227465 14930352 24157817 39088169 63245986 102334155 165580141 267914296 433494437 701408733 1134903170 1836311903 2971215073 4807526976 7778742049 12586269025 20365011074 32951280099 53316291173 86267571272 139583862445 225851433717 365435296162 591286729879 956722026041 1548008755920 2504730781961 4052739537881 6557470319842 10610209857723 17167680177565 27777890035288 44945570212853 72723460248141 117669030460994 190392490709135 308061521170129 498454011879264 806515533049393 1304969544928657 2111485077978050 3416454622906707 5527939700884757 8944394323791464 14472334024676221 23416728348467685 37889062373143906 61305790721611591 99194853094755497 160500643816367088 259695496911122585 420196140727489673 679891637638612258 1100087778366101931 1779979416004714189 2880067194370816120 4660046610375530309 7540113804746346429 12200160415121876738 19740274219868223167 28963646256722998974 38187018293577774781 47410390330432550588 56633762367287326395 65857134404142102202 75080506440996878009 84303878477851653816 93527250514706429623 102750622551561205430 111973994588415981237 121197366625270757044 130420738662125532851 139644110698980308658 148867482735835084465 158090854772689860272 167314226809544636079 176537598846399411886 185760970883254187693 194984342920108963500 204207714956963739307 213431086993818515114 222654459030673290921 231877831067528066728 241101203104382842535 250324575141237618342 259547947178092394149 268771319214947169956 277994691251801945763 287218063288656721570 296441435325511497377 305664807362366273184 314888179399221048991 324111551436075824798 333334923472930600605 342558295509785376412 351781667546640152219 361005039583494928026 370228411620349703833 379451783657204479640 388675155694059255447 397898527730914031254 407121899767768807061 416345271804623582868 425568643841478358675 434792015878333134482 444015387915187910289 453238759952042686096 462462131988897461903 471685504025752237710 480908876062607013517 490132248099461789324 499355620136316565131 508578992173171340938 517802364210026116745 527025736246880892552 536249108283735668359 545472480320590444166 554695852357445219973 563919224394299995780 573142596431154771587 582365968468009547394 591589340504864323201 600812712541719099008 610036084578573874815 619259456615428650622 628482828652283426429 637706200689138202236 646929572725992978043 656152944762847753850 665376316799702529657 674599688836557305464 683823060873412081271 693046432910266857078 702269804947121632885 711493176983976408692 720716549020831184499 729939921057685960306 739163293094540736113 748386665131395511920 757610037168250287727 766833409205105063534 776056781241959839341 785280153278814615148 794503525315669390955 803726897352524166762 812950269389378942569 822173641426233718376 831397013463088494183 840620385499943269990 849843757536798045797 859067129573652821604 868290501610507597411 877513873647362373218 886737245684217149025 895960617721071924832 905183989757926700639 914407361794781476446 923630733831636252253 932854105868491028060 942077477905345803867 951300849942200579674 960524221979055355481 969747594015910131288 978970966052764907095 988194338089619682902 997417710126474458709 ',
            Error: 'befunge_error_infinite_loop',
            BefungeStack: [], PC: [], Command: [], Mnemonic: [])},

      {'code' : '0.1>:.:00p+00g\\v\n' +
                '^           <',
        'input' : '',
        'expectedOutput' :
        BefungeOutput(
            Output: '0 1 ',
            Error: 'befunge_error_infinite_loop',
            BefungeStack: [], PC: [], Command: [], Mnemonic: [])},
      {'code' : '4 3 + . @',
        'input' : '',
        'expectedOutput' :
        BefungeOutput(Output: '7 ', Error: '', BefungeStack: [], PC: [], Command: [], Mnemonic: [])},
      {'code' : 'v   > . v\n' +
                '         \n' +
                '4   +   @\n' +
                '         \n' +
                '> 3 ^',
        'input' : '',
        'expectedOutput' :
        BefungeOutput(
            Output: '7 ',
            Error: '',
            BefungeStack: [], PC: [], Command: [], Mnemonic: [])},
      {'code' : 'v*>.v\n' +
                '4*+*@\n' +
                '>3^**',
        'input' : '',
        'expectedOutput' :
        BefungeOutput(
            Output: '7 ',
            Error: '',
            BefungeStack: [], PC: [], Command: [], Mnemonic: [])},
      {'code' : '"!dlroW olleH"v\n' +
                '@,,,,,,,,,,,,,<',
        'input' : '',
        'expectedOutput' :
        BefungeOutput(
            Output: 'Hello World!\x00',
            Error: '',
            BefungeStack: [], PC: [], Command: [], Mnemonic: [])},
      {'code' : '"!dlrow olleH">:#,_@',
        'input' : '',
        'expectedOutput' :
        BefungeOutput(
            Output: 'Hello world!',
            Error: '',
            BefungeStack: [], PC: [], Command: [], Mnemonic: [])},

      // https://github.com/catseye/Befunge-93/blob/master/eg/befunge2.bf
      {'code' : '<>: #+1 #:+ 3 : *6+ \$#2 9v#\n' +
                'v 7 :   +   8 \\ + + 5   <\n' +
                '>-  :2  -:  " " 1 + \\ v ^<\n' +
                '2 + :   7   + : 7 + v > :\n' +
                ':1- :3- >   :#, _ @ >:3 5*-',
        'input' : '',
        'expectedOutput' :
        BefungeOutput(
            Output: 'BEFUNGE!EGNUFEB',
            Error: '',
            BefungeStack: [], PC: [], Command: [], Mnemonic: [])},

      // https://github.com/catseye/Befunge-93/blob/master/eg/chars.bf
/*
25*3*4+>:."=",:,25*,1+:88*2*-#v_@\n
       ^                      <
*/
      {'code' : '25*3*4+>:."=",:,25*,1+:88*2*-#v_@\n' +
                '^                             <',
        'input' : '',
        'expectedOutput' :
        BefungeOutput(
            Output: '34 ="\n35 =#\n36 =\$\n37 =%\n38 =&\n39 =\'\n40 =(\n41 =)\n42 =*\n43 =+\n44 =,\n45 =-\n46 =.\n47 =/\n48 =0\n49 =1\n50 =2\n51 =3\n52 =4\n53 =5\n54 =6\n55 =7\n56 =8\n57 =9\n58 =:\n59 =;\n60 =<\n61 ==\n62 =>\n63 =?\n64 =@\n65 =A\n66 =B\n67 =C\n68 =D\n69 =E\n70 =F\n71 =G\n72 =H\n73 =I\n74 =J\n75 =K\n76 =L\n77 =M\n78 =N\n79 =O\n80 =P\n81 =Q\n82 =R\n83 =S\n84 =T\n85 =U\n86 =V\n87 =W\n88 =X\n89 =Y\n90 =Z\n91 =[\n92 =\\\n93 =]\n94 =^\n95 =_\n96 =`\n97 =a\n98 =b\n99 =c\n100 =d\n101 =e\n102 =f\n103 =g\n104 =h\n105 =i\n106 =j\n107 =k\n108 =l\n109 =m\n110 =n\n111 =o\n112 =p\n113 =q\n114 =r\n115 =s\n116 =t\n117 =u\n118 =v\n119 =w\n120 =x\n121 =y\n122 =z\n123 ={\n124 =|\n125 =}\n126 =~\n127 =',
            Error: '',
            BefungeStack: [], PC: [], Command: [], Mnemonic: [])},

      // https://github.com/catseye/Befunge-93/blob/master/eg/fact2.bf
/*
vv    <>v *<
&>:1-:|\$>\\:|
>^    >^@.\$<
*/
      {'code' : 'vv    <>v *<\n' +
                '&>:1-:|\$>\\:|\n' +
                '>^    >^@.\$<',
        'input' : '7',
        'expectedOutput' :
        BefungeOutput(
            Output: '5040 ',
            Error: '',
            BefungeStack: [], PC: [], Command: [], Mnemonic: [])},

  // https://github.com/catseye/Befunge-93/blob/master/eg/numer.bf
/*
000p>~:25*-!#v_"a"-1+00g+00p> 00g9`#v_v
        @.g00<  vp00+%*52g00 /*52g00<
    ^           >#          ^#        <
*/*/
      {'code' : '000p>~:25*-!#v_"a"-1+00g+00p> 00g9`#v_v\n' +
                '        @.g00<  vp00+%*52g00 /*52g00<  \n' +
                '    ^           >#          ^#        <',
        'input' : '7',
        'expectedOutput' :
        BefungeOutput(
            Output: '0 ',
            Error: '',
            BefungeStack: [], PC: [], Command: [], Mnemonic: [])},

      // https://esolangs.org/w/index.php?title=Talk:Befunge&oldid=38327
/*
00:.1:.>:"@"8**++\1+:67+`#@_v
       ^ .:\/*8"@"\%*8"@":\ <
*/*/
      {'code' : '00:.1:.>:"@"8**++\\1+:67+`#@_v\n' +
                '       ^ .:\\/*8"@"\\%*8"@":\\ <\n',
        'input' : '',
        'expectedOutput' :
        BefungeOutput(
            Output: '0 1 1 2 3 5 8 13 21 34 55 89 144 233 377 ',
            Error: '',
            BefungeStack: [], PC: [], Command: [], Mnemonic: [])},


      // https://github.com/catseye/Befunge-93/blob/master/eg/ea.bf
/*
   100p            v
    v"love"0     <
    v"power"0   <
    v"strength"0?^#<            <
    v"success"0 ?v
    v"agony"0   <
    >v"beauty"0   <>025*"." 1v v_^
    ,:      >00g2- |        v< #:
    ^_,00g1-|      >0" fo "3>00p^<
    >0" eht si "2   ^  >,^
*/
/*  // Does not work as a Testcase because of the random Element
      {'code' : '100p            v\n' +
               ' v"love"0     <\n' +
               ' v"power"0   <\n' +
               ' v"strength"0?^#<            <\n' +
               ' v"success"0 ?v\n' +
               ' v"agony"0   <\n' +
               ' >v"beauty"0   <>025*"." 1v v_^\n' +
               ' ,:      >00g2- |        v< #:\n' +
               ' ^_,00g1-|      >0" fo "3>00p^<\n' +
               ' >0" eht si "2   ^  >,^',
        'input' : '',
        'expectedOutput' :
        BefungeOutput(
            Output: '',
            Error: '',
            BefungeStack: [], PC: [], Command: [], Mnemonic: [])},
*/

      // self generated
/*
>43*7+3*87*83+5*69*68*5+94+2*2*98+3*55+5*77*86*v
v                                              >
>52*52**0*52*1*0++1+>1-:v
                    ^,\ _@
*/
    {'code' : '>43*7+3*87*83+5*69*68*5+94+2*2*98+3*55+5*77*86*v\n' +
              'v                                              >\n' +
              '>52*52**0*52*1*0++1+>1-:v\n' +
              '                    ^,\\ _@',
      'input' : '',
      'expectedOutput' :
      BefungeOutput(
          Output: '0123456789',
          Error: '',
          BefungeStack: [], PC: [], Command: [], Mnemonic: [])},
    // prints UNICODE Table from 32 .. 47
    {'code' : 'v   v               <\n' +
              '>84*>::.,5:+,1+:77*-|\n' +
              '@                   <',
      'input' : '',
      'expectedOutput' :
      BefungeOutput(
          Output: '32  \n33 !\n34 "\n35 #\n36 \$\n37 %\n38 &\n39 \'\n40 (\n41 )\n42 *\n43 +\n44 ,\n45 -\n46 .\n47 /\n48 0\n',
        //Output: '',
          Error: '',
          BefungeStack: [], PC: [], Command: [], Mnemonic: [])},

    ];




    _inputsToExpected.forEach((elem) {
      test('code: ${elem['code']}, input: ${elem['input']}', () {
        var _actual = interpretBefunge(elem['code'], input: elem['input']);
        expect(_actual.Output, elem['expectedOutput'].Output);
        expect(_actual.Error, elem['expectedOutput'].Error);
      });
    });
  });
}