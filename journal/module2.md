The goal of this language (temporarily named "Language") is to use grammar that is beginner-friendly and easy to learn and understand for people with little to no programming experience.

Grammar rules:
- variable declarations (eg. let x = 5;)
- assignments (eg. x = x + 1;)
- print statements (eg. print("hello world");)
- if/else statements with optional blocks
- while loops
- blocks for grouping multiple statements
- expressions (numbers, strings, identifiers, boolean literals, arithmetic operators, comparisons, equality, and logical operators)
- lexer rules for identifiers, numbers, strings, whitespace, and comments

Ambiguities:
Dangling else problem: if blocks are not specified, else attaches to the nearest if.
Unary operators fall under a separate unary rule.

Left recursion:
To avoid instances of left recursion, we use a layered expression design to implement the following precedence: or > and > equality > comparison > term > factor > unary > primary. This ensures that standard PEMDAS rules are followed when parentheses are not used in the expression.

Implementation with ANTLR:
After some troubleshooting, ANTLR was able to generate code successfully and create support files inside gen/grammar/ that allowed the program to function as expected. We were able to generate a GUI parse tree that verified correct functioning of our grammar.

What I Learned About Syntax Definition and Parser Behavior:
- When learning a robust programming language like Java or C++, it's easy to overlook small design choices like operator precedence; however, all these small choices matter when designing a grammar because they can drastically change parse results.
- ANTLR's ALL(*) parser can resolve some ambiguities like the dangling else without having to directly specify what to do.
- Whitespace and comments should be handled in the lexer to avoid cluttering up parser rules.

Generative AI was used in the development process for troubleshooting, debugging, and help with creating relevant test files
