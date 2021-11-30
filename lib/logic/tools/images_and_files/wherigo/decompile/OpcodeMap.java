class OpcodeMap
{
  List<Op> map;

  OpcodeMap(int version)
  {
    if (version == 80) {
      map = new List<Op>(35);
      map[0] = Op_.MOVE;
      map[1] = Op_.LOADK;
      map[2] = Op_.LOADBOOL;
      map[3] = Op_.LOADNIL;
      map[4] = Op_.GETUPVAL;
      map[5] = Op_.GETGLOBAL;
      map[6] = Op_.GETTABLE;
      map[7] = Op_.SETGLOBAL;
      map[8] = Op_.SETUPVAL;
      map[9] = Op_.SETTABLE;
      map[10] = Op_.NEWTABLE50;
      map[11] = Op_.SELF;
      map[12] = Op_.ADD;
      map[13] = Op_.SUB;
      map[14] = Op_.MUL;
      map[15] = Op_.DIV;
      map[16] = Op_.POW;
      map[17] = Op_.UNM;
      map[18] = Op_.NOT;
      map[19] = Op_.CONCAT;
      map[20] = Op_.JMP;
      map[21] = Op_.EQ;
      map[22] = Op_.LT;
      map[23] = Op_.LE;
      map[24] = Op_.TEST50;
      map[25] = Op_.CALL;
      map[26] = Op_.TAILCALL;
      map[27] = Op_.RETURN;
      map[28] = Op_.FORLOOP;
      map[29] = Op_.TFORLOOP;
      map[30] = Op_.TFORPREP;
      map[31] = Op_.SETLIST50;
      map[32] = Op_.SETLISTO;
      map[33] = Op_.CLOSE;
      map[34] = Op_.CLOSURE;
    } else {
      if (version == 81) {
        map = new List<Op>(38);
        map[0] = Op_.MOVE;
        map[1] = Op_.LOADK;
        map[2] = Op_.LOADBOOL;
        map[3] = Op_.LOADNIL;
        map[4] = Op_.GETUPVAL;
        map[5] = Op_.GETGLOBAL;
        map[6] = Op_.GETTABLE;
        map[7] = Op_.SETGLOBAL;
        map[8] = Op_.SETUPVAL;
        map[9] = Op_.SETTABLE;
        map[10] = Op_.NEWTABLE;
        map[11] = Op_.SELF;
        map[12] = Op_.ADD;
        map[13] = Op_.SUB;
        map[14] = Op_.MUL;
        map[15] = Op_.DIV;
        map[16] = Op_.MOD;
        map[17] = Op_.POW;
        map[18] = Op_.UNM;
        map[19] = Op_.NOT;
        map[20] = Op_.LEN;
        map[21] = Op_.CONCAT;
        map[22] = Op_.JMP;
        map[23] = Op_.EQ;
        map[24] = Op_.LT;
        map[25] = Op_.LE;
        map[26] = Op_.TEST;
        map[27] = Op_.TESTSET;
        map[28] = Op_.CALL;
        map[29] = Op_.TAILCALL;
        map[30] = Op_.RETURN;
        map[31] = Op_.FORLOOP;
        map[32] = Op_.FORPREP;
        map[33] = Op_.TFORLOOP;
        map[34] = Op_.SETLIST;
        map[35] = Op_.CLOSE;
        map[36] = Op_.CLOSURE;
        map[37] = Op_.VARARG;
      } else {
        if (version == 82) {
          map = new List<Op>(40);
          map[0] = Op_.MOVE;
          map[1] = Op_.LOADK;
          map[2] = Op_.LOADKX;
          map[3] = Op_.LOADBOOL;
          map[4] = Op_.LOADNIL;
          map[5] = Op_.GETUPVAL;
          map[6] = Op_.GETTABUP;
          map[7] = Op_.GETTABLE;
          map[8] = Op_.SETTABUP;
          map[9] = Op_.SETUPVAL;
          map[10] = Op_.SETTABLE;
          map[11] = Op_.NEWTABLE;
          map[12] = Op_.SELF;
          map[13] = Op_.ADD;
          map[14] = Op_.SUB;
          map[15] = Op_.MUL;
          map[16] = Op_.DIV;
          map[17] = Op_.MOD;
          map[18] = Op_.POW;
          map[19] = Op_.UNM;
          map[20] = Op_.NOT;
          map[21] = Op_.LEN;
          map[22] = Op_.CONCAT;
          map[23] = Op_.JMP;
          map[24] = Op_.EQ;
          map[25] = Op_.LT;
          map[26] = Op_.LE;
          map[27] = Op_.TEST;
          map[28] = Op_.TESTSET;
          map[29] = Op_.CALL;
          map[30] = Op_.TAILCALL;
          map[31] = Op_.RETURN;
          map[32] = Op_.FORLOOP;
          map[33] = Op_.FORPREP;
          map[34] = Op_.TFORCALL;
          map[35] = Op_.TFORLOOP;
          map[36] = Op_.SETLIST;
          map[37] = Op_.CLOSURE;
          map[38] = Op_.VARARG;
          map[39] = Op_.EXTRAARG;
        } else {
          map = new List<Op>(47);
          map[0] = Op_.MOVE;
          map[1] = Op_.LOADK;
          map[2] = Op_.LOADKX;
          map[3] = Op_.LOADBOOL;
          map[4] = Op_.LOADNIL;
          map[5] = Op_.GETUPVAL;
          map[6] = Op_.GETTABUP;
          map[7] = Op_.GETTABLE;
          map[8] = Op_.SETTABUP;
          map[9] = Op_.SETUPVAL;
          map[10] = Op_.SETTABLE;
          map[11] = Op_.NEWTABLE;
          map[12] = Op_.SELF;
          map[13] = Op_.ADD;
          map[14] = Op_.SUB;
          map[15] = Op_.MUL;
          map[16] = Op_.MOD;
          map[17] = Op_.POW;
          map[18] = Op_.DIV;
          map[19] = Op_.IDIV;
          map[20] = Op_.BAND;
          map[21] = Op_.BOR;
          map[22] = Op_.BXOR;
          map[23] = Op_.SHL;
          map[24] = Op_.SHR;
          map[25] = Op_.UNM;
          map[26] = Op_.BNOT;
          map[27] = Op_.NOT;
          map[28] = Op_.LEN;
          map[29] = Op_.CONCAT;
          map[30] = Op_.JMP;
          map[31] = Op_.EQ;
          map[32] = Op_.LT;
          map[33] = Op_.LE;
          map[34] = Op_.TEST;
          map[35] = Op_.TESTSET;
          map[36] = Op_.CALL;
          map[37] = Op_.TAILCALL;
          map[38] = Op_.RETURN;
          map[39] = Op_.FORLOOP;
          map[40] = Op_.FORPREP;
          map[41] = Op_.TFORCALL;
          map[42] = Op_.TFORLOOP;
          map[43] = Op_.SETLIST;
          map[44] = Op_.CLOSURE;
          map[45] = Op_.VARARG;
          map[46] = Op_.EXTRAARG;
        }
      }
    }
  }

  Op get(int opNumber)
  {
    if ((opNumber >= 0) && (opNumber < map.length)) {
      return map[opNumber];
    } else {
      return null;
    }
  }
}