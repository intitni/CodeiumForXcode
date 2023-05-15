import Foundation
import LaunchAgentManager

extension LaunchAgentManager {
    init() {
        self.init(
            serviceIdentifier: Bundle.main
                .object(forInfoDictionaryKey: "BUNDLE_IDENTIFIER_BASE") as! String +
                ".ExtensionService",
            executablePath: Bundle.main.bundleURL
                .appendingPathComponent("Contents")
                .appendingPathComponent("Applications")
                .appendingPathComponent(
                    "CodeiumForXcodeExtensionService.app/Contents/MacOS/CodeiumForXcodeExtensionService"
                )
                .path
        )
    }
}
