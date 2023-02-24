// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CmakeBuildPlugin",
    products: [
        .plugin(
        name: "CmakeBuildPlugin",
        targets: ["CmakeBuildPlugin"]),
        )
    ],
    targets: [
        .plugin(
        name: "CmakeBuildPlugin",
        capability: .buildtool()
        )
    ]
)
