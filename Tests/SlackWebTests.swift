import XCTest
@testable import Slack

class SlackWebTests: XCTestCase {
  let token = "MY_TOKEN"
  let testChannel = "MY_CHANNEL"
  let timeout = 60.0

  func testAuthTest() {
    let api = SlackWeb(token: token)
    let expectation = expectationWithDescription("auth.test")

    api.authTest() { response, error in
      // TODO: assert result
      expectation.fulfill()
    }

    waitForExpectationsWithTimeout(60, handler: nil)
  }

  // Channels

  func testChannelsInfo() {
    let api = SlackWeb(token: token)
    let expectation = expectationWithDescription("channels.info")

    api.channelsInfo(testChannel) { response, error in
      // TODO: assert result
      expectation.fulfill()
    }

    waitForExpectationsWithTimeout(60, handler: nil)
  }

  func testChannelsJoin() {
    let api = SlackWeb(token: token)
    let expectation = expectationWithDescription("channels.join")

    api.channelsJoin("random") { response, error in
      // TODO: assert result
      expectation.fulfill()
    }

    waitForExpectationsWithTimeout(60, handler: nil)
  }

  func testChannelsLeave() {
    let api = SlackWeb(token: token)
    let expectation = expectationWithDescription("channels.leave")

    api.channelsLeave(testChannel) { response, error in
      // TODO: assert result
      expectation.fulfill()
    }

    waitForExpectationsWithTimeout(60, handler: nil)
  }

  func testChannelsList() {
    let api = SlackWeb(token: token)
    let expectation = expectationWithDescription("channels.list")

    api.channelsList() { response, error in
      // TODO: assert result
      expectation.fulfill()
    }

    waitForExpectationsWithTimeout(60, handler: nil)
  }

  func testChatPostMessage() {
    let api = SlackWeb(token: token)
    let expectation = expectationWithDescription("chat.postMessage")

    api.chatPostMessage(testChannel, text: "hi", asUser: true) { response, error in
      // TODO: assert result
      expectation.fulfill()
    }

    waitForExpectationsWithTimeout(60, handler: nil)
  }

  func testRtmStart() {
    let api = SlackWeb(token: token)
    let expectation = expectationWithDescription("rtm.start")

    api.rtmStart(true) { response, error in
      // TODO: assert result
      expectation.fulfill()
    }

    waitForExpectationsWithTimeout(60, handler: nil)
  }
}
