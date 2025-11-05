import Testing
import SnapshotTesting
@testable import TreeFormatter

@Suite("TreePrinter Tests")
struct TreePrinterTests {

    @Test("Single element with label")
    func singleElementWithLabel() throws {
        let element = PrintableElement(
            role: "AXButton",
            label: "Submit",
            identifier: "submit_btn",
            traits: ["button"]
        )

        let config = TreePrinterConfig(maxWidth: 80, useColors: false)
        let output = TreePrinter.format(element, config: config)

        assertSnapshot(of: output, as: .lines)
    }

    @Test("Single element with long label that wraps")
    func singleElementWithLongLabel() throws {
        let element = PrintableElement(
            role: "AXStaticText",
            label: "This is a very long label that should wrap to multiple lines when printed because it exceeds the maximum width"
        )

        let config = TreePrinterConfig(maxWidth: 80, useColors: false)
        let output = TreePrinter.format(element, config: config)

        assertSnapshot(of: output, as: .lines)
    }

    @Test("Element with all attributes")
    func elementWithAllAttributes() throws {
        let element = PrintableElement(
            role: "AXTextField",
            label: "Email Address",
            title: "Email",
            value: "user@example.com",
            identifier: "email_field",
            hint: "Enter your email address",
            traits: ["textField", "selected"]
        )

        let config = TreePrinterConfig(maxWidth: 80, useColors: false)
        let output = TreePrinter.format(element, config: config)

        assertSnapshot(of: output, as: .lines)
    }

    @Test("Element with children")
    func elementWithChildren() throws {
        let child1 = PrintableElement(
            role: "AXStaticText",
            label: "First Name",
            traits: ["staticText"]
        )

        let child2 = PrintableElement(
            role: "AXStaticText",
            label: "Last Name",
            traits: ["staticText"]
        )

        let parent = PrintableElement(
            role: "AXGroup",
            label: "Name Group",
            children: [child1, child2]
        )

        let config = TreePrinterConfig(maxWidth: 80, useColors: false)
        let output = TreePrinter.format(parent, config: config)

        assertSnapshot(of: output, as: .lines)
    }

    @Test("Multiple root elements")
    func multipleRootElements() throws {
        let element1 = PrintableElement(
            role: "AXButton",
            label: "Cancel",
            traits: ["button"]
        )

        let element2 = PrintableElement(
            role: "AXButton",
            label: "OK",
            traits: ["button"]
        )

        let config = TreePrinterConfig(maxWidth: 80, useColors: false)
        let output = TreePrinter.formatRoots([element1, element2], config: config)

        assertSnapshot(of: output, as: .lines)
    }

    @Test("Nested tree structure")
    func nestedTreeStructure() throws {
        let grandchild = PrintableElement(
            role: "AXButton",
            label: "Submit",
            identifier: "submit_btn",
            traits: ["button"]
        )

        let child = PrintableElement(
            role: "AXGroup",
            label: "Button Group",
            children: [grandchild]
        )

        let root = PrintableElement(
            role: "AXWindow",
            label: "Main Window",
            children: [child]
        )

        let config = TreePrinterConfig(maxWidth: 80, useColors: false)
        let output = TreePrinter.format(root, config: config)

        assertSnapshot(of: output, as: .lines)
    }

    @Test("Element with colored output")
    func elementWithColoredOutput() throws {
        let element = PrintableElement(
            role: "AXButton",
            label: "Submit",
            identifier: "submit_btn",
            traits: ["button"]
        )

        let config = TreePrinterConfig(maxWidth: 80, useColors: true)
        let output = TreePrinter.format(element, config: config)

        assertSnapshot(of: output, as: .lines)
    }

    @Test("Three-level nested structure")
    func threeLevelNesting() throws {
        let leafButton = PrintableElement(
            role: "AXButton",
            label: "Delete",
            identifier: "delete_btn",
            traits: ["button"]
        )

        let middleGroup = PrintableElement(
            role: "AXGroup",
            label: "Actions",
            children: [leafButton]
        )

        let root = PrintableElement(
            role: "AXWindow",
            label: "Settings",
            children: [middleGroup]
        )

        let config = TreePrinterConfig(maxWidth: 80, useColors: false)
        let output = TreePrinter.format(root, config: config)

        assertSnapshot(of: output, as: .lines)
    }

    @Test("Complex multi-child structure")
    func complexMultiChildStructure() throws {
        // Level 3 - Leaf nodes
        let textField1 = PrintableElement(
            role: "AXTextField",
            label: "Username",
            value: "john.doe",
            identifier: "username_field",
            traits: ["textField"]
        )

        let textField2 = PrintableElement(
            role: "AXTextField",
            label: "Password",
            identifier: "password_field",
            traits: ["textField", "secureText"]
        )

        let submitButton = PrintableElement(
            role: "AXButton",
            label: "Log In",
            identifier: "login_btn",
            traits: ["button"]
        )

        let cancelButton = PrintableElement(
            role: "AXButton",
            label: "Cancel",
            identifier: "cancel_btn",
            traits: ["button"]
        )

        // Level 2 - Groups
        let formGroup = PrintableElement(
            role: "AXGroup",
            label: "Login Form",
            children: [textField1, textField2]
        )

        let buttonGroup = PrintableElement(
            role: "AXGroup",
            label: "Actions",
            children: [submitButton, cancelButton]
        )

        // Level 1 - Root
        let window = PrintableElement(
            role: "AXWindow",
            label: "Login Window",
            children: [formGroup, buttonGroup]
        )

        let config = TreePrinterConfig(maxWidth: 80, useColors: false)
        let output = TreePrinter.format(window, config: config)

        assertSnapshot(of: output, as: .lines)
    }

    @Test("Deep nesting with multiple siblings at each level")
    func deepNestingWithSiblings() throws {
        // Level 4
        let icon1 = PrintableElement(role: "AXImage", label: "User Icon", traits: ["image"])
        let icon2 = PrintableElement(role: "AXImage", label: "Settings Icon", traits: ["image"])

        // Level 3
        let header = PrintableElement(
            role: "AXGroup",
            label: "Header",
            children: [icon1, icon2]
        )

        let bodyText = PrintableElement(
            role: "AXStaticText",
            label: "Welcome back! Please review your settings.",
            traits: ["staticText"]
        )

        // Level 2
        let contentArea = PrintableElement(
            role: "AXGroup",
            label: "Content",
            children: [header, bodyText]
        )

        let footerButton1 = PrintableElement(role: "AXButton", label: "Save", traits: ["button"])
        let footerButton2 = PrintableElement(role: "AXButton", label: "Close", traits: ["button"])

        let footer = PrintableElement(
            role: "AXGroup",
            label: "Footer",
            children: [footerButton1, footerButton2]
        )

        // Level 1 - Root
        let dialog = PrintableElement(
            role: "AXDialog",
            label: "User Settings",
            children: [contentArea, footer]
        )

        let config = TreePrinterConfig(maxWidth: 80, useColors: false)
        let output = TreePrinter.format(dialog, config: config)

        assertSnapshot(of: output, as: .lines)
    }
}
