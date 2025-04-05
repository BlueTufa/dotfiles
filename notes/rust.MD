# Notes about the Rust language

* supports tuples (T, T) is a tuple of type T.
* supports pattern matching
* unit return type = (), similar to void in Java and Unit in Scala
* Supports options with Some and None.
* Enums are algebraic data types.
* Falliable functions should return a Result value.
* `!` suffix on a name indicates that it is a macro.

## The `?` operator:
This ? operator exists as a shortcut to writing: 
```rust
let output = match File::create(filename) {
    Ok(f) => { f }
    Err(e) => { return Err(e); }
};
```
However, the ? does not work in the main function because the main function does not have a return value.

## The `vec!` macro:
The macro call vec![v; n] create a vector n elements long with the elements initialized to v.  