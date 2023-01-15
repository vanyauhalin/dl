import ArgumentParser
import Foundation

/// The command to set up environment variables.
public struct Environment: ParsableCommand {
  /// Configurable environment variables.
  public enum Variable: String {
    /// The absolute path to the home directory where the project-related files
    /// will be located.
    case home = "DL_HOME"

    /// The target name for a symbolic link in the project.
    case name = "DL_NAME"

    /// Default variable value.
    public var `default`: String {
      switch self {
        case .home:
          return FileManager.default
            .homeDirectoryForCurrentUser
            .appending(path: ".dl")
            .path()
        case .name:
          return ".local"
      }
    }

    /// The environment variable value from a launched process, if passed, or
    /// the default value if not.
    public var value: String {
      guard let value = ProcessInfo.processInfo.environment[rawValue] else {
        return `default`
      }
      return value.isEmpty ? `default` : value
    }

    /// Generates a one-line shell command to set the environment variable.
    ///
    /// - Returns: One-line shell command to set the environment variable.
    public func generate(with value: String) -> String {
      "set -gx \(rawValue) \"\(value.isEmpty ? `default` : value)\";"
    }
  }

  public static let configuration = CommandConfiguration(
    commandName: "env",
    abstract: "Print commands to set up dl environment.",
    discussion: ""
      + "This is an optional command that generates a few commands that should "
      + "be evaluated by your shell to override default values.\n\n"
      + "Each shell has its own syntax of evaluating a dynamic expression. "
      + "For example:\n\n"
      + "  - in Bash and Zsh would look like `eval \"$(dl env)\"`\n"
      + "  - in Fish would look like `eval (dl env)` or `dl env | source`\n\n"
      + "For more information about evaluation, please refer to your "
      + "terminal's documentation."
  )

  /// The absolute path to the home directory where the project-related files
  /// will be located.
  ///
  /// By default, `home` is `.dl` in the current user's home directory.
  @Option(
    name: .long,
    help: ArgumentHelp(
      "The absolute path to the home directory where the project-related files "
      + "will be located.",
      valueName: Variable.home.rawValue
    )
  )
  public var home = Variable.home.default

  /// The target name for a symbolic link in the project.
  ///
  /// By default, `name` is `.local`.
  @Option(
    name: .long,
    help: ArgumentHelp(
      "The target name for a symbolic link in the project.",
      valueName: Variable.name.rawValue
    )
  )
  public var name = Variable.name.default

  /// The generated shell command to set the environment variable.
  public var generated: String {
    [
      Variable.home.generate(with: home),
      Variable.name.generate(with: name)
    ]
      .joined(separator: .newline)
  }

  public init() {}

  public func run() {
    print(generated)
  }
}
