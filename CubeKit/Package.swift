// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "CubeKit",
    platforms: [.iOS(.v16)],

    products: [
        .library(
            name: "CubeKit",
            type: .static,
            targets: ["CubeKit"]
        ),
    ],

    dependencies: [],

    targets: [
        .target(name: "CubeKit", dependencies: ["OCCubeKit"]),
        .target(name: "OCCubeKit", dependencies: ["libCube"]),
        .target(
            name: "libCube",
            dependencies: ["MoltenVK"],
            cxxSettings: [.headerSearchPath("../../MoltenVK/MoltenVK.xcframework/Headers")]
        ),
        .binaryTarget(name: "MoltenVK", path: "./MoltenVK/MoltenVK.xcframework")
    ],
    cxxLanguageStandard: CXXLanguageStandard.cxx20
)

/*
 set(MOLTENVK_PATH /Users/morrisj/Source/llmv/VulkanSDK/current/MoltenVK/MoltenVK.xcframework/ios-arm64/libMoltenVK.a)
 set(MOLTENVK_INCLUDE_PATH /Users/morrisj/Source/llmv/VulkanSDK/current/MoltenVK/include)
*/
