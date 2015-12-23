import SwiftHTTP

public class SlackWeb {
  let baseURL = "https://slack.com/api/"
  let token: String

  public init(token: String) {
    self.token = token
  }

  public func apiTest(params: [String: String], callback: (String?, NSError?) -> Void) {
    httpRequest("api.test", params: params, callback: callback)
  }

  public func httpRequest(path: String, params: [String: String], callback: (String?, NSError?) -> Void) {
    do {
      let req = try HTTP.GET(baseURL + path, parameters: params)

      req.start() { response in
        if let err = response.error {
          callback(nil, err)
          return
        }

        callback(String(data: response.data, encoding: NSUTF8StringEncoding), nil)
      }
    } catch let error {
      print("got an error creating the request: \(error)")
    }
  }
}
