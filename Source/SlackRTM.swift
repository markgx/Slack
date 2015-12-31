import Starscream
import SwiftyJSON
import ObjectMapper

public class SlackRTM : WebSocketDelegate {
  let token: String
  var socket: WebSocket?

  public var onHello: (() -> Void)?
  public var onMessage: ((MessageResponse) -> Void)?
  public var onReply: (() -> Void)?

  public init(token: String) {
    self.token = token
  }

  public func connect(callback: ((NSError?) -> Void)?) {
    let webApi = SlackWeb(token: token)

    webApi.rtmStart() { response, error in
      if error != nil {
        debugPrint(error)
        callback?(error)
      } else {
        debugPrint("**** wss ---- " + response!.url!)
        self.socket = WebSocket(url: NSURL(string: response!.url!)!)
        self.socket!.delegate = self

        self.socket!.connect()
        callback?(nil)
      }
    }
  }

  public func sendChannelMessage(channel: String, text: String) {
    let json: JSON = ["type": "message", "channel": channel, "text": text]
    socket!.writeString(json.rawString()!)
    debugPrint("***** send ---- \(json.rawString()!)")
  }

  public func websocketDidConnect(socket: WebSocket) {
    debugPrint("***** websocket connected")
  }

  public func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
    if error != nil {
      debugPrint(error!)
    }

    debugPrint("***** websocket disconnected")
  }

  public func websocketDidReceiveData(socket: WebSocket, data: NSData) {
    debugPrint("***** websocket data \(data)")
  }

  public func websocketDidReceiveMessage(socket: WebSocket, text: String) {
    debugPrint("***** websocket msg \(text)")

    if let dataFromString = text.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
      let json = JSON(data: dataFromString)

      if let type = json["type"].string {
        switch type {
          case "hello":
            onHello?()
          case "message":
            if onMessage != nil {
              let response = Mapper<MessageResponse>().map(dataFromString)
              onMessage!(response!)
            }
          default:
            debugPrint("default")
        }
      } else if let replyTo = json["reply_to"].string {
        onReply?()
      }
    }
  }
}
