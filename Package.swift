// 각각 게임에 OpenAPI가 다르기에 추가 된 패키지 입니다.
// 해당 패키지는 DnF 관련 DTO, Request model 등 포함합니다.
//
// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DnFKit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "DnFKit",
            targets: ["DnFKit"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", from: "15.0.3"),
        .package(url: "https://github.com/devxoul/Then.git", from: "3.0.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.7.1")
    ],
    targets: [
        .target(
            name: "DnFKit",
            dependencies: [
                .product(name: "Moya", package: "Moya")
            ]
        ),
        .target(
            name: "Then",
            dependencies: [
                .product(name: "Then", package: "Then")
            ]
        ),
        .target(
            name: "SnapKit",
            dependencies: [
                .product(name: "SnapKit", package: "SnapKit")
            ]
        )
    ]
)
