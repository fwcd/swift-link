// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

var targets: [Target] = []

#if os(iOS)
targets += [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .binaryTarget(
        name: "LinkKit",
        url: "https://github.com/Ableton/LinkKit/releases/download/LinkKit-3.2.1/LinkKit.zip",
        // Recompute with `swift package compute-checksum <path/to/zip>`
        checksum: "ed0f216a7cd63e569b045397958be2a622d1e8a403939570781d8e8e8b32f182"
    ),
    .target(
        name: "CLinkKit",
        dependencies: ["LinkKit"]
    ),
    .target(
        name: "Link",
        dependencies: ["CLinkKit"]
    ),
]
#else
targets += [
    .target(
        name: "Link",
        dependencies: []
    ),
]
#endif

let package = Package(
    name: "Link",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Link",
            targets: ["Link"]
        ),
    ],
    targets: targets
)
