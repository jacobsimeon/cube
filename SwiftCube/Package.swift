// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "SwiftElephant",

    products: [
        .library(name: "SwiftElephant", targets: ["SwiftElephant"]),
    ],

    dependencies: [],

    targets: [
        .target(name: "SwiftElephant", dependencies: []),
        .binaryTarget(
            name: "libCube",
            path: "../cube.xcframework"
        )
    ]
)
