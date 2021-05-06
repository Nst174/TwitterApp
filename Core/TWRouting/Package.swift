// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TWRouting",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "TWRouting",
            targets: ["TWRouting"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "TWRouting",
            dependencies: []),
        .testTarget(
            name: "TWRoutingTests",
            dependencies: ["TWRouting"]),
    ]
)
