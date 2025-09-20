# Type Systems and Memory Reflection – Team 1

## Type System Design

Our custom programming language will implement a **hybrid type system** combining static type declarations with optional dynamic features. The language will be **statically and strongly typed** as the primary approach, ensuring type safety and compile-time error detection. This provides the reliability benefits of languages like Java and C# while maintaining performance advantages through compile-time optimization.

However, we will include a special `dynamic` keyword that allows programmers to opt into dynamic typing for specific variables when needed. This provides flexibility for rapid prototyping and interoperability scenarios while preserving the safety of static typing for the majority of code.

**Key Features:**
- Static type binding by default with compile-time checking
- Strong typing prevents implicit type coercion that could cause errors
- Optional `dynamic` keyword for runtime type flexibility
- Type inference capabilities to reduce verbosity while maintaining safety
- Explicit casting required for type conversions, preventing accidental errors

## Memory Management Strategy

Our language will employ **automatic memory management** using a combination of reference counting and mark-and-sweep garbage collection. This hybrid approach balances performance with programmer convenience.

**Memory Allocation:**
- Stack allocation for primitive types and local variables
- Heap allocation for objects and dynamic data structures
- Reference counting for immediate deallocation of unreachable objects
- Mark-and-sweep garbage collection for handling circular references

**Memory Categories:**
- **Static variables:** Allocated at compile time with lifetime extending through program execution
- **Stack-dynamic variables:** Allocated on function entry, deallocated on exit
- **Heap-dynamic variables:** Allocated/deallocated dynamically as needed

This approach eliminates manual memory management complexity while providing predictable performance characteristics.

## Memory Layout Visualization

```
MEMORY LAYOUT DIAGRAM

HIGH ADDRESSES
┌─────────────────────┐
│      HEAP           │ ← Dynamic objects, garbage collected
│   (grows down)      │   Reference counted + mark-sweep
├─────────────────────┤
│                     │
│    FREE SPACE       │
│                     │
├─────────────────────┤
│      STACK          │ ← Local variables, parameters
│    (grows up)       │   Automatic deallocation on scope exit
├─────────────────────┤
│   STATIC DATA       │ ← Global variables, string literals
│    SEGMENT          │   Allocated at compile time
├─────────────────────┤
│   CODE SEGMENT      │ ← Program instructions
│   (Read Only)       │   Contains compiled bytecode
└─────────────────────┘
LOW ADDRESSES

TYPE CHECKING EXAMPLE:

// Static typing with type inference
let name = "Alice"        // inferred as String
let age: Int = 25         // explicit type declaration
let score = 95.5          // inferred as Float

// Dynamic typing when needed
dynamic var data = getValue() // type determined at runtime
if (data is String) {
    print("Got string: " + data)
}

// Strong typing prevents errors
// age + name  // COMPILE ERROR: cannot add Int and String
```

This design provides the safety and performance of static typing while offering dynamic capabilities when flexibility is essential. The memory management system ensures reliable operation without burdening programmers with manual allocation concerns.
