import Foundation
import AXWrapper
import TreeFormatter
import ArgumentParser

/// Output format for accessibility tree
enum OutputFormat: String, ExpressibleByArgument {
    case tree
    case json
}

/// Converts AccessibilityElement to PrintableElement
func toPrintableElement(_ element: AccessibilityElement) -> PrintableElement {
    let children = element.children.map { toPrintableElement($0) }
    return PrintableElement(
        role: element.role,
        label: element.label,
        title: element.title,
        value: element.value,
        identifier: element.identifier,
        hint: element.hint,
        traits: element.traits,
        children: children
    )
}

/// Converts AccessibilityElement to TreeNode for JSON
func toTreeNode(_ element: AccessibilityElement) -> TreeNode {
    let frameInfo: TreeNode.FrameInfo?
    if let frame = element.frame {
        frameInfo = TreeNode.FrameInfo(
            x: Double(frame.origin.x),
            y: Double(frame.origin.y),
            width: Double(frame.width),
            height: Double(frame.height)
        )
    } else {
        frameInfo = nil
    }

    let childNodes = element.children.map { toTreeNode($0) }

    return TreeNode(
        role: element.role,
        label: element.label,
        title: element.title,
        value: element.value,
        identifier: element.identifier,
        hint: element.hint,
        traits: element.traits,
        frame: frameInfo,
        children: childNodes
    )
}

@main
struct XCTree: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "xctree",
        abstract: "iOS Simulator Accessibility Tree Inspector",
        discussion: """
            Extracts and displays the accessibility tree from iOS Simulator apps.
            Similar to Xcode's Accessibility Inspector but as a CLI tool.

            Requires:
            - Running iOS Simulator instance
            - Accessibility permissions for your terminal app
            """,
        version: "0.1.0"
    )

    @Option(name: .shortAndLong, help: "Output format (tree or json)")
    var format: OutputFormat = .tree

    @Flag(name: .long, help: "Disable colored output")
    var noColor = false

    @Option(name: .shortAndLong, help: "Column width for text wrapping")
    var width: Int = 80

    mutating func validate() throws {
        guard width > 0 else {
            throw ValidationError("Width must be a positive number (got \(width))")
        }
    }

    mutating func run() throws {
        // Check accessibility permissions
        guard PermissionChecker.hasPermission() else {
            print(PermissionChecker.permissionErrorMessage())
            throw ExitCode.failure
        }

        // Find iOS Simulator
        guard let simulator = SimulatorFinder.findSimulator() else {
            print(SimulatorFinder.simulatorNotFoundMessage())
            throw ExitCode.failure
        }

        // Find iOS app element
        guard let iosAppElement = SimulatorFinder.findIOSAppElement(in: simulator) else {
            print(SimulatorFinder.iosAppNotFoundMessage())
            throw ExitCode.failure
        }

        // Output based on format
        switch format {
        case .tree:
            let useColors = !noColor
            let printerConfig = TreePrinterConfig(maxWidth: width, useColors: useColors)
            let printableChildren = iosAppElement.children.map { toPrintableElement($0) }
            TreePrinter.printRoots(printableChildren, config: printerConfig)

        case .json:
            let treeNode = toTreeNode(iosAppElement)
            let jsonString = JSONFormatter.format(treeNode)
            print(jsonString)
        }
    }
}
