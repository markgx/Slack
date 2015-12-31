import ObjectMapper

public struct MessageResponse: Mappable {
  public var channel: String?
  public var user: String?
  public var text: String?
  public var ts: NSDate?

  public init?(_ map: Map) { }

  public mutating func mapping(map: Map) {
    channel <- map["channel"]
    user    <- map["user"]
    text    <- map["text"]
    ts      <- (map["ts"], DateTransform())
  }
}
