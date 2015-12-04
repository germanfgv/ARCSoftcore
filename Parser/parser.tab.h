/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_PARSER_TAB_H_INCLUDED
# define YY_YY_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    ORG = 258,
    EQU = 259,
    HALT = 260,
    NOP = 261,
    LD = 262,
    ST = 263,
    SETHI = 264,
    ADD = 265,
    ADDCC = 266,
    SRL = 267,
    SLL = 268,
    SRA = 269,
    AND = 270,
    ANDCC = 271,
    OR = 272,
    ORCC = 273,
    ORNCC = 274,
    BE = 275,
    BNE = 276,
    BCS = 277,
    BCC = 278,
    BNEG = 279,
    BPOS = 280,
    BVS = 281,
    BVC = 282,
    BA = 283,
    JMPL = 284,
    CALL = 285,
    REG_R0 = 286,
    REG_R1 = 287,
    REG_R2 = 288,
    REG_R3 = 289,
    REG_R4 = 290,
    REG_R5 = 291,
    REG_R6 = 292,
    REG_R7 = 293,
    REG_R8 = 294,
    REG_R9 = 295,
    REG_R10 = 296,
    REG_R11 = 297,
    REG_R12 = 298,
    REG_R13 = 299,
    REG_R14 = 300,
    REG_R15 = 301,
    NAME = 302,
    P_INT = 303,
    N_INT = 304,
    COMMA = 305,
    COLON = 306,
    SEMICOLON = 307,
    LEFT_SQ_BR = 308,
    RIGHT_SQ_BR = 309,
    PLUS = 310
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 20 "parser.y" /* yacc.c:1909  */

	char *str;

#line 114 "parser.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */
