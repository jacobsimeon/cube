// swift-tools-version: 5.7

import PackageDescription

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

    dependencies: [
        .package(path: "../CmakeBuildPlugin")
    ],

    targets: [
        .target(name: "Cube",
                dependencies: ["OCCube"]),
        .target(name: "OCCube",
//                dependencies: ["cube"],
                plugins: [
                    .plugin(name: "CmakeBuildPlugin",
                            package: "CmakeBuildPlugin")
                ]
        ),
        .binaryTarget(
            name: "cube",
            path: "./cube.xcframework"
        )
    ]
)
