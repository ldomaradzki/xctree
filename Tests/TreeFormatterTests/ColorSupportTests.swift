import Testing
@testable import TreeFormatter

@Suite("ColorSupport Tests")
struct ColorSupportTests {

    // MARK: - Color Code Constants Tests

    @Test("Reset color code is correct")
    func resetColorCode() {
        #expect(ColorSupport.reset == "\u{001B}[0m")
    }

    @Test("Bold color code is correct")
    func boldColorCode() {
        #expect(ColorSupport.bold == "\u{001B}[1m")
    }

    @Test("Gray color code is correct")
    func grayColorCode() {
        #expect(ColorSupport.gray == "\u{001B}[90m")
    }

    @Test("Red color code is correct")
    func redColorCode() {
        #expect(ColorSupport.red == "\u{001B}[31m")
    }

    @Test("Green color code is correct")
    func greenColorCode() {
        #expect(ColorSupport.green == "\u{001B}[32m")
    }

    @Test("Yellow color code is correct")
    func yellowColorCode() {
        #expect(ColorSupport.yellow == "\u{001B}[33m")
    }

    @Test("Blue color code is correct")
    func blueColorCode() {
        #expect(ColorSupport.blue == "\u{001B}[34m")
    }

    @Test("Magenta color code is correct")
    func magentaColorCode() {
        #expect(ColorSupport.magenta == "\u{001B}[35m")
    }

    @Test("Cyan color code is correct")
    func cyanColorCode() {
        #expect(ColorSupport.cyan == "\u{001B}[36m")
    }

    @Test("White color code is correct")
    func whiteColorCode() {
        #expect(ColorSupport.white == "\u{001B}[37m")
    }

    @Test("Bright blue color code is correct")
    func brightBlueColorCode() {
        #expect(ColorSupport.brightBlue == "\u{001B}[94m")
    }

    @Test("Bright magenta color code is correct")
    func brightMagentaColorCode() {
        #expect(ColorSupport.brightMagenta == "\u{001B}[95m")
    }

    @Test("Bright cyan color code is correct")
    func brightCyanColorCode() {
        #expect(ColorSupport.brightCyan == "\u{001B}[96m")
    }

    // MARK: - stripColors() Empty and Edge Cases

    @Test("Strips colors from empty string")
    func stripsColorsFromEmptyString() {
        let result = ColorSupport.stripColors("")
        #expect(result == "")
    }

    @Test("Strips colors from string with only reset code")
    func stripsOnlyResetCode() {
        let text = "\u{001B}[0m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "")
    }

    @Test("Strips colors from string with only bold code")
    func stripsOnlyBoldCode() {
        let text = "\u{001B}[1m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "")
    }

    @Test("Strips colors from string with only gray code")
    func stripsOnlyGrayCode() {
        let text = "\u{001B}[90m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "")
    }

    @Test("Strips colors from string with multiple color codes only")
    func stripsMultipleColorCodesOnly() {
        let text = "\u{001B}[1m\u{001B}[31m\u{001B}[0m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "")
    }

    // MARK: - stripColors() Single Color Code Tests

    @Test("Strips red color code from text")
    func stripsRedColorCode() {
        let text = "\u{001B}[31mError\u{001B}[0m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "Error")
    }

    @Test("Strips green color code from text")
    func stripsGreenColorCode() {
        let text = "\u{001B}[32mSuccess\u{001B}[0m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "Success")
    }

    @Test("Strips yellow color code from text")
    func stripsYellowColorCode() {
        let text = "\u{001B}[33mWarning\u{001B}[0m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "Warning")
    }

    @Test("Strips blue color code from text")
    func stripsBlueColorCode() {
        let text = "\u{001B}[34mInfo\u{001B}[0m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "Info")
    }

    @Test("Strips magenta color code from text")
    func stripsMagentaColorCode() {
        let text = "\u{001B}[35mDebug\u{001B}[0m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "Debug")
    }

    @Test("Strips cyan color code from text")
    func stripsCyanColorCode() {
        let text = "\u{001B}[36mTrace\u{001B}[0m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "Trace")
    }

    @Test("Strips white color code from text")
    func stripsWhiteColorCode() {
        let text = "\u{001B}[37mText\u{001B}[0m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "Text")
    }

    @Test("Strips gray color code from text")
    func stripsGrayColorCode() {
        let text = "\u{001B}[90mComment\u{001B}[0m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "Comment")
    }

    @Test("Strips bright blue color code from text")
    func stripsBrightBlueColorCode() {
        let text = "\u{001B}[94mHighlight\u{001B}[0m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "Highlight")
    }

