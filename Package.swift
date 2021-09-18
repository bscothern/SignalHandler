// swift-tools-version:5.3

import PackageDescription

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
            dependencies: []
        ),
    ]
)
