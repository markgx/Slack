import XCTest
@testable import Slack

class SlackWebTests: XCTestCase {
  func testTestAPI() {
    let api = SlackWeb(token: "")
    let expectation = expectationWithDescription("api.test")

    api.apiTest(["foo": "hi"]) { data, err in
      // TODO: assert response
      expectation.fulfill()
    }

    waitForExpectationsWithTimeout(10, handler: nil)
  }
}