    @Test("Strips bright magenta color code from text")
    func stripsBrightMagentaColorCode() {
        let text = "\u{001B}[95mEmphasis\u{001B}[0m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "Emphasis")
    }

    @Test("Strips bright cyan color code from text")
    func stripsBrightCyanColorCode() {
        let text = "\u{001B}[96mNotice\u{001B}[0m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "Notice")
    }

    @Test("Strips bold formatting from text")
    func stripsBoldFormatting() {
        let text = "\u{001B}[1mBold Text\u{001B}[0m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "Bold Text")
    }

    // MARK: - stripColors() Complex Combinations

    @Test("Strips bold and red color codes combined")
    func stripsBoldAndRed() {
        let text = "\u{001B}[1m\u{001B}[31mBold Red\u{001B}[0m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "Bold Red")
    }

    @Test("Strips multiple color codes in sequence")
    func stripsMultipleColorCodesInSequence() {
        let text = "\u{001B}[32mGreen\u{001B}[0m and \u{001B}[31mRed\u{001B}[0m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "Green and Red")
    }

    @Test("Strips nested color codes")
    func stripsNestedColorCodes() {
        let text = "\u{001B}[1m\u{001B}[32mStart \u{001B}[31mmiddle\u{001B}[32m end\u{001B}[0m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "Start middle end")
    }

    @Test("Strips all basic colors in one string")
    func stripsAllBasicColors() {
        let text = "\u{001B}[31mR\u{001B}[32mG\u{001B}[33mY\u{001B}[34mB\u{001B}[35mM\u{001B}[36mC\u{001B}[37mW\u{001B}[0m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "RGYBMCW")
    }

    @Test("Strips all bright colors in one string")
    func stripsAllBrightColors() {
        let text = "\u{001B}[94mBB\u{001B}[95mBM\u{001B}[96mBC\u{001B}[0m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "BBBMBC")
    }

    @Test("Strips color codes from text without reset code")
    func stripsColorCodesWithoutReset() {
        let text = "\u{001B}[31mError message"
        let result = ColorSupport.stripColors(text)
        #expect(result == "Error message")
    }

    @Test("Strips color codes from middle of text")
    func stripsColorCodesFromMiddle() {
        let text = "Start \u{001B}[32mcolored\u{001B}[0m end"
        let result = ColorSupport.stripColors(text)
        #expect(result == "Start colored end")
    }

    @Test("Strips multiple instances of same color code")
    func stripsMultipleInstancesOfSameColorCode() {
        let text = "\u{001B}[31mRed\u{001B}[0m and \u{001B}[31mRed\u{001B}[0m again"
        let result = ColorSupport.stripColors(text)
        #expect(result == "Red and Red again")
    }

    // MARK: - stripColors() Real-World Scenarios

    @Test("Strips colors from tree branch with colors")
    func stripsColorsFromTreeBranch() {
        let text = "\u{001B}[90m├── \u{001B}[0m\u{001B}[1mfile.txt\u{001B}[0m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "├── file.txt")
    }

    @Test("Strips colors from file path with decorations")
    func stripsColorsFromFilePathWithDecorations() {
        let text = "\u{001B}[36m/Users/test/\u{001B}[1mdocument.pdf\u{001B}[0m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "/Users/test/document.pdf")
    }

    @Test("Strips colors from multi-line text")
    func stripsColorsFromMultiLineText() {
        let text = "\u{001B}[32mLine 1\u{001B}[0m\n\u{001B}[31mLine 2\u{001B}[0m\n\u{001B}[33mLine 3\u{001B}[0m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "Line 1\nLine 2\nLine 3")
    }

    @Test("Strips colors from text with special characters")
    func stripsColorsWithSpecialCharacters() {
        let text = "\u{001B}[32m└── 📁 Folder\u{001B}[0m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "└── 📁 Folder")
    }

    @Test("Strips colors from text with unicode characters")
    func stripsColorsWithUnicodeCharacters() {
        let text = "\u{001B}[32mHello 世界\u{001B}[0m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "Hello 世界")
    }

    @Test("Strips colors preserving whitespace")
    func stripsColorsPreservingWhitespace() {
        let text = "\u{001B}[32m  Indented  Text  \u{001B}[0m"
        let result = ColorSupport.stripColors(text)
        #expect(result == "  Indented  Text  ")
    }

