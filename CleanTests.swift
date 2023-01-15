@testable import DotLocal
import XCTest

class CleanFlagTests: XCTestCase {
  func test_forceCleanFlagDefaultValue() {
    let flag = Clean.CleanFlag.force
    let value = false
    XCTAssertEqual(flag.default, value)
  }
}
