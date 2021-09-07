// swift-tools-version:5.5
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
            targets: ["Canary"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        
      .package(url: "https://github.com/brightdigit/Prch.git", from: "0.1.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Canary",
            dependencies: ["Prch"]),
        .testTarget(
            name: "CanaryTests",
            dependencies: ["Canary"]),
    ]
)
