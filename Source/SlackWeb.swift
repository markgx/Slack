import SwiftHTTP
import SwiftyJSON
import ObjectMapper

public class SlackWeb {
  let baseURL = "https://slack.com/api/"
  let token: String

  public init(token: String) {
    self.token = token
  }

  // https://api.slack.com/methods/api.test
//  public func apiTest(params: [String: String], callback: (JSON?, NSError?) -> Void) {
//    httpGetRequest("api.test", params: params, callback: callback)
//  }

  // https://api.slack.com/methods/auth.test
  public func authTest(callback: (AuthTestResponse?, NSError?) -> Void) {
    httpGetRequest("auth.test", params: [String: String]()) { json, error in
      if error != nil {
        callback(nil, error)
        return
      }

      let response = Mapper<AuthTestResponse>().map(json)
      callback(response, nil)
    }
  }

  // https://api.slack.com/methods/channels.info
  public func channelsInfo(name: String, callback: (ChannelsInfoResponse?, NSError?) -> Void) {
    httpGetRequest("channels.info", params: ["name": name]) { json, error in
      if error != nil {
        callback(nil, error)
        return
      }

      let response = Mapper<ChannelsInfoResponse>().map(json)
      callback(response, nil)
    }
  }

  // https://api.slack.com/methods/channels.join
  public func channelsJoin(name: String, callback: (ChannelsJoinResponse?, NSError?) -> Void) {
    httpGetRequest("channels.join", params: ["name": name]) { json, error in
      if error != nil {
        callback(nil, error)
        return
      }

      let response = Mapper<ChannelsJoinResponse>().map(json)
      callback(response, nil)
    }
  }

  // https://api.slack.com/methods/channels.leave
  public func channelsLeave(channel: String, callback: (ChannelsLeaveResponse?, NSError?) -> Void) {
    httpGetRequest("channels.leave", params: ["channel": channel]) { json, error in
      if error != nil {
        callback(nil, error)
        return
      }

      let response = Mapper<ChannelsLeaveResponse>().map(json)
      callback(response, nil)
    }
  }

  // https://api.slack.com/methods/channels.list
  public func channelsList(excludeArchived: Bool? = nil, callback: (ChannelsListResponse?, NSError?) -> Void) {
    var params = [String : String]()

    if let excludeArchivedBool = excludeArchived {
      if excludeArchivedBool {
        params["exclude_archived"] = "1"
      } else {
        params["exclude_archived"] = "0"
      }
    }

    httpGetRequest("channels.list", params: params) { json, error in
      if error != nil {
        callback(nil, error)
        return
      }

      let response = Mapper<ChannelsListResponse>().map(json)
      callback(response, nil)
    }
  }

  // https://api.slack.com/methods/chat.postMessage
  public func chatPostMessage(channel: String, text: String, username: String? = nil, asUser: Bool? = nil,
    parse: Bool? = nil, linkNames: Bool? = nil, attachments: [String: String]? = nil, unfurlLinks: Bool? = nil,
    unfurlMedia: Bool? = nil, iconUrl: String? = nil, iconEmoji: String? = nil,
    callback: (ChatPostMessageResponse?, NSError?) -> Void) {

    var params = [
      "channel": channel,
      "text": text
    ]

    if username != nil {
      params["username"] = username!
    }

    if asUser != nil {
      params["as_user"] = asUser!.description
    }

    if parse != nil {
      params["parse"] = parse!.description
    }

    if linkNames != nil {
      params["link_names"] = linkNames!.description
    }

    // TODO: attachments

    if unfurlLinks != nil {
      params["unfurl_links"] = unfurlLinks!.description
    }

    if unfurlMedia != nil {
      params["unfurl_media"] = unfurlMedia!.description
    }

    if iconUrl != nil {
      params["icon_url"] = iconUrl!
    }

    if iconEmoji != nil {
      params["icon_emoji"] = iconEmoji!
    }

    httpGetRequest("chat.postMessage", params: params) { json, error in
      if error != nil {
        callback(nil, error)
        return
      }

      let response = Mapper<ChatPostMessageResponse>().map(json)
      callback(response, nil)
    }
  }

  // https://api.slack.com/methods/rtm.start
  public func rtmStart(simpleLatest: Bool? = nil, noUnreads: Bool? = nil, mpimAware: Bool? = nil,
    callback: (RTMStartResponse?, NSError?) -> Void) {

    var params = [String : String]()

    if simpleLatest != nil {
      params["simple_latest"] = simpleLatest!.description
    }

    if noUnreads != nil {
      params["no_unreads"] = noUnreads!.description
    }

    if mpimAware != nil {
      params["mpim_aware"] = mpimAware!.description
    }

    httpGetRequest("rtm.start", params: params) { json, error in
      if error != nil {
        callback(nil, error)
        return
      }

      let response = Mapper<RTMStartResponse>().map(json)
      callback(response, nil)
    }
  }

  // https://api.slack.com/methods/users.getPresence
  public func usersGetPresence(user: String, callback: (UsersGetPresenceResponse?, NSError?) -> Void) {
    httpGetRequest("users.getPresence", params: ["user": user]) { json, error in
      if error != nil {
        callback(nil, error)
        return
      }

      let response = Mapper<UsersGetPresenceResponse>().map(json)
      callback(response, nil)
    }
  }

  // https://api.slack.com/methods/users.info
  public func usersInfo(user: String, callback: (UsersInfoResponse?, NSError?) -> Void) {
    httpGetRequest("users.info", params: ["user": user]) { json, error in
      if error != nil {
        callback(nil, error)
        return
      }

      let response = Mapper<UsersInfoResponse>().map(json)
      callback(response, nil)
    }
  }

  // https://api.slack.com/methods/users.list
  public func usersList(presence: Bool? = nil, callback: (UsersListResponse?, NSError?) -> Void) {
    var params = [String: String]()

    if let presenceBool = presence {
      params["presence"] = presenceBool ? "1" : "0"
    }

    httpGetRequest("users.list", params: params) { json, error in
      if error != nil {
        callback(nil, error)
        return
      }

      let response = Mapper<UsersListResponse>().map(json)
      callback(response, nil)
    }
  }

  // https://api.slack.com/methods/users.setActive
  public func usersSetActive(callback: (NSError?) -> Void) {
    httpGetRequest("users.setActive", params: [String: String]()) { json, error in
      if error != nil {
        callback(error)
        return
      }

      callback(nil)
    }
  }

  // https://api.slack.com/methods/users.setPresence
  public func usersSetPresence(presence: Presence, callback: (NSError?) -> Void) {
    httpGetRequest("users.setPresence", params: ["presence": presence.rawValue]) { json, error in
      if error != nil {
        callback(error)
        return
      }

      callback(nil)
    }
  }

  public func httpGetRequest(path: String, params: [String: String], callback: (String?, NSError?) -> Void) {
    do {
      var mergedParams = params
      mergedParams["token"] = token

      let req = try HTTP.GET(baseURL + path, parameters: mergedParams)

      req.start() { response in
        if let err = response.error {
          callback(nil, err)
          return
        }

        let json = JSON(data: response.data)
        debugPrint(String(data: response.data, encoding: NSUTF8StringEncoding))

        if !json["ok"].boolValue {
          callback(nil, NSError(domain: json["error"].stringValue, code: NSURLErrorBadServerResponse, userInfo: nil))
          return
        }

        callback(String(data: response.data, encoding: NSUTF8StringEncoding), nil)
      }
    } catch let error {
      print("error: \(error)")
      // TODO: return error
    }
  }
}
