import ArgumentParser

/// The command to print the current dl version.
public struct Version: ParsableCommand {
  /// The current dl version.
  public static let version = "0.1.0"

  public static let configuration = CommandConfiguration(
    abstract: "Print the current dl version."
  )

  public init() {}

  public func run() {
    print(Version.version)
  }
}
