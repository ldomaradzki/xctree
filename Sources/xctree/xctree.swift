import Foundation
import AXWrapper
import TreeFormatter

/// Command-line configuration
struct Config {
    enum OutputFormat {
        case tree
        case json
    }

    let format: OutputFormat
    let useColors: Bool
    let maxWidth: Int

    static let `default` = Config(format: .tree, useColors: true, maxWidth: 80)
}

/// Command-line argument parser
enum ArgumentParser {
    enum ParseError: Error, CustomStringConvertible {
        case invalidFormat(String)
        case missingFormatValue
        case missingWidthValue
        case invalidWidth(String)
        case unknownArgument(String)

        var description: String {
            switch self {
            case .invalidFormat(let value):
                return "❌ Error: Invalid format '\(value)'. Use 'tree' or 'json'."
            case .missingFormatValue:
                return "❌ Error: --format requires an argument (tree or json)"
            case .missingWidthValue:
                return "❌ Error: --width requires a number argument"
            case .invalidWidth(let value):
                return "❌ Error: Invalid width '\(value)'. Must be a positive number."
            case .unknownArgument(let arg):
                return "❌ Error: Unknown argument '\(arg)'"
            }
        }
    }

    static func parse(_ args: [String]) throws -> Config {
        var format: Config.OutputFormat = .tree
        var useColors = true
        var maxWidth = 80

        var iterator = args.makeIterator()
        while let arg = iterator.next() {
            switch arg {
            case "--help", "-h":
                printUsage()
                exit(0)

            case "--format", "-f":
                guard let formatArg = iterator.next() else {
                    throw ParseError.missingFormatValue
                }
                switch formatArg.lowercased() {
                case "tree":
                    format = .tree
                case "json":
                    format = .json
                default:
                    throw ParseError.invalidFormat(formatArg)
                }

            case "--no-color":
                useColors = false

            case "--width", "-w":
                guard let widthArg = iterator.next() else {
                    throw ParseError.missingWidthValue
                }
                guard let width = Int(widthArg), width > 0 else {
                    throw ParseError.invalidWidth(widthArg)
                }
                maxWidth = width

            default:
                throw ParseError.unknownArgument(arg)
            }
        }

        return Config(format: format, useColors: useColors, maxWidth: maxWidth)
    }

    static func printUsage() {
        print("""
        Usage: xctree [OPTIONS]

        Options:
          --format <tree|json>   Output format (default: tree)
          --no-color             Disable colored output
          --width <number>       Set column width (default: 80)
          --help, -h             Show this help message

        Description:
          Prints the accessibility tree of the currently running iOS Simulator app.
          Similar to Xcode's Accessibility Inspector but for the command line.

        Examples:
          xctree                           # Tree output with colors
          xctree --format json             # JSON output
          xctree --no-color --width 120    # Wide tree without colors
        """)
    }
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
struct xctree {
    static func main() {
        // Parse arguments
        let args = Array(CommandLine.arguments.dropFirst())
        let config: Config
        do {
            config = try ArgumentParser.parse(args)
        } catch let error as ArgumentParser.ParseError {
            print(error.description)
            print("")
            ArgumentParser.printUsage()
            exit(1)
        } catch {
            print("❌ Error: \(error)")
            exit(1)
        }

        // Check accessibility permissions
        guard PermissionChecker.hasPermission() else {
            print(PermissionChecker.permissionErrorMessage())
            exit(1)
        }

        // Find iOS Simulator
        guard let simulator = SimulatorFinder.findSimulator() else {
            print(SimulatorFinder.simulatorNotFoundMessage())
            exit(1)
        }

        // Find iOS app element
        guard let iosAppElement = SimulatorFinder.findIOSAppElement(in: simulator) else {
            print(SimulatorFinder.iosAppNotFoundMessage())
            exit(1)
        }

        // Output based on format
        switch config.format {
        case .tree:
            let printerConfig = TreePrinterConfig(maxWidth: config.maxWidth, useColors: config.useColors)
            let printableChildren = iosAppElement.children.map { toPrintableElement($0) }
            TreePrinter.printRoots(printableChildren, config: printerConfig)

        case .json:
            let treeNode = toTreeNode(iosAppElement)
            let jsonString = JSONFormatter.format(treeNode)
            print(jsonString)
        }
    }
}
