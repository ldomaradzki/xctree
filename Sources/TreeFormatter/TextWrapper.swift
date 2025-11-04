import Foundation

/// Handles text wrapping with indentation support.
public enum TextWrapper {
    /// Wraps text to fit within a maximum width while preserving indentation.
    ///
    /// - Parameters:
    ///   - text: The text to wrap
    ///   - prefix: The prefix to add to each line (e.g., indentation)
    ///   - maxWidth: The maximum line width including prefix
    ///   - useColors: Whether the text contains color codes
    /// - Returns: Array of wrapped lines
    public static func wrap(
        _ text: String,
        prefix: String,
        maxWidth: Int,
        useColors: Bool = false
    ) -> [String] {
        var lines: [String] = []
        let availableWidth = maxWidth - (useColors ? ColorSupport.visibleLength(prefix) : prefix.count)
        var remaining = text

        // Handle edge case: if availableWidth is 0 or negative, we must advance 1 char at a time
        let effectiveWidth = max(1, availableWidth)

        while !remaining.isEmpty {
            if (useColors ? ColorSupport.visibleLength(remaining) : remaining.count) <= effectiveWidth {
                lines.append("\(prefix)\(remaining)")
                break
            }

            // Find last space before limit
            let cutIndex = remaining.index(remaining.startIndex, offsetBy: effectiveWidth)
            if let spaceIndex = remaining[..<cutIndex].lastIndex(of: " ") {
                let line = remaining[..<spaceIndex]
                lines.append("\(prefix)\(line)")
                remaining = String(remaining[remaining.index(after: spaceIndex)...])
            } else {
                // No space found, hard cut
                let line = remaining[..<cutIndex]
                lines.append("\(prefix)\(line)")
                remaining = String(remaining[cutIndex...])
            }
        }

        return lines
    }

    /// Wraps text with indentation and prints to stdout.
    ///
    /// - Parameters:
    ///   - text: The text to wrap and print
    ///   - prefix: The prefix to add to each line
    ///   - maxWidth: The maximum line width
    ///   - color: Optional color code to wrap the text in
    public static func print(
        _ text: String,
        prefix: String,
        maxWidth: Int,
        color: String = ""
    ) {
        let closeColor = color.isEmpty ? "" : ColorSupport.reset
        let useColors = !color.isEmpty

        let lines = wrap(text, prefix: prefix, maxWidth: maxWidth, useColors: useColors)
        for line in lines {
            if !color.isEmpty {
                Swift.print("\(color)\(line)\(closeColor)")
            } else {
                Swift.print(line)
            }
        }
    }
}
