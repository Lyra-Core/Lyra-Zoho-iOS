// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LyraZoho",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "LyraZoho",
            targets: ["LyraZoho",]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/zoho/SalesIQ-Mobilisten-iOS-SP.git", from: "10.1.6")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "LyraZoho",
            dependencies: [
                .product(name: "Mobilisten", package: "SalesIQ-Mobilisten-iOS-SP"),
                // Only if you also need call support:
                // .product(name: "MobilistenCalls", package: "SalesIQ-Mobilisten-iOS-SP")
            ],
            resources: [
                .process("Resources/departments.json"),
                .process("Resources/translations")
            ]
        ),
        .testTarget(
            name: "LyraZohoTests",
            dependencies: ["LyraZoho"]
        ),
    ]
)
