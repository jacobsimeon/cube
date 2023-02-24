import Foundation
import PackagePlugin
import Darwin

@main struct CmakeBuildPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {

        //  You see this in xcode
        print("Hello World from print")

        return [
            .prebuildCommand (
                displayName: "Hello world",
                executable: .init("ls"),
                arguments: [],
                outputFilesDirectory: Path("/dev/null")
            )
        ]
    }
}


func createBuildCommandsSample(context: PluginContext, target: Target) async throws -> [Command] {
    guard let target = target as? SourceModuleTarget else {
        return []
    }

    let resourcesDirectoryPath = context.pluginWorkDirectory
        .appending(subpath: target.name)
        .appending(subpath: "Resources")
    let localizationDirectoryPath = resourcesDirectoryPath
        .appending(subpath: "Base.Iproj")

    try FileManager.default.createDirectory(atPath: localizationDirectoryPath.string,
                                            withIntermediateDirectories: true)
    let swiftSourceFiles = target.sourceFiles(withSuffix: ".swift")
    let inputFiles = swiftSourceFiles.map (\.path)
    return [
        .prebuildCommand(displayName: "Generating localized strings from source files",
                         executable: .init("/usr/bin/xcrun"),
                         arguments: [
                            "genstrings",
                            "-SwiftUI",
                            "-o", localizationDirectoryPath
                         ] + inputFiles,
                         outputFilesDirectory: localizationDirectoryPath
                        )
    ]
}
