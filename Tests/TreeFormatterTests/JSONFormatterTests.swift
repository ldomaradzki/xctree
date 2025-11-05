import Testing
import SnapshotTesting
@testable import TreeFormatter

@Suite("JSONFormatter Tests")
struct JSONFormatterTests {

    @Test("Single element with label")
    func singleElementWithLabel() throws {
        let node = TestModels.SingleElementWithLabel.treeNode()
        let output = JSONFormatter.format(node)
        assertSnapshot(of: output, as: .lines)
    }

    @Test("Single element with long label that wraps")
    func singleElementWithLongLabel() throws {
        let node = TestModels.SingleElementWithLongLabel.treeNode()
        let output = JSONFormatter.format(node)
        assertSnapshot(of: output, as: .lines)
    }

    @Test("Element with all attributes")
    func elementWithAllAttributes() throws {
        let node = TestModels.ElementWithAllAttributes.treeNode()
        let output = JSONFormatter.format(node)
        assertSnapshot(of: output, as: .lines)
    }

    @Test("Element with children")
    func elementWithChildren() throws {
        let node = TestModels.ElementWithChildren.treeNode()
        let output = JSONFormatter.format(node)
        assertSnapshot(of: output, as: .lines)
    }

    @Test("Nested tree structure")
    func nestedTreeStructure() throws {
        let node = TestModels.NestedTreeStructure.treeNode()
        let output = JSONFormatter.format(node)
        assertSnapshot(of: output, as: .lines)
    }

    @Test("Three-level nested structure")
    func threeLevelNesting() throws {
        let node = TestModels.ThreeLevelNesting.treeNode()
        let output = JSONFormatter.format(node)
        assertSnapshot(of: output, as: .lines)
    }

    @Test("Complex multi-child structure")
    func complexMultiChildStructure() throws {
        let node = TestModels.ComplexMultiChildStructure.treeNode()
        let output = JSONFormatter.format(node)
        assertSnapshot(of: output, as: .lines)
    }

    @Test("Deep nesting with multiple siblings at each level")
    func deepNestingWithSiblings() throws {
        let node = TestModels.DeepNestingWithSiblings.treeNode()
        let output = JSONFormatter.format(node)
        assertSnapshot(of: output, as: .lines)
    }

    // JSON-specific tests

    @Test("Element with frame information")
    func elementWithFrameInfo() throws {
        let node = TestModels.ElementWithFrameInfo.treeNode()
        let output = JSONFormatter.format(node)
        assertSnapshot(of: output, as: .lines)
    }

    @Test("Element with empty values omits null fields")
    func elementWithEmptyValues() throws {
        let node = TestModels.ElementWithEmptyValues.treeNode()
        let output = JSONFormatter.format(node)
        assertSnapshot(of: output, as: .lines)
    }

    @Test("Multiple root elements as array")
    func multipleRootElements() throws {
        // For JSON, multiple roots would typically be in an array wrapper
        // But since JSONFormatter.format takes a single TreeNode,
        // we can test encoding an array of nodes manually
        let nodes = TestModels.MultipleRootElements.treeNodes()

        // Create a wrapper node to hold multiple roots
        let wrapper = TreeNode(
            role: "AXApplication",
            label: nil,
            title: nil,
            value: nil,
            identifier: nil,
            hint: nil,
            traits: nil,
            frame: nil,
            children: nodes
        )

        let output = JSONFormatter.format(wrapper)
        assertSnapshot(of: output, as: .lines)
    }

    @Test("Verify JSON keys are sorted")
    func verifySortedKeys() throws {
        // This test ensures that JSON keys appear in sorted order
        let node = TestModels.ElementWithAllAttributes.treeNode()
        let output = JSONFormatter.format(node)

        // The snapshot will verify the exact key order
        // Keys should appear alphabetically: hint, identifier, label, role, title, traits, value
        assertSnapshot(of: output, as: .lines)
    }
}
