import Testing
import SnapshotTesting
@testable import TreeFormatter

@Suite("TreePrinter Tests")
struct TreePrinterTests {

    @Test("Single element with label")
    func singleElementWithLabel() throws {
        let element = TestModels.SingleElementWithLabel.printable()

        let config = TreePrinterConfig(maxWidth: 80, useColors: false)
        let output = TreePrinter.format(element, config: config)

        assertSnapshot(of: output, as: .lines)
    }

    @Test("Single element with long label that wraps")
    func singleElementWithLongLabel() throws {
        let element = TestModels.SingleElementWithLongLabel.printable()

        let config = TreePrinterConfig(maxWidth: 80, useColors: false)
        let output = TreePrinter.format(element, config: config)

        assertSnapshot(of: output, as: .lines)
    }

    @Test("Element with all attributes")
    func elementWithAllAttributes() throws {
        let element = TestModels.ElementWithAllAttributes.printable()

        let config = TreePrinterConfig(maxWidth: 80, useColors: false)
        let output = TreePrinter.format(element, config: config)

        assertSnapshot(of: output, as: .lines)
    }

    @Test("Element with children")
    func elementWithChildren() throws {
        let parent = TestModels.ElementWithChildren.printable()

        let config = TreePrinterConfig(maxWidth: 80, useColors: false)
        let output = TreePrinter.format(parent, config: config)

        assertSnapshot(of: output, as: .lines)
    }

    @Test("Multiple root elements")
    func multipleRootElements() throws {
        let elements = TestModels.MultipleRootElements.printable()

        let config = TreePrinterConfig(maxWidth: 80, useColors: false)
        let output = TreePrinter.formatRoots(elements, config: config)

        assertSnapshot(of: output, as: .lines)
    }

    @Test("Nested tree structure")
    func nestedTreeStructure() throws {
        let root = TestModels.NestedTreeStructure.printable()

        let config = TreePrinterConfig(maxWidth: 80, useColors: false)
        let output = TreePrinter.format(root, config: config)

        assertSnapshot(of: output, as: .lines)
    }

    @Test("Element with colored output")
    func elementWithColoredOutput() throws {
        let element = TestModels.SingleElementWithLabel.printable()

        let config = TreePrinterConfig(maxWidth: 80, useColors: true)
        let output = TreePrinter.format(element, config: config)

        assertSnapshot(of: output, as: .lines)
    }

    @Test("Three-level nested structure")
    func threeLevelNesting() throws {
        let root = TestModels.ThreeLevelNesting.printable()

        let config = TreePrinterConfig(maxWidth: 80, useColors: false)
        let output = TreePrinter.format(root, config: config)

        assertSnapshot(of: output, as: .lines)
    }

    @Test("Complex multi-child structure")
    func complexMultiChildStructure() throws {
        let window = TestModels.ComplexMultiChildStructure.printable()

        let config = TreePrinterConfig(maxWidth: 80, useColors: false)
        let output = TreePrinter.format(window, config: config)

        assertSnapshot(of: output, as: .lines)
    }

    @Test("Deep nesting with multiple siblings at each level")
    func deepNestingWithSiblings() throws {
        let dialog = TestModels.DeepNestingWithSiblings.printable()

        let config = TreePrinterConfig(maxWidth: 80, useColors: false)
        let output = TreePrinter.format(dialog, config: config)

        assertSnapshot(of: output, as: .lines)
    }
}
