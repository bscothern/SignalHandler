// swift-tools-version:5.3

import Foundation
import PackageDescription

var disabledSignals: [SwiftSetting] {
    let signalDisableFlags: [(flag: String, forceDisable: Bool)] = [
        // When turned on all unix signals are disabled and just the base C standard 6 signals are supported.
        (flag: "NO_UNIX_SIGNALS", forceDisable: false),
        // Unix Signal Specific Flags
        (flag: "NO_SIGHUP", forceDisable: false),
        (flag: "NO_SIGQUIT", forceDisable: false),
        (flag: "NO_SIGTRAP", forceDisable: false),
        (flag: "NO_SIGEMT", forceDisable: false),
        (flag: "NO_SIGKILL", forceDisable: false),
        (flag: "NO_SIGBUS", forceDisable: false),
        (flag: "NO_SIGSYS", forceDisable: false),
        (flag: "NO_SIGPIPE", forceDisable: false),
        (flag: "NO_SIGALRM", forceDisable: false),
        (flag: "NO_SIGURG", forceDisable: false),
        (flag: "NO_SIGSTOP", forceDisable: false),
        (flag: "NO_SIGTSTP", forceDisable: false),
        (flag: "NO_SIGCONT", forceDisable: false),
        (flag: "NO_SIGCHLD", forceDisable: false),
        (flag: "NO_SIGTTIN", forceDisable: false),
        (flag: "NO_SIGTTOU", forceDisable: false),
        (flag: "NO_SIGIO", forceDisable: false),
        (flag: "NO_SIGXCPU", forceDisable: false),
        (flag: "NO_SIGXFSZ", forceDisable: false),
        (flag: "NO_SIGVTALRM", forceDisable: false),
        (flag: "NO_SIGPROF", forceDisable: false),
        (flag: "NO_SIGWINCH", forceDisable: false),
        (flag: "NO_SIGINFO", forceDisable: false),
        (flag: "NO_SIGUSR1", forceDisable: false),
        (flag: "NO_SIGUSR2", forceDisable: false),
    ]

    return signalDisableFlags.lazy
        .filter { ProcessInfo.processInfo.environment[$0.flag] != nil || $0.forceDisable }
        .map { SwiftSetting.define($0.flag) }
}

let package = Package(
    name: "SignalHandler",
    products: [
        .library(
            name: "SignalHandler",
            targets: ["SignalHandler"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SignalHandler",
            dependencies: [],
            swiftSettings: disabledSignals
        ),
    ]
)
