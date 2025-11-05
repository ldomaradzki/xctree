// swift-tools-version: 6.1
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
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.6.2"),
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.4.5"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.18.7")
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
                "TreeFormatter",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        ),

        // Tests
        .testTarget(
            name: "AXWrapperTests",
            dependencies: ["AXWrapper"]
        ),
        .testTarget(
            name: "TreeFormatterTests",
            dependencies: [
                "TreeFormatter",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ]
        ),
    ]
)
