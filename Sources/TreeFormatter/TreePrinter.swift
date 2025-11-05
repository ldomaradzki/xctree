import Foundation

/// Configuration for tree printing.
public struct TreePrinterConfig {
    public let maxWidth: Int
    public let useColors: Bool

    public init(maxWidth: Int = 80, useColors: Bool = true) {
        self.maxWidth = maxWidth
        self.useColors = useColors
    }
}

/// Element data to print in tree format.
public struct PrintableElement {
    public let role: String?
    public let label: String?
    public let title: String?
    public let value: String?
    public let identifier: String?
    public let hint: String?
    public let traits: [String]?
    public let children: [PrintableElement]

    public init(
        role: String?,
        label: String?,
        title: String? = nil,
        value: String? = nil,
        identifier: String? = nil,
        hint: String? = nil,
        traits: [String]? = nil,
        children: [PrintableElement] = []
    ) {
        self.role = role
        self.label = label
        self.title = title
        self.value = value
        self.identifier = identifier
        self.hint = hint
        self.traits = traits
        self.children = children
    }
}

/// Prints accessibility trees with visual connectors and formatting.
public enum TreePrinter {
    /// Formats an element and its children as a tree structure string.
    ///
    /// - Parameters:
    ///   - element: The element to format
    ///   - depth: Current depth in the tree (for recursion)
    ///   - isLast: Whether this is the last sibling
    ///   - prefix: Current line prefix (for indentation)
    ///   - config: Formatting configuration
    /// - Returns: Formatted tree string
    public static func format(
        _ element: PrintableElement,
        depth: Int = 0,
        isLast: Bool = true,
        prefix: String = "",
        config: TreePrinterConfig = TreePrinterConfig()
    ) -> String {
        var lines: [String] = []

        // Determine tree characters
        let connector = isLast ? "└──" : "├──"
        let continuation = isLast ? "    " : "│   "

        // Build the role/type as the main line
        let role = element.role ?? "AXElement"
        var roleLine = "\(prefix)\(connector) "

        if config.useColors {
            roleLine += "\(ColorSupport.magenta)\(role)\(ColorSupport.reset)"
        } else {
            roleLine += role
        }

        lines.append(roleLine)

        // Format attributes on subsequent lines
        let attrPrefix = prefix + continuation

        lines.append(contentsOf: formatAttribute(name: "label", value: element.label ?? element.title, prefix: attrPrefix, config: config, color: config.useColors ? ColorSupport.bold : ""))
        lines.append(contentsOf: formatAttribute(name: "value", value: element.value, prefix: attrPrefix, config: config))

        if let traits = element.traits, !traits.isEmpty {
            let traitsStr = "[\(traits.joined(separator: ", "))]"
            lines.append(contentsOf: formatAttribute(name: "traits", value: traitsStr, prefix: attrPrefix, config: config, color: config.useColors ? ColorSupport.gray : ""))
        }

        lines.append(contentsOf: formatAttribute(name: "id", value: element.identifier, prefix: attrPrefix, config: config, color: config.useColors ? ColorSupport.cyan : ""))
        lines.append(contentsOf: formatAttribute(name: "hint", value: element.hint, prefix: attrPrefix, config: config))

        // Format children
        for (index, child) in element.children.enumerated() {
            let childIsLast = index == element.children.count - 1
            lines.append(format(child, depth: depth + 1, isLast: childIsLast, prefix: prefix + continuation, config: config))
        }

        return lines.joined(separator: "\n")
    }

    /// Prints an element and its children as a tree structure.
    ///
    /// - Parameters:
    ///   - element: The element to print
    ///   - depth: Current depth in the tree (for recursion)
    ///   - isLast: Whether this is the last sibling
    ///   - prefix: Current line prefix (for indentation)
    ///   - config: Printing configuration
    public static func print(
        _ element: PrintableElement,
        depth: Int = 0,
        isLast: Bool = true,
        prefix: String = "",
        config: TreePrinterConfig = TreePrinterConfig()
    ) {
        let output = format(element, depth: depth, isLast: isLast, prefix: prefix, config: config)
        Swift.print(output)
    }

    /// Formats multiple root elements as siblings.
    ///
    /// - Parameters:
    ///   - elements: The elements to format
    ///   - config: Formatting configuration
    /// - Returns: Formatted tree string
    public static func formatRoots(_ elements: [PrintableElement], config: TreePrinterConfig = TreePrinterConfig()) -> String {
        var lines: [String] = []
        for (index, element) in elements.enumerated() {
            let isLast = index == elements.count - 1
            lines.append(format(element, depth: 0, isLast: isLast, prefix: "", config: config))
        }
        return lines.joined(separator: "\n")
    }

    /// Prints multiple root elements as siblings.
    ///
    /// - Parameters:
    ///   - elements: The elements to print
    ///   - config: Printing configuration
    public static func printRoots(_ elements: [PrintableElement], config: TreePrinterConfig = TreePrinterConfig()) {
        let output = formatRoots(elements, config: config)
        Swift.print(output)
    }

    private static func formatAttribute(
        name: String,
        value: String?,
        prefix: String,
        config: TreePrinterConfig,
        color: String = ""
    ) -> [String] {
        guard let value = value, !value.isEmpty else { return [] }

        let closeColor = color.isEmpty ? "" : ColorSupport.reset
        let testLine = "\(prefix)\(name): \(value)"

        // Calculate visible length
        let visibleLength = config.useColors ? ColorSupport.visibleLength(testLine) : testLine.count

        if visibleLength <= config.maxWidth {
            // Fits on one line
            if !color.isEmpty {
                return ["\(prefix)\(name): \(color)\(value)\(closeColor)"]
            } else {
                return ["\(prefix)\(name): \(value)"]
            }
        } else {
            // Too long - split into multiple lines
            let valuePrefix = prefix + "  "
            let wrappedLines = TextWrapper.wrap(value, prefix: valuePrefix, maxWidth: config.maxWidth)

            var lines = ["\(prefix)\(name):"]
            for line in wrappedLines {
                if !color.isEmpty {
                    lines.append("\(color)\(line)\(closeColor)")
                } else {
                    lines.append(line)
                }
            }
            return lines
        }
    }
}
