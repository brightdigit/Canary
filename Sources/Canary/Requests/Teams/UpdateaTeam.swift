import Foundation
import Prch

public extension Teams {
  /** Update various attributes and configurable settings for the given team. */
  enum UpdateaTeam {
    public static let service = Service<Response>(id: "Update a Team", tag: "Teams", method: "PUT", path: "/api/0/teams/{organization_slug}/{team_slug}/", hasBody: true, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["team:write"])])

    public final class Request: DeprecatedRequest<Response, CanaryAPI> {
      /** Update various attributes and configurable settings for the given team. */
      public struct Body: Model {
        /** The new name for the team. */
        public var name: String

        /** A new slug for the team. It has to be unique and available. */
        public var slug: String?

        public init(name: String, slug: String? = nil) {
          self.name = name
          self.slug = slug
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          name = try container.decode("name")
          slug = try container.decodeIfPresent("slug")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(name, forKey: "name")
          try container.encodeIfPresent(slug, forKey: "slug")
        }
      }

      public struct Options {
        /** The slug of the organization the team belongs to. */
        public var organizationSlug: String

        /** The slug of the team to get. */
        public var teamSlug: String

        public init(organizationSlug: String, teamSlug: String) {
          self.organizationSlug = organizationSlug
          self.teamSlug = teamSlug
        }
      }

      public var options: Options

      public var body: Body

      public init(body: Body, options: Options, encoder: RequestEncoder? = nil) {
        self.body = body
        self.options = options
        super.init(service: UpdateaTeam.service) { defaultEncoder in
          try (encoder ?? defaultEncoder).encode(body)
        }
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(organizationSlug: String, teamSlug: String, body: Body) {
        let options = Options(organizationSlug: organizationSlug, teamSlug: teamSlug)
        self.init(body: body, options: options)
      }

      override public var path: String {
        super.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "team_slug" + "}", with: "\(options.teamSlug)")
      }
    }

    public enum Response: DeprecatedResponse, CustomStringConvertible, CustomDebugStringConvertible {
      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      /** Update various attributes and configurable settings for the given team. */
      public struct Status200: Model {
        public var avatar: Avatar

        public var dateCreated: Date

        public var hasAccess: Bool

        public var id: String

        public var isMember: Bool

        public var isPending: Bool

        public var memberCount: Int

        public var name: String

        public var slug: String

        /** Update various attributes and configurable settings for the given team. */
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

        public init(avatar: Avatar, dateCreated: Date, hasAccess: Bool, id: String, isMember: Bool, isPending: Bool, memberCount: Int, name: String, slug: String) {
          self.avatar = avatar
          self.dateCreated = dateCreated
          self.hasAccess = hasAccess
          self.id = id
          self.isMember = isMember
          self.isPending = isPending
          self.memberCount = memberCount
          self.name = name
          self.slug = slug
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          avatar = try container.decode("avatar")
          dateCreated = try container.decode("dateCreated")
          hasAccess = try container.decode("hasAccess")
          id = try container.decode("id")
          isMember = try container.decode("isMember")
          isPending = try container.decode("isPending")
          memberCount = try container.decode("memberCount")
          name = try container.decode("name")
          slug = try container.decode("slug")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(avatar, forKey: "avatar")
          try container.encode(dateCreated, forKey: "dateCreated")
          try container.encode(hasAccess, forKey: "hasAccess")
          try container.encode(id, forKey: "id")
          try container.encode(isMember, forKey: "isMember")
          try container.encode(isPending, forKey: "isPending")
          try container.encode(memberCount, forKey: "memberCount")
          try container.encode(name, forKey: "name")
          try container.encode(slug, forKey: "slug")
        }
      }

      public typealias SuccessType = Status200

      /** Success */
      case status200(Status200)

      /** Bad Input */
      case status400

      /** Forbidden */
      case status403

      /** Team not found */
      case status404

      public var success: Status200? {
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
        case .status400: return 400
        case .status403: return 403
        case .status404: return 404
        }
      }

      public var successful: Bool {
        switch self {
        case .status200: return true
        case .status400: return false
        case .status403: return false
        case .status404: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 200: self = try .status200(decoder.decode(Status200.self, from: data))
        case 400: self = .status400
        case 403: self = .status403
        case 404: self = .status404
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
