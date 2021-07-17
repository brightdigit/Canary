// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SentryVanilla",
    platforms: [
        .macOS(.v10_10), .iOS(.v9), .tvOS(.v9), .watchOS(.v3) // .windows, .linux - swift 5.3 won't compile it even though it's on the docs
        // https://developer.apple.com/documentation/swift_packages/platform/3112702-linux
    ],
    products: [
        .library(
            name: "SentryVanilla",
            targets: ["SentryVanilla"]),
    ],
    dependencies: [
        .package(name: "PLCrashReporter", path: "Packages/plcrashreporter")
    ],
    targets: [
        .target(
            name: "SentryVanilla",
            dependencies: [
                .product(
                    name: "CrashReporter",
                    package: "PLCrashReporter",
                    condition: .when(platforms: [.macOS, .iOS,  .tvOS])),
            ]),
        .target(
            name: "Example",
            dependencies: ["SentryVanilla"],
            path: "Example"),
        .testTarget(
            name: "SentryTests",
            dependencies: [
                "SentryVanilla",
            ]),
    ]
)
