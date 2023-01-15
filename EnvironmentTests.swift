@testable import DotLocal
import Foundation
import XCTest

class EnvironmentVariableTests: XCTestCase {
  override func setUp() {
    super.setUp()
    let home = Environment.Variable.home
    let name = Environment.Variable.name
    setenv(home.rawValue, home.default, 1)
    setenv(name.rawValue, name.default, 1)
  }

  override func tearDown() {
    super.tearDown()
    let home = Environment.Variable.home
    let name = Environment.Variable.name
    setenv(home.rawValue, home.default, 1)
    setenv(name.rawValue, name.default, 1)
  }

  func test_homeEnvironmentVariableName() {
    let variable = Environment.Variable.home
    let value = "DL_HOME"
    XCTAssertEqual(variable.rawValue, value)
  }

  func test_nameEnvironmentVariableName() {
    let variable = Environment.Variable.name
    let value = "DL_NAME"
    XCTAssertEqual(variable.rawValue, value)
  }

  func test_homeEnvironmentVariableDefaultValue() {
    let variable = Environment.Variable.home
    let value = FileManager.default
      .homeDirectoryForCurrentUser
      .appending(path: ".dl")
      .path()
    XCTAssertEqual(variable.default, value)
  }

  func test_nameEnvironmentVariableDefaultValue() {
    let variable = Environment.Variable.name
    let value = ".local"
    XCTAssertEqual(variable.default, value)
  }

  func test_homeEnvironmentVariableValueIfSet() {
    let variable = Environment.Variable.home
    let value = ".custom"
    setenv(variable.rawValue, value, 1)
    XCTAssertEqual(variable.value, value)
  }

  func test_homeEnvironmentVariableValueIfNotSet() {
    let variable = Environment.Variable.home
    setenv(variable.rawValue, "", 1)
    XCTAssertEqual(variable.value, variable.default)
  }

  func test_nameEnvironmentVariableValueIfSet() {
    let variable = Environment.Variable.name
    let value = ".custom"
    setenv(variable.rawValue, value, 1)
    XCTAssertEqual(variable.value, value)
  }

  func test_nameEnvironmentVariableValueIfNotSet() {
    let variable = Environment.Variable.name
    setenv(variable.rawValue, "", 1)
    XCTAssertEqual(variable.value, variable.default)
  }

  func test_homeEnvironmentVariableGenerationIfValueSet() {
    let variable = Environment.Variable.home
    let value = ".custom"
    let command = "set -gx DL_HOME \".custom\";"
    XCTAssertEqual(variable.generate(with: value), command)
  }

  func test_homeEnvironmentVariableGenerationIfValueNotSet() {
    let variable = Environment.Variable.home
    let value = ""
    let command = "set -gx DL_HOME \"\(variable.default)\";"
    XCTAssertEqual(variable.generate(with: value), command)
  }

  func test_nameEnvironmentVariableGenerationIfValueSet() {
    let variable = Environment.Variable.name
    let value = ".custom"
    let command = "set -gx DL_NAME \".custom\";"
    XCTAssertEqual(variable.generate(with: value), command)
  }

  func test_nameEnvironmentVariableGenerationIfValueNotSet() {
    let variable = Environment.Variable.name
    let value = ""
    let command = "set -gx DL_NAME \"\(variable.default)\";"
    XCTAssertEqual(variable.generate(with: value), command)
  }
}
