import Foundation
import PackagePlugin

@main struct CmakeBuildPlugin: BuildToolPlugin {
	func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
		print("Hello World")
		return []
	}
}