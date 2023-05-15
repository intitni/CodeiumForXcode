import ArgumentParser
import Foundation

struct Helper: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "helper",
        abstract: "Helper CLI for Codeium for Xcode",
        subcommands: [
            ReloadLaunchAgent.self,
        ]
    )
}

Helper.main()