    @Test("Strips colors from long text")
    func stripsColorsFromLongText() {
        let longText = String(repeating: "\u{001B}[32mLorem ipsum dolor sit amet. ", count: 10) + "\u{001B}[0m"
        let result = ColorSupport.stripColors(longText)
        #expect(!result.contains("\u{001B}"))
        #expect(result.hasPrefix("Lorem ipsum"))
    }

    // MARK: - visibleLength() Empty and Edge Cases

    @Test("Visible length of empty string is zero")
    func visibleLengthOfEmptyString() {
        let result = ColorSupport.visibleLength("")
        #expect(result == 0)
    }

    @Test("Visible length of string with only color codes is zero")
    func visibleLengthOfOnlyColorCodes() {
        let text = "\u{001B}[31m\u{001B}[0m"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 0)
    }

    @Test("Visible length of string with multiple color codes only is zero")
    func visibleLengthOfMultipleColorCodesOnly() {
        let text = "\u{001B}[1m\u{001B}[31m\u{001B}[32m\u{001B}[0m"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 0)
    }

    // MARK: - visibleLength() Plain Text Tests

    @Test("Visible length of plain text without colors")
    func visibleLengthOfPlainText() {
        let text = "Hello"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 5)
    }

    @Test("Visible length of plain text with spaces")
    func visibleLengthOfPlainTextWithSpaces() {
        let text = "Hello World"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 11)
    }

    @Test("Visible length of single character")
    func visibleLengthOfSingleCharacter() {
        let text = "A"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 1)
    }

    @Test("Visible length of whitespace only")
    func visibleLengthOfWhitespaceOnly() {
        let text = "   "
        let result = ColorSupport.visibleLength(text)
        #expect(result == 3)
    }

    @Test("Visible length of newline character")
    func visibleLengthOfNewline() {
        let text = "\n"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 1)
    }

    @Test("Visible length of tab character")
    func visibleLengthOfTab() {
        let text = "\t"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 1)
    }

    // MARK: - visibleLength() With Color Codes

    @Test("Visible length excludes red color codes")
    func visibleLengthExcludesRedColorCodes() {
        let text = "\u{001B}[31mError\u{001B}[0m"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 5)
    }

    @Test("Visible length excludes green color codes")
    func visibleLengthExcludesGreenColorCodes() {
        let text = "\u{001B}[32mSuccess\u{001B}[0m"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 7)
    }

    @Test("Visible length excludes yellow color codes")
    func visibleLengthExcludesYellowColorCodes() {
        let text = "\u{001B}[33mWarning\u{001B}[0m"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 7)
    }

    @Test("Visible length excludes blue color codes")
    func visibleLengthExcludesBlueColorCodes() {
        let text = "\u{001B}[34mInfo\u{001B}[0m"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 4)
    }

    @Test("Visible length excludes magenta color codes")
    func visibleLengthExcludesMagentaColorCodes() {
        let text = "\u{001B}[35mDebug\u{001B}[0m"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 5)
    }

    @Test("Visible length excludes cyan color codes")
    func visibleLengthExcludesCyanColorCodes() {
        let text = "\u{001B}[36mTrace\u{001B}[0m"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 5)
    }

    @Test("Visible length excludes white color codes")
    func visibleLengthExcludesWhiteColorCodes() {
        let text = "\u{001B}[37mText\u{001B}[0m"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 4)
    }

    @Test("Visible length excludes gray color codes")
    func visibleLengthExcludesGrayColorCodes() {
        let text = "\u{001B}[90mComment\u{001B}[0m"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 7)
    }

    @Test("Visible length excludes bright blue color codes")
    func visibleLengthExcludesBrightBlueColorCodes() {
        let text = "\u{001B}[94mHighlight\u{001B}[0m"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 9)
    }

    @Test("Visible length excludes bright magenta color codes")
    func visibleLengthExcludesBrightMagentaColorCodes() {
        let text = "\u{001B}[95mEmphasis\u{001B}[0m"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 8)
    }

    @Test("Visible length excludes bright cyan color codes")
    func visibleLengthExcludesBrightCyanColorCodes() {
        let text = "\u{001B}[96mNotice\u{001B}[0m"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 6)
    }

    @Test("Visible length excludes bold formatting")
    func visibleLengthExcludesBoldFormatting() {
        let text = "\u{001B}[1mBold Text\u{001B}[0m"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 9)
    }

    // MARK: - visibleLength() Complex Scenarios

    @Test("Visible length with bold and color combined")
    func visibleLengthWithBoldAndColor() {
        let text = "\u{001B}[1m\u{001B}[31mBold Red\u{001B}[0m"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 8)
    }

    @Test("Visible length with multiple colored segments")
    func visibleLengthWithMultipleColoredSegments() {
        let text = "\u{001B}[32mGreen\u{001B}[0m and \u{001B}[31mRed\u{001B}[0m"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 13)
    }

    @Test("Visible length with nested color codes")
    func visibleLengthWithNestedColorCodes() {
        let text = "\u{001B}[1m\u{001B}[32mStart \u{001B}[31mmiddle\u{001B}[32m end\u{001B}[0m"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 16)
    }

    @Test("Visible length with colors in middle of text")
    func visibleLengthWithColorsInMiddle() {
        let text = "Start \u{001B}[32mcolored\u{001B}[0m end"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 17)
    }

    @Test("Visible length equals plain text length")
    func visibleLengthEqualsPlainTextLength() {
        let plainText = "Hello World"
        let coloredText = "\u{001B}[32mHello World\u{001B}[0m"
        #expect(ColorSupport.visibleLength(coloredText) == plainText.count)
    }

    @Test("Visible length with unicode emoji")
    func visibleLengthWithUnicodeEmoji() {
        let text = "\u{001B}[32m📁 Folder\u{001B}[0m"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 8)
    }

    @Test("Visible length with multi-byte unicode characters")
    func visibleLengthWithMultiByteUnicode() {
        let text = "\u{001B}[32m世界\u{001B}[0m"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 2)
    }

    @Test("Visible length preserves line breaks")
    func visibleLengthPreservesLineBreaks() {
        let text = "\u{001B}[32mLine 1\u{001B}[0m\n\u{001B}[31mLine 2\u{001B}[0m"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 13)
    }

    @Test("Visible length with leading and trailing spaces")
    func visibleLengthWithLeadingTrailingSpaces() {
        let text = "\u{001B}[32m  Text  \u{001B}[0m"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 8)
    }

    @Test("Visible length of tree structure with colors")
    func visibleLengthOfTreeStructureWithColors() {
        let text = "\u{001B}[90m├── \u{001B}[0m\u{001B}[1mfile.txt\u{001B}[0m"
        let result = ColorSupport.visibleLength(text)
        #expect(result == 12)
    }

    // MARK: - Integration Tests

    @Test("stripColors and visibleLength consistency")
    func stripColorsAndVisibleLengthConsistency() {
        let text = "\u{001B}[32mHello\u{001B}[0m"
        let stripped = ColorSupport.stripColors(text)
        let visibleLen = ColorSupport.visibleLength(text)
        #expect(visibleLen == stripped.count)
    }

    @Test("stripColors and visibleLength with empty input")
    func stripColorsAndVisibleLengthWithEmptyInput() {
        let text = ""
        let stripped = ColorSupport.stripColors(text)
        let visibleLen = ColorSupport.visibleLength(text)
        #expect(stripped.isEmpty)
        #expect(visibleLen == 0)
    }

    @Test("stripColors and visibleLength with plain text")
    func stripColorsAndVisibleLengthWithPlainText() {
        let text = "Plain text"
        let stripped = ColorSupport.stripColors(text)
        let visibleLen = ColorSupport.visibleLength(text)
        #expect(stripped == text)
        #expect(visibleLen == text.count)
    }

    @Test("stripColors and visibleLength with all color types")
    func stripColorsAndVisibleLengthWithAllColorTypes() {
        let text = "\u{001B}[31mR\u{001B}[32mG\u{001B}[33mY\u{001B}[34mB\u{001B}[35mM\u{001B}[36mC\u{001B}[37mW\u{001B}[90mG\u{001B}[94mBB\u{001B}[95mBM\u{001B}[96mBC\u{001B}[0m"
        let stripped = ColorSupport.stripColors(text)
        let visibleLen = ColorSupport.visibleLength(text)
        #expect(stripped == "RGYBMCWGBBBMBC")
        #expect(visibleLen == 14)
    }

    @Test("stripColors and visibleLength with complex real-world example")
    func stripColorsAndVisibleLengthWithComplexExample() {
        let text = "\u{001B}[90m│   \u{001B}[0m\u{001B}[90m├── \u{001B}[0m\u{001B}[1m\u{001B}[34mSources\u{001B}[0m"
        let stripped = ColorSupport.stripColors(text)
        let visibleLen = ColorSupport.visibleLength(text)
        #expect(stripped == "│   ├── Sources")
        #expect(visibleLen == stripped.count)
        #expect(visibleLen == 15)
    }
}
