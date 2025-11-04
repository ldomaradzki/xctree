import Foundation
@preconcurrency import ApplicationServices

/// A Swift wrapper around AXUIElement providing convenient access to accessibility attributes.
public struct AccessibilityElement {
    private let element: AXUIElement

    /// Creates an accessibility element wrapper.
    ///
    /// - Parameter element: The AXUIElement to wrap
    public init(element: AXUIElement) {
        self.element = element
    }

    /// Retrieves an attribute value of a specific type.
    ///
    /// - Parameter attribute: The accessibility attribute name
    /// - Returns: The attribute value cast to the specified type, or nil if unavailable
    private func getAttribute<T>(_ attribute: String) -> T? {
        var value: AnyObject?
        let error = AXUIElementCopyAttributeValue(element, attribute as CFString, &value)
        guard error == .success else { return nil }
        return value as? T
    }

    /// Returns all available attribute names for this element.
    ///
    /// - Returns: Array of attribute names
    public func getAttributeNames() -> [String] {
        var names: CFArray?
        let error = AXUIElementCopyAttributeNames(element, &names)
        guard error == .success, let attributeNames = names as? [String] else {
            return []
        }
        return attributeNames
    }

    /// The role of this accessibility element (e.g., "AXButton", "AXTextField").
    public var role: String? {
        getAttribute(kAXRoleAttribute as String)
    }

    /// The label or description of this element.
    ///
    /// Tries multiple attributes in order:
    /// 1. AXLabel
    /// 2. AXDescription (kAXDescriptionAttribute)
    public var label: String? {
        if let label: String = getAttribute("AXLabel") {
            return label
        }
        if let description: String = getAttribute(kAXDescriptionAttribute as String) {
            return description
        }
        return nil
    }

    /// The title of this element.
    public var title: String? {
        getAttribute(kAXTitleAttribute as String)
    }

    /// The value of this element as a string.
    ///
    /// Handles both String and NSNumber values.
    public var value: String? {
        if let stringValue: String = getAttribute(kAXValueAttribute as String) {
            return stringValue
        }
        if let numberValue: NSNumber = getAttribute(kAXValueAttribute as String) {
            return numberValue.stringValue
        }
        return nil
    }

    /// The accessibility identifier used for UI testing.
    public var identifier: String? {
        getAttribute(kAXIdentifierAttribute as String)
    }

    /// The frame (position and size) of this element.
    public var frame: CGRect? {
        var positionRef: CFTypeRef?
        var sizeRef: CFTypeRef?

        AXUIElementCopyAttributeValue(element, kAXPositionAttribute as CFString, &positionRef)
        AXUIElementCopyAttributeValue(element, kAXSizeAttribute as CFString, &sizeRef)

        guard let posValue = positionRef, let sizeValue = sizeRef else { return nil }

        var point = CGPoint.zero
        var cgSize = CGSize.zero

        AXValueGetValue(posValue as! AXValue, .cgPoint, &point)
        AXValueGetValue(sizeValue as! AXValue, .cgSize, &cgSize)

        return CGRect(origin: point, size: cgSize)
    }

    /// The child elements of this element.
    public var children: [AccessibilityElement] {
        var childrenRef: CFTypeRef?
        let error = AXUIElementCopyAttributeValue(element, kAXChildrenAttribute as CFString, &childrenRef)
        guard error == .success, let children = childrenRef as? [AXUIElement] else {
            return []
        }
        return children.map { AccessibilityElement(element: $0) }
    }

    /// The child elements in navigation order (if available).
    public var childrenInNavigationOrder: [AccessibilityElement]? {
        var childrenRef: CFTypeRef?
        let error = AXUIElementCopyAttributeValue(element, "AXChildrenInNavigationOrder" as CFString, &childrenRef)
        guard error == .success, let children = childrenRef as? [AXUIElement] else {
            return nil
        }
        return children.map { AccessibilityElement(element: $0) }
    }

    /// The hint text for VoiceOver users.
    public var hint: String? {
        getAttribute(kAXHelpAttribute as String)
    }

    /// The iOS accessibility traits for this element.
    ///
    /// - Returns: Array of trait names, or nil if traits are not available
    public var traits: [String]? {
        // In iOS accessibility, traits are represented as a bitmask value
        // But through the macOS accessibility API, they may come as a string description
        if let traitsValue: String = getAttribute("AXTraits") {
            return [traitsValue]
        }
        if let traitsValue: NSNumber = getAttribute("AXTraits") {
            let decoded = TraitDecoder.decode(traitsValue.uint64Value)
            return decoded.isEmpty ? nil : decoded
        }
        return nil
    }
}
