import CryptoKit
import Foundation

extension String {
  /// OS-independent newline character.
  public static var newline: String {
    #if os(Windows)
      return "\r\n"
    #else
      return "\n"
    #endif
  }
}

extension SHA512 {
  /// Wrapper over the `hash` function to extract a hash string without
  /// comments.
  public static func raw<D>(data: D) -> String where D: DataProtocol {
    hash(data: data)
      .description
      .replacingOccurrences(of: "SHA512 digest: ", with: "")
  }
}

extension URL {
  /// Wrapper over the `currentDirectoryPath` to convert it to the URL.
  public static var currentURL: URL {
    URL(filePath: FileManager.default.currentDirectoryPath)
  }

  /// Checks if the path is absolute.
  public var absolute: Bool {
    path().prefix(1) == "/"
  }
}

extension FileManager {
  /// Wrapper over the `contentsOfDirectory()` to support URL as a parameter.
  public func contentsOfDirectory(at url: URL) throws -> [String] {
    try contentsOfDirectory(atPath: url.path())
  }

  /// Wrapper over the `fileExists()` to support URL as a parameter.
  public func fileExists(at url: URL) -> Bool {
    fileExists(atPath: url.path())
  }
}
