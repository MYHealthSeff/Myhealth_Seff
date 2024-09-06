// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "MyHealth.AI",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "MyHealth.AI",
            targets: ["MyHealth.AI"]
        ),
    ],
    dependencies: [
        // Add any external package dependencies here
    ],
    targets: [
        .target(
            name: "MyHealth.AI",
            dependencies: [],
            path: "Sources",
            exclude: ["Tests"],
            resources: [
                .process("Resources") // Add if you have resources
            ]
        ),
        .testTarget(
            name: "MyHealthAITests",
            dependencies: ["MyHealth.AI"],
            path: "Tests"
        )
    ]
)

