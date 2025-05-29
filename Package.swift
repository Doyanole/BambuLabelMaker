// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "BambuLabelMaker",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "BambuLabelMaker",
            targets: ["BambuLabelMaker"]),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/realm-swift.git", from: "10.42.0"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "BambuLabelMaker",
            dependencies: [
                .product(name: "RealmSwift", package: "realm-swift"),
                .product(name: "Kingfisher", package: "onevcat/Kingfisher")
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "BambuLabelMakerTests",
            dependencies: ["BambuLabelMaker"]),
    ]
) 