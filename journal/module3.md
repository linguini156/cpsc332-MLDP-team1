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

Memory Lifecycle Details:
- **Variable creation**: Variables come into existence when `let` is encountered
- **Scope management**: Each `{...}` block creates a new scope that inherits from its parent
- **Automatic cleanup**: Variables are automatically deallocated when leaving their scope
- **Expression temporaries**: Intermediate values in expressions are handled automatically
  
Sequential logic/control flow:
- statements execute top-to-bottom within the block
- if binds to the nearest else
- while loop repeats until the condition is false or break is indicated

Execution Model Details:
- **Sequential execution**: Statements execute in textual order within blocks
- **Conditional branching**: `if` statements can alter execution flow based on boolean expressions
- **Loop iteration**: `while` loops repeat until condition becomes false
- **Block boundaries**: `{...}` creates execution contexts with local variable visibility


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

//Nested Scope Example:
let outer = 10;
{
let inner = 20;
let total = outer + inner; // Can access both outer and inner
print("Inner scope: " + total);

   if (total > 25) {
       let temp = total * 2;    // Another nested scope
       print("Deep scope: " + temp);
   }
   // temp is no longer accessible here
}
// inner and total are no longer accessible here
print("Outer scope: " + outer);

Implementation Section:

**Implementation Considerations:**
This imperative design builds on our Module 2 grammar work, where we established operator precedence (or > and > equality > comparison > term > factor > unary > primary) and resolved the dangling else ambiguity. The layered expression structure from our parse tree directly supports the left-to-right evaluation model described above.

**Performance characteristics:**
- Variable access: O(1) lookup within current scope using symbol tables
- Scope resolution: Linear search through scope chain for inherited variables  
- Memory efficiency: Stack allocation for local variables ensures automatic cleanup

