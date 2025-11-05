import Foundation
@testable import TreeFormatter

/// Shared test fixtures for both TreePrinter and JSONFormatter tests.
/// Each fixture can generate both PrintableElement and TreeNode with identical data.
enum TestModels {

    // MARK: - Simple Elements

    struct SingleElementWithLabel {
        static func printable() -> PrintableElement {
            PrintableElement(
                role: "AXButton",
                label: "Submit",
                identifier: "submit_btn",
                traits: ["button"]
            )
        }

        static func treeNode() -> TreeNode {
            TreeNode(
                role: "AXButton",
                label: "Submit",
                title: nil,
                value: nil,
                identifier: "submit_btn",
                hint: nil,
                traits: ["button"],
                frame: nil,
                children: []
            )
        }
    }

    struct SingleElementWithLongLabel {
        static func printable() -> PrintableElement {
            PrintableElement(
                role: "AXStaticText",
                label: "This is a very long label that should wrap to multiple lines when printed because it exceeds the maximum width"
            )
        }

        static func treeNode() -> TreeNode {
            TreeNode(
                role: "AXStaticText",
                label: "This is a very long label that should wrap to multiple lines when printed because it exceeds the maximum width",
                title: nil,
                value: nil,
                identifier: nil,
                hint: nil,
                traits: nil,
                frame: nil,
                children: []
            )
        }
    }

    struct ElementWithAllAttributes {
        static func printable() -> PrintableElement {
            PrintableElement(
                role: "AXTextField",
                label: "Email Address",
                title: "Email",
                value: "user@example.com",
                identifier: "email_field",
                hint: "Enter your email address",
                traits: ["textField", "selected"]
            )
        }

        static func treeNode() -> TreeNode {
            TreeNode(
                role: "AXTextField",
                label: "Email Address",
                title: "Email",
                value: "user@example.com",
                identifier: "email_field",
                hint: "Enter your email address",
                traits: ["textField", "selected"],
                frame: nil,
                children: []
            )
        }
    }

    // MARK: - Elements with Children

    struct ElementWithChildren {
        static func printable() -> PrintableElement {
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

            return PrintableElement(
                role: "AXGroup",
                label: "Name Group",
                children: [child1, child2]
            )
        }

        static func treeNode() -> TreeNode {
            let child1 = TreeNode(
                role: "AXStaticText",
                label: "First Name",
                title: nil,
                value: nil,
                identifier: nil,
                hint: nil,
                traits: ["staticText"],
                frame: nil,
                children: []
            )

            let child2 = TreeNode(
                role: "AXStaticText",
                label: "Last Name",
                title: nil,
                value: nil,
                identifier: nil,
                hint: nil,
                traits: ["staticText"],
                frame: nil,
                children: []
            )

            return TreeNode(
                role: "AXGroup",
                label: "Name Group",
                title: nil,
                value: nil,
                identifier: nil,
                hint: nil,
                traits: nil,
                frame: nil,
                children: [child1, child2]
            )
        }
    }

    struct MultipleRootElements {
        static func printable() -> [PrintableElement] {
            [
                PrintableElement(
                    role: "AXButton",
                    label: "Cancel",
                    traits: ["button"]
                ),
                PrintableElement(
                    role: "AXButton",
                    label: "OK",
                    traits: ["button"]
                )
            ]
        }

        static func treeNodes() -> [TreeNode] {
            [
                TreeNode(
                    role: "AXButton",
                    label: "Cancel",
                    title: nil,
                    value: nil,
                    identifier: nil,
                    hint: nil,
                    traits: ["button"],
                    frame: nil,
                    children: []
                ),
                TreeNode(
                    role: "AXButton",
                    label: "OK",
                    title: nil,
                    value: nil,
                    identifier: nil,
                    hint: nil,
                    traits: ["button"],
                    frame: nil,
                    children: []
                )
            ]
        }
    }

    // MARK: - Nested Structures

    struct NestedTreeStructure {
        static func printable() -> PrintableElement {
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

            return PrintableElement(
                role: "AXWindow",
                label: "Main Window",
                children: [child]
            )
        }

        static func treeNode() -> TreeNode {
            let grandchild = TreeNode(
                role: "AXButton",
                label: "Submit",
                title: nil,
                value: nil,
                identifier: "submit_btn",
                hint: nil,
                traits: ["button"],
                frame: nil,
                children: []
            )

            let child = TreeNode(
                role: "AXGroup",
                label: "Button Group",
                title: nil,
                value: nil,
                identifier: nil,
                hint: nil,
                traits: nil,
                frame: nil,
                children: [grandchild]
            )

            return TreeNode(
                role: "AXWindow",
                label: "Main Window",
                title: nil,
                value: nil,
                identifier: nil,
                hint: nil,
                traits: nil,
                frame: nil,
                children: [child]
            )
        }
    }

    struct ThreeLevelNesting {
        static func printable() -> PrintableElement {
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

            return PrintableElement(
                role: "AXWindow",
                label: "Settings",
                children: [middleGroup]
            )
        }

        static func treeNode() -> TreeNode {
            let leafButton = TreeNode(
                role: "AXButton",
                label: "Delete",
                title: nil,
                value: nil,
                identifier: "delete_btn",
                hint: nil,
                traits: ["button"],
                frame: nil,
                children: []
            )

            let middleGroup = TreeNode(
                role: "AXGroup",
                label: "Actions",
                title: nil,
                value: nil,
                identifier: nil,
                hint: nil,
                traits: nil,
                frame: nil,
                children: [leafButton]
            )

            return TreeNode(
                role: "AXWindow",
                label: "Settings",
                title: nil,
                value: nil,
                identifier: nil,
                hint: nil,
                traits: nil,
                frame: nil,
                children: [middleGroup]
            )
        }
    }

