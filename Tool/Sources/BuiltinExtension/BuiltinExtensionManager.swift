import AppKit
import Combine
import Foundation
import XcodeInspector

public final class BuiltinExtensionManager {
    public static let shared: BuiltinExtensionManager = .init()
    public private(set) var extensions: [any BuiltinExtension] = []

    private var cancellable: Set<AnyCancellable> = []

    init() {
        XcodeInspector.shared.$activeApplication.sink { [weak self] app in
            if let app, app.isXcode || app.isExtensionService {
                self?.checkAppConfiguration()
            }
        }.store(in: &cancellable)
    }

    public func setupExtensions(_ extensions: [any BuiltinExtension]) {
        self.extensions = extensions
        checkAppConfiguration()
    }

    public func addExtensions(_ extensions: [any BuiltinExtension]) {
        self.extensions.append(contentsOf: extensions)
        checkAppConfiguration()
    }

    public func terminate() {
        for ext in extensions {
            ext.terminate()
        }
    }
}

extension BuiltinExtensionManager {
    func checkAppConfiguration() {
        let suggestionFeatureProvider = UserDefaults.shared.value(for: \.suggestionFeatureProvider)
        for ext in extensions {
            let isSuggestionFeatureInUse = switch suggestionFeatureProvider {
            case let .builtIn(provider):
                switch provider {
                case .gitHubCopilot:
                    ext.extensionIdentifier == "com.github.copilot"
                case .codeium:
                    ext.extensionIdentifier == "com.codeium"
                }
            case let .extension(_, bundleIdentifier):
                ext.extensionIdentifier == bundleIdentifier
            }
            let isChatFeatureInUse = false
            ext.extensionUsageDidChange(.init(
                isSuggestionServiceInUse: isSuggestionFeatureInUse,
                isChatServiceInUse: isChatFeatureInUse
            ))
        }
    }
}

