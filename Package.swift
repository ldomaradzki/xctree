// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "xctree",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "xctree",
            targets: ["xctree"]
        ),
        .library(
            name: "AXWrapper",
            targets: ["AXWrapper"]
        ),
        .library(
            name: "TreeFormatter",
            targets: ["TreeFormatter"]
        ),
    ],
    targets: [
        // Libraries
        .target(
            name: "AXWrapper",
            dependencies: []
        ),
        .target(
            name: "TreeFormatter",
            dependencies: []
        ),

        // Executable
        .executableTarget(
            name: "xctree",
            dependencies: [
                "AXWrapper",
                "TreeFormatter"
            ]
        ),

        // Tests
        .testTarget(
            name: "AXWrapperTests",
            dependencies: ["AXWrapper"]
        ),
        .testTarget(
            name: "TreeFormatterTests",
            dependencies: ["TreeFormatter"]
        ),
    ]
)
