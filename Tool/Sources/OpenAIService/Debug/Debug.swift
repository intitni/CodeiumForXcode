import AppKit
import Foundation

enum Debugger {
    @TaskLocal
    static var id: UUID?

    #if DEBUG
    static func didSendRequestBody(body: ChatCompletionsRequestBody) {
        let center = NotificationCenter.default
        center.post(
            name: .init("ServiceDebugger.ChatRequestDebug.requestSent"),
            object: nil,
            userInfo: [
                "id": id ?? UUID(),
                "data": body,
            ]
        )
    }

    static func didReceiveFunction(name: String, arguments: String) {
        let center = NotificationCenter.default
        center.post(
            name: .init("ServiceDebugger.ChatRequestDebug.receivedFunctionCall"),
            object: nil,
            userInfo: [
                "id": id ?? UUID(),
                "name": name,
                "arguments": arguments,
            ]
        )
    }

    static func didReceiveFunctionResult(result: String) {
        let center = NotificationCenter.default
        center.post(
            name: .init("ServiceDebugger.ChatRequestDebug.receivedFunctionResult"),
            object: nil,
            userInfo: [
                "id": id ?? UUID(),
                "result": result,
            ]
        )
    }

    static func didReceiveResponse(content: String) {
        let center = NotificationCenter.default
        center.post(
            name: .init("ServiceDebugger.ChatRequestDebug.responseReceived"),
            object: nil,
            userInfo: [
                "id": id ?? UUID(),
                "response": content,
            ]
        )
    }

    static func didFinish() {
        let center = NotificationCenter.default
        center.post(
            name: .init("ServiceDebugger.ChatRequestDebug.finished"),
            object: nil,
            userInfo: [
                "id": id ?? UUID(),
            ]
        )
    }
    #endif
}

