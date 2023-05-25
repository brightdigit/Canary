// swift-tools-version:5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Canary",
  platforms: [.iOS(.v16), .macOS(.v12), .watchOS(.v9)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "Canary",
      targets: ["Canary"]
    )
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    .package(url: "https://github.com/brightdigit/Prch.git", from: "1.0.0-alpha.1"),
    //.package(name: "PLCrashReporter", url: "https://github.com/microsoft/plcrashreporter.git", from: "1.10.0"),
    .package(url: "https://github.com/getsentry/sentry-cocoa", from: "8.7.2")
    //    .package(name: "SwiftSentry", url: "https://github.com/swift-sentry/swift-sentry.git", from: "1.0.0")

  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "Canary",
      dependencies: ["Prch", 
                     .product(
                       name: "Sentry",
                       package: "sentry-cocoa",
                       condition: .when(platforms: [.macOS, .iOS, .watchOS, .tvOS])
                     )]
    ),
    .testTarget(
      name: "CanaryTests",
      dependencies: ["Canary"]
    ),
    // .target(
    //   name: "SentryVanilla",
    //   dependencies: [
    //     .product(
    //       name: "CrashReporter",
    //       package: "PLCrashReporter",
    //       condition: .when(platforms: [.macOS, .iOS, .tvOS])
    //     )
    //   ]
    // )
  ]
)
