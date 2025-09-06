# Object-Oriented Design Reflection

## How Object-Oriented Concepts Apply to Our Language

In our language design, we adopt key OOP features as defined in the literature: encapsulation, inheritance, and polymorphism. We support encapsulation by enforcing access control and clear interface boundaries so data hiding is integral to modularity and maintainability. Our approach ensures objects and abstract data types are organized to protect internal structure and expose only authorized operations.

Inheritance is available through single inheritance. This allows creation of hierarchies, enabling code reuse without the ambiguity associated with multiple inheritance. Our derived types inherit data and methods from base types, and can override or extend base behaviors, supporting problem-space modeling and rapid modification, as recommended for modern languages.

Polymorphism is accomplished through dynamic method binding and static type hierarchies. Our classes provide virtual methods and abstract interfaces so objects may be manipulated in generic contexts. This allows us to support flexible, extensible systems where common operations can be dispatched to specialized implementations at runtime.

## OOP Features We Include, Modify, or Exclude

**Included Features:**
- Single inheritance for clear class hierarchies and safe modeling
- Access control (private, public, protected modifiers) for strong encapsulation
- Abstract types and interfaces to encourage modular and reusable code
- Dynamic method binding for polymorphic behaviour

**Modified Features:**
- Constructors and destructors are simplified, making initialization and cleanup predictable and explicit for all objects
- Expose only necessary methods and variables, limiting data exposure to prevent aliasing and maintain reliability

**Excluded Features:**
- Multiple inheritance is not implemented to avoid diamond inheritance complexity and ambiguous base member resolution
- Deep inheritance trees (limited to three-four levels) for manageability
- Operator overloading is not supported, so code remains readable and consistent

These choices come directly from the trade-offs described in reliable systems design: we prioritize clarity, maintainability, and reduced error risk over theoretical flexibility.

## Challenges Encountered in Modeling OOP

When designing our approach, several textbook challenges surfaced:

- Ensuring reliability and simplicity meant favoring compile-time type checks to catch inconsistencies early, avoiding problems present in some legacy languages.
- Avoiding aliasing, so our data abstraction features prevent dangerous scenarios where multiple names can access the same memory, as flagged in classic design texts.
- Balancing abstraction and dependency: while inheritance solves modification and organization problems, it does introduce dependencies in class hierarchies. We address this by limiting hierarchy depth and promoting composition over inheritance wherever practical.
- Trade-offs in feature inclusion (e.g., not adding overly expressive but hard-to-read constructs like deep operator overloading) keep the language aligned with maintainable, readable, and reliable programming habits.

```
// Example: OOP structure in our language
class Device {
    private id: int
    protected status: string

    public constructor(id: int) {
        this.id = id
        this.status = "offline"
    }

    public virtual setStatus(newStatus: string): void {
        status = newStatus
    }

    public getStatus(): string {
        return status
    }
}

interface Connectable {
    connect(): void
    disconnect(): void
}

class Router extends Device implements Connectable {
    private connections: int

    public constructor(id: int) {
        super(id)
        connections = 0
    }

    public override setStatus(newStatus: string): void {
        super.setStatus(newStatus)
        // Router specific logic
    }

    public connect(): void {
        connections += 1
        setStatus("online")
    }

    public disconnect(): void {
        connections = 0
        setStatus("offline")
    }
}
```

Our language is built to offer clean object modeling, strict encapsulation, predictable inheritance, and robust polymorphism, closely following established principles for modern, maintainable, and readable software.
