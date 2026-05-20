---
name: clean-code
description: Review and refactor Dart/Flutter code for production quality — less verbose, smarter, cleaner. Use before committing or when you want tighter, idiomatic code.
---

# Clean Code Review Skill

Claude's default output can be verbose for exploration; this skill enforces concise, idiomatic Dart/Flutter patterns.

## Instructions

When reviewing code, apply these principles:

### 1. Eliminate Verbosity

**Remove unnecessary comments:**
```dart
// BAD - Comment states the obvious
// Initialize the user service
final userService = UserService();

// GOOD - Code is self-documenting
final userService = UserService();
```

**Only comment when:**
- Explaining *why*, not *what*
- Documenting non-obvious business logic
- Warning about gotchas or edge cases

**Prefer expression bodies:**
```dart
// Verbose
String get name {
  return _name;
}

// Clean
String get name => _name;
```

**Use collection literals and spreads:**
```dart
// Verbose
final list = <String>[];
list.add('a');
list.add('b');

// Clean
final list = ['a', 'b'];
```

### 2. Dart/Flutter Idioms

**Prefer `final` over `var` when possible.**

**Use cascade notation:**
```dart
// Verbose
controller.addListener(listener);
controller.forward();

// Clean
controller
  ..addListener(listener)
  ..forward();
```

**Use null-aware operators:**
```dart
// Verbose
if (value != null) {
  return value.toString();
}
return 'default';

// Clean
return value?.toString() ?? 'default';
```

**Prefer named constructors for clarity:**
```dart
Widget.loading()
Model.empty()
```

### 3. Remove Dead Code & Over-Engineering

- Delete commented-out code (git has history).
- Remove unused imports, variables, parameters.
- Don't add "just in case" error handling.
- Don't create abstractions for single-use cases.
- Don't add feature flags for things you can just change.

### 4. Simplify Logic

**Early returns over nested ifs:**
```dart
// Verbose
void process(User? user) {
  if (user != null) {
    if (user.isActive) {
      // do work
    }
  }
}

// Clean
void process(User? user) {
  if (user == null) return;
  if (!user.isActive) return;
  // do work
}
```

**Use switch expressions:**
```dart
final label = switch (status) {
  Status.loading => 'Loading...',
  Status.error => 'Error',
  Status.success => 'Done',
};
```

### 5. Review Checklist

When `/clean-code` is invoked, review recent changes for:

- [ ] **Comments**: Remove obvious ones, keep meaningful ones
- [ ] **Verbosity**: Can any code be expressed more concisely?
- [ ] **Dead code**: Any unused imports, vars, or commented code?
- [ ] **Over-engineering**: Any unnecessary abstractions?
- [ ] **Naming**: Are names clear and consistent?
- [ ] **Logic flow**: Can conditionals be simplified?
- [ ] **Dart idioms**: Using language features effectively?
- [ ] **DRY violations**: Any copy-paste that should be extracted?

### 6. Output Format

When reviewing, provide:
1. A brief summary of issues found
2. Specific file:line references
3. Before/after code snippets for each fix
4. Apply the fixes directly (don't just suggest)

## Usage

Invoke with `/clean-code` to review and clean up recent changes.
Invoke with `/clean-code <file-path>` to review a specific file.
