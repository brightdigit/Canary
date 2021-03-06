import Foundation
import Prch

public extension Teams {
  /** Return details on an individual team. */
  enum RetrieveaTeam {
    public static let service = Service<Response>(id: "Retrieve a Team", tag: "Teams", method: "GET", path: "/api/0/teams/{organization_slug}/{team_slug}/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["team:read"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        RetrieveaTeam.service
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

      public init(options: Options) {
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(organizationSlug: String, teamSlug: String) {
        let options = Options(organizationSlug: organizationSlug, teamSlug: teamSlug)
        self.init(options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "team_slug" + "}", with: "\(options.teamSlug)")
      }
    }

    public enum Response: Prch.Response {
      public var response: ClientResult<Status200, Void> {
        switch self {
        case let .status200(response):
          return .success(response)

        default:
          return .defaultResponse(statusCode, ())
        }
      }

      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      /** Return details on an individual team. */
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

        public var organization: Organization

        /** Return details on an individual team. */
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

        /** Return details on an individual team. */
        public struct Organization: Model {
          public var avatar: Avatar

          public var dateCreated: Date

          public var id: String

          public var isEarlyAdopter: Bool

          public var name: String

          public var require2FA: Bool

          public var slug: String

          public var status: Status

          /** Return details on an individual team. */
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

          /** Return details on an individual team. */
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

          public init(avatar: Avatar, dateCreated: Date, id: String, isEarlyAdopter: Bool, name: String, require2FA: Bool, slug: String, status: Status) {
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

        public init(avatar: Avatar, dateCreated: Date, hasAccess: Bool, id: String, isMember: Bool, isPending: Bool, memberCount: Int, name: String, slug: String, organization: Organization) {
          self.avatar = avatar
          self.dateCreated = dateCreated
          self.hasAccess = hasAccess
          self.id = id
          self.isMember = isMember
          self.isPending = isPending
          self.memberCount = memberCount
          self.name = name
          self.slug = slug
          self.organization = organization
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
          organization = try container.decode("organization")
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
          try container.encode(organization, forKey: "organization")
        }
      }

      public typealias SuccessType = Status200

      /** Success */
      case status200(Status200)

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

      public var statusCode: Int {
        switch self {
        case .status200: return 200
        case .status403: return 403
        case .status404: return 404
        }
      }

      public var successful: Bool {
        switch self {
        case .status200: return true
        case .status403: return false
        case .status404: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 200: self = try .status200(decoder.decode(Status200.self, from: data))
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
