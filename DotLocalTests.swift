import CryptoKit
@testable import DotLocal
import Foundation
import XCTest

class DotLocalTests: XCTestCase {
  func test_home() {
    let url = URL(filePath: Environment.Variable.home.value)
    XCTAssertEqual(DotLocal.home, url)
  }

  func test_source() {
    // swiftlint:disable:next-line force_unwrapping
    let data = URL.currentURL.path().data(using: .utf8)!
    let hash = SHA512.raw(data: data).prefix(10)
    let base = URL.currentURL.lastPathComponent
    let path = "\(DotLocal.home.path())/\(base)-\(hash)"
    XCTAssertEqual(DotLocal.source.path(), path)
  }

  func test_target() {
    let url = URL.currentURL.appending(path: Environment.Variable.name.value)
    XCTAssertEqual(DotLocal.target, url)
  }
}
