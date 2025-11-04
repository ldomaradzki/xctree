import Foundation
import ApplicationServices
import AppKit

/// Checks and validates accessibility permissions.
public enum PermissionChecker {
    /// Checks if the current process has accessibility permissions.
    ///
    /// - Returns: true if accessibility is enabled, false otherwise
    public static func hasPermission() -> Bool {
        AXIsProcessTrusted()
    }

    /// Returns a user-friendly error message explaining how to grant permissions.
    ///
    /// - Returns: Formatted error message with instructions
    public static func permissionErrorMessage() -> String {
        """
        ❌ Error: This tool requires accessibility permissions.

        To grant permissions:
        1. Open System Settings → Privacy & Security → Accessibility
        2. Add your terminal app to the list
        3. Enable the checkbox next to it
        4. Restart this tool
        """
    }

    /// Opens System Settings to the Accessibility privacy panel.
    ///
    /// - Returns: true if the settings were opened successfully, false otherwise
    @discardableResult
    public static func openAccessibilitySettings() -> Bool {
        let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility")!
        return NSWorkspace.shared.open(url)
    }
}
