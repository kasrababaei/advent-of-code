// swift-tools-version: 6.2
import PackageDescription

let dependencies: [Target.Dependency] = [
    .product(name: "Algorithms", package: "swift-algorithms"),
    .product(name: "Collections", package: "swift-collections"),
    .product(name: "ArgumentParser", package: "swift-argument-parser"),
]

let package = Package(
    name: "advent-of-code",
    platforms: [.macOS(.v26)],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-algorithms.git",
            .upToNextMajor(from: "1.2.1")),
        .package(
            url: "https://github.com/apple/swift-collections.git",
            .upToNextMajor(from: "1.3.0")),
        .package(
            url: "https://github.com/apple/swift-argument-parser.git",
            .upToNextMajor(from: "1.6.2")),
        .package(
            url: "https://github.com/apple/swift-format.git",
            .upToNextMajor(from: "602.0.0"))
    ],
    targets: [
        .executableTarget(
            name: "AdventOfCode",
            dependencies: dependencies,
            resources: [.copy("Data")],
            swiftSettings: [.unsafeFlags(["-enable-bare-slash-regex"])]),
        .testTarget(
            name: "AdventOfCode-Tests",
            dependencies: ["AdventOfCode"] + dependencies
        )
    ]
)
