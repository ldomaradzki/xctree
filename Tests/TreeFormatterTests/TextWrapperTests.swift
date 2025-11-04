import Testing
@testable import TreeFormatter

@Suite("TextWrapper Tests")
struct TextWrapperTests {

    // MARK: - Basic Wrapping Tests

    @Test("Wraps text at 40 characters width")
    func wrapsTextAt40Characters() {
        let text = "This is a longer piece of text that should wrap at forty characters width limit"
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 40)

        #expect(result.count > 1)
        for line in result {
            #expect(line.count <= 40)
        }
    }

    @Test("Wraps text at 80 characters width")
    func wrapsTextAt80Characters() {
        let text = "This is a moderately long sentence that demonstrates text wrapping behavior at eighty character width which is a common terminal width setting"
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 80)

        #expect(result.count > 1)
        for line in result {
            #expect(line.count <= 80)
        }
    }

    @Test("Wraps text at 120 characters width")
    func wrapsTextAt120Characters() {
        let text = "This is an even longer sentence designed to test the text wrapping functionality at one hundred twenty characters width which is another popular terminal configuration used by many developers who prefer wider displays"
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 120)

        #expect(result.count > 1)
        for line in result {
            #expect(line.count <= 120)
        }
    }

    // MARK: - Prefix/Indentation Tests

    @Test("Wraps text with simple prefix")
    func wrapsTextWithSimplePrefix() {
        let text = "This is some text that needs to be wrapped with a prefix added to each line"
        let prefix = "  "
        let result = TextWrapper.wrap(text, prefix: prefix, maxWidth: 40)

        #expect(result.count > 1)
        for line in result {
            #expect(line.hasPrefix(prefix))
            #expect(line.count <= 40)
        }
    }

    @Test("Wraps text with longer indentation prefix")
    func wrapsTextWithLongerIndentation() {
        let text = "Text with substantial indentation should still wrap correctly"
        let prefix = "      "
        let result = TextWrapper.wrap(text, prefix: prefix, maxWidth: 50)

        #expect(result.count > 0)
        for line in result {
            #expect(line.hasPrefix(prefix))
            #expect(line.count <= 50)
        }
    }

    @Test("Wraps text with tree symbol prefix")
    func wrapsTextWithTreeSymbolPrefix() {
        let text = "This simulates tree output with proper indentation and wrapping behavior"
        let prefix = "├── "
        let result = TextWrapper.wrap(text, prefix: prefix, maxWidth: 40)

        #expect(result.count > 1)
        for line in result {
            #expect(line.hasPrefix(prefix))
        }
    }

    @Test("Accounts for prefix in available width calculation")
    func accountsForPrefixInWidthCalculation() {
        let text = "Short"
        let prefix = "          " // 10 characters
        let result = TextWrapper.wrap(text, prefix: prefix, maxWidth: 20)

        #expect(result.count == 1)
        #expect(result[0] == "          Short")
        #expect(result[0].count == 15)
    }

    // MARK: - Single Line Tests (No Wrapping Needed)

    @Test("Returns single line for text that fits within width")
    func returnsSingleLineForShortText() {
        let text = "Short text"
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 80)

        #expect(result.count == 1)
        #expect(result[0] == text)
    }

    @Test("Returns single line with prefix when text fits")
    func returnsSingleLineWithPrefix() {
        let text = "Fits in one line"
        let prefix = ">> "
        let result = TextWrapper.wrap(text, prefix: prefix, maxWidth: 80)

        #expect(result.count == 1)
        #expect(result[0] == ">> Fits in one line")
    }

    @Test("Returns single line for text exactly at width limit")
    func returnsSingleLineAtExactWidth() {
        let text = "This text has exactly 40 characters!!!!!"
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 40)

        #expect(result.count == 1)
        #expect(result[0].count == 40)
    }

    @Test("Returns single line when prefix plus text equals max width")
    func returnsSingleLineWithPrefixAtExactWidth() {
        let text = "Twenty characters!!!" // 20 chars
        let prefix = "12345" // 5 chars
        let result = TextWrapper.wrap(text, prefix: prefix, maxWidth: 25)

        #expect(result.count == 1)
        #expect(result[0] == "12345Twenty characters!!!")
    }

    // MARK: - Hard Break Tests (No Spaces)

    @Test("Performs hard break on text without spaces")
    func performsHardBreakOnTextWithoutSpaces() {
        let text = "ThisIsAVeryLongWordWithNoSpacesThatNeedsToBeHardWrapped"
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 20)

        #expect(result.count > 1)
        for line in result {
            #expect(line.count <= 20)
        }
    }

    @Test("Hard breaks long URL correctly")
    func hardBreaksLongURL() {
        let text = "https://example.com/very/long/path/without/spaces/that/needs/wrapping"
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 30)

        #expect(result.count > 1)
        for line in result {
            #expect(line.count <= 30)
        }
    }

    @Test("Hard breaks with prefix applied to each line")
    func hardBreaksWithPrefix() {
        let text = "NoSpacesInThisLongTextAtAll"
        let prefix = ">> "
        let result = TextWrapper.wrap(text, prefix: prefix, maxWidth: 15)

        #expect(result.count > 1)
        for line in result {
            #expect(line.hasPrefix(prefix))
            #expect(line.count <= 15)
        }
    }

    @Test("Hard breaks when first word exceeds available width")
    func hardBreaksFirstWordExceedingWidth() {
        let text = "Supercalifragilisticexpialidocious word"
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 20)

        #expect(result.count > 1)
        #expect(result[0].count == 20)
    }

    // MARK: - Empty and Edge Case Tests

    @Test("Handles empty string gracefully")
    func handlesEmptyString() {
        let text = ""
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 80)

        #expect(result.isEmpty)
    }

    @Test("Handles empty string with prefix")
    func handlesEmptyStringWithPrefix() {
        let text = ""
        let prefix = ">> "
        let result = TextWrapper.wrap(text, prefix: prefix, maxWidth: 80)

        #expect(result.isEmpty)
    }

    @Test("Handles single character text")
    func handlesSingleCharacter() {
        let text = "A"
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 80)

        #expect(result.count == 1)
        #expect(result[0] == "A")
    }

    @Test("Handles single space text")
    func handlesSingleSpace() {
        let text = " "
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 80)

        #expect(result.count == 1)
        #expect(result[0] == " ")
    }

    @Test("Handles text with only spaces")
    func handlesOnlySpaces() {
        let text = "     "
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 10)

        #expect(result.count == 1)
        #expect(result[0] == "     ")
    }

    @Test("Handles very small width limit")
    func handlesVerySmallWidth() {
        let text = "Hello World"
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 5)

        #expect(result.count > 1)
        for line in result {
            #expect(line.count <= 5)
        }
    }

    @Test("Handles width of 1 character")
    func handlesWidthOfOne() {
        let text = "Hi"
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 1)

        #expect(result.count == 2)
        #expect(result[0] == "H")
        #expect(result[1] == "i")
    }

    // MARK: - Space Handling Tests

    @Test("Wraps at last space before width limit")
    func wrapsAtLastSpaceBeforeLimit() {
        let text = "One Two Three Four Five Six Seven"
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 20)

        #expect(result.count > 1)
        for line in result {
            #expect(line.count <= 20)
            // Should not start with space (trimmed after wrap)
            if line.count > 0 && line != result[0] {
                #expect(!line.hasPrefix(" "))
            }
        }
    }

    @Test("Removes leading space from continuation lines")
    func removesLeadingSpaceFromContinuationLines() {
        let text = "This is a test of space handling in wrapped text"
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 15)

        #expect(result.count > 1)
        for (index, line) in result.enumerated() {
            if index > 0 {
                // Continuation lines should not start with space
                #expect(!line.hasPrefix(" "))
            }
        }
    }

    @Test("Handles multiple consecutive spaces")
    func handlesMultipleConsecutiveSpaces() {
        let text = "Word1    Word2    Word3"
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 15)

        #expect(result.count > 0)
        // Should wrap at spaces
        for line in result {
            #expect(line.count <= 15)
        }
    }

    // MARK: - Color Code Tests (useColors parameter)

    @Test("Wraps text with color codes using useColors parameter")
    func wrapsTextWithColorCodes() {
        let text = "\u{001B}[31mRed\u{001B}[0m text and \u{001B}[32mGreen\u{001B}[0m text"
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 20, useColors: true)

        #expect(result.count > 0)
        // Visible length should be considered, not actual string length
        for line in result {
            let visibleLength = ColorSupport.visibleLength(line)
            #expect(visibleLength <= 20)
        }
    }

    @Test("Accounts for color codes in prefix with useColors")
    func accountsForColorCodesInPrefix() {
        let text = "Some text to wrap"
        let prefix = "\u{001B}[34m>>\u{001B}[0m " // Blue >> with reset
        let result = TextWrapper.wrap(text, prefix: prefix, maxWidth: 20, useColors: true)

        #expect(result.count > 0)
        for line in result {
            #expect(line.hasPrefix(prefix))
            let visibleLength = ColorSupport.visibleLength(line)
            #expect(visibleLength <= 20)
        }
    }

    @Test("Wraps long colored text correctly")
    func wrapsLongColoredText() {
        let text = "\u{001B}[1m\u{001B}[33mThis is a very long piece of bold yellow text that should wrap properly\u{001B}[0m"
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 30, useColors: true)

        #expect(result.count > 1)
        for line in result {
            let visibleLength = ColorSupport.visibleLength(line)
            #expect(visibleLength <= 30)
        }
    }

    @Test("Handles mixed colored and plain text")
    func handlesMixedColoredAndPlainText() {
        let text = "Plain \u{001B}[31mred\u{001B}[0m plain \u{001B}[32mgreen\u{001B}[0m plain"
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 15, useColors: true)

        #expect(result.count > 0)
        for line in result {
            let visibleLength = ColorSupport.visibleLength(line)
            #expect(visibleLength <= 15)
        }
    }

    @Test("Wraps text without useColors parameter defaults to false")
    func wrapsWithoutUseColorsDefaultsToFalse() {
        let text = "Simple text without colors"
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 20)

        #expect(result.count > 1)
        for line in result {
            #expect(line.count <= 20)
        }
    }

    @Test("Different behavior with useColors true vs false on colored text")
    func differentBehaviorWithUseColorsFlag() {
        let coloredText = "\u{001B}[31mRed\u{001B}[0m"

        // With useColors = false, counts actual characters including escape codes
        let resultWithoutColors = TextWrapper.wrap(coloredText, prefix: "", maxWidth: 5, useColors: false)

        // With useColors = true, counts only visible characters
        let resultWithColors = TextWrapper.wrap(coloredText, prefix: "", maxWidth: 5, useColors: true)

        // Should produce different results due to different width calculations
        #expect(resultWithoutColors.count != resultWithColors.count || resultWithoutColors != resultWithColors)
    }

    // MARK: - Complex Scenario Tests

    @Test("Wraps complex multi-sentence text")
    func wrapsComplexMultiSentenceText() {
        let text = "First sentence here. Second sentence is longer. Third sentence adds more complexity to test."
        let result = TextWrapper.wrap(text, prefix: "  ", maxWidth: 40)

        #expect(result.count > 1)
        for line in result {
            #expect(line.hasPrefix("  "))
            #expect(line.count <= 40)
        }
    }

    @Test("Wraps text with punctuation and special characters")
    func wrapsTextWithPunctuationAndSpecialCharacters() {
        let text = "Hello, world! How are you? I'm fine, thanks. #swift @testing"
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 25)

        #expect(result.count > 1)
        for line in result {
            #expect(line.count <= 25)
        }
    }

    @Test("Wraps text that alternates between short and long words")
    func wrapsAlternatingShortLongWords() {
        let text = "A superlongword b anotherlongword c yetanotherlongword"
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 15)

        #expect(result.count > 1)
        for line in result {
            #expect(line.count <= 15)
        }
    }

    @Test("Preserves prefix consistency across all wrapped lines")
    func preservesPrefixConsistency() {
        let text = "Line one content here and line two content here and line three content here"
        let prefix = ">>> "
        let result = TextWrapper.wrap(text, prefix: prefix, maxWidth: 30)

        #expect(result.count >= 3)
        for line in result {
            #expect(line.hasPrefix(prefix))
        }
    }

    @Test("Wraps at width boundary with space exactly at limit")
    func wrapsAtWidthBoundaryWithSpaceAtLimit() {
        // "Hello World Extra" - space at position 11, wrapping at 12 should break before "World"
        let text = "Hello World Extra"
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 12)

        #expect(result.count > 1)
        #expect(result[0] == "Hello World")
        #expect(result[1] == "Extra")
    }

    // MARK: - Real-World Scenario Tests

    @Test("Wraps file path with tree prefix")
    func wrapsFilePathWithTreePrefix() {
        let text = "VeryLongFileName.swift"
        let prefix = "│   ├── "
        let result = TextWrapper.wrap(text, prefix: prefix, maxWidth: 30)

        #expect(result.count > 0)
        for line in result {
            #expect(line.hasPrefix(prefix))
        }
    }

    @Test("Wraps error message with indentation")
    func wrapsErrorMessageWithIndentation() {
        let text = "Error: The requested operation could not be completed because the file was not found at the specified path"
        let prefix = "    "
        let result = TextWrapper.wrap(text, prefix: prefix, maxWidth: 60)

        #expect(result.count > 1)
        for line in result {
            #expect(line.hasPrefix(prefix))
            #expect(line.count <= 60)
        }
    }

    @Test("Wraps description text in tree output format")
    func wrapsDescriptionInTreeFormat() {
        let text = "This is a detailed description of a UI element that might appear in accessibility tree output"
        let prefix = "│   │   "
        let result = TextWrapper.wrap(text, prefix: prefix, maxWidth: 50)

        #expect(result.count > 1)
        for line in result {
            #expect(line.hasPrefix(prefix))
            #expect(line.count <= 50)
        }
    }

    // MARK: - Boundary Condition Tests

    @Test("Wraps when available width equals one character after prefix")
    func wrapsWhenAvailableWidthIsOne() {
        let text = "Hello"
        let prefix = "1234567890" // 10 chars
        let result = TextWrapper.wrap(text, prefix: prefix, maxWidth: 11) // Only 1 char available

        #expect(result.count == 5)
        for line in result {
            #expect(line.count == 11)
        }
    }

    @Test("Handles prefix length equal to max width")
    func handlesPrefixLengthEqualToMaxWidth() {
        let text = "Text"
        let prefix = "12345678901234567890" // 20 chars
        let result = TextWrapper.wrap(text, prefix: prefix, maxWidth: 20)

        // Available width is 0, should still handle gracefully
        #expect(result.count > 0)
    }

    @Test("Wraps text with newlines in original content")
    func wrapsTextPreservingNewlines() {
        // Note: The implementation treats newlines as regular characters
        let text = "Line one\nLine two"
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 10)

        // Should wrap based on character count, newline is just another char
        #expect(result.count > 0)
    }

    @Test("Wraps very long single word exceeding multiple line widths")
    func wrapsVeryLongSingleWord() {
        let text = String(repeating: "a", count: 100)
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 20)

        #expect(result.count == 5)
        for (index, line) in result.enumerated() {
            if index < result.count - 1 {
                #expect(line.count == 20)
            }
        }
    }

    @Test("Wraps text with unicode characters")
    func wrapsTextWithUnicodeCharacters() {
        let text = "Hello 👋 World 🌍 Test 🧪 Swift 🚀"
        let result = TextWrapper.wrap(text, prefix: "", maxWidth: 15)

        #expect(result.count > 1)
        for line in result {
            #expect(line.count <= 15)
        }
    }

    @Test("Wraps with colored prefix and colored text")
    func wrapsWithColoredPrefixAndColoredText() {
        let text = "\u{001B}[32mGreen message\u{001B}[0m with \u{001B}[31mred warning\u{001B}[0m"
        let prefix = "\u{001B}[34m>> \u{001B}[0m"
        let result = TextWrapper.wrap(text, prefix: prefix, maxWidth: 30, useColors: true)

        #expect(result.count > 0)
        for line in result {
            let visibleLength = ColorSupport.visibleLength(line)
            #expect(visibleLength <= 30)
        }
    }
}
