import Foundation
import ApplicationServices
import Cocoa

/// Finds and interacts with the iOS Simulator process.
public enum SimulatorFinder {
    /// The bundle identifier for iOS Simulator.
    private static let simulatorBundleID = "com.apple.iphonesimulator"

    /// Finds the running iOS Simulator application.
    ///
    /// - Returns: The NSRunningApplication instance, or nil if not found
    public static func findSimulator() -> NSRunningApplication? {
        NSWorkspace.shared.runningApplications.first {
            $0.bundleIdentifier == simulatorBundleID
        }
    }

    /// Finds the iOS app element within the simulator.
    ///
    /// The iOS app content is typically in the first AXGroup within the simulator window.
    ///
    /// - Parameter simulator: The running simulator application
    /// - Returns: The accessibility element for the iOS app, or nil if not found
    public static func findIOSAppElement(in simulator: NSRunningApplication) -> AccessibilityElement? {
        let pid = simulator.processIdentifier
        let appElement = AXUIElementCreateApplication(pid)
        let simulatorElement = AccessibilityElement(element: appElement)

        // Find the first AXGroup within the window
        for window in simulatorElement.children where window.role == "AXWindow" {
            for child in window.children where child.role == "AXGroup" {
                return child
            }
        }

        return nil
    }

    /// Returns a user-friendly error message when simulator is not found.
    ///
    /// - Returns: Formatted error message
    public static func simulatorNotFoundMessage() -> String {
        """
        ❌ Error: iOS Simulator is not running

        Please launch the iOS Simulator and try again.
        """
    }

    /// Returns a user-friendly error message when iOS app is not found.
    ///
    /// - Returns: Formatted error message
    public static func iosAppNotFoundMessage() -> String {
        """
        ❌ Error: Could not find iOS app content inside the simulator.

        Possible reasons:
          • The simulator is showing the home screen
          • No app is currently running
          • The app hasn't finished launching

        Please open an iOS app in the simulator and try again.
        """
    }
}
