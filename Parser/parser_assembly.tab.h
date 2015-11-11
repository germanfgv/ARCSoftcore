/* A Bison parser, made by GNU Bison 2.5.  */

/* Bison interface for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2011 Free Software Foundation, Inc.
   
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


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     BEGIN = 258,
     END = 259,
     ORG = 260,
     LD = 261,
     ADD = 262,
     ADDCC = 263,
     ST = 264,
     REG_R1 = 265,
     REG_R2 = 266,
     REG_R3 = 267,
     REG_R4 = 268,
     REG_R5 = 269,
     REG_R6 = 270,
     REG_R7 = 271,
     REG_R8 = 272,
     REG_R9 = 273,
     REG_R10 = 274,
     REG_R11 = 275,
     REG_R12 = 276,
     REG_R13 = 277,
     REG_R14 = 278,
     REG_R15 = 279,
     COMMA = 280,
     COLON = 281,
     SEMICOLON = 282,
     LEFT_SQ_BR = 283,
     RIGHT_SQ_BR = 284,
     NAME = 285,
     intval = 286,
     INT = 287
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 2068 of yacc.c  */
#line 6 "parser_assembly.y"

	int intval;
	struct symtab *symp;



/* Line 2068 of yacc.c  */
#line 89 "parser_assembly.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


