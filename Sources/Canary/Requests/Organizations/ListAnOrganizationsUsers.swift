import Foundation
import Prch

public extension Organizations {
  /** Return a list of users that belong to a given organization. */
  enum ListAnOrganizationsUsers {
    public static let service = Service<Response>(id: "List an Organization's Users", tag: "Organizations", method: "GET", path: "/api/0/organizations/{organization_slug}/users/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["org: read"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        ListAnOrganizationsUsers.service
      }

      public struct Options {
        /** The slug of the organization the event ID should be looked up in. */
        public var organizationSlug: String

        /** Restrict results to users who have access to a given project ID */
        public var project: String?

        public init(organizationSlug: String, project: String? = nil) {
          self.organizationSlug = organizationSlug
          self.project = project
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(organizationSlug: String, project: String? = nil) {
        let options = Options(organizationSlug: organizationSlug, project: project)
        self.init(options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)")
      }

      public var queryParameters: [String: Any] {
        var params: [String: Any] = [:]
        if let project = options.project {
          params["project"] = project
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
      /** Return a list of users that belong to a given organization. */
      public struct Status200: Model {
        /** Return a list of users that belong to a given organization. */
        public enum Role: String, Codable, Equatable, CaseIterable {
          case owner
          case manager
          case admin
          case member
          case billing
        }

        public var dateCreated: String

        public var user: User

        public var roleName: String

        public var expired: Bool

        public var id: String

        public var projects: [String]

        public var name: String

        public var role: Role

        public var flags: Flags

        public var email: String

        public var pending: Bool

        /** Return a list of users that belong to a given organization. */
        public struct User: Model {
          public var username: String

          public var lastLogin: String?

          public var isSuperuser: Bool

          public var isManaged: Bool

          public var lastActive: String

          public var isStaff: Bool

          public var id: String

          public var isActive: Bool

          public var has2fa: Bool

          public var name: String

          public var avatarUrl: String

          public var dateJoined: String

          public var emails: [Emails]

          public var avatar: Avatar

          public var hasPasswordAuth: Bool

          public var email: String

          /** Return a list of users that belong to a given organization. */
          public struct Emails: Model {
            public var email: String?

            public var id: String?

            public var isVerified: Bool?

            public init(email: String? = nil, id: String? = nil, isVerified: Bool? = nil) {
              self.email = email
              self.id = id
              self.isVerified = isVerified
            }

            public init(from decoder: Decoder) throws {
              let container = try decoder.container(keyedBy: StringCodingKey.self)

              email = try container.decodeIfPresent("email")
              id = try container.decodeIfPresent("id")
              isVerified = try container.decodeIfPresent("is_verified")
            }

            public func encode(to encoder: Encoder) throws {
              var container = encoder.container(keyedBy: StringCodingKey.self)

              try container.encodeIfPresent(email, forKey: "email")
              try container.encodeIfPresent(id, forKey: "id")
              try container.encodeIfPresent(isVerified, forKey: "is_verified")
            }
          }

          /** Return a list of users that belong to a given organization. */
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

          public init(username: String, lastLogin: String?, isSuperuser: Bool, isManaged: Bool, lastActive: String, isStaff: Bool, id: String, isActive: Bool, has2fa: Bool, name: String, avatarUrl: String, dateJoined: String, emails: [Emails], avatar: Avatar, hasPasswordAuth: Bool, email: String) {
            self.username = username
            self.lastLogin = lastLogin
            self.isSuperuser = isSuperuser
            self.isManaged = isManaged
            self.lastActive = lastActive
            self.isStaff = isStaff
            self.id = id
            self.isActive = isActive
            self.has2fa = has2fa
            self.name = name
            self.avatarUrl = avatarUrl
            self.dateJoined = dateJoined
            self.emails = emails
            self.avatar = avatar
            self.hasPasswordAuth = hasPasswordAuth
            self.email = email
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            username = try container.decode("username")
            lastLogin = try container.decodeIfPresent("lastLogin")
            isSuperuser = try container.decode("isSuperuser")
            isManaged = try container.decode("isManaged")
            lastActive = try container.decode("lastActive")
            isStaff = try container.decode("isStaff")
            id = try container.decode("id")
            isActive = try container.decode("isActive")
            has2fa = try container.decode("has2fa")
            name = try container.decode("name")
            avatarUrl = try container.decode("avatarUrl")
            dateJoined = try container.decode("dateJoined")
            emails = try container.decodeArray("emails")
            avatar = try container.decode("avatar")
            hasPasswordAuth = try container.decode("hasPasswordAuth")
            email = try container.decode("email")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encode(username, forKey: "username")
            try container.encodeIfPresent(lastLogin, forKey: "lastLogin")
            try container.encode(isSuperuser, forKey: "isSuperuser")
            try container.encode(isManaged, forKey: "isManaged")
            try container.encode(lastActive, forKey: "lastActive")
            try container.encode(isStaff, forKey: "isStaff")
            try container.encode(id, forKey: "id")
            try container.encode(isActive, forKey: "isActive")
            try container.encode(has2fa, forKey: "has2fa")
            try container.encode(name, forKey: "name")
            try container.encode(avatarUrl, forKey: "avatarUrl")
            try container.encode(dateJoined, forKey: "dateJoined")
            try container.encode(emails, forKey: "emails")
            try container.encode(avatar, forKey: "avatar")
            try container.encode(hasPasswordAuth, forKey: "hasPasswordAuth")
            try container.encode(email, forKey: "email")
          }
        }

        /** Return a list of users that belong to a given organization. */
        public struct Flags: Model {
          public var ssoInvalid: Bool?

          public var ssoLinked: Bool?

          public init(ssoInvalid: Bool? = nil, ssoLinked: Bool? = nil) {
            self.ssoInvalid = ssoInvalid
            self.ssoLinked = ssoLinked
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            ssoInvalid = try container.decodeIfPresent("sso: invalid")
            ssoLinked = try container.decodeIfPresent("sso: linked")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encodeIfPresent(ssoInvalid, forKey: "sso: invalid")
            try container.encodeIfPresent(ssoLinked, forKey: "sso: linked")
          }
        }

        public init(dateCreated: String, user: User, roleName: String, expired: Bool, id: String, projects: [String], name: String, role: Role, flags: Flags, email: String, pending: Bool) {
          self.dateCreated = dateCreated
          self.user = user
          self.roleName = roleName
          self.expired = expired
          self.id = id
          self.projects = projects
          self.name = name
          self.role = role
          self.flags = flags
          self.email = email
          self.pending = pending
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          dateCreated = try container.decode("dateCreated")
          user = try container.decode("user")
          roleName = try container.decode("roleName")
          expired = try container.decode("expired")
          id = try container.decode("id")
          projects = try container.decodeArray("projects")
          name = try container.decode("name")
          role = try container.decode("role")
          flags = try container.decode("flags")
          email = try container.decode("email")
          pending = try container.decode("pending")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(dateCreated, forKey: "dateCreated")
          try container.encode(user, forKey: "user")
          try container.encode(roleName, forKey: "roleName")
          try container.encode(expired, forKey: "expired")
          try container.encode(id, forKey: "id")
          try container.encode(projects, forKey: "projects")
          try container.encode(name, forKey: "name")
          try container.encode(role, forKey: "role")
          try container.encode(flags, forKey: "flags")
          try container.encode(email, forKey: "email")
          try container.encode(pending, forKey: "pending")
        }
      }

      public typealias SuccessType = [Status200]

      /** Success */
      case status200([Status200])

      /** Unauthorized */
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
