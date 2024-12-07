// swift-tools-version: 6.0
import PackageDescription

let dependencies: [Target.Dependency] = [
    .product(name: "Algorithms", package: "swift-algorithms"),
    .product(name: "Collections", package: "swift-collections"),
    .product(name: "ArgumentParser", package: "swift-argument-parser"),
]

let package = Package(
    name: "advent-of-code",
    platforms: [.macOS(.v15)],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-algorithms.git",
            .upToNextMajor(from: "1.2.0")),
        .package(
            url: "https://github.com/apple/swift-collections.git",
            .upToNextMajor(from: "1.0.0")),
        .package(
            url: "https://github.com/apple/swift-argument-parser.git",
            .upToNextMajor(from: "1.2.0")),
        .package(
            url: "https://github.com/apple/swift-format.git",
            .upToNextMajor(from: "509.0.0"))
    ],
    targets: [
        .executableTarget(
            name: "advent-of-code",
            dependencies: dependencies,
            resources: [.copy("Data")],
            swiftSettings: [.unsafeFlags(["-enable-bare-slash-regex"])]),
        .testTarget(
            name: "advent-of-code-tests",
            dependencies: ["advent-of-code"] + dependencies
        )
    ]
)
