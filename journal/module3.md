Imperative constructs:
- variables & assignments:
    - Declaration: let x; or let x = 5;
    - Reassignment: x = x + 2;
    - Variables mutable by default
 - { .. } creates nested block/scope
 - if statement: if (expr) stmt / else stmt (optional)
 - while loop: while (expr) stmt
 - no explicit for loop at this time; while loop can be used for this purpose
 - print statment: print(expr);
 - true/false, unary ! and -, mathematical operators, comparisons, equality, logical and/or, and grouping with parentheses

State & memory management:
- identifiers map to specific memory locations; assignments update the values stored at those locations
- expressions evaluate left-to-right
- blocks create new scope for declarations

Sequential logic/control flow:
- statements execute top-to-bottom within the block
- if binds to the nearest else
- while loop repeats until the condition is false or break is indicated

Main program example:

// Declare and initialize
let total = 0;
let i = 1;

// Sum 1..5 with a while loop
while (i <= 5) {
  total = total + i;
  i = i + 1;
}

// Conditional reporting
if (total == 15) {
  print("ok: total is 15");
} else {
  print("unexpected total = " + total);
}

// Simple boolean logic
let a = true;
let b = false;
if (a and (b or (total > 10))) {
  print("logic branch taken");
}