    struct ComplexMultiChildStructure {
        static func printable() -> PrintableElement {
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
            return PrintableElement(
                role: "AXWindow",
                label: "Login Window",
                children: [formGroup, buttonGroup]
            )
        }

        static func treeNode() -> TreeNode {
            // Level 3 - Leaf nodes
            let textField1 = TreeNode(
                role: "AXTextField",
                label: "Username",
                title: nil,
                value: "john.doe",
                identifier: "username_field",
                hint: nil,
                traits: ["textField"],
                frame: nil,
                children: []
            )

            let textField2 = TreeNode(
                role: "AXTextField",
                label: "Password",
                title: nil,
                value: nil,
                identifier: "password_field",
                hint: nil,
                traits: ["textField", "secureText"],
                frame: nil,
                children: []
            )

            let submitButton = TreeNode(
                role: "AXButton",
                label: "Log In",
                title: nil,
                value: nil,
                identifier: "login_btn",
                hint: nil,
                traits: ["button"],
                frame: nil,
                children: []
            )

            let cancelButton = TreeNode(
                role: "AXButton",
                label: "Cancel",
                title: nil,
                value: nil,
                identifier: "cancel_btn",
                hint: nil,
                traits: ["button"],
                frame: nil,
                children: []
            )

            // Level 2 - Groups
            let formGroup = TreeNode(
                role: "AXGroup",
                label: "Login Form",
                title: nil,
                value: nil,
                identifier: nil,
                hint: nil,
                traits: nil,
                frame: nil,
                children: [textField1, textField2]
            )

            let buttonGroup = TreeNode(
                role: "AXGroup",
                label: "Actions",
                title: nil,
                value: nil,
                identifier: nil,
                hint: nil,
                traits: nil,
                frame: nil,
                children: [submitButton, cancelButton]
            )

            // Level 1 - Root
            return TreeNode(
                role: "AXWindow",
                label: "Login Window",
                title: nil,
                value: nil,
                identifier: nil,
                hint: nil,
                traits: nil,
                frame: nil,
                children: [formGroup, buttonGroup]
            )
        }
    }

    struct DeepNestingWithSiblings {
        static func printable() -> PrintableElement {
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
            return PrintableElement(
                role: "AXDialog",
                label: "User Settings",
                children: [contentArea, footer]
            )
        }

        static func treeNode() -> TreeNode {
            // Level 4
            let icon1 = TreeNode(
                role: "AXImage",
                label: "User Icon",
                title: nil,
                value: nil,
                identifier: nil,
                hint: nil,
                traits: ["image"],
                frame: nil,
                children: []
            )
            let icon2 = TreeNode(
                role: "AXImage",
                label: "Settings Icon",
                title: nil,
                value: nil,
                identifier: nil,
                hint: nil,
                traits: ["image"],
                frame: nil,
                children: []
            )

            // Level 3
            let header = TreeNode(
                role: "AXGroup",
                label: "Header",
                title: nil,
                value: nil,
                identifier: nil,
                hint: nil,
                traits: nil,
                frame: nil,
                children: [icon1, icon2]
            )

            let bodyText = TreeNode(
                role: "AXStaticText",
                label: "Welcome back! Please review your settings.",
                title: nil,
                value: nil,
                identifier: nil,
                hint: nil,
                traits: ["staticText"],
                frame: nil,
                children: []
            )

            // Level 2
            let contentArea = TreeNode(
                role: "AXGroup",
                label: "Content",
                title: nil,
                value: nil,
                identifier: nil,
                hint: nil,
                traits: nil,
                frame: nil,
                children: [header, bodyText]
            )

            let footerButton1 = TreeNode(
                role: "AXButton",
                label: "Save",
                title: nil,
                value: nil,
                identifier: nil,
                hint: nil,
                traits: ["button"],
                frame: nil,
                children: []
            )
            let footerButton2 = TreeNode(
                role: "AXButton",
                label: "Close",
                title: nil,
                value: nil,
                identifier: nil,
                hint: nil,
                traits: ["button"],
                frame: nil,
                children: []
            )

            let footer = TreeNode(
                role: "AXGroup",
                label: "Footer",
                title: nil,
                value: nil,
                identifier: nil,
                hint: nil,
                traits: nil,
                frame: nil,
                children: [footerButton1, footerButton2]
            )

            // Level 1 - Root
            return TreeNode(
                role: "AXDialog",
                label: "User Settings",
                title: nil,
                value: nil,
                identifier: nil,
                hint: nil,
                traits: nil,
                frame: nil,
                children: [contentArea, footer]
            )
        }
    }

    // MARK: - JSON-Specific Test Cases

    struct ElementWithFrameInfo {
        static func treeNode() -> TreeNode {
            TreeNode(
                role: "AXButton",
                label: "Positioned Button",
                title: nil,
                value: nil,
                identifier: "positioned_btn",
                hint: nil,
                traits: ["button"],
                frame: TreeNode.FrameInfo(x: 10.5, y: 20.0, width: 100.0, height: 44.0),
                children: []
            )
        }
    }

    struct ElementWithEmptyValues {
        static func treeNode() -> TreeNode {
            TreeNode(
                role: "AXGroup",
                label: nil,
                title: nil,
                value: nil,
                identifier: nil,
                hint: nil,
                traits: [],
                frame: nil,
                children: []
            )
        }
    }
}
