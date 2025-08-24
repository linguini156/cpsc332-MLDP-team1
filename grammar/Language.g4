grammar Language;

// parser rules

program : stmt* EOF ;

stmt
  : varDecl
  | assignStmt
  | printStmt
  | ifStmt
  | whileStmt
  | block
  ;

varDecl     : 'let' ID ('=' expr)? ';' ;
assignStmt  : ID '=' expr ';' ;
printStmt   : 'print' '(' expr ')' ';' ;
ifStmt      : 'if' '(' expr ')' stmt ('else' stmt)? ;   // nearest-else
whileStmt   : 'while' '(' expr ')' stmt ;
block       : '{' stmt* '}' ;

// Expression precedence: or > and > equality > comparison > term > factor > unary > primary
expr        : orExpr ;
orExpr      : andExpr ( 'or' andExpr )* ;
andExpr     : equality ( 'and' equality )* ;
equality    : comparison ( ( '==' | '!=' ) comparison )* ;
comparison  : term ( ( '<' | '<=' | '>' | '>=' ) term )* ;
term        : factor ( ( '+' | '-' ) factor )* ;
factor      : unary ( ( '*' | '/' | '%' ) unary )* ;
unary       : ( '!' | '-' ) unary | primary ;
primary     : NUMBER
            | STRING
            | 'true'
            | 'false'
            | ID
            | '(' expr ')'
            ;

// lexer rules

ID      : [a-zA-Z_] [a-zA-Z_0-9]* ;
NUMBER  : [0-9]+ ('.' [0-9]+)? ;
STRING  : '"' ( ~["\\] | '\\' . )* '"' ;

WS      : [ \t\r\n]+ -> skip ;
LINE_COMMENT : '//' ~[\r\n]* -> skip ;
BLOCK_COMMENT: '/*' .*? '*/' -> skip ;
