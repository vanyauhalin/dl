@testable import DotLocal
import XCTest

class VersionTests: XCTestCase {
  func test_version() {
    XCTAssertEqual(Version.version, "0.1.0")
  }
}
