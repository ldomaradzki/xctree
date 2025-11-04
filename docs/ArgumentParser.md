# ArgumentParser

**Straightforward, type-safe argument parsing for Swift.**

##### Overview

By using `ArgumentParser`, you can create a command-line interface tool by declaring simple Swift types. Begin by declaring a type that defines the information that you need to collect from the command line. Decorate each stored property with one of `ArgumentParser`‘s property wrappers, declare conformance to Parsable Command, and implement your command’s logic in its `run()` method. For `async` renditions of `run`, declare Async Parsable Command conformance instead.

```swift
import ArgumentParser

@main
struct Repeat: ParsableCommand {
    @Argument(help: "The phrase to repeat.")
    var phrase: String

    @Option(help: "The number of times to repeat 'phrase'.")
    var count: Int? = nil

    mutating func run() throws {
        let repeatCount = count ?? 2
        for _ in 0..<repeatCount {
            print(phrase)
        }
    }
}
```

When a user executes your command, the `ArgumentParser` library parses the command-line arguments, instantiates your command type, and then either calls your `run()` method or exits with a useful message.


###### Additional Resources

- [ArgumentParser on GitHub](https://github.com/apple/swift-argument-parser/)
- [ArgumentParser on the Swift Forums](https://forums.swift.org/c/related-projects/argumentparser/60)

---

## Topics

### Structures

**`struct Argument`**
A property wrapper that represents a positional command-line argument.

> **`init<T>(help: ArgumentHelp?, completion: CompletionKind?)`**
> Creates an optional property that reads its value from an argument.
>
> **`init(help: ArgumentHelp?, completion: CompletionKind?)`**
> Creates a property with no default value.
>
> **`init(help: ArgumentHelp?, completion: CompletionKind?, transform: (String) throws -> Value)`**
> Creates a property with no default value, parsing with the given closure.
>
> **`init<T>(help: ArgumentHelp?, completion: CompletionKind?, transform: (String) throws -> T)`**
> Creates an optional property that reads its value from an argument.
>
> **`init<T>(parsing: ArgumentArrayParsingStrategy, help: ArgumentHelp?, completion: CompletionKind?)`**
> Creates a property with no default value that reads an array from zero or   more arguments.
>
> **`init<T>(parsing: ArgumentArrayParsingStrategy, help: ArgumentHelp?, completion: CompletionKind?, transform: (String) throws -> T)`**
> Creates a property with no default value that reads an array from zero or   more arguments, parsing each element with the given closure.
>
> **`init<T>(wrappedValue: _OptionalNilComparisonType, help: ArgumentHelp?, completion: CompletionKind?)`**
> This initializer allows a user to provide a   default value for an   optional  -marked property without allowing a non-  default   value.
>
> **`init(wrappedValue: Value, help: ArgumentHelp?, completion: CompletionKind?)`**
> Creates a property with a default value provided by standard Swift default   value syntax.
>
> **`init<T>(wrappedValue: _OptionalNilComparisonType, help: ArgumentHelp?, completion: CompletionKind?, transform: (String) throws -> T)`**
> This initializer allows a user to provide a   default value for an   optional  -marked property without allowing a non-  default   value.
>
> **`init(wrappedValue: Value, help: ArgumentHelp?, completion: CompletionKind?, transform: (String) throws -> Value)`**
> Creates a property with a default value provided by standard Swift default   value syntax, parsing with the given closure.
>
> **`init<T>(wrappedValue: [T], parsing: ArgumentArrayParsingStrategy, help: ArgumentHelp?, completion: CompletionKind?)`**
> Creates a property that reads an array from zero or more arguments.
>
> **`init<T>(wrappedValue: [T], parsing: ArgumentArrayParsingStrategy, help: ArgumentHelp?, completion: CompletionKind?, transform: (String) throws -> T)`**
> Creates a property that reads an array from zero or more arguments,   parsing each element with the given closure.
>
> **`wrappedValue: Value`**
> The value presented by this property wrapper.
>
**`struct ArgumentArrayParsingStrategy`**
The strategy to use when parsing multiple values from positional arguments   into an array.

> **`allUnrecognized: ArgumentArrayParsingStrategy`**
> After parsing, capture all unrecognized inputs in this argument array.
>
> **`captureForPassthrough: ArgumentArrayParsingStrategy`**
> Parse all remaining inputs after parsing any known options or flags,   including dash-prefixed inputs and the   terminator.
>
> **`postTerminator: ArgumentArrayParsingStrategy`**
> Before parsing arguments, capture all inputs that follow the    terminator in this argument array.
>
> **`remaining: ArgumentArrayParsingStrategy`**
> Parse only unprefixed values from the command-line input, ignoring   any inputs that have a dash prefix; this is the default strategy.
>
**`struct ArgumentHelp`**
Help information for a command-line argument.

> **`init(String, discussion: String?, valueName: String?, shouldDisplay: Bool)`**
> Creates a new help instance.
>
> **`init(String, discussion: String?, valueName: String?, visibility: ArgumentVisibility, argumentType: (any ExpressibleByArgument.Type)?)`**
> Creates a new help instance.
>
> **`init(extendedGraphemeClusterLiteral: Self.StringLiteralType)`**
> Inherited from  .
>
> **`init(stringInterpolation: DefaultStringInterpolation)`**
> Inherited from  .
>
> **`init(stringLiteral: String)`**
> Inherited from  .
>
> **`init(unicodeScalarLiteral: Self.ExtendedGraphemeClusterLiteralType)`**
> Inherited from  .
>
> **`abstract: String`**
> A short description of the argument.
>
> **`argumentType: (any ExpressibleByArgument.Type)?`**
> A property of meta type   that serves to retain   information about any arguments that have enumerable values and their descriptions.
>
> **`discussion: String?`**
> An expanded description of the argument, in plain text form.
>
> **`hidden: ArgumentHelp`**
> A   instance that shows an argument only in the extended help display.
>
> **`private: ArgumentHelp`**
> A   instance that hides an argument from the extended help display.
>
> **`shouldDisplay: Bool`**
> A Boolean value indicating whether this argument should be shown in   the extended help display.
>
> **`valueName: String?`**
> An alternative name to use for the argument’s value when showing usage   information.
>
> **`visibility: ArgumentVisibility`**
> A visibility level indicating whether this argument should be shown in   the extended help display.
>
**`struct ArgumentVisibility`**
Visibility level of an argument’s help.

> **`default: ArgumentVisibility`**
> Show help for this argument whenever appropriate.
>
> **`hidden: ArgumentVisibility`**
> Only show help for this argument in the extended help screen.
>
> **`private: ArgumentVisibility`**
> Never show help for this argument.
>
**`struct ArrayParsingStrategy`**
The strategy to use when parsing multiple values from   arguments into an   array.

> **`remaining: ArrayParsingStrategy`**
> Parse all remaining arguments into an array.
>
> **`singleValue: ArrayParsingStrategy`**
> Parse one value per option, joining multiple into an array.
>
> **`unconditionalSingleValue: ArrayParsingStrategy`**
> Parse the value immediately after the option while allowing repeating options, joining multiple into an array.
>
> **`upToNextOption: ArrayParsingStrategy`**
> Parse all values up to the next option.
>
**`struct CleanExit`**
An error type that represents a clean (non-error state) exit of the   utility.

> **`static func helpRequest((any ParsableCommand.Type)?) -> CleanExit`**
> Treat this error as a help request and display the full help message.
>
> **`static func helpRequest(any ParsableCommand) -> CleanExit`**
> Treat this error as a help request and display the full help message.
>
> **`static func message(String) -> CleanExit`**
> Treat this error as a clean exit with the given message.
>
**`struct CommandConfiguration`**
The configuration for a command.

> **`init(commandName: String?, abstract: String, usage: String?, discussion: String, version: String, shouldDisplay: Bool, subcommands: [any ParsableCommand.Type], groupedSubcommands: [CommandGroup], defaultSubcommand: (any ParsableCommand.Type)?, helpNames: NameSpecification?, aliases: [String])`**
> Creates the configuration for a command.
>
> **`abstract: String`**
> A one-line description of this command.
>
> **`aliases: [String]`**
> An array of aliases for the command’s name.
>
> **`commandName: String?`**
> The name of the command to use on the command line.
>
> **`defaultSubcommand: (any ParsableCommand.Type)?`**
> The default command type to run if no subcommand is given.
>
> **`discussion: String`**
> A longer description of this command, to be shown in the extended help   display.
>
> **`groupedSubcommands: [CommandGroup]`**
> The list of subcommands and subcommand groups.
>
> **`helpNames: NameSpecification?`**
> Flag names to be used for help.
>
> **`shouldDisplay: Bool`**
> A Boolean value indicating whether this command should be shown in   the extended help display.
>
> **`subcommands: [any ParsableCommand.Type]`**
> An array of the types that define subcommands for this command.
>
> **`ungroupedSubcommands: [any ParsableCommand.Type]`**
> An array of types that define subcommands for this command and are   not part of any command group.
>
> **`usage: String?`**
> A customized usage string to be shown in the help display and error   messages.
>
> **`version: String`**
> Version information for this command.
>
**`struct CommandGroup`**
A set of commands grouped together under a common name.

> **`init(name: String, subcommands: [any ParsableCommand.Type])`**
> Create a command group.
>
> **`name: String`**
> The name of the command group that will be displayed in help.
>
> **`subcommands: [any ParsableCommand.Type]`**
> The list of subcommands that are part of this group.
>
**`struct CompletionKind`**
The type of completion to use for an argument or option value.

> **`default: CompletionKind`**
> Use the default completion kind for the argument’s or option value’s type.
>
> **`directory: CompletionKind`**
> The completion candidates are directory names.
>
> **`static func custom(([String], Int, String) -> [String]) -> CompletionKind`**
> The completion candidates are the strings in the array returned by the   given closure when it is executed in response to a user’s request for   completions.
>
> **`static func custom(([String], Int, String) async -> [String]) -> CompletionKind`**
> Generate completions using the given async closure.
>
> **`static func custom(([String]) -> [String]) -> CompletionKind`**
> Deprecated; only kept for backwards compatibility.
>
> **`static func file(extensions: [String]) -> CompletionKind`**
> The completion candidates include directory and file names, the latter   filtered by the given list of extensions.
>
> **`static func list([String]) -> CompletionKind`**
> The completion candidates are the strings in the given array.
>
> **`static func shellCommand(String) -> CompletionKind`**
> The completion candidates are specified by the   output of the   given string run as a shell command when a user requests completions.
>
**`struct CompletionShell`**
A shell for which the parser can generate a completion script.

> **`init?(rawValue: String)`**
> Creates a new instance from the given string.
>
> **`allCases: [CompletionShell]`**
> An array of all supported shells for completion scripts.
>
> **`bash: CompletionShell`**
> An instance representing  .
>
> **`fish: CompletionShell`**
> An instance representing  .
>
> **`requesting: CompletionShell?`**
> The shell for which completions will be or are being requested.
>
> **`requestingVersion: String?`**
> The shell version for which completions will be or are being requested.
>
> **`zsh: CompletionShell`**
> An instance representing  .
>
> **`static func autodetected() -> CompletionShell?`**
> Returns an instance representing the current shell, if recognized.
>
**`struct ExitCode`**
An error type that only includes an exit code.

> **`init(Int32)`**
> Creates a new   with the given code.
>
> **`init(rawValue: Int32)`**
> Inherited from  .
>
> **`failure: ExitCode`**
> An exit code that indicates that the command failed.
>
> **`isSuccess: Bool`**
> A Boolean value indicating whether this exit code represents the   successful completion of a command.
>
> **`rawValue: Int32`**
> The exit code represented by this instance.
>
> **`success: ExitCode`**
> An exit code that indicates successful completion of a command.
>
> **`validationFailure: ExitCode`**
> An exit code that indicates that the user provided invalid input.
>
**`struct Flag`**
A property wrapper that represents a command-line flag.

> **`init(exclusivity: FlagExclusivity, help: ArgumentHelp?)`**
> Creates a property with no default value that gets its value from the presence of a flag.
>
> **`init<Element>(exclusivity: FlagExclusivity, help: ArgumentHelp?)`**
> Creates a property that gets its value from the presence of a flag,   where the allowed flags are defined by an   type.
>
> **`init<Element>(help: ArgumentHelp?)`**
> Creates an array property with no default value that gets its values from the presence of zero or more flags, where the allowed flags are defined by an   type.
>
> **`init(name: NameSpecification, help: ArgumentHelp?)`**
> Creates an integer property that gets its value from the number of times   a flag appears.
>
> **`init(name: NameSpecification, inversion: FlagInversion, exclusivity: FlagExclusivity, help: ArgumentHelp?)`**
> Creates a Boolean property that reads its value from the presence of   one or more inverted flags.
>
> **`init(name: NameSpecification, inversion: FlagInversion, exclusivity: FlagExclusivity, help: ArgumentHelp?)`**
> Creates a Boolean property with no default value that reads its value from the presence of one or more inverted flags.
>
> **`init(wrappedValue: Value, exclusivity: FlagExclusivity, help: ArgumentHelp?)`**
> Creates a property with a default value provided by standard Swift default value syntax that gets its value from the presence of a flag.
>
> **`init<Element>(wrappedValue: [Element], help: ArgumentHelp?)`**
> Creates an array property that gets its values from the presence of   zero or more flags, where the allowed flags are defined by an    type.
>
> **`init(wrappedValue: Bool, name: NameSpecification, help: ArgumentHelp?)`**
> Creates a Boolean property with default value provided by standard Swift default value syntax that reads its value from the presence of a flag.
>
> **`init(wrappedValue: Bool, name: NameSpecification, inversion: FlagInversion, exclusivity: FlagExclusivity, help: ArgumentHelp?)`**
> Creates a Boolean property with default value provided by standard Swift default value syntax that reads its value from the presence of one or more inverted flags.
>
> **`wrappedValue: Value`**
> The value presented by this property wrapper.
>
**`struct FlagExclusivity`**
The options for treating enumeration-based flags as exclusive.

> **`chooseFirst: FlagExclusivity`**
> The first enumeration case that is provided is used.
>
> **`chooseLast: FlagExclusivity`**
> The last enumeration case that is provided is used.
>
> **`exclusive: FlagExclusivity`**
> Only one of the enumeration cases may be provided.
>
**`struct FlagInversion`**
The options for converting a Boolean flag into a  /  pair.

> **`prefixedEnableDisable: FlagInversion`**
> Uses matching flags with   and   prefixes.
>
> **`prefixedNo: FlagInversion`**
> Adds a matching flag with a   prefix to represent  .
>
**`struct NameSpecification`**
A specification for how to represent a property as a command-line argument   label.

> **`init<S>(S)`**
>
> **`init(arrayLiteral: NameSpecification.Element...)`**
> Inherited from  .
>
> **`long: NameSpecification`**
> Use the property’s name converted to lowercase with words separated by   hyphens.
>
> **`short: NameSpecification`**
> Use the first character of the property’s name as a short option label.
>
> **`shortAndLong: NameSpecification`**
> Combine the   and   specifications to allow both long   and short labels.
>
> **`static func customLong(String, withSingleDash: Bool) -> NameSpecification`**
> Use the given string instead of the property’s name.
>
> **`static func customShort(Character, allowingJoined: Bool) -> NameSpecification`**
> Use the given character as a short option label.
>
**`struct NameSpecification.Element`**
An individual property name translation.

**`struct Option`**
A property wrapper that represents a command-line option.

> **`init<T>(name: NameSpecification, parsing: SingleValueParsingStrategy, help: ArgumentHelp?, completion: CompletionKind?)`**
> Creates an optional property that reads its value from a labeled option.
>
> **`init(name: NameSpecification, parsing: SingleValueParsingStrategy, help: ArgumentHelp?, completion: CompletionKind?)`**
> Creates a required property that reads its value from a labeled option.
>
> **`init<T>(name: NameSpecification, parsing: ArrayParsingStrategy, help: ArgumentHelp?, completion: CompletionKind?)`**
> Creates a required array property that reads its values from zero or   more labeled options.
>
> **`init<T>(name: NameSpecification, parsing: SingleValueParsingStrategy, help: ArgumentHelp?, completion: CompletionKind?, transform: (String) throws -> T)`**
> Creates an optional property that reads its value from a labeled option,   parsing with the given closure.
>
> **`init(name: NameSpecification, parsing: SingleValueParsingStrategy, help: ArgumentHelp?, completion: CompletionKind?, transform: (String) throws -> Value)`**
> Creates a required property that reads its value from a labeled option,   parsing with the given closure.
>
> **`init<T>(name: NameSpecification, parsing: ArrayParsingStrategy, help: ArgumentHelp?, completion: CompletionKind?, transform: (String) throws -> T)`**
> Creates a required array property that reads its values from zero or   more labeled options, parsing each element with the given closure.
>
> **`init(wrappedValue: Value, name: NameSpecification, parsing: SingleValueParsingStrategy, help: ArgumentHelp?, completion: CompletionKind?)`**
> Creates a property with a default value that reads its value from a   labeled option.
>
> **`init<T>(wrappedValue: _OptionalNilComparisonType, name: NameSpecification, parsing: SingleValueParsingStrategy, help: ArgumentHelp?, completion: CompletionKind?)`**
> Creates an optional property that reads its value from a labeled option,   with an explicit   default.
>
> **`init<T>(wrappedValue: [T], name: NameSpecification, parsing: ArrayParsingStrategy, help: ArgumentHelp?, completion: CompletionKind?)`**
> Creates an array property that reads its values from zero or   more labeled options.
>
> **`init<T>(wrappedValue: _OptionalNilComparisonType, name: NameSpecification, parsing: SingleValueParsingStrategy, help: ArgumentHelp?, completion: CompletionKind?, transform: (String) throws -> T)`**
> Creates an optional property that reads its value from a labeled option,   parsing with the given closure, with an explicit   default.
>
> **`init<T>(wrappedValue: [T], name: NameSpecification, parsing: ArrayParsingStrategy, help: ArgumentHelp?, completion: CompletionKind?, transform: (String) throws -> T)`**
> Creates an array property that reads its values from zero or   more labeled options, parsing each element with the given closure.
>
> **`init(wrappedValue: Value, name: NameSpecification, parsing: SingleValueParsingStrategy, help: ArgumentHelp?, completion: CompletionKind?, transform: (String) throws -> Value)`**
> Creates a property with a default value that reads its value from a   labeled option, parsing with the given closure.
>
> **`wrappedValue: Value`**
> The value presented by this property wrapper.
>
**`struct OptionGroup`**
A wrapper that transparently includes a parsable type.

> **`init()`**
> Creates a property that represents another parsable type.
>
> **`init(title: String, visibility: ArgumentVisibility)`**
> Creates a property that represents another parsable type, using the   specified title and visibility.
>
> **`title: String`**
> The title to use in the help screen for this option group.
>
> **`wrappedValue: Value`**
> The value presented by this property wrapper.
>
**`struct SingleValueParsingStrategy`**
The strategy to use when parsing a single value from   arguments.

> **`next: SingleValueParsingStrategy`**
> Parse the input after the option and expect it to be a value.
>
> **`scanningForValue: SingleValueParsingStrategy`**
> Parse the next input, as long as that input can’t be interpreted as   an option or flag.
>
> **`unconditional: SingleValueParsingStrategy`**
> Parse the next input, even if it could be interpreted as an option or   flag.
>
**`struct ValidationError`**
An error type that is presented to the user as an error with parsing their   command-line input.

> **`init(String)`**
> Creates a new validation error with the given message.
>
> **`message: String`**
> The error message represented by this instance, this string is presented to   the user when a   is thrown from either;  ,    or a transform closure.
>

### Articles

**`article Customizing Completions`**
Provide custom shell completions for your command-line tool’s arguments and options.

**`article Customizing Help`**
Support your users (and yourself) by providing rich help for arguments, options, and flags.

**`article Customizing Help for Commands`**
Define your command’s abstract, extended discussion, or usage string, and set the flags used to invoke the help display.

**`article Declaring Arguments, Options, and Flags`**
Use the  ,   and   property wrappers to declare the command-line interface for your command.

**`article Defining Commands and Subcommands`**
Break complex command-line tools into a tree of subcommands.

**`article Experimental Features`**
Learn about ArgumentParser’s experimental features.

**`article Generating and Installing Completion Scripts`**
Install shell completion scripts generated by your command-line tool.

**`article Getting Started with ArgumentParser`**
Learn to set up and customize a simple command-line tool.

**`article Manual Parsing and Testing`**
Provide your own array of command-line inputs or work directly with parsed command-line arguments.

**`article Providing Custom Validation`**
Provide helpful feedback to users when things go wrong.


---

### Argument

**Summary:** A property wrapper that represents a positional command-line argument.

##### Overview

Use the `@Argument` wrapper to define a property of your custom command as a positional argument. A positional argument for a command-line tool is specified without a label and must appear in declaration order. `@Argument` properties with `Optional` type or a default value are optional for the user of your command-line tool.

For example, the following program has two positional arguments. The `name` argument is required, while `greeting` is optional because it has a default value.

```swift
@main
struct Greet: ParsableCommand {
    @Argument var name: String
    @Argument var greeting: String = "Hello"

    mutating func run() {
        print("\(greeting) \(name)!")
    }
}
```

You can call this program with just a name or with a name and a greeting. When you supply both arguments, the first argument is always treated as the name, due to the order of the property declarations.

```
$ greet Nadia
Hello Nadia!
$ greet Tamara Hi
Hi Tamara!
```

---

### ArgumentArrayParsingStrategy

**Summary:** The strategy to use when parsing multiple values from positional arguments   into an array.

---

### AsyncMainProtocol

**Summary:** A type that can designate an   as the program’s   entry point.

##### Overview

See the Async Parsable Command documentation for usage information.

---

### AsyncParsableCommand

**Summary:** A type that can be executed asynchronously, as part of a nested tree of   commands.

##### Overview

To use `async`/`await` code in your commands’ `run()` method implementations, follow these steps:

1. For the root command in your command-line tool, declare conformance to ``, whether or not that command uses asynchronous code.
2. Apply the `` attribute to the root command. (Note: If your root command is in a `` file, rename the file to the name of the command.)
3. For any command that needs to use asynchronous code, declare conformance to `` and mark the `` method as ``. No changes are needed for subcommands that don’t use asynchronous code.

The following example declares a `CountLines` command that uses Foundation’s asynchronous `FileHandle.AsyncBytes` to read the lines from a file:

```swift
import Foundation

@main
struct CountLines: AsyncParsableCommand {
    @Argument(transform: URL.init(fileURLWithPath:))
    var inputFile: URL

    mutating func run() async throws {
        let fileHandle = try FileHandle(forReadingFrom: inputFile)
        let lineCount = try await fileHandle.bytes.lines.reduce(into: 0) 
            { count, _ in count += 1 }
        print(lineCount)
    }
}
```

> **Note**
> > The Swift compiler uses either the type marked with `@main` or a `main.swift` file as the entry point for an executable program. You can use either one, but not both — rename your `main.swift` file to the name of the command when you add `@main`.

###### Usage in Swift 5.5

Swift 5.5 is supported by the obsolete versions 1.1.x & 1.2.x versions of Swift Argument Parser.

In Swift 5.5, an asynchronous `@main` entry point must be declared as a separate standalone type.

Your root command cannot be designated as `@main`, unlike as described above.

Instead, use the code snippet below, replacing the `<#RootCommand#>` placeholder with the name of your own root command.

```swift
@main struct AsyncMain: AsyncMainProtocol {
    typealias Command = <#RootCommand#>
}
```

Continue to follow the other steps above to use `async`/`await` code within your commands’ `run()` methods.

---

### CleanExit

**Summary:** An error type that represents a clean (non-error state) exit of the   utility.

##### Overview

Throwing a `CleanExit` instance from a `validate` or `run` method, or passing it to `exit(with:)`, exits the program with exit code `0`.

---

### CommandConfiguration

**Summary:** The configuration for a command.

---

### CompletionKind

**Summary:** The type of completion to use for an argument or option value.

##### Overview

For all `CompletionKind`s, the completion shell script is configured with the following settings, which will not affect the requesting shell outside the completion script:

###### bash

```shell
shopt -s extglob
set +o history +o posix
```

###### fish

no settings

###### zsh

```shell
emulate -RL zsh -G
setopt extendedglob nullglob numericglobsort
unsetopt aliases banghist
```

---

### Customizing Completions

**Summary:** Provide custom shell completions for your command-line tool’s arguments and options.

##### Overview

`ArgumentParser` provides default completions for any types that it can. For example, an `@Option` property that is a `CaseIterable` type will automatically have the correct values as completion suggestions.

When declaring an option or argument, you can customize the completions that are offered by specifying a Completion Kind. With this completion kind you can specify that the value should be a file, a directory, or one of a list of strings:

```swift
struct Example: ParsableCommand {
    @Option(help: "The file to read from.", completion: .file())
    var input: String

    @Option(help: "The output directory.", completion: .directory)
    var outputDir: String

    @Option(help: "The preferred file format.", completion: .list(["markdown", "rst"]))
    var format: String

    enum CompressionType: String, CaseIterable, ExpressibleByArgument {
        case zip, gzip
    }

    @Option(help: "The compression type to use.")
    var compression: CompressionType
}
```

The generated completion script will suggest only file names for the `--input` option, only directory names for `--output-dir`, and only the strings `markdown` and `rst` for `--format`. The `--compression` option uses the default completions for a `CaseIterable` type, so the completion script will suggest `zip` and `gzip`.

You can define the default completion kind for custom Expressible By Argument types by implementing Default Completion Kind. For example, any arguments or options with this `File` type will automatically use files for completions:

```swift
struct File: Hashable, ExpressibleByArgument {
    var path: String
    
    init?(argument: String) {
        self.path = argument
    }
    
    static var defaultCompletionKind: CompletionKind {
        .file()
    }
}
```

For even more control over the suggested completions, you can specify a function that will be called during completion by using the `.custom` completion kind.

```swift
func listExecutables(_ arguments: [String]) -> [String] {
    // Generate the list of executables in the current directory
}

struct SwiftRun {
    @Option(help: "The target to execute.", completion: .custom(listExecutables))
    var target: String?
}
```

In this example, when a user requests completions for the `--target` option, the completion script runs the `SwiftRun` command-line tool with a special syntax, calling the `listExecutables` function with an array of the arguments given so far.

###### Configuring Completion Candidates per Shell

The shells supported for word completion all have different completion candidate formats, as well as their own different syntaxes and built-in commands.

The `CompletionShell.requesting` singleton (of type `CompletionShell?`) can be read to determine which shell is requesting completion candidates when evaluating functions that either provide arguments to a `CompletionKind` creation function, or that are themselves arguments to a `CompletionKind` creation function.

The `CompletionShell.requestingVersion` singleton (of type `String?`) can be read to determine the version of the shell that is requesting completion candidates when evaluating functions that are themselves arguments to a `CompletionKind` creation function.

e.g.:

```swift
struct Tool {
    @Option(completion: .shellCommand(generateCommandPerShell()))
    var x: String?

    @Option(completion: .custom(generateCompletionCandidatesPerShell))
    var y: String?
}

/// Runs when a completion script is generated; results hardcoded into script.
func generateCommandPerShell() -> String {
    switch CompletionShell.requesting {
    case CompletionShell.bash:
        return "bash-specific script"
    case CompletionShell.fish:
        return "fish-specific script"
    case CompletionShell.zsh:
        return "zsh-specific script"
    default:
        // return a universal no-op for unknown shells
        return ":"
    }
}

/// Runs during completion while user is typing command line to use your tool
/// Note that the `Version` struct is not included in Swift Argument Parser
func generateCompletionCandidatesPerShell(_ arguments: [String]) -> [String] {
    switch CompletionShell.requesting {
    case CompletionShell.bash:
        if Version(CompletionShell.requestingVersion).major >= 4 {
            return ["A:in:bash4+:syntax", "B:in:bash4+:syntax", "C:in:bash4+:syntax"]
        } else {
            return ["A:in:bash:syntax", "B:in:bash:syntax", "C:in:bash:syntax"]
        }
    case CompletionShell.fish:
        return ["A:in:fish:syntax", "B:in:bash:syntax", "C:in:bash:syntax"]
    case CompletionShell.zsh:
        return ["A:in:zsh:syntax",  "B:in:zsh:syntax",  "C:in:zsh:syntax"]
    default:
        return []
    }
}
```

---

### Customizing Help

**Summary:** Support your users (and yourself) by providing rich help for arguments, options, and flags.

##### Overview

You can provide help text when declaring any `@Argument`, `@Option`, or `@Flag` by passing a string literal as the `help` parameter:

```swift
struct Example: ParsableCommand {
    @Flag(help: "Display extra information while processing.")
    var verbose = false

    @Option(help: "The number of extra lines to show.")
    var extraLines = 0

    @Argument(help: "The input file.")
    var inputFile: String?
}
```

Users see these strings in the automatically-generated help screen, which is triggered by the `-h` or `--help` flags, by default:

```
% example --help
USAGE: example [--verbose] [--extra-lines <extra-lines>] <input-file>

ARGUMENTS:
  <input-file>            The input file.

OPTIONS:
  --verbose               Display extra information while processing.
  --extra-lines <extra-lines>
                          The number of extra lines to show. (default: 0)
  -h, --help              Show help information.
```

###### Customizing Help for Arguments

For more control over the help text, pass an Argument Help instance instead of a string literal. The `ArgumentHelp` type can include an abstract (which is what the string literal becomes), a discussion, a value name to use in the usage string, and a visibility level for that argument.

Here’s the same command with some extra customization:

```swift
struct Example: ParsableCommand {
    @Flag(help: "Display extra information while processing.")
    var verbose = false

    @Option(help: ArgumentHelp(
        "The number of extra lines to show.",
        valueName: "n"))
    var extraLines = 0

    @Argument(help: ArgumentHelp(
        "The input file.",
        discussion: "If no input file is provided, the tool reads from stdin.",
        valueName: "file"))
    var inputFile: String?
}
```

…and the help screen:

```
USAGE: example [--verbose] [--extra-lines <n>] [<file>]

ARGUMENTS:
  <file>                  The input file.
        If no input file is provided, the tool reads from stdin.

OPTIONS:
  --verbose               Display extra information while processing.
  --extra-lines <n>       The number of extra lines to show. (default: 0)
  -h, --help              Show help information.
```

###### Enumerating Possible Values

When an argument or option has a fixed set of possible values, listing these values in the help screen can simplify use of your tool. You can customize the displayed set of values for custom Expressible By Argument types by implementing All Value Strings. Despite the name, All Value Strings does not need to be an exhaustive list of possible values.

```swift
enum Fruit: String, ExpressibleByArgument {
    case apple
    case banana
    case coconut
    case dragonFruit = "dragon-fruit"

    static var allValueStrings: [String] {
        ["apple", "banana", "coconut", "dragon-fruit"]
    }
}

struct FruitStore: ParsableCommand {
    @Argument(help: "The fruit to purchase")
    var fruit: Fruit
  
    @Option(help: "The number of fruit to purchase")
    var quantity: Int = 1
}
```

The help screen includes the list of values in the description of the `<fruit>` argument:

```
USAGE: fruit-store <fruit> [--quantity <quantity>]

ARGUMENTS:
  <fruit>                 The fruit to purchase (values: apple, banana,
                          coconut, dragon-fruit)

OPTIONS:
  --quantity <quantity>   The number of fruit to purchase (default: 1)
  -h, --help              Show help information.
```

###### Deriving Possible Values

ExpressibleByArgument types that conform to `CaseIterable` do not need to manually specify All Value Strings. Instead, a list of possible values is derived from the type’s cases, as in this updated example:

```swift
enum Fruit: String, CaseIterable, ExpressibleByArgument {
    case apple
    case banana
    case coconut
    case dragonFruit = "dragon-fruit"
}

struct FruitStore: ParsableCommand {
    @Argument(help: "The fruit to purchase")
    var fruit: Fruit
  
    @Option(help: "The number of fruit to purchase")
    var quantity: Int = 1
}
```

The help screen still contains all the possible values.

```
USAGE: fruit-store <fruit> [--quantity <quantity>]

ARGUMENTS:
  <fruit>                 The fruit to purchase (values: apple, banana,
                          coconut, dragon-fruit)

OPTIONS:
  --quantity <quantity>   The number of fruit to purchase (default: 1)
  -h, --help              Show help information.
```

For an Expressible By Argument and `CaseIterable` type with many cases, you may still want to implement All Value Strings to avoid an overly long list of values appearing in the help screen. For these types it is recommended to include the most common possible values.

###### Controlling Argument Visibility

You can specify the visibility of any argument, option, or flag.

```swift
struct Example: ParsableCommand {
    @Flag(help: ArgumentHelp("Show extra info.", visibility: .hidden))
    var verbose: Bool = false

    @Flag(help: ArgumentHelp("Use the legacy format.", visibility: .private))
    var useLegacyFormat: Bool = false
}
```

The `--verbose` flag is only visible in the extended help screen. The `--use-legacy-format` stays hidden even in the extended help screen, due to its `.private` visibility.

```
% example --help
USAGE: example

OPTIONS:
  -h, --help              Show help information.

% example --help-hidden
USAGE: example [--verbose]

OPTIONS:
  --verbose               Show extra info.
  -h, --help              Show help information.
```

Alternatively, you can group multiple arguments, options, and flags together as part of a Parsable Arguments type, and set the visibility when including them as an `@OptionGroup` property.

```swift
struct ExperimentalFlags: ParsableArguments {
    @Flag(help: "Use the remote access token. (experimental)")
    var experimentalUseRemoteAccessToken: Bool = false

    @Flag(help: "Use advanced security. (experimental)")
    var experimentalAdvancedSecurity: Bool = false
}

struct Example: ParsableCommand {
    @OptionGroup(visibility: .hidden)
    var flags: ExperimentalFlags
}
```

The members of `ExperimentalFlags` are only shown in the extended help screen:

```
% example --help
USAGE: example

OPTIONS:
  -h, --help              Show help information.

% example --help-hidden
USAGE: example [--experimental-use-remote-access-token] [--experimental-advanced-security]

OPTIONS:
  --experimental-use-remote-access-token
                          Use the remote access token. (experimental)
  --experimental-advanced-security
                          Use advanced security. (experimental)
  -h, --help              Show help information.
```

###### Grouping Arguments in the Help Screen

When you provide a title in an `@OptionGroup` declaration, that type’s  properties are grouped together under your title in the help screen. For example, this command bundles similar arguments together under a  “Build Options” title:

```swift
struct BuildOptions: ParsableArguments {
    @Option(help: "A setting to pass to the compiler.")
    var compilerSetting: [String] = []

    @Option(help: "A setting to pass to the linker.")
    var linkerSetting: [String] = []
}

struct Example: ParsableCommand {
    @Argument(help: "The input file to process.")
    var inputFile: String

    @Flag(help: "Show extra output.")
    var verbose: Bool = false

    @Option(help: "The path to a configuration file.")
    var configFile: String?

    @OptionGroup(title: "Build Options")
    var buildOptions: BuildOptions
}
```

This grouping is reflected in the command’s help screen:

```
% example --help
USAGE: example <input-file> [--verbose] [--config-file <config-file>] [--compiler-setting <compiler-setting> ...] [--linker-setting <linker-setting> ...]

ARGUMENTS:
  <input-file>            The input file to process.

BUILD OPTIONS:
  --compiler-setting <compiler-setting>
                          A setting to pass to the compiler.
  --linker-setting <linker-setting>
                          A setting to pass to the linker.

OPTIONS:
  --verbose               Show extra output.
  --config-file <config-file>
                          The path to a configuration file.
  -h, --help              Show help information.
```

---

### Customizing Help for Commands

**Summary:** Define your command’s abstract, extended discussion, or usage string, and set the flags used to invoke the help display.

##### Overview

In addition to configuring the command name and subcommands, as described in Commands And Subcommands, you can also configure a command’s help text by providing an abstract, discussion, or custom usage string.

```swift
struct Repeat: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Repeats your input phrase.",
        usage: """
            repeat <phrase>
            repeat --count <count> <phrase>
            """,
        discussion: """
            Prints to stdout forever, or until you halt the program.
            """)

    @Argument(help: "The phrase to repeat.")
    var phrase: String

    @Option(help: "How many times to repeat.")
    var count: Int? = nil

    mutating func run() throws {
        for _ in 0..<(count ?? 2) {
            print(phrase) 
        }
    }
}
```

The customized components now appear in the generated help screen:

```
% repeat --help
OVERVIEW: Repeats your input phrase.

Prints to stdout forever, or until you halt the program.

USAGE: repeat <phrase>
       repeat --count <count> <phrase>

ARGUMENTS:
  <phrase>                The phrase to repeat.

OPTIONS:
  -h, --help              Show help information.

% repeat hello!
hello!
hello!
hello!
hello!
hello!
hello!
...
```

###### Modifying the Help Flag Names

Users can see the help screen for a command by passing either the `-h` or the `--help` flag, by default. If you need to use one of those flags for another purpose, you can provide alternative names when configuring a root command.

```swift
struct Example: ParsableCommand {
    static let configuration = CommandConfiguration(
        helpNames: [.long, .customShort("?")])

    @Option(name: .shortAndLong, help: "The number of history entries to show.")
    var historyDepth: Int

    mutating func run() throws {
        printHistory(depth: historyDepth)
    }
}
```

When running the command, `-h` matches the short name of the `historyDepth` property, and `-?` displays the help screen.

```
% example -h 3
nmap -v -sS -O 10.2.2.2
sshnuke 10.2.2.2 -rootpw="Z1ON0101"
ssh 10.2.2.2 -l root
% example -?
USAGE: example --history-depth <history-depth>

ARGUMENTS:
  <phrase>                The phrase to repeat.

OPTIONS:
  -h, --history-depth     The number of history entries to show.
  -?, --help              Show help information.
```

When not overridden, custom help names are inherited by subcommands. In this example, the parent command defines `--help` and `-?` as its help names:

```swift
struct Parent: ParsableCommand {
    static let configuration = CommandConfiguration(
        subcommands: [Child.self],
        helpNames: [.long, .customShort("?")])

    struct Child: ParsableCommand {
        @Option(name: .shortAndLong, help: "The host the server will run on.")
        var host: String
    }
}
```

The `child` subcommand inherits the parent’s help names, allowing the user to distinguish between the host argument (`-h`) and help (`-?`).

```
% parent child -h 192.0.0.0
...
% parent child -?
USAGE: parent child --host <host>

OPTIONS:
  -h, --host <host>       The host the server will run on.
  -?, --help              Show help information.
```

###### Hiding Commands

You may not want to show every one of your command as part of your command-line interface. To render a command invisible (but still usable), pass `shouldDisplay: false` to the Command Configuration initializer.

###### Generating Help Text Programmatically

The help screen is automatically shown to users when they call your command with the help flag. You can generate the same text from within your program by calling the `helpMessage()` method.

```swift
let help = Repeat.helpMessage()
// `help` matches the output above

let fortyColumnHelp = Repeat.helpMessage(columns: 40)
// `fortyColumnHelp` is the same help screen, but wrapped to 40 columns
```

When generating help text for a subcommand, call `helpMessage(for:)` on the `ParsableCommand` type that represents the root of the command tree and pass the subcommand type as a parameter to ensure the correct display.

---

### Declaring Arguments, Options, and Flags

**Summary:** Use the  ,   and   property wrappers to declare the command-line interface for your command.

##### Overview

When creating commands, you can define three primary kinds of command-line inputs:

- Arguments are values given by a user and are read in order from first to last (see Argument). For example, this command is called with three file names as arguments:
- Options are named key-value pairs. Keys start with one or two dashes (`-` or `--`), and a user can separate the key and value with an equal sign (`=`) or a space (see Option). This command is called with two options:
- Flags are like options, but without a paired value. Instead, their presence indicates a particular value (see Flag). This command is called with two flags:

The three preceding examples could be calls of this `Example` command:

```swift
struct Example: ParsableCommand {
    @Argument var files: [String] = []
    @Option var count: Int?
    @Option var index = 0
    @Flag var verbose = false
    @Flag var stripWhitespace = false
}
```

This example shows how `ArgumentParser` provides defaults that speed up your initial development process:

- Option and flag names are derived from the names of your command’s properties.
- What kinds of inputs are valid, and whether arguments are required, is based on your properties’ types and default values.

In this example, all of the properties have default values (optional properties default to `nil`).

Users must provide values for all properties with no implicit or specified default. For example, this command would require one integer argument and a string with the key `--user-name`.

```swift
struct Example: ParsableCommand {
    @Option var userName: String
    @Argument var value: Int
}
```

When called without both values, the command exits with an error:

```
% example 5
Error: Missing '--user-name <user-name>'
Usage: example --user-name <user-name> <value>
  See 'example --help' for more information.
% example --user-name kjohnson
Error: Missing '<value>'
Usage: example --user-name <user-name> <value>
  See 'example --help' for more information.
```

When providing a default value for an array property, any user-supplied values replace the entire default.

```swift
struct Lucky: ParsableCommand {
    @Argument var numbers = [7, 14, 21]

    mutating func run() throws {
        print("""
        Your lucky numbers are:
        \(numbers.map(String.init).joined(separator: " "))
        """)
    }
}
```

```
% lucky 
Your lucky numbers are:
7 14 21
% lucky 1 2 3
Your lucky numbers are:
1 2 3
```

###### Customizing option and flag names

By default, options and flags derive the name that you use on the command line from the name of the property, such as `--count` and `--index`. Camel-case names are converted to lowercase with hyphen-separated words, like `--strip-whitespace`.

You can override this default by specifying one or more name specifications in the `@Option` or `@Flag` initializers. This command demonstrates the four name specifications:

```swift
struct Example: ParsableCommand {
    @Flag(name: .long)  // Same as the default
    var stripWhitespace = false

    @Flag(name: .short)
    var verbose = false

    @Option(name: .customLong("count"))
    var iterationCount: Int

    @Option(name: [.customShort("I"), .long])
    var inputFile: String
}
```

- Specifying `.long` or `.short` uses the property’s name as the source of the command-line name. Long names use the whole name, prefixed by two dashes, while short names are a single character prefixed by a single dash. In this example, the `stripWhitespace` and `verbose` flags are specified in this way:
- Specifying `.customLong(_:)` or `.customShort(_:)` uses the given string or character as the long or short name for the property.
- Use array literal syntax to specify multiple names. The `inputFile` property can alternatively be given with the default long name:

**Note:** You can also pass `withSingleDash: true` to `.customLong` to create a single-dash flag or option, such as `-verbose`. Use this name specification only when necessary, such as when migrating a legacy command-line interface. Using long names with a single-dash prefix can lead to ambiguity with combined short names: it may not be obvious whether `-file` is a single option or the combination of the four short options `-f`, `-i`, `-l`, and `-e`.

###### Parsing custom types

Arguments and options can be parsed from any type that conforms to the Expressible By Argument protocol. Standard library integer and floating-point types, strings, and Booleans all conform to `ExpressibleByArgument`.

You can make your own custom types conform to `ExpressibleByArgument` by implementing Init(argument:):

```swift
struct Path: ExpressibleByArgument {
    var pathString: String

    init?(argument: String) {
        self.pathString = argument
    }
}

struct Example: ParsableCommand {
    @Argument var inputFile: Path
}
```

The library provides a default implementation for `RawRepresentable` types, like string-backed enumerations, so you only need to declare conformance.

```swift
enum ReleaseMode: String, ExpressibleByArgument {
    case debug, release
}

struct Example: ParsableCommand {
    @Option var mode: ReleaseMode

    mutating func run() throws {
        print(mode)
    }
}
```

The user can provide the raw values on the command line, which are then converted to your custom type. Only valid values are allowed:

```
% example --mode release
release
% example --mode future
Error: The value 'future' is invalid for '--mode <mode>'
```

To use a non-`ExpressibleByArgument` type for an argument or option, you can instead provide a throwing `transform` function that converts the parsed string to your desired type. This is a good idea for custom types that are more complex than a `RawRepresentable` type, or for types you don’t define yourself.

```swift
enum Format {
    case text
    case other(String)

    init(_ string: String) throws {
        if string == "text" {
            self = .text
        } else {
            self = .other(string)
        }
    }
}

struct Example: ParsableCommand {
    @Argument(transform: Format.init)
    var format: Format
}
```

Throw an error from the `transform` function to indicate that the user provided an invalid value for that type. See Validation for more about customizing `transform` function errors.

###### Using flag inversions, enumerations, and counts

Flags are most frequently used for `Bool` properties. You can generate a `true`/`false` pair of flags by specifying a flag inversion:

```swift
struct Example: ParsableCommand {
    @Flag(inversion: .prefixedNo)
    var index = true

    @Flag(inversion: .prefixedEnableDisable)
    var requiredElement: Bool

    mutating func run() throws {
        print(index, requiredElement)
    }
}
```

When declaring a flag with an inversion, set the default by specifying `true` or `false` as the property’s initial value. If you want to require that the user specify one of the two inversions, leave off the default value.

In the `Example` command defined above, a flag is required for the `requiredElement` property. The specified prefixes are prepended to the long names for the flags:

```
% example --enable-required-element
true true
% example --no-index --disable-required-element
false false
% example --index
Error: Missing one of: '--enable-required-element', '--disable-required-element'
```

To create a flag with custom names for a Boolean value, to provide an exclusive choice between more than two names, or for collecting multiple values from a set of defined choices, define an enumeration that conforms to the `EnumerableFlag` protocol.

```swift
enum CacheMethod: String, EnumerableFlag {
    case inMemoryCache
    case persistentCache
}

enum Color: String, EnumerableFlag {
    case pink, purple, silver
}

struct Example: ParsableCommand {
    @Flag var cacheMethod: CacheMethod
    @Flag var colors: [Color] = []

    mutating func run() throws {
        print(cacheMethod)
        print(colors)
    }
}
```

The flag names in this case are drawn from the raw values — for information about customizing the names and help text, see the  Enumerable Flag documentation.

```
% example --in-memory-cache --pink --silver
.inMemoryCache
[.pink, .silver]
% example
Error: Missing one of: '--in-memory-cache', '--persistent-cache'
```

Finally, when a flag is of type `Int`, the value is parsed as a count of the number of times that the flag is specified.

```swift
struct Example: ParsableCommand {
    @Flag(name: .shortAndLong)
    var verbose: Int

    mutating func run() throws {
        print("Verbosity level: \(verbose)")
    }
}
```

In this example, `verbose` defaults to zero, and counts the number of times that `-v` or `--verbose` is given.

```
% example --verbose
Verbosity level: 1
% example -vvvv
Verbosity level: 4
```

###### Specifying default values

You can specify default values for almost all supported argument, option, and flag types using normal property initialization syntax:

```swift
enum CustomFlag: String, EnumerableFlag {
    case foo, bar, baz
}

struct Example: ParsableCommand {
    @Flag
    var booleanFlag = false

    @Flag
    var arrayFlag: [CustomFlag] = [.foo, .baz]

    @Option
    var singleOption = 0

    @Option
    var arrayOption = ["bar", "qux"]

    @Argument
    var singleArgument = "quux"

    @Argument
    var arrayArgument = ["quux", "quuz"]
}
```

This includes all of the variants of the argument types above (including `@Option(transform: ...)`, etc.), with a few notable exceptions:

- `Optional`-typed values (which default to `nil` and for which a default would not make sense, as the value could never be `nil`)
- `Int` flags (which are used for counting the number of times a flag is specified and therefore default to `0`)

If a default is not specified, the user must provide a value for that argument/option/flag or will receive an error that the value is missing.

You must also always specify a default of `false` for a non-optional `Bool` flag, as in the example above. This makes the behavior consistent with both normal Swift properties (which either must be explicitly initialized or optional to initialize a `struct`/`class` containing them) and the other property types.

###### Specifying a parsing strategy

When parsing a list of command-line inputs, `ArgumentParser` distinguishes between dash-prefixed keys and un-prefixed values. When looking for the value for a key, only an un-prefixed value will be selected by default.

For example, this command defines a `--verbose` flag, a `--name` option, and an optional `file` argument:

```swift
struct Example: ParsableCommand {
    @Flag var verbose = false
    @Option var name: String
    @Argument var file: String?

    mutating func run() throws {
        print("Verbose: \(verbose), name: \(name), file: \(file ?? "none")")
    }
}
```

When calling this command, the value for `--name` must be given immediately after the key. If the `--verbose` flag is placed in between, parsing fails with an error:

```
% example --verbose --name Tomás
Verbose: true, name: Tomás, file: none
% example --name --verbose Tomás
Error: Missing value for '--name <name>'
Usage: example [--verbose] --name <name> [<file>]
  See 'example --help' for more information.
```

Parsing options as arrays is similar — only adjacent key-value pairs are recognized by default.

###### Alternative single-value parsing strategies

You can change this behavior by providing a different parsing strategy in the `@Option` initializer. **Be careful when selecting any of the alternative parsing strategies** — they may lead your command-line tool to have unexpected behavior for users!

The `.unconditional` parsing strategy uses the immediate next input for the value of the option, even if it starts with a dash. If `name` were instead defined as `@Option(parsing: .unconditional) var name: String`, the second attempt would result in `"--verbose"` being read as the value of `name`:

```
% example --name --verbose Tomás
Verbose: false, name: --verbose, file: Tomás
```

The `.scanningForValue` strategy, on the other hand, looks ahead in the list of command-line inputs and uses the first un-prefixed value as the input, even if that requires skipping over other flags or options.  If `name` were defined as `@Option(parsing: .scanningForValue) var name: String`, the parser would look ahead to find `Tomás`, then pick up parsing where it left off to get the `--verbose` flag:

```
% example --name --verbose Tomás
Verbose: true, name: Tomás, file: none
```

###### Alternative array parsing strategies

The default strategy for parsing options as arrays is to read each value from a key-value pair. For example, this command expects zero or more input file names:

```swift
struct Example: ParsableCommand {
    @Option var file: [String] = []
    @Flag var verbose = false

    mutating func run() throws {
        print("Verbose: \(verbose), files: \(file)")
    }
}
```

As with single values, each time the user provides the `--file` key, they must also provide a value:

```
% example --verbose --file file1.swift --file file2.swift
Verbose: true, files: ["file1.swift", "file2.swift"]
% example --file --verbose file1.swift --file file2.swift
Error: Missing value for '--file <file>'
Usage: example [--file <file> ...] [--verbose]
  See 'example --help' for more information.
```

The `.unconditionalSingleValue` parsing strategy uses whatever input follows the key as its value, even if that input is dash-prefixed. If `file` were defined as `@Option(parsing: .unconditionalSingleValue) var file: [String]`, then the resulting array could include strings that look like options:

```
% example --file file1.swift --file --verbose
Verbose: false, files: ["file1.swift", "--verbose"]
```

The `.upToNextOption` parsing strategy uses the inputs that follow the option key until reaching a dash-prefixed input. If `file` were defined as `@Option(parsing: .upToNextOption) var file: [String]`, then the user could specify multiple files without repeating `--file`:

```
% example --file file1.swift file2.swift
Verbose: false, files: ["file1.swift", "file2.swift"]
% example --file file1.swift file2.swift --verbose
Verbose: true, files: ["file1.swift", "file2.swift"]
```

Finally, the `.remaining` parsing strategy uses all the inputs that follow the option key, regardless of their prefix. If `file` were defined as `@Option(parsing: .remaining) var file: [String]`, then the user would need to specify `--verbose` before the `--file` key for it to be recognized as a flag:

```
% example --verbose --file file1.swift file2.swift
Verbose: true, files: ["file1.swift", "file2.swift"]
% example --file file1.swift file2.swift --verbose
Verbose: false, files: ["file1.swift", "file2.swift", "--verbose"]
```

###### Alternative positional argument parsing strategies

The default strategy for parsing arrays of positional arguments is to ignore  all dash-prefixed command-line inputs. For example, this command accepts a `--verbose` flag and a list of file names as positional arguments:

```swift
struct Example: ParsableCommand {
    @Flag var verbose = false
    @Argument var files: [String] = []

    mutating func run() throws {
        print("Verbose: \(verbose), files: \(files)")
    }
}
```

The `files` argument array uses the default `.remaining` parsing strategy, so it only picks up values that don’t have a prefix:

```
% example --verbose file1.swift file2.swift
Verbose: true, files: ["file1.swift", "file2.swift"]
% example --verbose file1.swift file2.swift --other
Error: Unexpected argument '--other'
Usage: example [--verbose] [<files> ...]
  See 'example --help' for more information.
```

Any input after the `--` terminator is automatically treated as positional input, so users can provide dash-prefixed values that way even with the default configuration:

```
% example --verbose -- file1.swift file2.swift --other
Verbose: true, files: ["file1.swift", "file2.swift", "--other"]
```

The `.unconditionalRemaining` parsing strategy uses whatever input is left after parsing known options and flags, even if that input is dash-prefixed, including the terminator itself. If `files` were defined as `@Argument(parsing: .unconditionalRemaining) var files: [String]`, then the resulting array would also include strings that look like options:

```
% example --verbose file1.swift file2.swift --other
Verbose: true, files: ["file1.swift", "file2.swift", "--other"]
% example -- --verbose file1.swift file2.swift --other
Verbose: false, files: ["--", "--verbose", "file1.swift", "file2.swift", "--other"]
```

###### Ignoring unknown arguments

Different versions of a CLI tool may have full or partial sets of supported flags and options.

By default, `ArgumentParser` throws an error if unknown arguments are passed as command input. When appropriate, you can process supported arguments and ignore unknown ones by collecting unknowns in special `@Argument` with the `.allUnrecognized` strategy.

```swift
struct Example: ParsableCommand {
    @Flag var verbose = false
    
    @Argument(parsing: .allUnrecognized)
    var unknowns: [String] = []

    func run() throws {
        print("Verbose: \(verbose)")
    }
}
```

This way any unknown parameters are silently captured in the `unknowns` array.

```
% example --flag --verbose --option abc file1.swift
Verbose: true
```

---

### Defining Commands and Subcommands

**Summary:** Break complex command-line tools into a tree of subcommands.

##### Overview

When command-line programs grow larger, it can be useful to divide them into a group of smaller programs, providing an interface through subcommands. Utilities such as `git` and the Swift package manager are able to provide varied interfaces for each of their sub-functions by implementing subcommands such as `git branch` or `swift package init`.

Generally, these subcommands each have their own configuration options, as well as options that are shared across several or all aspects of the larger program.

You can build a program with commands and subcommands by defining multiple command types and specifying each command’s subcommands in its configuration. For example, here’s the interface of a `math` utility that performs operations on a series of values given on the command line.

```
% math add 10 15 7
32
% math multiply 10 15 7
1050
% math stats average 3 4 13 15 15
10.0
% math stats average --kind median 3 4 13 15 15
13.0
% math stats
OVERVIEW: Calculate descriptive statistics.

USAGE: math stats <subcommand>

OPTIONS:
  -h, --help              Show help information.

SUBCOMMANDS:
  average, avg            Print the average of the values.
  stdev                   Print the standard deviation of the values.
  quantiles               Print the quantiles of the values (TBD).

  See 'math help stats <subcommand>' for detailed help.
```

Start by defining the root `Math` command. You can provide a static Configuration property for a command that specifies its subcommands and a default subcommand, if any.

```swift
struct Math: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A utility for performing maths.",
        subcommands: [Add.self, Multiply.self, Statistics.self],
        defaultSubcommand: Add.self)
}
```

`Math` lists its three subcommands by their types; we’ll see the definitions of `Add`, `Multiply`, and `Statistics` below. `Add` is also given as a default subcommand — this means that it is selected if a user leaves out a subcommand name:

```
% math 10 15 7
32
```

Next, define a Parsable Arguments type with properties that will be shared across multiple subcommands. Types that conform to `ParsableArguments` can be parsed from command-line arguments, but don’t provide any execution through a `run()` method.

In this case, the `Options` type accepts a `--hexadecimal-output` flag and expects a list of integers.

```swift
struct Options: ParsableArguments {
    @Flag(name: [.long, .customShort("x")], help: "Use hexadecimal notation for the result.")
    var hexadecimalOutput = false

    @Argument(help: "A group of integers to operate on.")
    var values: [Int]
}
```

It’s time to define our first two subcommands: `Add` and `Multiply`. Both of these subcommands include the arguments defined in the `Options` type by denoting that property with the `@OptionGroup` property wrapper (see Option Group). `@OptionGroup` doesn’t define any new arguments for a command; instead, it splats in the arguments defined by another `ParsableArguments` type.

```swift
extension Math {
    struct Add: ParsableCommand {
        static let configuration
            = CommandConfiguration(abstract: "Print the sum of the values.")

        @OptionGroup var options: Math.Options

        mutating func run() {
            let result = options.values.reduce(0, +)
            print(format(result: result, usingHex: options.hexadecimalOutput))
        }
    }

    struct Multiply: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Print the product of the values.",
            aliases: ["mul"])

        @OptionGroup var options: Math.Options

        mutating func run() {
            let result = options.values.reduce(1, *)
            print(format(result: result, usingHex: options.hexadecimalOutput))
        }
    }
}
```

One thing to note is the aliases parameter for `CommandConfiguration`. This is useful for subcommands to define alternative names that can be used to invoke them. In this case we’ve defined a shorthand for multiply named mul, so you could invoke the `Multiply` command for our program by either of the below:

```
% math multiply 10 15 7
1050
% math mul 10 15 7
1050
```

Next, we’ll define `Statistics`, the third subcommand of `Math`. The `Statistics` command specifies a custom command name (`stats`) in its configuration, overriding the default derived from the type name (`statistics`). It also declares two additional subcommands, meaning that it acts as a forked branch in the command tree, and not a leaf.

```swift
extension Math {
    struct Statistics: ParsableCommand {
        static let configuration = CommandConfiguration(
            commandName: "stats",
            abstract: "Calculate descriptive statistics.",
            subcommands: [Average.self, StandardDeviation.self])
    }
}
```

Let’s finish our subcommands with the `Average` and `StandardDeviation` types. Each of them has slightly different arguments, so they don’t use the `Options` type defined above. Each subcommand is ultimately independent and can specify a combination of shared and unique arguments.

```swift
extension Math.Statistics {
    struct Average: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Print the average of the values.",
            aliases: ["avg"])

        enum Kind: String, ExpressibleByArgument {
            case mean, median, mode
        }

        @Option(help: "The kind of average to provide.")
        var kind: Kind = .mean

        @Argument(help: "A group of floating-point values to operate on.")
        var values: [Double] = []

        func calculateMean() -> Double { ... }
        func calculateMedian() -> Double { ... }
        func calculateMode() -> [Double] { ... }

        mutating func run() {
            switch kind {
            case .mean:
                print(calculateMean())
            case .median:
                print(calculateMedian())
            case .mode:
                let result = calculateMode()
                    .map(String.init(describing:))
                    .joined(separator: " ")
                print(result)
            }
        }
    }

    struct StandardDeviation: ParsableCommand {
        static let configuration = CommandConfiguration(
            commandName: "stdev",
            abstract: "Print the standard deviation of the values.")

        @Argument(help: "A group of floating-point values to operate on.")
        var values: [Double] = []

        mutating func run() {
            if values.isEmpty {
                print(0.0)
            } else {
                let sum = values.reduce(0, +)
                let mean = sum / Double(values.count)
                let squaredErrors = values
                    .map { $0 - mean }
                    .map { $0 * $0 }
                let variance = squaredErrors.reduce(0, +) / Double(values.count)
                let result = variance.squareRoot()
                print(result)
            }
        }
    }
}
```

Last but not least, we add the `@main` attribute to the root of our command tree, to tell the compiler to use that as the program’s entry point. Upon execution, this parses the command-line arguments, determines whether a subcommand was selected, and then instantiates and calls the `run()` method on that particular subcommand.

> **Note**
> > The Swift compiler uses either the type marked with `@main` or a `main.swift` file as the entry point for an executable program. You can use either one, but not both — rename your `main.swift` file to the name of your command when you add `@main`. In this case, rename it to `Math.swift`.

```swift
@main
struct Math: ParsableCommand {
    // ...
}
```

That’s it for this doubly-nested `math` command! This example is also provided as a part of the `swift-argument-parser` repository, so you can see it all together and experiment with it .

---

### EnumerableFlag

**Summary:** A type that represents the different possible flags to be used by a    property.

##### Overview

For example, the `Size` enumeration declared here can be used as the type of a `@Flag` property:

```swift
enum Size: String, EnumerableFlag {
    case small, medium, large, extraLarge
}

struct Example: ParsableCommand {
    @Flag var sizes: [Size]

    mutating func run() {
        print(sizes)
    }
}
```

By default, each case name is converted to a flag by using the `.long` name specification, so a user can call `example` like this:

```
$ example --small --large
[.small, .large]
```

Provide alternative or additional name specifications for each case by implementing the `name(for:)` static method on your `EnumerableFlag` type.

```swift
extension Size {
    static func name(for value: Self) -> NameSpecification {
        switch value {
        case .extraLarge:
            return [.customShort("x"), .long]
        default:
            return .shortAndLong
        }
    }
}
```

With this extension, a user can use short or long versions of the flags:

```
$ example -s -l -x --medium
[.small, .large, .extraLarge, .medium]
```

---

### ExitCode

**Summary:** An error type that only includes an exit code.

##### Overview

If you’re printing custom error messages yourself, you can throw this error to specify the exit code without adding any additional output to standard out or standard error.

---

### Experimental Features

**Summary:** Learn about ArgumentParser’s experimental features.

##### Overview

Command-line programs built using `ArgumentParser` may include some built-in experimental features, available with the prefix `--experimental`. These features should not be considered stable while still prefixed, as future releases may change their behavior or remove them.

If you have any feedback on experimental features, please .

###### List of Experimental Features

---

### Flag

**Summary:** A property wrapper that represents a command-line flag.

##### Overview

Use the `@Flag` wrapper to define a property of your custom type as a command-line flag. A flag is a dash-prefixed label that can be provided on the command line, such as `-d` and `--debug`.

For example, the following program declares a flag that lets a user indicate that seconds should be included when printing the time.

```swift
@main
struct Time: ParsableCommand {
    @Flag var includeSeconds = false

    mutating func run() {
        if includeSeconds {
            print(Date.now.formatted(.dateTime.hour().minute().second()))
        } else {
            print(Date.now.formatted(.dateTime.hour().minute()))
        }
    }
}
```

`includeSeconds` has a default value of `false`, but becomes `true` if `--include-seconds` is provided on the command line.

```
$ time
11:09 AM
$ time --include-seconds
11:09:15 AM
```

A flag can have a value that is a `Bool`, an `Int`, or any `EnumerableFlag` type. When using an `EnumerableFlag` type as a flag, the individual cases form the flags that are used on the command line.

```
@main
struct Math: ParsableCommand {
    enum Operation: EnumerableFlag {
        case add
        case multiply
    }

    @Flag var operation: Operation

    mutating func run() {
        print("Time to \(operation)!")
    }
}
```

Instead of using the name of the `operation` property as the flag in this case, the two cases of the `Operation` enumeration become valid flags. The `operation` property is neither optional nor given a default value, so one of the two flags is required.

```
$ math --add
Time to add!
$ math
Error: Missing one of: '--add', '--multiply'
```

---

### Generating and Installing Completion Scripts

**Summary:** Install shell completion scripts generated by your command-line tool.

##### Overview

Command-line tools that you build with `ArgumentParser` include a built-in option for generating completion scripts, with support for Bash, Z shell, and Fish. To generate completions, run your command with the `--generate-completion-script` option to generate completions for your specific shell.

```
$ example --generate-completion-script bash
#compdef example

_example() {
    ...
}

_example
```

The correct method of installing a completion script can depend on both your shell and your configuration.

###### Installing Zsh Completions

If you have  installed, you already have a directory of automatically loading completion scripts — `.oh-my-zsh/completions`. Copy your new completion script to that directory.

```
$ example --generate-completion-script zsh > ~/.oh-my-zsh/completions/_example
```

> **Your completion script must have the following filename format**
> > `_example`.

Without `oh-my-zsh`, you’ll need to add a path for completion scripts to your function path, and turn on completion script autoloading. First, add these lines to `~/.zshrc`:

```
fpath=(~/.zsh/completion $fpath)
autoload -U compinit
compinit
```

Next, create a directory at `~/.zsh/completion` and copy the completion script to the new directory.

###### Installing Bash Completions

If you have  installed, you can just copy your new completion script to the `/usr/local/etc/bash_completion.d` directory.

Without `bash-completion`, you’ll need to source the completion script directly. Copy it to a directory such as `~/.bash_completions/`, and then add the following line to `~/.bash_profile` or `~/.bashrc`:

```
source ~/.bash_completions/example.bash
```

###### Installing Fish Completions

Copy the completion script to any path listed in the environment variable `$fish_completion_path`.  For example, a typical location is `~/.config/fish/completions/your_script.fish`.

---

### Getting Started with ArgumentParser

**Summary:** Learn to set up and customize a simple command-line tool.

##### Overview

This guide walks through building an example command. You’ll learn about the different tools that `ArgumentParser` provides for defining a command’s options, customizing the interface, and providing help text for your user.

###### Adding ArgumentParser as a Dependency

Let’s write a tool called `count` that reads an input file, counts the words, and writes the result to an output file.

First, we need to add `swift-argument-parser` as a dependency to our package, and then include `"ArgumentParser"` as a dependency for our executable target. Our “Package.swift” file ends up looking like this:

```swift
// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "Count",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.3.0"),
    ],
    targets: [
        .executableTarget(
            name: "count",
            dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")]),
    ]
)
```

###### Building Our First Command

Once we’ve built the `count` tool, we’ll be able to run it like this:

```
% count readme.md readme.counts
Counting words in 'readme.md' and writing the result into 'readme.counts'.
```

We’ll define the initial version of the command as a type that conforms to the `ParsableCommand` protocol:

```swift
import ArgumentParser

@main
struct Count: ParsableCommand {
    @Argument var inputFile: String
    @Argument var outputFile: String
    
    mutating func run() throws {
        print("""
            Counting words in '\(inputFile)' \
            and writing the result into '\(outputFile)'.
            """)
            
        // Read 'inputFile', count the words, and save to 'outputFile'.
    }
}
```

In the code above, the `inputFile` and `outputFile` properties use the `@Argument` property wrapper. `ArgumentParser` uses this wrapper to denote a positional command-line input — because `inputFile` is specified first in the `Count` type, it’s the first value read from the command line, and `outputFile` is the second.

The command’s logic is implemented in its `run()` method. Here, it prints out a message confirming the names of the files the user gave. (You can find a full implementation of the completed command at the end of this guide.)

Finally, the `Count` command is designated as the program’s entry point by applying the `@main` attribute. When running your command, the `ArgumentParser` library parses the command-line arguments, verifies that they match up with what we’ve defined in `Count`, and either calls the `run()` method or exits with a helpful message.

> **Note**
> > The Swift compiler uses either the type marked with `@main` or a `main.swift` file as the entry point for an executable program. You can use either one, but not both — rename your `main.swift` file to the name of the command when you add `@main`. In this case, rename the file to `Count.swift`.

###### Working with Named Options

Our `count` tool may have a usability problem — it’s not immediately clear whether a user should provide the input file first, or the output file. Instead of using positional arguments for our two inputs, let’s specify that they should be labeled options:

```
% count --input-file readme.md --output-file readme.counts
Counting words in 'readme.md' and writing the result into 'readme.counts'.
```

We do this by using the `@Option` property wrapper instead of `@Argument`:

```swift
@main
struct Count: ParsableCommand {
    @Option var inputFile: String
    @Option var outputFile: String
    
    mutating func run() throws {
        print("""
            Counting words in '\(inputFile)' \
            and writing the result into '\(outputFile)'.
            """)
            
        // Read 'inputFile', count the words, and save to 'outputFile'.
    }
}
```

The `@Option` property wrapper denotes a command-line input that looks like `--name <value>`, deriving its name from the name of your property.

This interface has a trade-off for the users of our `count` tool: With `@Argument`, users don’t need to type as much, but they have to remember whether to provide the input file or the output file first. Using `@Option` makes the user type a little more, but the distinction between values is explicit. Options are order-independent, as well, so the user can name the input and output files in either order:

```
% count --output-file readme.counts --input-file readme.md
Counting words in 'readme.md' and writing the result into 'readme.counts'.
```

###### Adding a Flag

Next, we want to add a `--verbose` flag to our tool, and only print the message if the user specifies that option:

```
% count --input-file readme.md --output-file readme.counts
(no output)
% count --verbose --input-file readme.md --output-file readme.counts
Counting words in 'readme.md' and writing the result into 'readme.counts'.
```

Let’s change our `Count` type to look like this:

```swift
@main
struct Count: ParsableCommand {
    @Option var inputFile: String
    @Option var outputFile: String
    @Flag var verbose = false
    
    mutating func run() throws {
        if verbose {
            print("""
                Counting words in '\(inputFile)' \
                and writing the result into '\(outputFile)'.
                """)
        }
 
        // Read 'inputFile', count the words, and save to 'outputFile'.
    }
}
```

The `@Flag` property wrapper denotes a command-line input that looks like `--name`, deriving its name from the name of your property. Flags are most frequently used for Boolean values, like the `verbose` property here.

###### Using Custom Names

We can customize the names of our options and add an alternative to the `verbose` flag so that users can specify `-v` instead of `--verbose`. The new interface will look like this:

```
% count -v -i readme.md -o readme.counts
Counting words in 'readme.md' and writing the result into 'readme.counts'.
% count --input readme.md --output readme.counts -v
Counting words in 'readme.md' and writing the result into 'readme.counts'.
% count -o readme.counts -i readme.md --verbose
Counting words in 'readme.md' and writing the result into 'readme.counts'.
```

Customize the input names by passing `name` parameters to the `@Option` and `@Flag` initializers:

```swift
@main
struct Count: ParsableCommand {
    @Option(name: [.short, .customLong("input")])
    var inputFile: String

    @Option(name: [.short, .customLong("output")])
    var outputFile: String

    @Flag(name: .shortAndLong)
    var verbose = false
    
    mutating func run() throws { ... }
}
```

The default name specification is `.long`, which uses a property’s name with a two-dash prefix. `.short` uses only the first letter of a property’s name with a single-dash prefix, and allows combining groups of short options. You can specify custom short and long names with the `.customShort(_:)` and `.customLong(_:)` methods, respectively, or use the combined `.shortAndLong` property to specify the common case of both the short and long derived names.

###### Providing Help

`ArgumentParser` automatically generates help for any command when a user provides the `-h` or `--help` flags:

```
% count --help
USAGE: count --input <input> --output <output> [--verbose]

OPTIONS:
  -i, --input <input>      
  -o, --output <output>    
  -v, --verbose            
  -h, --help              Show help information.
```

This is a great start — you can see that all the custom names are visible, and the help shows that values are expected for the `--input` and `--output` options. However, our custom options and flag don’t have any descriptive text. Let’s add that now by passing string literals as the `help` parameter:

```swift
@main
struct Count: ParsableCommand {
    @Option(name: [.short, .customLong("input")], help: "A file to read.")
    var inputFile: String

    @Option(name: [.short, .customLong("output")], help: "A file to save word counts to.")
    var outputFile: String

    @Flag(name: .shortAndLong, help: "Print status updates while counting.")
    var verbose = false

    mutating func run() throws { ... }
}
```

The help screen now includes descriptions for each parameter:

```
% count -h
USAGE: count --input <input> --output <output> [--verbose]

OPTIONS:
  -i, --input <input>     A file to read. 
  -o, --output <output>   A file to save word counts to. 
  -v, --verbose           Print status updates while counting. 
  -h, --help              Show help information.

```

###### The Complete Utility

As promised, here’s the complete `count` command, for your experimentation:

```swift
import ArgumentParser
import Foundation

@main
struct Count: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Word counter.")
    
    @Option(name: [.short, .customLong("input")], help: "A file to read.")
    var inputFile: String

    @Option(name: [.short, .customLong("output")], help: "A file to save word counts to.")
    var outputFile: String

    @Flag(name: .shortAndLong, help: "Print status updates while counting.")
    var verbose = false

    mutating func run() throws {
        if verbose {
            print("""
                Counting words in '\(inputFile)' \
                and writing the result into '\(outputFile)'.
                """)
        }
 
        guard let input = try? String(contentsOfFile: inputFile) else {
            throw RuntimeError("Couldn't read from '\(inputFile)'!")
        }
        
        let words = input.components(separatedBy: .whitespacesAndNewlines)
            .map { word in
                word.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
                    .lowercased()
            }
            .compactMap { word in word.isEmpty ? nil : word }
        
        let counts = Dictionary(grouping: words, by: { $0 })
            .mapValues { $0.count }
            .sorted(by: { $0.value > $1.value })
        
        if verbose {
            print("Found \(counts.count) words.")
        }
        
        let output = counts.map { word, count in "\(word): \(count)" }
            .joined(separator: "\n")
        
        guard let _ = try? output.write(toFile: outputFile, atomically: true, encoding: .utf8) else {
            throw RuntimeError("Couldn't write to '\(outputFile)'!")
        }
    }
}

struct RuntimeError: Error, CustomStringConvertible {
    var description: String
    
    init(_ description: String) {
        self.description = description
    }
}
```

###### Next Steps … Swift concurrency

`ArgumentParser` supports Swift concurrency, notably `async` renditions of `run`. If you use `async` rendition of `run`, conform to `AsyncParsableCommand` instead of `ParsableCommand`.

```swift
@main
struct FileUtility: AsyncParsableCommand {
    @Argument(
        help: "File to be parsed.",
        transform: URL.init(fileURLWithPath:)
    )
    var file: URL

    mutating func run() async throws {
        let handle = try FileHandle(forReadingFrom: file)

        for try await line in handle.bytes.lines {
            // do something with each line
        }

        try handle.close()
    }
}
```

> **Note**
> > If you accidentally use `ParsableCommand` with an `async` rendition of `run`, the app may never reach your `run` function and may only show the `USAGE` text. If you are using `async` version of `run`, you must use `AsyncParsableCommand`.

---

### Manual Parsing and Testing

**Summary:** Provide your own array of command-line inputs or work directly with parsed command-line arguments.

##### Overview

For most programs, denoting the root command type as `@main` is all that’s necessary. As the program’s entry point, that type parses the command-line arguments to find the correct command from your tree of nested subcommands, instantiates and validates the result, and executes the chosen command. For more control, however, you can perform each of those steps manually.

###### Parsing Arguments

For simple Swift scripts, and for those who prefer a straight-down-the-left-edge-of-the-screen scripting style, you can define a single Parsable Arguments type to parse explicitly from the command-line arguments.

Let’s implement the `Select` command discussed in Validation, but using a scripty style instead of the typical command. First, we define the options as a `ParsableArguments` type:

```swift
struct SelectOptions: ParsableArguments {
    @Option var count: Int = 1
    @Argument var elements: [String] = []
}
```

The next step is to parse our options from the command-line input:

```swift
let options = SelectOptions.parseOrExit()
```

The static Parse Or Exit(_:) method either returns a fully initialized instance of the type, or exits with an error message and code. Alternatively, you can call the throwing Parse(_:) method if you’d like to catch any errors that arise during parsing.

We can perform validation on the inputs and exit the script if necessary:

```swift
guard options.elements.count >= options.count else {
    let error = ValidationError("Please specify a 'count' less than the number of elements.")
    SelectOptions.exit(withError: error)
}
```

As you would expect, the Exit(with Error:) method includes usage information when you pass it a Validation Error.

Finally, we print out the requested number of elements:

```swift
let chosen = options.elements
    .shuffled()
    .prefix(options.count)
print(chosen.joined(separator: "\n"))
```

###### Parsing Commands

Manually parsing commands is a little more complex than parsing a simple `ParsableArguments` type. The result of parsing from a tree of subcommands may be of a different type than the root of the tree, so the static Parse As Root(_:) method returns a type-erased Parsable Command.

Let’s see how this works by using the `Math` command and subcommands defined in Commands And Subcommands. This time, instead of calling `Math.main()`, we’ll call `Math.parseAsRoot()`, and switch over the result:

```swift
do {
    var command = try Math.parseAsRoot()

    switch command {
    case var command as Math.Add:
        print("You chose to add \(command.options.values.count) values.")
        command.run()
    default:
        print("You chose to do something else.")
        try command.run()
    }
} catch {
    Math.exit(withError: error)
}
```

Our new logic intercepts the command between validation and running, and outputs an additional message:

```
% math 10 15 7
You chose to add 3 values.
32
% math multiply 10 15 7
You chose to do something else.
1050
```

###### Providing Command-Line Input

All of the parsing methods — `parse()`, `parseOrExit()`, and `parseAsRoot()` — can optionally take an array of command-line inputs as an argument. You can use this capability to test your commands, to perform pre-parse filtering of the command-line arguments, or to manually execute commands from within the same or another target.

Let’s update our `select` script above to strip out any words that contain all capital letters before parsing the inputs.

```swift
let noShoutingArguments = CommandLine.arguments.dropFirst().filter { phrase in
    phrase.uppercased() != phrase
}
let options = SelectOptions.parseOrExit(noShoutingArguments)
```

Now when we call our command, the parser won’t even see the capitalized words — `HEY` won’t ever be printed:

```
% select hi howdy HEY --count 2
hi
howdy
% select hi howdy HEY --count 2
howdy
hi
```

---

### Option

**Summary:** A property wrapper that represents a command-line option.

##### Overview

Use the `@Option` wrapper to define a property of your custom command as a command-line option. An option is a named value passed to a command-line tool, like `--configuration debug`. Options can be specified in any order.

An option can have a default value specified as part of its declaration; options with optional `Value` types implicitly have `nil` as their default value. Options that are neither declared as `Optional` nor given a default value are required for users of your command-line tool.

For example, the following program defines three options:

```swift
@main
struct Greet: ParsableCommand {
    @Option var greeting = "Hello"
    @Option var age: Int? = nil
    @Option var name: String

    mutating func run() {
        print("\(greeting) \(name)!")
        if let age {
            print("Congrats on making it to the ripe old age of \(age)!")
        }
    }
}
```

`greeting` has a default value of `"Hello"`, which can be overridden by providing a different string as an argument, while `age` defaults to `nil`. `name` is a required option because it is non-`nil` and has no default value.

```
$ greet --name Alicia
Hello Alicia!
$ greet --age 28 --name Seungchin --greeting Hi
Hi Seungchin!
Congrats on making it to the ripe old age of 28!
```

---

### OptionGroup

**Summary:** A wrapper that transparently includes a parsable type.

##### Overview

Use an option group to include a group of options, flags, or arguments declared in a parsable type.

```swift
struct GlobalOptions: ParsableArguments {
    @Flag(name: .shortAndLong)
    var verbose: Bool = false

    @Argument var values: [Int]
}

struct Options: ParsableArguments {
    @Option var name: String
    @OptionGroup var globals: GlobalOptions
}
```

The flag and positional arguments declared as part of `GlobalOptions` are included when parsing `Options`.

---

### ParsableArguments

**Summary:** A type that can be parsed from a program’s command-line arguments.

##### Overview

When you implement a `ParsableArguments` type, all properties must be declared with one of the four property wrappers provided by the `ArgumentParser` library.

---

### ParsableCommand

**Summary:** A type that can be executed as part of a nested tree of commands.

##### Overview

`ParsableCommand` types are the basic building blocks for command-line tools built using `ArgumentParser`. To create a command, declare properties using the `@Argument`, `@Option`, and `@Flag` property wrappers, or include groups of options with `@OptionGroup`. Finally, implement your command’s functionality in the Run() method.

```swift
@main
struct Repeat: ParsableCommand {
    @Argument(help: "The phrase to repeat.")
    var phrase: String

    @Option(help: "The number of times to repeat 'phrase'.")
    var count: Int? = nil

    mutating func run() throws {
        let repeatCount = count ?? 2
        for _ in 0..<repeatCount {
            print(phrase)
        }
    }
}
```

> **Note**
> > The Swift compiler uses either the type marked with `@main` or a `main.swift` file as the entry point for an executable program. You can use either one, but not both — rename your `main.swift` file to the name of the command when you add `@main`.

---

### Providing Custom Validation

**Summary:** Provide helpful feedback to users when things go wrong.

##### Overview

While `ArgumentParser` validates that the inputs given by your user match the requirements and types that you define in each command, there are some requirements that can’t easily be described in Swift’s type system, such as the number of elements in an array, or an expected integer value.

###### Validating Command-Line Input

To validate your commands properties after parsing, implement the Validate() method on any Parsable Command, Parsable Arguments, or Async Parsable Command type. Throwing an error from the `validate()` method causes the program to print a message to standard error and exit with an error code, preventing the `run()` method from being called with invalid inputs.

Here’s a command that prints out one or more random elements from the list you provide. Its `validate()` method catches three different errors that a user can make and throws a relevant error for each one.

```swift
struct Select: ParsableCommand {
    @Option var count: Int = 1
    @Argument var elements: [String] = []

    mutating func validate() throws {
        guard count >= 1 else {
            throw ValidationError("Please specify a 'count' of at least 1.")
        }

        guard !elements.isEmpty else {
            throw ValidationError("Please provide at least one element to choose from.")
        }

        guard count <= elements.count else {
            throw ValidationError("Please specify a 'count' less than the number of elements.")
        }
    }

    mutating func run() {
        print(elements.shuffled().prefix(count).joined(separator: "\n"))
    }
}
```

When you provide useful error messages, they can guide new users to success with your command-line tool!

```
% select
Error: Please provide at least one element to choose from.
Usage: select [--count <count>] [<elements> ...]
  See 'select --help' for more information.
% select --count 2 hello
Error: Please specify a 'count' less than the number of elements.
Usage: select [--count <count>] [<elements> ...]
  See 'select --help' for more information.
% select --count 0 hello hey hi howdy
Error: Please specify a 'count' of at least 1.
Usage: select [--count <count>] [<elements> ...]
  See 'select --help' for more information.
% select --count 2 hello hey hi howdy
howdy
hey
```

###### Handling Post-Validation Errors

The Validation Error type is a special `ArgumentParser` error — a validation error’s message is always accompanied by an appropriate usage string. You can throw other errors, from either the `validate()` or `run()` method to indicate that something has gone wrong that isn’t validation-specific. Errors that conform to `CustomStringConvertible` or `LocalizedError` provide the best experience for users.

```swift
struct LineCount: ParsableCommand {
    @Argument var file: String

    mutating func run() throws {
        let contents = try String(contentsOfFile: file, encoding: .utf8)
        let lines = contents.split(separator: "\n")
        print(lines.count)
    }
}
```

The throwing `String(contentsOfFile:encoding:)` initializer fails when the user specifies an invalid file. `ArgumentParser` prints its error message to standard error and exits with an error code.

```
% line-count file1.swift
37
% line-count non-existing-file.swift
Error: The file “non-existing-file.swift” couldn’t be opened because
there is no such file.
```

If you print your error output yourself, you still need to throw an error from `validate()` or `run()`, so that your command exits with the appropriate exit code. To avoid printing an extra error message, use the `ExitCode` error, which has static properties for success, failure, and validation errors, or lets you specify a specific exit code.

```swift
struct RuntimeError: Error, CustomStringConvertible {
    var description: String
}

struct Example: ParsableCommand {
    @Argument var inputFile: String

    mutating func run() throws {
        if !ExampleCore.processFile(inputFile) {
            // ExampleCore.processFile(_:) prints its own errors
            // and returns `false` on failure.
            throw ExitCode.failure
        }
    }
}
```

###### Handling Transform Errors

During argument and option parsing, you can use a closure to transform the command line strings to custom types. If this transformation fails, you can throw a `ValidationError`; its `message` property will be displayed to the user.

In addition, you can throw your own errors. Errors that conform to `CustomStringConvertible` or `LocalizedError` provide the best experience for users.

```swift
struct ExampleTransformError: Error, CustomStringConvertible {
  var description: String
}

struct ExampleDataModel: Codable {
  let identifier: UUID
  let tokens: [String]
  let tokenCount: Int

  static func dataModel(_ jsonString: String) throws -> ExampleDataModel  {
    guard let data = jsonString.data(using: .utf8) else { throw ValidationError("Badly encoded string, should be UTF-8") }
    return try JSONDecoder().decode(ExampleDataModel.self, from: data)
  }
}

struct Example: ParsableCommand {
  // Reads in the argument string and attempts to transform it to
  // an `ExampleDataModel` object using the `JSONDecoder`. If the
  // string is not valid JSON, `decode` will throw an error and
  // parsing will halt.
  @Argument(transform: ExampleDataModel.dataModel)
  var inputJSON: ExampleDataModel

  // Specifiying this option will always cause the parser to exit
  // and print the custom error.
  @Option(transform: { throw ExampleTransformError(description: "Trying to write to failOption always produces an error. Input: \($0)") })
  var failOption: String?
}
```

Throwing from a transform closure benefits users by providing context and can reduce development time by pinpointing issues quickly and more precisely.

```
% example '{"Bad JSON"}'
Error: The value '{"Bad JSON"}' is invalid for '<input-json>': dataCorrupted(Swift.DecodingError.Context(codingPath: [], debugDescription: "The given data was not valid JSON.", underlyingError: Optional(Error Domain=NSCocoaErrorDomain Code=3840 "No value for key in object around character 11." UserInfo={NSDebugDescription=No value for key in object around character 11.})))
Usage: example <input-json> --fail-option <fail-option>
  See 'select --help' for more information.
```

While throwing standard library or Foundation errors adds context, custom errors provide the best experience for users and developers.

```
% example '{"tokenCount":0,"tokens":[],"identifier":"F77D661C-C5B7-448E-9344-267B284F66AD"}' --fail-option="Some Text Here!"
Error: The value 'Some Text Here!' is invalid for '--fail-option <fail-option>': Trying to write to failOption always produces an error. Input: Some Text Here!
Usage: example <input-json> --fail-option <fail-option>
  See 'select --help' for more information.
```

---

### SingleValueParsingStrategy

**Summary:** The strategy to use when parsing a single value from   arguments.

##### Overview

> **See Also**
> > Array Parsing Strategy

---

### CommandConfiguration.aliases

**Summary:** An array of aliases for the command’s name.

##### Discussion

All of the aliases MUST not match the actual command’s name, whether that be the derived name if `commandName` is not provided, or `commandName` itself if provided.

---

### ArgumentArrayParsingStrategy.allUnrecognized

**Summary:** After parsing, capture all unrecognized inputs in this argument array.

##### Discussion

You can use the `allUnrecognized` parsing strategy to suppress “unexpected argument” errors or to capture unrecognized inputs for further processing.

For example, the `Example` command defined below has an `other` array that uses the `allUnrecognized` parsing strategy:

```
@main
struct Example: ParsableCommand {
    @Flag var verbose = false
    @Argument var name: String

    @Argument(parsing: .allUnrecognized)
    var other: [String]

    func run() {
        print(other.joined(separator: "\n"))
    }
}
```

After parsing the `--verbose` flag and `<name>` argument, any remaining input is captured in the `other` array.

```
$ example --verbose Negin one two
one
two
$ example Asa --verbose --other -zzz
--other
-zzz
```

---

### ExpressibleByArgument.allValueDescriptions

**Summary:** A dictionary containing the descriptions for each possible value of this type,   for display in the help screen.

##### Discussion

The default implementation of this property returns an empty dictionary. If the conforming type is also `CaseIterable`, the default implementation returns a dictionary with a description for each value as its key-value pair. Note that the conforming type must implement the `defaultValueDescription` for each value - if the description and the value are the same string, it’s assumed that a description is not implemented.

---

### ExpressibleByArgument.allValueStrings

**Summary:** An array of all possible strings that can convert to a value of this   type, for display in the help screen.

##### Discussion

The default implementation of this property returns an empty array. If the conforming type is also `CaseIterable`, the default implementation returns an array with a value for each case.

---

### ArgumentArrayParsingStrategy.captureForPassthrough

**Summary:** Parse all remaining inputs after parsing any known options or flags,   including dash-prefixed inputs and the   terminator.

##### Discussion

You can use the `captureForPassthrough` parsing strategy if you need to capture a user’s input to manually pass it unchanged to another command.

When you use this parsing strategy, the parser stops parsing flags and options as soon as it encounters a positional argument or an unrecognized flag, and captures all remaining inputs in the array argument.

For example, the `Example` command defined below has an `words` array that uses the `captureForPassthrough` parsing strategy:

```
@main
struct Example: ParsableCommand {
    @Flag var verbose = false

    @Argument(parsing: .captureForPassthrough)
    var words: [String] = []

    func run() {
        print(words.joined(separator: "\n"))
    }
}
```

Any values after the first unrecognized input are captured in the `words` array.

```
$ example --verbose one two --other
one
two
--other
$ example one two --verbose
one
two
--verbose
```

With the `captureForPassthrough` parsing strategy, the `--` terminator is included in the captured values.

```
$ example --verbose one two -- --other
one
two
--
--other
```

> **Note**
> > This parsing strategy can be surprising for users, particularly when combined with options and flags. Prefer Remaining or All Unrecognized whenever possible, since users can always terminate options and flags with the `--` terminator. With the `remaining` parsing strategy, the input `--verbose -- one two --other` would have the same result as the first example above.

---

### CommandConfiguration.commandName

**Summary:** The name of the command to use on the command line.

##### Discussion

If `nil`, the command name is derived by converting the name of the command type to hyphen-separated lowercase words.

---

### ParsableArguments.completionScript(for:)

**Summary:** Returns a shell completion script for the specified shell.

##### Return Value

The completion script for `shell`.

---

### CompletionKind.custom(_:)

**Summary:** The completion candidates are the strings in the array returned by the   given closure when it is executed in response to a user’s request for   completions.

##### Discussion

Completion candidates are interpreted by the requesting shell as literals. They must be neither escaped nor quoted; Swift Argument Parser escapes or quotes them as necessary for the requesting shell.

The given closure is evaluated after a user invokes completion in their shell (normally by pressing TAB); it is not evaluated when a completion script is generated.

The array of strings passed to the given closure contains all the shell words in the command line for the current command at completion invocation; this is exclusive of words for prior or subsequent commands or pipes, but inclusive of redirects and any other command line elements. Each word is its own element in the argument array; they appear in the same order as in the command line. Note that shell words may contain spaces if they are escaped or quoted.

Shell words are passed to Swift verbatim, without processing or removing any quotes or escapes. For example, the shell word `"abc\\""def"` would be passed to Swift as `"abc\\""def"` (i.e. the Swift String’s contents would include all 4 of the double quotes and the 2 consecutive backslashes).

The second argument (an `Int`) is the 0-based index of the word for which completions are being requested within the given `[String]`.

The third argument (a `String`) is the prefix of the word for which completions are being requested that precedes the cursor.

###### bash

In bash 3-, a process substitution (`<(…)`) in the command line prevents Swift custom completion functions from being called.

In bash 4+, a process substitution (`<(…)`) is split into multiple elements in the argument array: one for the starting `<(`, and one for each unescaped/unquoted-space-separated token through the closing `)`.

In bash, if the cursor is between the backslash and the single quote for the last escaped single quote in a word, all subsequent pipes or other commands are included in the words passed to Swift. This oddity might occur only when additional constraints are met. This or similar oddities might occur in other circumstances.

###### fish

In fish 3-, due to a bug, the argument array includes the fish words only through the word being completed. This is fixed in fish 4+.

In fish, a redirect’s symbol is not included, but its source/target is.

In fish 3-, due to limitations, words are passed to Swift unquoted. For example, the shell word `"abc\\""def"` would be passed to Swift as `abc\def`. This is fixed in fish 4+.

In fish 3-, the cursor index is provided based on the verbatim word, not based on the unquoted word, so it can be inconsistent with the unquoted word that is supplied to Swift. This problem does not exist in fish 4+.

###### zsh

In zsh, redirects (both their symbol and source/target) are omitted.

In zsh, if the cursor is between a backslash and the character that it escapes, the shell cursor index will be indicated as after the escaped character, not as after the backslash.

---

### CompletionKind.custom(_:)

**Summary:** Generate completions using the given async closure.

##### Discussion

The same as `custom(@Sendable @escaping ([String], Int, String) -> [String])`, except that the closure is asynchronous.

---

### CompletionKind.custom(_:)

**Summary:** Deprecated; only kept for backwards compatibility.

##### Discussion

The same as `custom(@Sendable @escaping ([String], Int, String) -> [String])`, except that the last two closure arguments are not supplied.

---

### NameSpecification.customLong(_:withSingleDash:)

**Summary:** Use the given string instead of the property’s name.

##### Return Value

A `long` name specification with the requested `name`.

##### Discussion

To create a single-dash argument, pass `true` as `withSingleDash`. Note that combining single-dash options and options with short, single-character names can lead to ambiguities for the user.

---

### Element.customLong(_:withSingleDash:)

**Summary:** Use the given string instead of the property’s name.

##### Return Value

A `long` name specification with the requested `name`.

##### Discussion

To create a single-dash argument, pass `true` as `withSingleDash`. Note that combining single-dash options and options with short, single-character names can lead to ambiguities for the user.

---

### Element.customShort(_:allowingJoined:)

**Summary:** Use the given character as a short option label.

##### Return Value

A `short` name specification with the requested `char`.

##### Discussion

When passing `true` as `allowingJoined` in an `@Option` declaration, the user can join a value with the option name. For example, if an option is declared as `-D`, allowing joined values, a user could pass `-Ddebug` to specify `debug` as the value for that option.

---

### NameSpecification.customShort(_:allowingJoined:)

**Summary:** Use the given character as a short option label.

##### Return Value

A `short` name specification with the requested `char`.

##### Discussion

When passing `true` as `allowingJoined` in an `@Option` declaration, the user can join a value with the option name. For example, if an option is declared as `-D`, allowing joined values, a user could pass `-Ddebug` to specify `debug` as the value for that option.

---

### ExpressibleByArgument.defaultCompletionKind

**Summary:** The completion kind to use for options or arguments of this type that   don’t explicitly declare a completion kind.

##### Discussion

The default implementation of this property returns `.default`.

---

### CompletionKind.directory

**Summary:** The completion candidates are directory names.

##### Discussion

The directory filter is included in a completion script when it is generated.

---

### CommandConfiguration.discussion

**Summary:** A longer description of this command, to be shown in the extended help   display.

##### Discussion

Can include specific abstracts about the argument’s possible values (e.g. for a custom `EnumerableOptionValue` type), or can describe a static block of text that extends the description of the argument.

---

### ParsableArguments.exit(withError:)

**Summary:** Terminates execution with a message and exit code that is appropriate   for the given error.

##### Discussion

If the `error` parameter is `nil`, this method prints nothing and exits with code `EXIT_SUCCESS`. If `error` represents a help request or another `CleanExit` error, this method prints help information and exits with code `EXIT_SUCCESS`. Otherwise, this method prints a relevant error message and exits with code `EX_USAGE` or `EXIT_FAILURE`.

---

### ParsableArguments.exitCode(for:)

**Summary:** Returns the exit code for the given error.

##### Return Value

The exit code for `error`.

##### Discussion

The returned code is the same exit code that is used if `error` is passed to `exit(withError:)`.

---

### CompletionKind.file(extensions:)

**Summary:** The completion candidates include directory and file names, the latter   filtered by the given list of extensions.

##### Discussion

If the given list of extensions is empty, then file names are not filtered.

Given file extensions must not include the `.` initial extension separator.

Given file extensions are parsed by the requesting shell as globs; Swift Argument Parser does not perform any escaping or quoting.

The directory/file filter and the given list of extensions are included in a completion script when it is generated.

---

### ParsableArguments.fullMessage(for:columns:)

**Summary:** Returns a full message for the given error, including usage information,   if appropriate.

##### Return Value

A message that can be displayed to the user.

---

### EnumerableFlag.help(for:)

**Summary:** Returns the help information to show for the given flag.

##### Discussion

The default implementation for this method always returns `nil`, which groups the flags together with the help provided in the `@Flag` declaration. Implement this method for your custom type to provide different help information for each flag.

---

### ParsableArguments.helpMessage(columns:)

**Summary:** Returns the text of the help screen for this type.

##### Return Value

The full help screen for this type.

---

### ParsableCommand.helpMessage(for:columns:)

**Summary:** Returns the text of the help screen for the given subcommand of this   command.

##### Return Value

The full help screen for this type.

---

### ParsableCommand.helpMessage(for:includeHidden:columns:)

**Summary:** Returns the text of the help screen for the given subcommand of this   command.

##### Return Value

The full help screen for this type.

---

### ParsableArguments.helpMessage(includeHidden:columns:)

**Summary:** Returns the text of the help screen for this type.

##### Return Value

The full help screen for this type.

---

### CleanExit.helpRequest(_:)

**Summary:** Treat this error as a help request and display the full help message.

##### Return Value

A throwable CleanExit error.

##### Discussion

You can use this case to simulate the user specifying one of the help flags or subcommands.

---

### CleanExit.helpRequest(_:)

**Summary:** Treat this error as a help request and display the full help message.

##### Return Value

A throwable CleanExit error.

##### Discussion

You can use this case to simulate the user specifying one of the help flags or subcommands.

---

### Flag.init(exclusivity:help:)

**Summary:** Creates a property with no default value that gets its value from the presence of a flag.

##### Discussion

Use this initializer to customize the name and number of states further than using a `Bool`. To use, define an `EnumerableFlag` enumeration with a case for each state, and use that as the type for your flag. In this case, the user can specify either `--use-production-server` or `--use-development-server` to set the flag’s value.

```swift
enum ServerChoice: EnumerableFlag {
  case useProductionServer
  case useDevelopmentServer
}

@Flag var serverChoice: ServerChoice
```

---

### Flag.init(help:)

**Summary:** Creates an array property with no default value that gets its values from the presence of zero or more flags, where the allowed flags are defined by an   type.

##### Discussion

This method is called to initialize an array `Flag` with no default value such as:

```swift
@Flag
var foo: [CustomFlagType]
```

---

### Argument.init(help:completion:)

**Summary:** Creates an optional property that reads its value from an argument.

##### Discussion

The argument is optional for the caller of the command and defaults to `nil`.

---

### Argument.init(help:completion:)

**Summary:** Creates a property with no default value.

##### Discussion

This method is called to initialize an `Argument` without a default value such as:

```swift
@Argument var foo: String
```

---

### Argument.init(help:completion:transform:)

**Summary:** Creates a property with no default value, parsing with the given closure.

##### Discussion

This method is called to initialize an `Argument` with no default value such as:

```swift
@Argument(transform: baz)
var foo: String
```

---

### Argument.init(help:completion:transform:)

**Summary:** Creates an optional property that reads its value from an argument.

##### Discussion

The argument is optional for the caller of the command and defaults to `nil`.

---

### Flag.init(name:help:)

**Summary:** Creates an integer property that gets its value from the number of times   a flag appears.

##### Discussion

This property defaults to a value of zero.

---

### Flag.init(name:inversion:exclusivity:help:)

**Summary:** Creates a Boolean property that reads its value from the presence of   one or more inverted flags.

##### Discussion

Use this initializer to create an optional Boolean flag with an on/off pair. With the following declaration, for example, the user can specify either `--use-https` or `--no-use-https` to set the `useHTTPS` flag to `true` or `false`, respectively. If neither is specified, the resulting flag value would be `nil`.

```
@Flag(inversion: .prefixedNo)
var useHTTPS: Bool?
```

---

### Flag.init(name:inversion:exclusivity:help:)

**Summary:** Creates a Boolean property with no default value that reads its value from the presence of one or more inverted flags.

##### Discussion

Use this initializer to create a Boolean flag with an on/off pair. With the following declaration, for example, the user can specify either `--use-https` or `--no-use-https` to set the `useHTTPS` flag to `true` or `false`, respectively.

```swift
@Flag(inversion: .prefixedNo)
var useHTTPS: Bool
```

---

### Option.init(name:parsing:help:completion:)

**Summary:** Creates an optional property that reads its value from a labeled option.

##### Discussion

This initializer is used when you declare an `@Option`-attributed property with an optional type and no default value:

```swift
@Option var count: Int?
```

---

### Option.init(name:parsing:help:completion:)

**Summary:** Creates a required property that reads its value from a labeled option.

##### Discussion

This initializer is used when you declare an `@Option`-attributed property that has an `ExpressibleByArgument` type, but without a default value:

```swift
@Option var title: String
```

---

### Option.init(name:parsing:help:completion:)

**Summary:** Creates a required array property that reads its values from zero or   more labeled options.

##### Discussion

This initializer is used when you declare an `@Option`-attributed array property without a default value:

```swift
@Option(name: .customLong("char"))
var chars: [Character]
```

---

### Option.init(name:parsing:help:completion:transform:)

**Summary:** Creates an optional property that reads its value from a labeled option,   parsing with the given closure.

##### Discussion

This initializer is used when you declare an `@Option`-attributed property with a transform closure and without a default value:

```swift
@Option(transform: { $0.first ?? " " })
var char: Character?
```

---

### Option.init(name:parsing:help:completion:transform:)

**Summary:** Creates a required property that reads its value from a labeled option,   parsing with the given closure.

##### Discussion

This initializer is used when you declare an `@Option`-attributed property with a transform closure and without a default value:

```swift
@Option(transform: { $0.first ?? " " })
var char: Character
```

---

### Option.init(name:parsing:help:completion:transform:)

**Summary:** Creates a required array property that reads its values from zero or   more labeled options, parsing each element with the given closure.

##### Discussion

This initializer is used when you declare an `@Option`-attributed array property with a transform closure and without a default value:

```swift
@Option(name: .customLong("char"), transform: { $0.first ?? " " })
var chars: [Character]
```

---

### Argument.init(parsing:help:completion:)

**Summary:** Creates a property with no default value that reads an array from zero or   more arguments.

##### Discussion

This method is called to initialize an array `Argument` with no default value such as:

```swift
@Argument()
var foo: [String]
```

---

### Argument.init(parsing:help:completion:transform:)

**Summary:** Creates a property with no default value that reads an array from zero or   more arguments, parsing each element with the given closure.

##### Discussion

This method is called to initialize an array `Argument` with no default value such as:

```swift
@Argument(transform: baz)
var foo: [String]
```

---

### Flag.init(wrappedValue:exclusivity:help:)

**Summary:** Creates a property with a default value provided by standard Swift default value syntax that gets its value from the presence of a flag.

##### Discussion

Use this initializer to customize the name and number of states further than using a `Bool`. To use, define an `EnumerableFlag` enumeration with a case for each state, and use that as the type for your flag. In this case, the user can specify either `--use-production-server` or `--use-development-server` to set the flag’s value.

```swift
enum ServerChoice: EnumerableFlag {
  case useProductionServer
  case useDevelopmentServer
}

@Flag var serverChoice: ServerChoice = .useProductionServer
```

---

### Flag.init(wrappedValue:help:)

**Summary:** Creates an array property that gets its values from the presence of   zero or more flags, where the allowed flags are defined by an    type.

##### Discussion

This property has an empty array as its default value.

---

### Argument.init(wrappedValue:help:completion:)

**Summary:** Creates a property with a default value provided by standard Swift default   value syntax.

##### Discussion

This method is called to initialize an `Argument` with a default value such as:

```swift
@Argument var foo: String = "bar"
```

---

### Argument.init(wrappedValue:help:completion:transform:)

**Summary:** Creates a property with a default value provided by standard Swift default   value syntax, parsing with the given closure.

##### Discussion

This method is called to initialize an `Argument` with a default value such as:

```swift
@Argument(transform: baz)
var foo: String = "bar"
```

---

### Flag.init(wrappedValue:name:inversion:exclusivity:help:)

**Summary:** Creates a Boolean property with default value provided by standard Swift default value syntax that reads its value from the presence of one or more inverted flags.

##### Discussion

Use this initializer to create a Boolean flag with an on/off pair. With the following declaration, for example, the user can specify either `--use-https` or `--no-use-https` to set the `useHTTPS` flag to `true` or `false`, respectively.

```swift
@Flag(inversion: .prefixedNo)
var useHTTPS: Bool = true
```

---

### Option.init(wrappedValue:name:parsing:help:completion:)

**Summary:** Creates a property with a default value that reads its value from a   labeled option.

##### Discussion

This initializer is used when you declare an `@Option`-attributed property that has an `ExpressibleByArgument` type, providing a default value:

```swift
@Option var title: String = "<Title>"
```

---

### Option.init(wrappedValue:name:parsing:help:completion:)

**Summary:** Creates an optional property that reads its value from a labeled option,   with an explicit   default.

##### Discussion

This initializer allows a user to provide a `nil` default value for an optional `@Option`-marked property:

```swift
@Option var count: Int? = nil
```

---

### Option.init(wrappedValue:name:parsing:help:completion:)

**Summary:** Creates an array property that reads its values from zero or   more labeled options.

##### Discussion

This initializer is used when you declare an `@Option`-attributed array property with a default value:

```swift
@Option(name: .customLong("char"))
var chars: [Character] = []
```

---

### Option.init(wrappedValue:name:parsing:help:completion:transform:)

**Summary:** Creates an optional property that reads its value from a labeled option,   parsing with the given closure, with an explicit   default.

##### Discussion

This initializer is used when you declare an `@Option`-attributed property with a transform closure and with a default value of `nil`:

```swift
@Option(transform: { $0.first ?? " " })
var char: Character? = nil
```

---

### Option.init(wrappedValue:name:parsing:help:completion:transform:)

**Summary:** Creates an array property that reads its values from zero or   more labeled options, parsing each element with the given closure.

##### Discussion

This initializer is used when you declare an `@Option`-attributed array property with a transform closure and a default value:

```swift
@Option(name: .customLong("char"), transform: { $0.first ?? " " })
var chars: [Character] = []
```

---

### Option.init(wrappedValue:name:parsing:help:completion:transform:)

**Summary:** Creates a property with a default value that reads its value from a   labeled option, parsing with the given closure.

##### Discussion

This initializer is used when you declare an `@Option`-attributed property with a transform closure and a default value:

```swift
@Option(transform: { $0.first ?? " " })
var char: Character = "_"
```

---

### CompletionKind.list(_:)

**Summary:** The completion candidates are the strings in the given array.

##### Discussion

Completion candidates are interpreted by the requesting shell as literals. They must be neither escaped nor quoted; Swift Argument Parser escapes or quotes them as necessary for the requesting shell.

The completion candidates are included in a completion script when it is generated.

---

### Element.long

**Summary:** Use the property’s name, converted to lowercase with words separated by   hyphens.

##### Discussion

For example, a property named `allowLongNames` would be converted to the label `--allow-long-names`.

---

### NameSpecification.long

**Summary:** Use the property’s name converted to lowercase with words separated by   hyphens.

##### Discussion

For example, a property named `allowLongNames` would be converted to the label `--allow-long-names`.

---

### ParsableCommand.main()

**Summary:** Executes this command, or one of its subcommands, with the program’s   command-line arguments.

##### Discussion

Instead of calling this method directly, you can add `@main` to the root command for your command-line tool.

This method parses an instance of this type, one of its subcommands, or another built-in `ParsableCommand` type, from command-line arguments, and then calls its `run()` method, exiting with a relevant error message if necessary.

---

### AsyncParsableCommand.main()

**Summary:** Executes this command, or one of its subcommands, with the program’s   command-line arguments.

##### Discussion

Instead of calling this method directly, you can add `@main` to the root command for your command-line tool.

This method parses an instance of this type, one of its subcommands, or another built-in `AsyncParsableCommand` type, from command-line arguments, and then calls its `run()` method, exiting with a relevant error message if necessary.

---

### AsyncParsableCommand.main(_:)

**Summary:** Executes this command, or one of its subcommands, with the given arguments.

##### Discussion

This method parses an instance of this type, one of its subcommands, or another built-in `AsyncParsableCommand` type, from command-line (or provided) arguments, and then calls its `run()` method, exiting with a relevant error message if necessary.

---

### ParsableCommand.main(_:)

**Summary:** Executes this command, or one of its subcommands, with the given   arguments.

##### Discussion

This method parses an instance of this type, one of its subcommands, or another built-in `ParsableCommand` type, from command-line arguments, and then calls its `run()` method, exiting with a relevant error message if necessary.

---

### ParsableArguments.message(for:)

**Summary:** Returns a brief message for the given error.

##### Return Value

A message that can be displayed to the user.

---

### EnumerableFlag.name(for:)

**Summary:** Returns the name specification to use for the given flag.

##### Discussion

The default implementation for this method always returns `.long`. Implement this method for your custom `EnumerableFlag` type to provide different name specifications for different cases.

---

### SingleValueParsingStrategy.next

**Summary:** Parse the input after the option and expect it to be a value.

##### Discussion

For inputs such as `--foo foo`, this would parse `foo` as the value. However, the input `--foo --bar foo bar` would result in an error. Even though two values are provided, they don’t succeed each option. Parsing would result in an error such as the following:

```
Error: Missing value for '--foo <foo>'
Usage: command [--foo <foo>]
```

This is the **default behavior** for `@Option`-wrapped properties.

---

### ParsableArguments.parse(_:)

**Summary:** Parses a new instance of this type from command-line arguments.

##### Return Value

A new instance of this type.

##### Discussion

> **Throws**
> > If parsing failed or arguments contains a help request.

---

### ParsableCommand.parseAsRoot(_:)

**Summary:** Parses an instance of this type, or one of its subcommands, from   command-line arguments.

##### Return Value

A new instance of this type, one of its subcommands, or a command type internal to the `ArgumentParser` library.

##### Discussion

> **Throws**
> > If parsing fails.

---

### ParsableArguments.parseOrExit(_:)

**Summary:** Parses a new instance of this type from command-line arguments or exits   with a relevant message.

##### Return Value

An instance of `Self` parsable properties populated with the provided argument values.

---

### ArgumentArrayParsingStrategy.postTerminator

**Summary:** Before parsing arguments, capture all inputs that follow the    terminator in this argument array.

##### Discussion

For example, the `Example` command defined below has a `words` array that uses the `postTerminator` parsing strategy:

```
@main
struct Example: ParsableCommand {
    @Flag var verbose = false
    @Argument var name = ""

    @Argument(parsing: .postTerminator)
    var words: [String]

    func run() {
        print(words.joined(separator: "\n"))
    }
}
```

Before looking for the `--verbose` flag and `<name>` argument, any inputs after the `--` terminator are captured into the `words` array.

```
$ example --verbose Asa -- one two --other
one
two
--other
$ example Asa Extra -- one two --other
Error: Unexpected argument 'Extra'
```

Because options are parsed before arguments, an option that consumes or suppresses the `--` terminator can prevent a `postTerminator` argument array from capturing any input. In particular, the Unconditional, Unconditional Single Value, and Remaining parsing strategies can all consume the terminator as part of their values.

> **Note**
> > This parsing strategy can be surprising for users, since it changes the behavior of the `--` terminator. Prefer Remaining whenever possible.

---

### FlagInversion.prefixedEnableDisable

**Summary:** Uses matching flags with   and   prefixes.

##### Discussion

For example, the `extraOutput` property in this declaration is set to `true` when a user provides `--enable-extra-output` and to `false` when the user provides `--disable-extra-output`:

```
@Flag(inversion: .prefixedEnableDisable)
var extraOutput: Bool
```

---

### FlagInversion.prefixedNo

**Summary:** Adds a matching flag with a   prefix to represent  .

##### Discussion

For example, the `shouldRender` property in this declaration is set to `true` when a user provides `--render` and to `false` when the user provides `--no-render`:

```
@Flag(name: .customLong("render"), inversion: .prefixedNo)
var shouldRender: Bool
```

---

### ArrayParsingStrategy.remaining

**Summary:** Parse all remaining arguments into an array.

##### Discussion

`.remaining` can be used for capturing pass-through flags. For example, for a parsable type defined as `@Option(parsing: .remaining) var passthrough: [String]`:

```
$ cmd --passthrough --foo 1 --bar 2 -xvf
------------
options.passthrough == ["--foo", "1", "--bar", "2", "-xvf"]
```

> **Note**
> > This will read all inputs following the option without attempting to do any parsing. This is usually not what users would expect. Use with caution.

Consider using a trailing `@Argument` instead and letting users explicitly turn off parsing through the terminator `--`. That is the more common approach. For example:

```swift
struct Options: ParsableArguments {
    @Option var title: String
    @Argument var remainder: [String]
}
```

would parse the input `--title Foo -- Bar --baz` such that the `remainder` would hold the value `["Bar", "--baz"]`.

---

### ArgumentArrayParsingStrategy.remaining

**Summary:** Parse only unprefixed values from the command-line input, ignoring   any inputs that have a dash prefix; this is the default strategy.

##### Discussion

`remaining` is the default parsing strategy for argument arrays.

For example, the `Example` command defined below has a `words` array that uses the `remaining` parsing strategy:

```
@main
struct Example: ParsableCommand {
    @Flag var verbose = false

    @Argument(parsing: .remaining)
    var words: [String]

    func run() {
        print(words.joined(separator: "\n"))
    }
}
```

Any non-dash-prefixed inputs will be captured in the `words` array.

```
$ example --verbose one two
one
two
$ example one two --verbose
one
two
$ example one two --other
Error: Unknown option '--other'
```

If a user uses the `--` terminator in their input, all following inputs will be captured in `words`.

```
$ example one two -- --verbose --other
one
two
--verbose
--other
```

---

### CompletionShell.requesting

**Summary:** The shell for which completions will be or are being requested.

##### Discussion

`CompletionShell.requesting` is non-`nil` only while generating a shell completion script or while a Swift custom completion function is executing to offer completions for a word from a command line (that is, while `customCompletion` from `@Option(completion: .custom(customCompletion))` executes).

---

### CompletionShell.requestingVersion

**Summary:** The shell version for which completions will be or are being requested.

##### Discussion

`CompletionShell.requestingVersion` is non-`nil` only while generating a shell completion script or while a Swift custom completion function is running (that is, while `customCompletion` from `@Option(completion: .custom(customCompletion))` executes).

---

### AsyncParsableCommand.run()

**Summary:** The behavior or functionality of this command.

##### Discussion

Implement this method in your `ParsableCommand`-conforming type with the functionality that this command represents.

This method has a default implementation that prints the help screen for this command.

---

### ParsableCommand.run()

**Summary:** The behavior or functionality of this command.

##### Discussion

Implement this method in your `ParsableCommand`-conforming type with the functionality that this command represents.

This method has a default implementation that prints the help screen for this command.

---

### SingleValueParsingStrategy.scanningForValue

**Summary:** Parse the next input, as long as that input can’t be interpreted as   an option or flag.

##### Discussion

> **Note**
> > This will skip other options and read ahead in the input to find the next available value. This may be unexpected for users. Use with caution.

For example, if `--foo` takes a value, then the input `--foo --bar bar` would be parsed such that the value `bar` is used for `--foo`.

---

### CompletionKind.shellCommand(_:)

**Summary:** The completion candidates are specified by the   output of the   given string run as a shell command when a user requests completions.

##### Discussion

Swift Argument Parser does not perform any escaping or quoting on the given shell command.

The given shell command is included in a completion script when it is generated.

---

### Element.short

**Summary:** Use the first character of the property’s name as a short option label.

##### Discussion

For example, a property named `verbose` would be converted to the label `-v`. Short labels can be combined into groups.

---

### NameSpecification.short

**Summary:** Use the first character of the property’s name as a short option label.

##### Discussion

For example, a property named `verbose` would be converted to the label `-v`. Short labels can be combined into groups.

---

### NameSpecification.shortAndLong

**Summary:** Combine the   and   specifications to allow both long   and short labels.

##### Discussion

For example, a property named `verbose` would be converted to both the long `--verbose` and short `-v` labels.

---

### ArrayParsingStrategy.singleValue

**Summary:** Parse one value per option, joining multiple into an array.

##### Discussion

For example, for a parsable type with a property defined as `@Option(parsing: .singleValue) var read: [String]`, the input `--read foo --read bar` would result in the array `["foo", "bar"]`. The same would be true for the input `--read=foo --read=bar`.

> **Note**
> > This follows the default behavior of differentiating between values and options. As such, the value for this option will be the next value (non-option) in the input. For the above example, the input `--read --name Foo Bar` would parse `Foo` into `read` (and `Bar` into `name`).

---

### CommandConfiguration.subcommands

**Summary:** An array of the types that define subcommands for this command.

##### Discussion

This property “flattens” the grouping structure of the subcommands. Use ‘ungroupedSubcommands’ to access ‘groupedSubcommands’ to retain the grouping structure.

---

### SingleValueParsingStrategy.unconditional

**Summary:** Parse the next input, even if it could be interpreted as an option or   flag.

##### Discussion

For inputs such as `--foo --bar baz`, if `.unconditional` is used for `foo`, this would read `--bar` as the value for `foo` and would use `baz` as the next positional argument.

This allows reading negative numeric values or capturing flags to be passed through to another program since the leading hyphen is normally interpreted as the start of another option.

> **Note**
> > This is usually not what users would expect. Use with caution.

---

### ArrayParsingStrategy.unconditionalSingleValue

**Summary:** Parse the value immediately after the option while allowing repeating options, joining multiple into an array.

##### Discussion

This is identical to `.singleValue` except that the value will be read from the input immediately after the option, even if it could be interpreted as an option.

For example, for a parsable type with a property defined as `@Option(parsing: .unconditionalSingleValue) var read: [String]`, the input `--read foo --read bar` would result in the array `["foo", "bar"]` – just as it would have been the case for `.singleValue`.

> **Note**
> > However, the input `--read --name Foo Bar --read baz` would result in `read` being set to the array `["--name", "baz"]`. This is usually not what users would expect. Use with caution.

---

### ArrayParsingStrategy.upToNextOption

**Summary:** Parse all values up to the next option.

##### Discussion

For example, for a parsable type with a property defined as `@Option(parsing: .upToNextOption) var files: [String]`, the input `--files foo bar` would result in the array `["foo", "bar"]`.

Parsing stops as soon as there’s another option in the input such that `--files foo bar --verbose` would also set `files` to the array `["foo", "bar"]`.

---

### CommandConfiguration.usage

**Summary:** A customized usage string to be shown in the help display and error   messages.

##### Discussion

If `usage` is `nil`, the help display and errors show the autogenerated usage string. To hide the usage string entirely, set `usage` to the empty string.

---

### ParsableCommand.usageString(for:includeHidden:)

**Summary:** Returns the usage text for the given subcommand of this command.

##### Return Value

The usage text for this type.

---

### ParsableArguments.usageString(includeHidden:)

**Summary:** Returns the usage text for this type.

##### Return Value

The usage text for this type.

---

### ParsableArguments.validate()

**Summary:** Validates the properties of the instance after parsing.

##### Discussion

Implement this method to perform validation or other processing after creating a new instance from command-line arguments.

---

### ArgumentHelp.valueName

**Summary:** An alternative name to use for the argument’s value when showing usage   information.

##### Discussion

> **Note**
> > This property is ignored when generating help for flags, since flags don’t include a value.

---

---

*Generated by docc2md - DocC Archive to Markdown Converter*
*For AI coding agents and documentation processing*
