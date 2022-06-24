import Foundation
import Prch

public extension Events {
  /** This endpoint lists an issue's events. */
  enum ListAnIssuesEvents {
    public static let service = Service<Response>(id: "List an Issue's Events", tag: "Events", method: "GET", path: "/api/0/issues/{issue_id}/events/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["event:read"])])

    public final class Request: DeprecatedRequest<Response, CanaryAPI> {
      public struct Options {
        /** The ID of the issue to retrieve. */
        public var issueId: String

        /** If this is set to true then the event payload will include the full event body, including the stacktrace.
         Set to true to enable. */
        public var full: Bool?

        public init(issueId: String, full: Bool? = nil) {
          self.issueId = issueId
          self.full = full
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
        super.init(service: ListAnIssuesEvents.service)
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(issueId: String, full: Bool? = nil) {
        let options = Options(issueId: issueId, full: full)
        self.init(options: options)
      }

      override public var path: String {
        super.path.replacingOccurrences(of: "{" + "issue_id" + "}", with: "\(self.options.issueId)")
      }

      override public var queryParameters: [String: Any] {
        var params: [String: Any] = [:]
        if let full = options.full {
          params["full"] = full
        }
        return params
      }
    }

    public enum Response: DeprecatedResponse, CustomStringConvertible, CustomDebugStringConvertible {
      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      /** This endpoint lists an issue's events. */
      public struct Status200: Model {
        public var eventID: String

        public var tags: [Tags]

        public var dateCreated: String

        public var user: User?

        public var message: String

        public var id: String

        public var platform: String

        public var eventType: String

        public var groupID: String

        public var title: String

        /** This endpoint lists an issue's events. */
        public struct Tags: Model {
          public var key: String?

          public var value: String?

          public init(key: String? = nil, value: String? = nil) {
            self.key = key
            self.value = value
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            key = try container.decodeIfPresent("key")
            value = try container.decodeIfPresent("value")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encodeIfPresent(key, forKey: "key")
            try container.encodeIfPresent(value, forKey: "value")
          }
        }

        /** This endpoint lists an issue's events. */
        public struct User: Model {
          public var username: String?

          public var name: String?

          public var ipAddress: String?

          public var email: String?

          public var data: DataType?

          public var id: String

          /** This endpoint lists an issue's events. */
          public struct DataType: Model {
            public var isStaff: Bool?

            public init(isStaff: Bool? = nil) {
              self.isStaff = isStaff
            }

            public init(from decoder: Decoder) throws {
              let container = try decoder.container(keyedBy: StringCodingKey.self)

              isStaff = try container.decodeIfPresent("isStaff")
            }

            public func encode(to encoder: Encoder) throws {
              var container = encoder.container(keyedBy: StringCodingKey.self)

              try container.encodeIfPresent(isStaff, forKey: "isStaff")
            }
          }

          public init(username: String?, name: String?, ipAddress: String?, email: String?, data: DataType?, id: String) {
            self.username = username
            self.name = name
            self.ipAddress = ipAddress
            self.email = email
            self.data = data
            self.id = id
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            username = try container.decodeIfPresent("username")
            name = try container.decodeIfPresent("name")
            ipAddress = try container.decodeIfPresent("ip_address")
            email = try container.decodeIfPresent("email")
            data = try container.decodeIfPresent("data")
            id = try container.decode("id")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encodeIfPresent(username, forKey: "username")
            try container.encodeIfPresent(name, forKey: "name")
            try container.encodeIfPresent(ipAddress, forKey: "ip_address")
            try container.encodeIfPresent(email, forKey: "email")
            try container.encodeIfPresent(data, forKey: "data")
            try container.encode(id, forKey: "id")
          }
        }

        public init(eventID: String, tags: [Tags], dateCreated: String, user: User?, message: String, id: String, platform: String, eventType: String, groupID: String, title: String) {
          self.eventID = eventID
          self.tags = tags
          self.dateCreated = dateCreated
          self.user = user
          self.message = message
          self.id = id
          self.platform = platform
          self.eventType = eventType
          self.groupID = groupID
          self.title = title
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          eventID = try container.decode("eventID")
          tags = try container.decodeArray("tags")
          dateCreated = try container.decode("dateCreated")
          user = try container.decodeIfPresent("user")
          message = try container.decode("message")
          id = try container.decode("id")
          platform = try container.decode("platform")
          eventType = try container.decode("event.type")
          groupID = try container.decode("groupID")
          title = try container.decode("title")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(eventID, forKey: "eventID")
          try container.encode(tags, forKey: "tags")
          try container.encode(dateCreated, forKey: "dateCreated")
          try container.encodeIfPresent(user, forKey: "user")
          try container.encode(message, forKey: "message")
          try container.encode(id, forKey: "id")
          try container.encode(platform, forKey: "platform")
          try container.encode(eventType, forKey: "event.type")
          try container.encode(groupID, forKey: "groupID")
          try container.encode(title, forKey: "title")
        }
      }

      public typealias SuccessType = [Status200]

      /** Success */
      case status200([Status200])

      /** Forbidden */
      case status403

      public var success: [Status200]? {
        switch self {
        case let .status200(response): return response
        default: return nil
        }
      }

      public var response: Any {
        switch self {
        case let .status200(response): return response
        default: return ()
        }
      }

      public var statusCode: Int {
        switch self {
        case .status200: return 200
        case .status403: return 403
        }
      }

      public var successful: Bool {
        switch self {
        case .status200: return true
        case .status403: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 200: self = try .status200(decoder.decode([Status200].self, from: data))
        case 403: self = .status403
        default: throw ClientError.unexpectedStatusCode(statusCode: statusCode, data: data)
        }
      }

      public var description: String {
        "\(statusCode) \(successful ? "success" : "failure")"
      }

      public var debugDescription: String {
        var string = description
        let responseString = "\(response)"
        if responseString != "()" {
          string += "\n\(responseString)"
        }
        return string
      }
    }
  }
}
