// Copyright (c) 2006, Adam Dunkels
// All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions
// are met:
// 1. Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright
// notice, this list of conditions and the following disclaimer in the
// documentation and/or other materials provided with the distribution.
// 3. The name of the author may not be used to endorse or promote
// products derived from this software without specific prior
// written permission.
// THIS SOFTWARE IS PROVIDED BY THE AUTHOR `AS IS' AND ANY EXPRESS
// OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
//     WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
// NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

enum TOKENIZER {
TOKENIZER_ERROR,
TOKENIZER_ENDOFINPUT,
TOKENIZER_NUMBER,
TOKENIZER_STRING,
TOKENIZER_VARIABLE,
TOKENIZER_LET,
TOKENIZER_PRINT,
TOKENIZER_IF,
TOKENIZER_THEN,
TOKENIZER_ELSE,
TOKENIZER_FOR,
TOKENIZER_TO,
TOKENIZER_NEXT,
TOKENIZER_GOTO,
TOKENIZER_GOSUB,
TOKENIZER_RETURN,
TOKENIZER_CALL,
TOKENIZER_REM,
TOKENIZER_PEEK,
TOKENIZER_POKE,
TOKENIZER_END,
TOKENIZER_COMMA,
TOKENIZER_SEMICOLON,
TOKENIZER_PLUS,
TOKENIZER_MINUS,
TOKENIZER_AND,
TOKENIZER_OR,
TOKENIZER_ASTR,
TOKENIZER_SLASH,
TOKENIZER_MOD,
TOKENIZER_HASH,
TOKENIZER_LEFTPAREN,
TOKENIZER_RIGHTPAREN,
TOKENIZER_LT,
TOKENIZER_GT,
TOKENIZER_EQ,
TOKENIZER_CR,
}

 var current_token = TOKENIZER.TOKENIZER_ERROR;

class KeywordToken{
  String keyword;
  var token;

  KeywordToken(this.keyword, this.token);
}

final List<KeywordToken> keywords = [
  KeywordToken("let", TOKENIZER.TOKENIZER_LET),
  KeywordToken("print", TOKENIZER.TOKENIZER_PRINT),
  KeywordToken("if", TOKENIZER.TOKENIZER_IF),
  KeywordToken("then", TOKENIZER.TOKENIZER_THEN),
  KeywordToken("else", TOKENIZER.TOKENIZER_ELSE),
  KeywordToken("for", TOKENIZER.TOKENIZER_FOR),
  KeywordToken("to", TOKENIZER.TOKENIZER_TO),
  KeywordToken("next", TOKENIZER.TOKENIZER_NEXT),
  KeywordToken("goto", TOKENIZER.TOKENIZER_GOTO),
  KeywordToken("gosub", TOKENIZER.TOKENIZER_GOSUB),
  KeywordToken("return", TOKENIZER.TOKENIZER_RETURN),
  KeywordToken("call", TOKENIZER.TOKENIZER_CALL),
  KeywordToken("rem", TOKENIZER.TOKENIZER_REM),
  KeywordToken("peek", TOKENIZER.TOKENIZER_PEEK),
  KeywordToken("poke", TOKENIZER.TOKENIZER_POKE),
  KeywordToken("end", TOKENIZER.TOKENIZER_END),
  KeywordToken(null, TOKENIZER.TOKENIZER_ERROR)
];

TOKENIZER singlechar(String c) {
  if (c == '\n') {
    return TOKENIZER.TOKENIZER_CR;
  } else if(c == ',') {
    return TOKENIZER.TOKENIZER_COMMA;
  } else if(c == ';') {
    return TOKENIZER.TOKENIZER_SEMICOLON;
  } else if(c == '+') {
   return TOKENIZER.TOKENIZER_PLUS;
  } else if(c == '-') {
   return TOKENIZER.TOKENIZER_MINUS;
  } else if(c == '&') {
    return TOKENIZER.TOKENIZER_AND;
  } else if(c == '|') {
   return TOKENIZER.TOKENIZER_OR;
  } else if(c == '*') {
    return TOKENIZER.TOKENIZER_ASTR;
  } else if(c == '/') {
   return TOKENIZER.TOKENIZER_SLASH;
  } else if(c == '%') {
   return TOKENIZER.TOKENIZER_MOD;
  } else if(c == '(') {
    return TOKENIZER.TOKENIZER_LEFTPAREN;
  } else if(c == '#') {
   return TOKENIZER.TOKENIZER_HASH;
  } else if(c == ')') {
   return TOKENIZER.TOKENIZER_RIGHTPAREN;
  } else if(c == '<') {
   return TOKENIZER.TOKENIZER_LT;
  } else if(c == '>') {
   return TOKENIZER.TOKENIZER_GT;
  } else if(c == '=') {
   return TOKENIZER.TOKENIZER_EQ;
  }
  return TOKENIZER.TOKENIZER_ERROR;
}


String interpretBasic(String program, String STDIN){

  return '';
}