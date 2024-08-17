// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// Unfortunately Xcode doesn't seem to like unsafe flags, so we'll have to
// cond-compile them even though we use a platform conditional.
#if os(Linux)
let linkerSettings: [LinkerSetting] = [
    .unsafeFlags(["-latomic"], .when(platforms: [.linux])),
]
#else
let linkerSettings: [LinkerSetting] = []
#endif

let package = Package(
    name: "swift-link",
    platforms: [
        .iOS(.v17),
        .macOS(.v10_15),
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
                .target(name: "LinkKit", condition: .when(platforms: [.iOS, .macCatalyst])),
            ]
        ),
        .systemLibrary(
            name: "CxxAsio",
            pkgConfig: "asio",
            providers: [
                .apt(["libasio-dev"]),
                .brew(["asio"]),
            ]
        ),
        .target(
            name: "CxxLink",
            dependencies: [
                .target(name: "CxxAsio"),
            ],
            exclude: [
                "link", // We add the header path manually
            ],
            cxxSettings: [
                .define("LINK_PLATFORM_UNIX", .when(platforms: [.macOS, .linux, .openbsd])),
                .define("LINK_PLATFORM_MACOSX", .when(platforms: [.macOS])),
                .define("LINK_PLATFORM_LINUX", .when(platforms: [.linux, .openbsd])),
                .define("LINK_PLATFORM_WINDOWS", .when(platforms: [.windows])),
                .headerSearchPath("link/include"),
                .headerSearchPath("link/third_party/catch"),
            ],
            linkerSettings: linkerSettings
        ),
        .target(
            name: "Link",
            dependencies: [
                .target(name: "CLinkKit", condition: .when(platforms: [.iOS, .macCatalyst])),
                .target(name: "CxxLink", condition: .when(platforms: [.android, .linux, .macOS, .openbsd, .wasi, .windows])),
            ]
        ),
    ],
    cxxLanguageStandard: .cxx20
)
