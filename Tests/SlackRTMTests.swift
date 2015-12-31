import XCTest
@testable import Slack

class SlackRTMTests: XCTestCase {
  let token = "MY_TOKEN"
  let testChannel = "MY_CHANNEL"
  let timeout = 60.0

  func testInit() {
    let expectation = expectationWithDescription("connect")

    let rtm = SlackRTM(token: token)
    rtm.onHello = {
      debugPrint("***** Hello")
      expectation.fulfill()
    }

    rtm.connect() { error in
      if error == nil {
        debugPrint("***** connected")
      }
    }

    waitForExpectationsWithTimeout(timeout, handler: nil)
  }

  func testSendChannelMessage() {
    let expectation = expectationWithDescription("connect")

    let rtm = SlackRTM(token: token)

    rtm.onReply = {
      expectation.fulfill()
    }

    rtm.connect(nil)
    sleep(5)

    rtm.sendChannelMessage(testChannel, text: "testSendChannelMessage \(NSDate())")

    waitForExpectationsWithTimeout(timeout, handler: nil)
  }
}
