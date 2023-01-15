import Foundation
import ProjectDescription

public let current = URL(filePath: FileManager.default.currentDirectoryPath)

extension ProjectDescription.TargetScript {
  public static let makefile = current.appending(path: "Makefile").path()

  public static func make(_ subcommand: String) -> TargetScript {
    .pre(
      script: "make -f \(makefile) \(subcommand)",
      name: "make \(subcommand)"
    )
  }

  public static func lint() -> TargetScript {
    .make("lint")
  }
}
