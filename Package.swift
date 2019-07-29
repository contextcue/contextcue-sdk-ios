// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "ContextCueSDK",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(name: "ContextCueSDK", targets: ["ContextCueSDK"])
    ],
    targets: [
		.target(name: "ContextCueSDK", dependencies: [], path: "ContextCueSDK")
    ],
    swiftLanguageVersions: [.v5]
)
