import Foundation

/// ANSI color code support for terminal output.
public enum ColorSupport {
    /// ANSI color codes
    public static let reset = "\u{001B}[0m"
    public static let bold = "\u{001B}[1m"
    public static let gray = "\u{001B}[90m"
    public static let red = "\u{001B}[31m"
    public static let green = "\u{001B}[32m"
    public static let yellow = "\u{001B}[33m"
    public static let blue = "\u{001B}[34m"
    public static let magenta = "\u{001B}[35m"
    public static let cyan = "\u{001B}[36m"
    public static let white = "\u{001B}[37m"
    public static let brightBlue = "\u{001B}[94m"
    public static let brightMagenta = "\u{001B}[95m"
    public static let brightCyan = "\u{001B}[96m"

    /// All color codes to strip
    private static let colorCodes = [
        reset, bold, gray, red, green, yellow, blue, magenta, cyan, white,
        brightBlue, brightMagenta, brightCyan
    ]

    /// Strips all ANSI color codes from a string.
    ///
    /// - Parameter text: The text containing color codes
    /// - Returns: The text with all color codes removed
    public static func stripColors(_ text: String) -> String {
        var result = text
        for code in colorCodes {
            result = result.replacingOccurrences(of: code, with: "")
        }
        return result
    }

    /// Calculates the visible length of a string (excluding color codes).
    ///
    /// - Parameter text: The text to measure
    /// - Returns: The visible character count
    public static func visibleLength(_ text: String) -> Int {
        stripColors(text).count
    }
}
