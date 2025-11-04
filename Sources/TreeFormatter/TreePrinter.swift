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
        // Determine tree characters
        let connector = isLast ? "└──" : "├──"
        let continuation = isLast ? "    " : "│   "

        // Print the role/type as the main line
        let role = element.role ?? "AXElement"
        var roleLine = "\(prefix)\(connector) "

        if config.useColors {
            roleLine += "\(ColorSupport.magenta)\(role)\(ColorSupport.reset)"
        } else {
            roleLine += role
        }

        // Show short label on same line for clarity
        if let label = element.label, !label.isEmpty, label.count < 30 {
            if config.useColors {
                roleLine += " - \(ColorSupport.bold)\(label)\(ColorSupport.reset)"
            } else {
                roleLine += " - \(label)"
            }
        }

        Swift.print(roleLine)

        // Print attributes on subsequent lines
        let attrPrefix = prefix + continuation

        printAttribute(name: "label", value: element.label ?? element.title, prefix: attrPrefix, config: config)
        printAttribute(name: "value", value: element.value, prefix: attrPrefix, config: config)

        if let traits = element.traits, !traits.isEmpty {
            let traitsStr = "[\(traits.joined(separator: ", "))]"
            printAttribute(name: "traits", value: traitsStr, prefix: attrPrefix, config: config, color: config.useColors ? ColorSupport.gray : "")
        }

        printAttribute(name: "id", value: element.identifier, prefix: attrPrefix, config: config, color: config.useColors ? ColorSupport.cyan : "")
        printAttribute(name: "hint", value: element.hint, prefix: attrPrefix, config: config)

        // Print children
        for (index, child) in element.children.enumerated() {
            let childIsLast = index == element.children.count - 1
            print(child, depth: depth + 1, isLast: childIsLast, prefix: prefix + continuation, config: config)
        }
    }

    /// Prints multiple root elements as siblings.
    ///
    /// - Parameters:
    ///   - elements: The elements to print
    ///   - config: Printing configuration
    public static func printRoots(_ elements: [PrintableElement], config: TreePrinterConfig = TreePrinterConfig()) {
        for (index, element) in elements.enumerated() {
            let isLast = index == elements.count - 1
            print(element, depth: 0, isLast: isLast, prefix: "", config: config)
        }
    }

    private static func printAttribute(
        name: String,
        value: String?,
        prefix: String,
        config: TreePrinterConfig,
        color: String = ""
    ) {
        guard let value = value, !value.isEmpty else { return }

        // Skip label if it was already shown inline
        if name == "label" && value.count < 30 {
            return
        }

        let closeColor = color.isEmpty ? "" : ColorSupport.reset
        let testLine = "\(prefix)\(name): \(value)"

        // Calculate visible length
        let visibleLength = config.useColors ? ColorSupport.visibleLength(testLine) : testLine.count

        if visibleLength <= config.maxWidth {
            // Fits on one line
            if !color.isEmpty {
                Swift.print("\(prefix)\(name): \(color)\(value)\(closeColor)")
            } else {
                Swift.print("\(prefix)\(name): \(value)")
            }
        } else {
            // Too long - split into multiple lines
            Swift.print("\(prefix)\(name):")
            let valuePrefix = prefix + "  "
            TextWrapper.print(value, prefix: valuePrefix, maxWidth: config.maxWidth, color: color)
        }
    }
}
