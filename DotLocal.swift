import ArgumentParser
import CryptoKit
import Foundation

/// A tiny tool for creating a local directory in a project that should not be
/// published.
///
/// Sometimes it is necessary to store additional information in sources and
/// yet not publish it to a branch. The dl helps to ingenuously organize it.
///
/// ```text
/// /Users/vanyauhalin
/// ├─ .dl
/// │  └─ my-first-project-f98fa077fe ─┐
/// └─ my-first-project                │
///    └─ .local  # Symbolic link to ──┘
/// ```
///
/// When the dl is executed, it:
///
/// 1. Creates a directory in dl's home directory with a name consisting of the
/// current directory name and the hashed path to it.
/// 2. Creates a symbolic link in the current directory to the directory created
/// in the first step.
///
/// The dl's home directory, as well as the name of the directory created within
/// the project, can be changed. Take a look at the environment command for more
/// information on this.
@main
public struct DotLocal: ParsableCommand {
  /// Localized errors for the main command.
  public enum Error: LocalizedError {
    /// Error if the home directory is not absolute.
    case homePathIsNotAbsolute

    /// Error if the target directory already exists.
    case targetDirectoryAlreadyExists

    public var errorDescription: String? {
      switch self {
        case .homePathIsNotAbsolute:
          return NSLocalizedString(
            "The home directory path should be absolute.",
            comment: "Home Path Is Not Absolute"
          )
        case .targetDirectoryAlreadyExists:
          return NSLocalizedString(
            "The target directory already exists.",
            comment: "Target Directory Already Exists"
          )
      }
    }
  }

  public static let configuration = CommandConfiguration(
    commandName: "dl",
    abstract: ""
      + "A tiny tool for creating a local directory in a project that should "
      + "not be published.",
    subcommands: [
      Clean.self,
      Environment.self,
      Version.self
    ]
  )

  /// The home directory where the project-related files will be located.
  public static var home: URL {
    URL(filePath: Environment.Variable.home.value)
  }

  /// The the source subdirectory in the home directory for the project.
  public static var source: URL {
    // We can omit the strictness as it is safe enough.
    // swiftlint:disable:next-line force_unwrapping
    let data = URL.currentURL.path().data(using: .utf8)!
    let hash = SHA512.raw(data: data).prefix(10)
    let base = URL.currentURL.lastPathComponent
    return home.appending(path: "\(base)-\(hash)")
  }

  /// The target directory in the project to link to the source subdirectory.
  public static var target: URL {
    .currentURL.appending(path: Environment.Variable.name.value)
  }

  public init() {}

  /// Validates that the home variable is absolute.
  public static func validateHome() throws {
    guard DotLocal.home.absolute else {
      throw Error.homePathIsNotAbsolute
    }
  }

  /// Validates that the target does not exist.
  public static func validateTarget() throws {
    guard !FileManager.default.fileExists(at: DotLocal.target) else {
      throw Error.targetDirectoryAlreadyExists
    }
  }

  /// Creates the source subdirectory in the home directory.
  public static func createSource() throws {
    try FileManager.default.createDirectory(
      at: DotLocal.source,
      withIntermediateDirectories: true
    )
  }

  /// Creates a link to the source subdirectory.
  public static func createTarget() throws {
    try FileManager.default.createSymbolicLink(
      at: DotLocal.target,
      withDestinationURL: DotLocal.source
    )
  }

  public func run() throws {
    try DotLocal.validateHome()
    try DotLocal.validateTarget()
    try DotLocal.createSource()
    try DotLocal.createTarget()
  }
}
