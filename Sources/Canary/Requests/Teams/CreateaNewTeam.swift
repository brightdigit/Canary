import Foundation
import Prch

public extension Teams {
  /** Create a new team bound to an organization. Only the name of the team is needed to create it, the slug can be auto generated. */
  enum CreateaNewTeam {
    public static let service = Service<Response>(id: "Create a New Team", tag: "Teams", method: "POST", path: "/api/0/organizations/{organization_slug}/teams/", hasBody: true, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["team:write"])])

    public final class Request: DeprecatedRequest<Response, CanaryAPI> {
      /** Create a new team bound to an organization. Only the name of the team is needed to create it, the slug can be auto generated. */
      public struct Body: Model {
        /** The name of the team. */
        public var name: String

        /** The optional slug for this team. If not provided it will be auto generated from the name. */
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
        /** The slug of the organization the team should be created for. */
        public var organizationSlug: String

        public init(organizationSlug: String) {
          self.organizationSlug = organizationSlug
        }
      }

      public var options: Options

      public var body: Body

      public init(body: Body, options: Options, encoder: RequestEncoder? = nil) {
        self.body = body
        self.options = options
        super.init(service: CreateaNewTeam.service) { defaultEncoder in
          try (encoder ?? defaultEncoder).encode(body)
        }
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(organizationSlug: String, body: Body) {
        let options = Options(organizationSlug: organizationSlug)
        self.init(body: body, options: options)
      }

      override public var path: String {
        super.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)")
      }
    }

    public enum Response: DeprecatedResponse, CustomStringConvertible, CustomDebugStringConvertible {
      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      /** Create a new team bound to an organization. Only the name of the team is needed to create it, the slug can be auto generated. */
      public struct Status201: Model {
        public var avatar: Avatar

        public var dateCreated: Date

        public var hasAccess: Bool

        public var id: String

        public var isMember: Bool

        public var isPending: Bool

        public var memberCount: Int

        public var name: String

        public var slug: String

        /** Create a new team bound to an organization. Only the name of the team is needed to create it, the slug can be auto generated. */
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

      public typealias SuccessType = Status201

      /** Success */
      case status201(Status201)

      /** Bad input */
      case status400

      /** Forbidden */
      case status403

      /** Team slug already exists */
      case status409

      public var success: Status201? {
        switch self {
        case let .status201(response): return response
        default: return nil
        }
      }

      public var response: Any {
        switch self {
        case let .status201(response): return response
        default: return ()
        }
      }

      public var statusCode: Int {
        switch self {
        case .status201: return 201
        case .status400: return 400
        case .status403: return 403
        case .status409: return 409
        }
      }

      public var successful: Bool {
        switch self {
        case .status201: return true
        case .status400: return false
        case .status403: return false
        case .status409: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 201: self = try .status201(decoder.decode(Status201.self, from: data))
        case 400: self = .status400
        case 403: self = .status403
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
