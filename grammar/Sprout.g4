grammar Sprout;

// ----- parser rules -----

program : stmt* EOF ;

stmt
  : varDecl
  | constDecl
  | assignStmt
  | funcDecl
  | returnStmt
  | printStmt
  | ifStmt
  | whileStmt
  | block
  | BREAK ';'
  | CONTINUE ';'
  ;

// Variables: static by default; optional `dynamic` escape hatch
// Inference: omit the :type to infer from initializer (if present)
varDecl     : (LET | VAR) dynamicOpt? ID typeAnnOpt? ('=' expr)? ';' ;
constDecl   : CONST dynamicOpt? ID typeAnnOpt? '=' expr ';' ;
dynamicOpt  : DYNAMIC? ;
typeAnnOpt  : (':' type)? ;
assignStmt  : ID '=' expr ';' ;

// Functions: optional return type; typed params support static typing
// (Dynamic params allowed via `dynamic` modifier on each param)
funcDecl    : purity? FUN ID '(' paramList? ')' (':' type)? block ;
purity      : PURE ;
paramList   : param (',' param)* ;
param       : dynamicOpt? ID typeAnnOpt? ;

returnStmt  : RETURN expr? ';' ;
printStmt   : PRINT '(' expr ')' ';' ;
ifStmt      : IF '(' expr ')' stmt (ELSE stmt)? ;
whileStmt   : WHILE '(' expr ')' stmt ;
block       : '{' stmt* '}' ;

// Expression precedence: or > and > equality > comparison > additive > multiplicative > unary > primary
expr        : orExpr ;
orExpr      : andExpr ( OR andExpr )* ;
andExpr     : equality ( AND equality )* ;
equality    : comparison ( ( '==' | '!=' ) comparison | IS type )* ;
comparison  : additive ( ( '<' | '<=' | '>' | '>=' ) additive )* ;
additive    : multiplicative ( ( '+' | '-' ) multiplicative )* ;
multiplicative
            : unary ( ( '*' | '/' | '%' ) unary )* ;
unary       : ( '!' | '-' ) unary
            | call
            ;

// Function calls (left-assoc), then postfix `as T` cast, and `is T` test at equality level
call        : primary ( '(' argList? ')' )* ( AS type)? ;
argList     : expr (',' expr)* ;
primary     : NUMBER
            | STRING
            | TRUE
            | FALSE
            | ID
            | '(' expr ')'
            | arrayLiteral
            | lambdaExpr
            ;
arrayLiteral: '[' (expr (',' expr)*)? ']' ;
lambdaExpr  : '(' paramList? ')' '=>' (expr | block) ;

// ----- types -----

type        : funcType
            | genericType
            | simpleType
            ;

simpleType  : ID ;
genericType : ID '<' type (',' type)* '>' ;

funcType    : '(' typeListOpt? ')' '->' type ;
typeListOpt : type (',' type)* ;

// ----- lexer rules -----

LET      : 'let';
VAR      : 'var';
CONST    : 'const';
FUN      : 'fun';
PURE     : 'pure';
RETURN   : 'return';
IF       : 'if';
ELSE     : 'else';
WHILE    : 'while';
PRINT    : 'print';
TRUE     : 'true';
FALSE    : 'false';
AND      : 'and';
OR       : 'or';
BREAK    : 'break';
CONTINUE : 'continue';

DYNAMIC  : 'dynamic';
AS       : 'as';
IS       : 'is';

ID       : [a-zA-Z_] [a-zA-Z_0-9]* ;
NUMBER   : [0-9]+ ('.' [0-9]+)? ;
STRING   : '"' ( ~["\\] | '\\' . )* '"' ;

WS      : [ \t\r\n]+ -> skip ;
LINE_COMMENT : '//' ~[\r\n]* -> skip ;
BLOCK_COMMENT: '/*' .*? '*/' -> skip ;
