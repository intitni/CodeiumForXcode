import Foundation

public var userDefaultSuiteName: String {
    "5YKZ4Y3DAW.group.com.intii.CodeiumForXcode"
}

public var keychainAccessGroup: String {
    #if DEBUG
    return "5YKZ4Y3DAW.dev.com.intii.CodeiumForXcode.Shared"
    #else
    return "5YKZ4Y3DAW.com.intii.CodeiumForXcode.Shared"
    #endif
}

public var keychainService: String {
    #if DEBUG
    return "dev.com.intii.CodeiumForXcode"
    #else
    return "com.intii.CodeiumForXcode"
    #endif
}

