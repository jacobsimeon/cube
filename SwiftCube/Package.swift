// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Cube",
    platforms: [.iOS(.v16)],

    products: [
        .library(
            name: "Cube",
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
