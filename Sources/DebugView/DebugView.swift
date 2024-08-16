// The Swift Programming Language
// https://docs.swift.org/swift-book
// Bin Hua <https://binhua.org>
import Foundation
import os.log
import SwiftUI

public struct DebugView: View {
    @State private var showLogs = false
    @StateObject private var logger = DebugLogger.shared

    public init() {}

    public var body: some View {
        ZStack {
            if showLogs {
                LogView()
                    .transition(.move(edge: .bottom))
            }

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            showLogs.toggle()
                        }
                    }) {
                        Image(systemName: "ladybug")
                            .font(.system(size: 30))
                            .foregroundColor(.yellow)
                            .padding()
                    }
                    .padding()
                }
            }
        }
    }
}

private struct LogView: View {
    @ObservedObject private var logger = DebugLogger.shared

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(logger.logs, id: \.self) { log in
                    Text(log)
                        .padding(.vertical, 2)
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.8))
        .foregroundColor(.white)
    }
}

public class DebugLogger: ObservableObject {
    public static let shared = DebugLogger()

    @Published private(set) var logs: [String] = []

    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "DebugView", category: "DebugLogs")

    private init() {}

    public func log(_ items: Any..., separator: String = " ", terminator: String = "\n", file: String = #file, line: Int = #line) {
        let message = items.map { String(describing: $0) }.joined(separator: separator)
        let logMessage = "[\(file.split(separator: "/").last ?? ""):\(line)] \(message)"

        // Print to console
        Swift.print(logMessage, terminator: terminator)

        // Log using os.log
        logger.debug("\(logMessage)")

        // Add to our logs
        DispatchQueue.main.async {
            self.logs.append(logMessage)
        }
    }
}
