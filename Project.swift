import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
  name: "dl",
  organizationName: "my.vanyauhalin",
  packages: [
    .remote(
      url: "https://github.com/apple/swift-argument-parser",
      requirement: .exact("1.2.0")
    )
  ],
  targets: [
    Target(
      name: "dl",
      platform: .macOS,
      product: .commandLineTool,
      bundleId: "my.vanyauhalin.dl",
      sources: [
        "Clean.swift",
        "DotLocal.swift",
        "Environment.swift",
        "Extensions.swift",
        "Version.swift"
      ],
      scripts: [
        .lint()
      ],
      dependencies: [
        .package(product: "ArgumentParser")
      ]
    ),
    Target(
      name: "DotLocal",
      platform: .macOS,
      product: .framework,
      bundleId: "my.vanyauhalin.DotLocal",
      sources: [
        "Clean.swift",
        "DotLocal.swift",
        "Environment.swift",
        "Extensions.swift",
        "Version.swift"
      ],
      scripts: [
        .lint()
      ],
      dependencies: [
        .package(product: "ArgumentParser")
      ]
    ),
    Target(
      name: "DotLocalTests",
      platform: .macOS,
      product: .unitTests,
      bundleId: "my.vanyauhalin.DotLocalTests",
      sources: [
        "CleanTests.swift",
        "DotLocalTests.swift",
        "EnvironmentTests.swift",
        "ExtensionsTests.swift",
        "VersionTests.swift"
      ],
      dependencies: [
        .target(name: "DotLocal"),
        .xctest
      ]
    )
  ]
)
