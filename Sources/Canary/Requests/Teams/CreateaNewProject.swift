import Foundation
import Prch

public extension Teams {
  /** Create a new project bound to a team. */
  enum CreateaNewProject {
    public static let service = Service<Response>(id: "Create a New Project", tag: "Teams", method: "POST", path: "/api/0/teams/{organization_slug}/{team_slug}/projects/", hasBody: true, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:write"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        CreateaNewProject.service
      }

      /** Create a new project bound to a team. */
      public struct Body: Model {
        /** The name for the new project. */
        public var name: String

        /** Optional slug for the new project. If not provided a slug is generated from the name. */
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

        /** The slug of the team to create a new project for. */
        public var teamSlug: String

        public init(organizationSlug: String, teamSlug: String) {
          self.organizationSlug = organizationSlug
          self.teamSlug = teamSlug
        }
      }

      public var options: Options

      public var body: Body

      public init(body: Body, options: Options, encoder _: RequestEncoder? = nil) {
        self.body = body
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(organizationSlug: String, teamSlug: String, body: Body) {
        let options = Options(organizationSlug: organizationSlug, teamSlug: teamSlug)
        self.init(body: body, options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "team_slug" + "}", with: "\(options.teamSlug)")
      }
    }

    public enum Response: Prch.Response {
      public var response: ClientResult<Status201, Void> {
        switch self {
        case let .status201(response):
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
      /** Create a new project bound to a team. */
      public struct Status201: Model {
        /** Create a new project bound to a team. */
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

        /** Create a new project bound to a team. */
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

      public typealias SuccessType = Status201

      /** Created */
      case status201(Status201)

      /** Bad input */
      case status400

      /** Forbidden */
      case status403

      /** Team not found */
      case status404

      /** A project with the given slug already exists */
      case status409

      public var success: Status201? {
        switch self {
        case let .status201(response): return response
        default: return nil
        }
      }

      public var statusCode: Int {
        switch self {
        case .status201: return 201
        case .status400: return 400
        case .status403: return 403
        case .status404: return 404
        case .status409: return 409
        }
      }

      public var successful: Bool {
        switch self {
        case .status201: return true
        case .status400: return false
        case .status403: return false
        case .status404: return false
        case .status409: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 201: self = try .status201(decoder.decode(Status201.self, from: data))
        case 400: self = .status400
        case 403: self = .status403
        case 404: self = .status404
        case 409: self = .status409
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
