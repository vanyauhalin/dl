import ArgumentParser
import Foundation

/// The command to clean up dl-created directories.
public struct Clean: ParsableCommand {
  /// Localized errors for the clean command.
  public enum Error: LocalizedError {
    case directoryIsNotEmpty

    public var errorDescription: String? {
      switch self {
        case .directoryIsNotEmpty:
          return NSLocalizedString(
            "The directory is not empty.",
            comment: "Directory Is Not Empty"
          )
      }
    }
  }

  /// Configurable command flags.
  public enum CleanFlag {
    /// The flag to clean up dl-created directories even if it is not empty.
    case force

    /// Default flag value.
    public var `default`: Bool {
      switch self {
        case .force:
          return false
      }
    }
  }

  public static let configuration = CommandConfiguration(
    abstract: "Clean up dl-created directories."
  )

  /// The flag to clean up dl-created directories even if it is not empty.
  @Flag(
    name: .shortAndLong,
    help: "Clean up dl-created directories even if it is not empty."
  )
  public var force = CleanFlag.force.default

  public init() {}

  /// Cleans up a link and the source subdirectory.
  public func clean(at url: URL) throws {
    guard FileManager.default.fileExists(at: url) else { return }
    let contents = try FileManager.default.contentsOfDirectory(at: url)
    guard contents.isEmpty || force else {
      throw Error.directoryIsNotEmpty
    }
    try FileManager.default.removeItem(at: url)
  }

  public func run() throws {
    try DotLocal.validateHome()
    try clean(at: DotLocal.target)
    try clean(at: DotLocal.source)
  }
}
