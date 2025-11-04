import Foundation

/// Represents an accessibility tree node for JSON serialization.
public struct TreeNode: Codable {
    public let role: String?
    public let label: String?
    public let title: String?
    public let value: String?
    public let identifier: String?
    public let hint: String?
    public let traits: [String]?
    public let frame: FrameInfo?
    public let children: [TreeNode]

    public init(
        role: String?,
        label: String?,
        title: String?,
        value: String?,
        identifier: String?,
        hint: String?,
        traits: [String]?,
        frame: FrameInfo?,
        children: [TreeNode]
    ) {
        self.role = role
        self.label = label
        self.title = title
        self.value = value
        self.identifier = identifier
        self.hint = hint
        self.traits = traits
        self.frame = frame
        self.children = children
    }

    // Custom encoding to omit null/empty values
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(role, forKey: .role)
        try container.encodeIfPresent(label, forKey: .label)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(value, forKey: .value)
        try container.encodeIfPresent(identifier, forKey: .identifier)
        try container.encodeIfPresent(hint, forKey: .hint)

        // Only encode traits if not nil and not empty
        if let traits = traits, !traits.isEmpty {
            try container.encode(traits, forKey: .traits)
        }

        try container.encodeIfPresent(frame, forKey: .frame)

        // Only encode children if not empty
        if !children.isEmpty {
            try container.encode(children, forKey: .children)
        }
    }

    enum CodingKeys: String, CodingKey {
        case role, label, title, value, identifier, hint, traits, frame, children
    }

    public struct FrameInfo: Codable {
        public let x: Double
        public let y: Double
        public let width: Double
        public let height: Double

        public init(x: Double, y: Double, width: Double, height: Double) {
            self.x = x
            self.y = y
            self.width = width
            self.height = height
        }
    }
}

/// Formats accessibility data as JSON.
public enum JSONFormatter {
    /// Encodes a tree node to pretty-printed JSON string.
    ///
    /// - Parameter node: The tree node to encode
    /// - Returns: JSON string, or error message if encoding fails
    public static func format(_ node: TreeNode) -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        do {
            let jsonData = try encoder.encode(node)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
            return "Error: Could not convert JSON data to string"
        } catch {
            return "Error encoding JSON: \(error)"
        }
    }
}
