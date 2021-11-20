// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Canary",
  platforms: [
    .macOS(.v10_15),
    .iOS(.v10),
    .tvOS(.v10),
    .watchOS(.v3)
  ],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "Canary",
      targets: ["Canary"]
    )
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.

    .package(url: "https://github.com/brightdigit/Prch.git", from: "0.1.1"),
    .package(name: "PLCrashReporter", url: "https://github.com/microsoft/plcrashreporter.git", from: "1.10.0"),
    .package(name: "Sentry", url: "https://github.com/getsentry/sentry-cocoa.git", from: "7.5.0"),
    .package(url: "https://github.com/shibapm/Komondor", from: "1.1.0"), // dev
    .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.47.0"), // dev
    .package(url: "https://github.com/realm/SwiftLint", from: "0.43.0"), // dev
    .package(url: "https://github.com/shibapm/Rocket.git", from: "1.2.0"), // dev
    .package(url: "https://github.com/mattpolzin/swift-test-codecov", .branch("master")) // dev
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "Canary",
      dependencies: ["Prch", "SentryVanilla", "Sentry"]
    ),
    .testTarget(
      name: "CanaryTests",
      dependencies: ["Canary"]
    ),
    .target(
      name: "SentryVanilla",
      dependencies: [
        .product(
          name: "CrashReporter",
          package: "PLCrashReporter",
          condition: .when(platforms: [.macOS, .iOS, .tvOS])
        )
      ]
    )
  ]
)

#if canImport(PackageConfig)
  import PackageConfig

  let requiredCoverage: Int = 0

  let config = PackageConfiguration([
    //    "rocket": [
//      "steps": [
//        ["hide_dev_dependencies": ["package_path": "Package@swift-5.5.swift"]],
//        "hide_dev_dependencies",
//        "git_add",
//        "commit",
//        "tag",
//        "unhide_dev_dependencies",
//        ["unhide_dev_dependencies": ["package_path": "Package@swift-5.5.swift"]],
//        "git_add",
//        ["commit": ["message": "Unhide dev dependencies"]]
//      ]
//    ],
    "komondor": [
      "pre-push": [
        // "swift test --enable-code-coverage --enable-test-discovery",
        // swiftlint:disable:next line_length
        // "swift run swift-test-codecov .build/debug/codecov/Canary.json --minimum \(requiredCoverage)"
      ],
      "pre-commit": [
        // "swift test --enable-code-coverage --enable-test-discovery --generate-linuxmain",
        "swift run swiftformat .",
        "swift run swiftlint autocorrect",
        // "swift run sourcedocs generate build --clean --reproducible-docs --all-modules",
        "git add .",
        "swift run swiftformat --lint .",
        "swift run swiftlint"
      ]
    ]
  ]).write()
#endif
