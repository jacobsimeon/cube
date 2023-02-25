// swift-tools-version: 5.7

import PackageDescription
import PackagePlugin

let package = Package(
    name: "Cube",
    platforms: [.iOS(.v16)],

    products: [
        .library(
            name: "Cube",
            type: .static,
            targets: ["Cube"]
        ),
    ],

    dependencies: [],

    targets: [
        .target(name: "Cube", dependencies: ["OCCube"]),
        .target(name: "OCCube", dependencies: ["cube"]),
        .binaryTarget(
            name: "cube",
            path: "./cube.xcframework"
        )
    ]
)
