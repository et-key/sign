# String and Comment Syntax in Sign

## 1. Comments

Comments begin with a backtick (`` ` ``) at the start of a line or expression:

```sign
` This is a single-line comment in Sign
add : x y ? x + y ` Inline comment
```

---

## 2. String Literals

String literals are enclosed in backticks (`` `...` ``) and represent lists of `Char`:

```sign
greeting : `Hello, Sign!`
```

Character escape sequences use a backslash (e.g. `\n`, `\t`, `\\`).
