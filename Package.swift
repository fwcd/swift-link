// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let linkPlatformDefines: [CXXSetting] = [
    .define("LINK_PLATFORM_UNIX", .when(platforms: [.macOS, .linux, .openbsd])),
    .define("LINK_PLATFORM_MACOSX", .when(platforms: [.macOS])),
    .define("LINK_PLATFORM_LINUX", .when(platforms: [.linux, .openbsd])),
    .define("LINK_PLATFORM_WINDOWS", .when(platforms: [.windows])),
]

let package = Package(
    name: "swift-link",
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
    targets: [
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
            dependencies: [
                .target(name: "LinkKit", condition: .when(platforms: [.iOS])),
            ]
        ),
        .systemLibrary(
            name: "CxxAsio",
            pkgConfig: "asio",
            providers: [
                .apt(["asio-dev"]),
                .brew(["asio"]),
            ]
        ),
        .target(
            name: "CxxLink",
            dependencies: [
                .target(name: "CxxAsio"),
            ],
            exclude: [
                "link/examples",
                "link/extensions/abl_link/examples",
                "link/src", // Contains only tests
                "link/modules", // We already consume asio as a system library
            ],
            publicHeadersPath: "link/extensions/abl_link/include",
            cxxSettings: linkPlatformDefines + [
                .headerSearchPath("link/include"),
                .headerSearchPath("link/third_party/catch"),
            ]
        ),
        .target(
            name: "Link",
            dependencies: [
                .target(name: "CLinkKit", condition: .when(platforms: [.iOS])),
                .target(name: "CxxLink", condition: .when(platforms: [.macOS])) // TODO: Other platforms
            ]
        ),
    ],
    cxxLanguageStandard: .cxx20
)
