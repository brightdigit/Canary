import Foundation
import Prch

public extension Teams {
  /** Returns a list of teams bound to a organization. */
  enum ListAnOrganizationsTeams {
    public static let service = Service<Response>(id: "List an Organization's Teams", tag: "Teams", method: "GET", path: "/api/0/organizations/{organization_slug}/teams/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["team:read"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        ListAnOrganizationsTeams.service
      }

      public struct Options {
        /** The slug of the organization for which the teams should be listed. */
        public var organizationSlug: String

        /** A pointer to the last object fetched and its' sort order; used to retrieve the next or previous results. */
        public var cursor: String?

        public init(organizationSlug: String, cursor: String? = nil) {
          self.organizationSlug = organizationSlug
          self.cursor = cursor
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(organizationSlug: String, cursor: String? = nil) {
        let options = Options(organizationSlug: organizationSlug, cursor: cursor)
        self.init(options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)")
      }

      public var queryParameters: [String: Any] {
        var params: [String: Any] = [:]
        if let cursor = options.cursor {
          params["cursor"] = cursor
        }
        return params
      }
    }

    public enum Response: Prch.Response {
      public var response: ClientResult<[Status200], Void> {
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
      /** Returns a list of teams bound to a organization. */
      public struct Status200: Model {
        public var avatar: Avatar

        public var dateCreated: Date

        public var hasAccess: Bool

        public var id: String

        public var isMember: Bool

        public var isPending: Bool

        public var memberCount: Int

        public var name: String

        public var projects: [Projects]

        public var slug: String

        /** Returns a list of teams bound to a organization. */
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

        /** Returns a list of teams bound to a organization. */
        public struct Projects: Model {
          /** Returns a list of teams bound to a organization. */
          public enum Status: String, Codable, Equatable, CaseIterable {
            case active
            case disabled
            case pendingDeletion = "pending_deletion"
            case deletionInProgress = "deletion_in_progress"
          }

          public var avatar: Avatar

          public var color: String

          public var dateCreated: Date

          public var features: [String]

          public var firstEvent: String?

          public var hasAccess: Bool

          public var id: String

          public var isBookmarked: Bool

          public var isInternal: Bool

          public var isMember: Bool

          public var isPublic: Bool

          public var name: String

          public var platform: String?

          public var slug: String

          public var status: Status

          /** Returns a list of teams bound to a organization. */
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

          public init(avatar: Avatar, color: String, dateCreated: Date, features: [String], firstEvent: String?, hasAccess: Bool, id: String, isBookmarked: Bool, isInternal: Bool, isMember: Bool, isPublic: Bool, name: String, platform: String?, slug: String, status: Status) {
            self.avatar = avatar
            self.color = color
            self.dateCreated = dateCreated
            self.features = features
            self.firstEvent = firstEvent
            self.hasAccess = hasAccess
            self.id = id
            self.isBookmarked = isBookmarked
            self.isInternal = isInternal
            self.isMember = isMember
            self.isPublic = isPublic
            self.name = name
            self.platform = platform
            self.slug = slug
            self.status = status
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            avatar = try container.decode("avatar")
            color = try container.decode("color")
            dateCreated = try container.decode("dateCreated")
            features = try container.decodeArray("features")
            firstEvent = try container.decodeIfPresent("firstEvent")
            hasAccess = try container.decode("hasAccess")
            id = try container.decode("id")
            isBookmarked = try container.decode("isBookmarked")
            isInternal = try container.decode("isInternal")
            isMember = try container.decode("isMember")
            isPublic = try container.decode("isPublic")
            name = try container.decode("name")
            platform = try container.decodeIfPresent("platform")
            slug = try container.decode("slug")
            status = try container.decode("status")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encode(avatar, forKey: "avatar")
            try container.encode(color, forKey: "color")
            try container.encode(dateCreated, forKey: "dateCreated")
            try container.encode(features, forKey: "features")
            try container.encodeIfPresent(firstEvent, forKey: "firstEvent")
            try container.encode(hasAccess, forKey: "hasAccess")
            try container.encode(id, forKey: "id")
            try container.encode(isBookmarked, forKey: "isBookmarked")
            try container.encode(isInternal, forKey: "isInternal")
            try container.encode(isMember, forKey: "isMember")
            try container.encode(isPublic, forKey: "isPublic")
            try container.encode(name, forKey: "name")
            try container.encodeIfPresent(platform, forKey: "platform")
            try container.encode(slug, forKey: "slug")
            try container.encode(status, forKey: "status")
          }
        }

        public init(avatar: Avatar, dateCreated: Date, hasAccess: Bool, id: String, isMember: Bool, isPending: Bool, memberCount: Int, name: String, projects: [Projects], slug: String) {
          self.avatar = avatar
          self.dateCreated = dateCreated
          self.hasAccess = hasAccess
          self.id = id
          self.isMember = isMember
          self.isPending = isPending
          self.memberCount = memberCount
          self.name = name
          self.projects = projects
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
          projects = try container.decodeArray("projects")
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
          try container.encode(projects, forKey: "projects")
          try container.encode(slug, forKey: "slug")
        }
      }

      public typealias SuccessType = [Status200]

      /** Success */
      case status200([Status200])

      /** Permission Denied */
      case status401

      /** Forbidden */
      case status403

      /** Not Found */
      case status404

      public var success: [Status200]? {
        switch self {
        case let .status200(response): return response
        default: return nil
        }
      }

      public var statusCode: Int {
        switch self {
        case .status200: return 200
        case .status401: return 401
        case .status403: return 403
        case .status404: return 404
        }
      }

      public var successful: Bool {
        switch self {
        case .status200: return true
        case .status401: return false
        case .status403: return false
        case .status404: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 200: self = try .status200(decoder.decode([Status200].self, from: data))
        case 401: self = .status401
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
