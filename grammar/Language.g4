grammar Language;

// parser rules

program : stmt* EOF ;

stmt
  : varDecl
  | constDecl
  | assignStmt
  | funcDecl
  | return Stmt
  | printStmt
  | ifStmt
  | whileStmt
  | block
  | BREAK ';'
  | CONTINUE ';'
  ;

varDecl     : LET ID ('=' expr)? ';' ;
constDecl   : CONST ID '=' expr ';' ;
assignStmt  : ID '=' expr ';' ;
funcDecl    : purity? FUN ID '(' paramList? ')' block ;
paramList   : ID (',' ID)* ;
purity      : PURE ;
returnStmt  : RETURN expr? ';' ;
printStmt   : PRINT '(' expr ')' ';' ;
ifStmt      : IF '(' expr ')' stmt (ELSE stmt)? ;
whileStmt   : WHILE '(' expr ')' stmt ;
block       : '{' stmt* '}' ;

// Expression precedence: or > and > equality > comparison > term > factor > unary > primary
expr        : orExpr ;
orExpr      : andExpr ( OR andExpr )* ;
andExpr     : equality ( AND equality )* ;
equality    : comparison ( ( '==' | '!=' ) comparison )* ;
comparison  : term ( ( '<' | '<=' | '>' | '>=' ) term )* ;
term        : factor ( ( '+' | '-' ) factor )* ;
factor      : unary ( ( '*' | '/' | '%' ) unary )* ;
unary       : ( '!' | '-' ) unary | primary ;
call        : primary ( '(' argList? ')' )* ;
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
lambdaExpr  : '(' paramList? ')' '=>' (expr | block) ; // (x,y)=>x+y or ()=>{ ... }

// lexer rules

LET      : 'let';
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
ID       : [a-zA-Z_] [a-zA-Z_0-9]* ;
NUMBER   : [0-9]+ ('.' [0-9]+)? ;
STRING   : '"' ( ~["\\] | '\\' . )* '"' ;

WS      : [ \t\r\n]+ -> skip ;
LINE_COMMENT : '//' ~[\r\n]* -> skip ;
BLOCK_COMMENT: '/*' .*? '*/' -> skip ;
