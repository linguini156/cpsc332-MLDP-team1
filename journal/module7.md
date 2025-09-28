Procedures & Functions:

Sprout uses a single declaration form with an optional return type, as well as an optional PURE modifier.

Procedure:
FUN name(params) { ... }

Function:
FUN name(params): type { ... }

Parameters can optionally be annotated with static types or marked dynamic for runtime typing. If types are not annotated, they are inferred by the compiler.

FUN f(x: int, dynamic y) {
  print(x + y);        // y is checked at runtime
}

We implemented static scoping as it's easier to learn and debug for beginners. 

LET x: int = 10;

FUN demo() {
  LET x: int = 3;      // shadows outer x
  {
    LET y = x + 1;     // y = 4; sees nearest x (3)
    print(y);
  }
  // y is out of scope here
  print(x);            // prints 3
}

print(x);              // prints 10 (outer x)

Parameter Passing:

- By value for scalars and immutable types
- By reference for compound values like arrays and function values
- No call by name

// By value (scalars)
FUN incCopy(n: int) {
  n = n + 1;           // modifies local copy only
}

LET a = 10;
incCopy(a);
print(a);              // 10 (unchanged)

// Reference semantics (arrays)
FUN fillOnes(xs: int[]) {
  LET i = 0;
  while (i < len(xs)) {
    xs[i] = 1;         // mutates caller-visible array
    i = i + 1;
  }
}

LET arr = [0,0,0];
fillOnes(arr);
print(arr);            // [1,1,1]
