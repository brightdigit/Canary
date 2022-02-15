import Foundation
import Prch

public extension Organizations {
  /** Return a list of organizations available to the authenticated session.  This is particularly useful for requests with an user bound context.  For API key based requests this will only return the organization that belongs to the key. */
  enum ListYourOrganizations {
    public static let service = APIService<Response>(id: "List Your Organizations", tag: "Organizations", method: "GET", path: "/api/0/organizations/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["org: read"])])

    public final class Request: APIRequest<Response, CanaryAPI> {
      public struct Options {
        /** Restrict results to organizations in which you are an organization owner. */
        public var owner: Bool?

        /** A pointer to the last object fetched and its' sort order; used to retrieve the next or previous results. */
        public var cursor: String?

        public init(owner: Bool? = nil, cursor: String? = nil) {
          self.owner = owner
          self.cursor = cursor
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
        super.init(service: ListYourOrganizations.service)
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(owner: Bool? = nil, cursor: String? = nil) {
        let options = Options(owner: owner, cursor: cursor)
        self.init(options: options)
      }

      override public var queryParameters: [String: Any] {
        var params: [String: Any] = [:]
        if let owner = options.owner {
          params["owner"] = owner
        }
        if let cursor = options.cursor {
          params["cursor"] = cursor
        }
        return params
      }
    }

    public enum Response: APIResponseValue, CustomStringConvertible, CustomDebugStringConvertible {
      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      /** Return a list of organizations available to the authenticated session.  This is particularly useful for requests with an user bound context.  For API key based requests this will only return the organization that belongs to the key. */
      public struct Status200: Model {
        public var avatar: Avatar

        public var dateCreated: DateTime

        public var id: String

        public var isEarlyAdopter: Bool

        public var name: String

        public var require2FA: Bool

        public var slug: String

        public var status: Status

        /** Return a list of organizations available to the authenticated session.  This is particularly useful for requests with an user bound context.  For API key based requests this will only return the organization that belongs to the key. */
        public struct Avatar: Model {
          public var avatarType: String?

          public var avatarUuid: String?

          public init(avatarType: String? = nil, avatarUuid: String? = nil) {
            self.avatarType = avatarType
            self.avatarUuid = avatarUuid
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            avatarType = try container.decodeIfPresent("avatarType")
            avatarUuid = try container.decodeIfPresent("avatarUuid")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encodeIfPresent(avatarType, forKey: "avatarType")
            try container.encodeIfPresent(avatarUuid, forKey: "avatarUuid")
          }
        }

        /** Return a list of organizations available to the authenticated session.  This is particularly useful for requests with an user bound context.  For API key based requests this will only return the organization that belongs to the key. */
        public struct Status: Model {
          public var id: String

          public var name: String

          public init(id: String, name: String) {
            self.id = id
            self.name = name
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            id = try container.decode("id")
            name = try container.decode("name")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encode(id, forKey: "id")
            try container.encode(name, forKey: "name")
          }
        }

        public init(avatar: Avatar, dateCreated: DateTime, id: String, isEarlyAdopter: Bool, name: String, require2FA: Bool, slug: String, status: Status) {
          self.avatar = avatar
          self.dateCreated = dateCreated
          self.id = id
          self.isEarlyAdopter = isEarlyAdopter
          self.name = name
          self.require2FA = require2FA
          self.slug = slug
          self.status = status
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          avatar = try container.decode("avatar")
          dateCreated = try container.decode("dateCreated")
          id = try container.decode("id")
          isEarlyAdopter = try container.decode("isEarlyAdopter")
          name = try container.decode("name")
          require2FA = try container.decode("require2FA")
          slug = try container.decode("slug")
          status = try container.decode("status")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(avatar, forKey: "avatar")
          try container.encode(dateCreated, forKey: "dateCreated")
          try container.encode(id, forKey: "id")
          try container.encode(isEarlyAdopter, forKey: "isEarlyAdopter")
          try container.encode(name, forKey: "name")
          try container.encode(require2FA, forKey: "require2FA")
          try container.encode(slug, forKey: "slug")
          try container.encode(status, forKey: "status")
        }
      }

      public typealias SuccessType = [Status200]

      /** Success */
      case status200([Status200])

      /** Unauthorized */
      case status401

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
        case .status401: return 401
        case .status403: return 403
        }
      }

      public var successful: Bool {
        switch self {
        case .status200: return true
        case .status401: return false
        case .status403: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 200: self = try .status200(decoder.decode([Status200].self, from: data))
        case 401: self = .status401
        case 403: self = .status403
        default: throw APIClientError.unexpectedStatusCode(statusCode: statusCode, data: data)
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
