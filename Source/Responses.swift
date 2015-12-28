import ObjectMapper

// Auth

public struct AuthTestResponse: Mappable {
  public var url: String?
  public var team: String?
  public var user: String?
  public var teamID: String?
  public var userID: String?

  public init?(_ map: Map) { }

  public mutating func mapping(map: Map) {
    url     <- map["url"]
    team    <- map["team"]
    user    <- map["user"]
    teamID  <- map["team_id"]
    userID  <- map["user_id"]
  }
}

// Channels

public struct ChannelInfoResponse: Mappable {
  public var value: String?
  public var creator: String?
  public var lastSet: NSDate?

  public init?(_ map: Map) { }

  public mutating func mapping(map: Map) {
    value   <- map["value"]
    creator <- map["creator"]
    lastSet <- (map["last_set"], DateTransform())
  }
}

public struct ChannelResponse: Mappable {
  public var id: String?
  public var name: String?
  public var created: NSDate?
  public var creator: String?
  public var isArchived: Bool?
  public var isMember: Bool?
  public var isGeneral: Bool?
  public var lastRead: NSDate?
//  public var latest: String?
  public var unreadCount: Int?
  public var unreadCountDisplay: Int?
  public var members: [String]?
  public var topic: ChannelInfoResponse?
  public var purpose: ChannelInfoResponse?

  public init?(_ map: Map) { }

  public mutating func mapping(map: Map) {
    id         <- map["id"]
    name       <- map["name"]
    created    <- (map["created"], DateTransform())
    creator    <- map["creator"]
    isArchived <- map["is_archived"]
    isMember   <- map["is_member"]
    isGeneral  <- map["is_general"]
    lastRead   <- map["last_read"]
//    latest   <- map["last_read"]
    unreadCount   <- map["unread_count"]
    unreadCountDisplay   <- map["unread_count_display"]
    members   <- map["members"]
    topic      <- map["topic"]
    purpose    <- map["purpose"]
  }
}

public struct ChannelsInfoResponse: Mappable {
  public var channel: ChannelResponse?

  public init?(_ map: Map) { }

  public mutating func mapping(map: Map) {
    channel <- map["channel"]
  }
}

public struct ChannelsJoinResponse: Mappable {
  public var alreadyInChannel: Bool?
  public var channel: ChannelResponse?

  public init?(_ map: Map) { }

  public mutating func mapping(map: Map) {
    alreadyInChannel <- map["already_in_channel"]
    channel <- map["channel"]
  }
}

public struct ChannelsLeaveResponse: Mappable {
  public var channel: String?

  public init?(_ map: Map) { }

  public mutating func mapping(map: Map) {
    channel <- map["channel"]
  }
}

public struct ChannelsListResponse: Mappable {
  public var channels: [ChannelResponse]?

  public init?(_ map: Map) { }

  public mutating func mapping(map: Map) {
    channels <- map["channels"]
  }
}

public struct ChatPostMessageResponse: Mappable {
  public var ts: NSDate?
  public var channel: String?
  // TODO: add all attributes

  public init?(_ map: Map) { }

  public mutating func mapping(map: Map) {
    ts      <- (map["ts"], DateTransform())
    channel <- map["channel"]
  }
}
