import Foundation
import PackagePlugin
import Darwin

@main struct CmakeBuildPlugin: BuildToolPlugin {

    func createBuildCommands(context: PackagePlugin.PluginContext, target: PackagePlugin.Target) async throws -> [PackagePlugin.Command] {

        let xcframeworkTargetDir = context.pluginWorkDirectory

        // FAILS WITH A BUNCH OF ERRORS
        /*
        let xcframeworkTargetDir = context.package.directory.appending([
            "..",
            "SwiftCube"
        ])
        */

        let xcframeworkPath = xcframeworkTargetDir.appending(subpath: "cube.xcframework")

        let scriptPath = context.package.directory.appending([
            "..",
            "libCube",
            "build-xcframework"
        ])

        debugPrint("HELLO WORLD \(xcframeworkTargetDir)")

        return [
            .prebuildCommand(displayName: "Generated xcframework",
                             executable: .init(scriptPath.string),
                             arguments: [
                                xcframeworkPath
                             ],
                             outputFilesDirectory: xcframeworkTargetDir
                            )
        ]
    }
}
