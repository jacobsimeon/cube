import Foundation
import PackagePlugin
import Darwin

@main struct CmakeBuildPlugin: BuildToolPlugin {

    func createBuildCommands(context: PackagePlugin.PluginContext, target: PackagePlugin.Target) async throws -> [PackagePlugin.Command] {

        let xcframeworkPath = context.package.directory.appending(subpath: "cube.xcframework")

        let scriptPath = context.package.directory.appending([
            "..",
            "libCube",
            "build-xcframework"
        ])

        return [
            .prebuildCommand(displayName: "Generated xcframework",
                             executable: .init(scriptPath.string),
                             arguments: [
                                xcframeworkPath
                             ],
                             outputFilesDirectory: context.package.directory
                            )
        ]
    }
}
