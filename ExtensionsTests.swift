import CryptoKit
@testable import DotLocal
import Foundation
import XCTest

class ExtensionsStringTests: XCTestCase{
  func test_newlineString() {
    #if os(Windows)
      XCTAssertEqual(String.newline, "\r\n")
    #else
      XCTAssertEqual(String.newline, "\n")
    #endif
  }
}

class ExtensionsSHA512Tests: XCTestCase {
  func test_rawSHA512Hash() {
    // swiftlint:disable:next-line force_unwrapping
    let data = "Hello world!".data(using: .utf8)!
    let hash = "f6cde2a0f8"
    XCTAssert(SHA512.raw(data: data).starts(with: hash))
  }
}

class ExtensionsURLTests: XCTestCase {
  func test_currentURL() {
    let path = FileManager.default.currentDirectoryPath
    let url = URL.currentURL
    XCTAssertEqual(url.path(), path)
  }

  func test_isItAbsolute() {
    let absolute = URL(filePath: "/sources")
    let relative = URL(filePath: "sources")
    XCTAssert(absolute.absolute)
    XCTAssertFalse(relative.absolute)
  }
}
