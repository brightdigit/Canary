import Foundation
import Prch

public extension Organizations {
  /** Update various attributes and configurable settings for the given organization. */
  enum UpdateAnOrganization {
    public static let service = Service<Response>(id: "Update an Organization", tag: "Organizations", method: "PUT", path: "/api/0/organizations/{organization_slug}/", hasBody: true, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["org:write"])])

    public final class Request: DeprecatedRequest<Response, CanaryAPI> {
      /** Update various attributes and configurable settings for the given organization. */
      public struct Body: Model {
        /** An optional new name for the organization. */
        public var name: String

        /** An optional new slug for the organization. Needs to be available and unique. */
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
        /** The slug of the organization to update. */
        public var organizationSlug: String

        public init(organizationSlug: String) {
          self.organizationSlug = organizationSlug
        }
      }

      public var options: Options

      public var body: Body?

      public init(body: Body?, options: Options, encoder: RequestEncoder? = nil) {
        self.body = body
        self.options = options
        super.init(service: UpdateAnOrganization.service) { defaultEncoder in
          try (encoder ?? defaultEncoder).encode(body)
        }
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(organizationSlug: String, body: Body? = nil) {
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
      /** Update various attributes and configurable settings for the given organization. */
      public struct Status200: Model {
        public var access: [String]

        public var allowSharedIssues: Bool

        public var availableRoles: [AvailableRoles]

        public var avatar: Avatar

        public var dataScrubber: Bool

        public var dataScrubberDefaults: Bool

        public var dateCreated: Date

        public var defaultRole: String

        public var enhancedPrivacy: Bool

        public var experiments: [String: AnyCodable]

        public var features: [String]

        public var id: String

        public var isDefault: Bool

        public var isEarlyAdopter: Bool

        public var name: String

        public var onboardingTasks: [[String: AnyCodable]]

        public var openMembership: Bool

        public var pendingAccessRequests: Int

        public var projects: [Projects]

        public var quota: [String: AnyCodable]

        public var require2FA: Bool

        public var safeFields: [String]

        public var scrapeJavaScript: Bool

        public var scrubIPAddresses: Bool

        public var sensitiveFields: [String]

        public var slug: String

        public var status: Status

        public var storeCrashReports: Int

        public var teams: [Teams]

        public var trustedRelays: [String]

        /** Update various attributes and configurable settings for the given organization. */
        public struct AvailableRoles: Model {
          public var id: String?

          public var name: String?

          public init(id: String? = nil, name: String? = nil) {
            self.id = id
            self.name = name
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            id = try container.decodeIfPresent("id")
            name = try container.decodeIfPresent("name")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encodeIfPresent(id, forKey: "id")
            try container.encodeIfPresent(name, forKey: "name")
          }
        }

        /** Update various attributes and configurable settings for the given organization. */
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

        /** Update various attributes and configurable settings for the given organization. */
        public struct Projects: Model {
          public var dateCreated: String

          public var firstEvent: String?

          public var hasAccess: Bool

          public var id: String

          public var isBookmarked: Bool

          public var isMember: Bool

          public var latestDeploys: String?

          public var name: String

          public var platform: String?

          public var platforms: [String]

          public var slug: String

          public var team: [String: AnyCodable]?

          public var teams: [Teams]

          /** Update various attributes and configurable settings for the given organization. */
          public struct Teams: Model {
            public var id: String

            public var name: String

            public var slug: String

            public init(id: String, name: String, slug: String) {
              self.id = id
              self.name = name
              self.slug = slug
            }

            public init(from decoder: Decoder) throws {
              let container = try decoder.container(keyedBy: StringCodingKey.self)

              id = try container.decode("id")
              name = try container.decode("name")
              slug = try container.decode("slug")
            }

            public func encode(to encoder: Encoder) throws {
              var container = encoder.container(keyedBy: StringCodingKey.self)

              try container.encode(id, forKey: "id")
              try container.encode(name, forKey: "name")
              try container.encode(slug, forKey: "slug")
            }
          }

          public init(dateCreated: String, firstEvent: String?, hasAccess: Bool, id: String, isBookmarked: Bool, isMember: Bool, latestDeploys: String?, name: String, platform: String?, platforms: [String], slug: String, team: [String: AnyCodable]?, teams: [Teams]) {
            self.dateCreated = dateCreated
            self.firstEvent = firstEvent
            self.hasAccess = hasAccess
            self.id = id
            self.isBookmarked = isBookmarked
            self.isMember = isMember
            self.latestDeploys = latestDeploys
            self.name = name
            self.platform = platform
            self.platforms = platforms
            self.slug = slug
            self.team = team
            self.teams = teams
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            dateCreated = try container.decode("dateCreated")
            firstEvent = try container.decodeIfPresent("firstEvent")
            hasAccess = try container.decode("hasAccess")
            id = try container.decode("id")
            isBookmarked = try container.decode("isBookmarked")
            isMember = try container.decode("isMember")
            latestDeploys = try container.decodeIfPresent("latestDeploys")
            name = try container.decode("name")
            platform = try container.decodeIfPresent("platform")
            platforms = try container.decodeArray("platforms")
            slug = try container.decode("slug")
            team = try container.decodeAnyIfPresent("team")
            teams = try container.decodeArray("teams")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encode(dateCreated, forKey: "dateCreated")
            try container.encodeIfPresent(firstEvent, forKey: "firstEvent")
            try container.encode(hasAccess, forKey: "hasAccess")
            try container.encode(id, forKey: "id")
            try container.encode(isBookmarked, forKey: "isBookmarked")
            try container.encode(isMember, forKey: "isMember")
            try container.encodeIfPresent(latestDeploys, forKey: "latestDeploys")
            try container.encode(name, forKey: "name")
            try container.encodeIfPresent(platform, forKey: "platform")
            try container.encode(platforms, forKey: "platforms")
            try container.encode(slug, forKey: "slug")
            try container.encodeAnyIfPresent(team, forKey: "team")
            try container.encode(teams, forKey: "teams")
          }
        }

        /** Update various attributes and configurable settings for the given organization. */
        public struct Status: Model {
          public var id: String?

          public var name: String?

          public init(id: String? = nil, name: String? = nil) {
            self.id = id
            self.name = name
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            id = try container.decodeIfPresent("id")
            name = try container.decodeIfPresent("name")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encodeIfPresent(id, forKey: "id")
            try container.encodeIfPresent(name, forKey: "name")
          }
        }

        /** Update various attributes and configurable settings for the given organization. */
        public struct Teams: Model {
          public var avatar: Avatar

          public var dateCreated: Date

          public var hasAccess: Bool

          public var id: String

          public var isMember: Bool

          public var isPending: Bool

          public var memberCount: Int

          public var name: String

          public var slug: String

          /** Update various attributes and configurable settings for the given organization. */
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

        public init(access: [String], allowSharedIssues: Bool, availableRoles: [AvailableRoles], avatar: Avatar, dataScrubber: Bool, dataScrubberDefaults: Bool, dateCreated: Date, defaultRole: String, enhancedPrivacy: Bool, experiments: [String: AnyCodable], features: [String], id: String, isDefault: Bool, isEarlyAdopter: Bool, name: String, onboardingTasks: [[String: AnyCodable]], openMembership: Bool, pendingAccessRequests: Int, projects: [Projects], quota: [String: AnyCodable], require2FA: Bool, safeFields: [String], scrapeJavaScript: Bool, scrubIPAddresses: Bool, sensitiveFields: [String], slug: String, status: Status, storeCrashReports: Int, teams: [Teams], trustedRelays: [String]) {
          self.access = access
          self.allowSharedIssues = allowSharedIssues
          self.availableRoles = availableRoles
          self.avatar = avatar
          self.dataScrubber = dataScrubber
          self.dataScrubberDefaults = dataScrubberDefaults
          self.dateCreated = dateCreated
          self.defaultRole = defaultRole
          self.enhancedPrivacy = enhancedPrivacy
          self.experiments = experiments
          self.features = features
          self.id = id
          self.isDefault = isDefault
          self.isEarlyAdopter = isEarlyAdopter
          self.name = name
          self.onboardingTasks = onboardingTasks
          self.openMembership = openMembership
          self.pendingAccessRequests = pendingAccessRequests
          self.projects = projects
          self.quota = quota
          self.require2FA = require2FA
          self.safeFields = safeFields
          self.scrapeJavaScript = scrapeJavaScript
          self.scrubIPAddresses = scrubIPAddresses
          self.sensitiveFields = sensitiveFields
          self.slug = slug
          self.status = status
          self.storeCrashReports = storeCrashReports
          self.teams = teams
          self.trustedRelays = trustedRelays
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          access = try container.decodeArray("access")
          allowSharedIssues = try container.decode("allowSharedIssues")
          availableRoles = try container.decodeArray("availableRoles")
          avatar = try container.decode("avatar")
          dataScrubber = try container.decode("dataScrubber")
          dataScrubberDefaults = try container.decode("dataScrubberDefaults")
          dateCreated = try container.decode("dateCreated")
          defaultRole = try container.decode("defaultRole")
          enhancedPrivacy = try container.decode("enhancedPrivacy")
          experiments = try container.decodeAny("experiments")
          features = try container.decodeArray("features")
          id = try container.decode("id")
          isDefault = try container.decode("isDefault")
          isEarlyAdopter = try container.decode("isEarlyAdopter")
          name = try container.decode("name")
          onboardingTasks = try container.decodeAny("onboardingTasks")
          openMembership = try container.decode("openMembership")
          pendingAccessRequests = try container.decode("pendingAccessRequests")
          projects = try container.decodeArray("projects")
          quota = try container.decodeAny("quota")
          require2FA = try container.decode("require2FA")
          safeFields = try container.decodeArray("safeFields")
          scrapeJavaScript = try container.decode("scrapeJavaScript")
          scrubIPAddresses = try container.decode("scrubIPAddresses")
          sensitiveFields = try container.decodeArray("sensitiveFields")
          slug = try container.decode("slug")
          status = try container.decode("status")
          storeCrashReports = try container.decode("storeCrashReports")
          teams = try container.decodeArray("teams")
          trustedRelays = try container.decodeArray("trustedRelays")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(access, forKey: "access")
          try container.encode(allowSharedIssues, forKey: "allowSharedIssues")
          try container.encode(availableRoles, forKey: "availableRoles")
          try container.encode(avatar, forKey: "avatar")
          try container.encode(dataScrubber, forKey: "dataScrubber")
          try container.encode(dataScrubberDefaults, forKey: "dataScrubberDefaults")
          try container.encode(dateCreated, forKey: "dateCreated")
          try container.encode(defaultRole, forKey: "defaultRole")
          try container.encode(enhancedPrivacy, forKey: "enhancedPrivacy")
          try container.encodeAny(experiments, forKey: "experiments")
          try container.encode(features, forKey: "features")
          try container.encode(id, forKey: "id")
          try container.encode(isDefault, forKey: "isDefault")
          try container.encode(isEarlyAdopter, forKey: "isEarlyAdopter")
          try container.encode(name, forKey: "name")
          try container.encodeAny(onboardingTasks, forKey: "onboardingTasks")
          try container.encode(openMembership, forKey: "openMembership")
          try container.encode(pendingAccessRequests, forKey: "pendingAccessRequests")
          try container.encode(projects, forKey: "projects")
          try container.encodeAny(quota, forKey: "quota")
          try container.encode(require2FA, forKey: "require2FA")
          try container.encode(safeFields, forKey: "safeFields")
          try container.encode(scrapeJavaScript, forKey: "scrapeJavaScript")
          try container.encode(scrubIPAddresses, forKey: "scrubIPAddresses")
          try container.encode(sensitiveFields, forKey: "sensitiveFields")
          try container.encode(slug, forKey: "slug")
          try container.encode(status, forKey: "status")
          try container.encode(storeCrashReports, forKey: "storeCrashReports")
          try container.encode(teams, forKey: "teams")
          try container.encode(trustedRelays, forKey: "trustedRelays")
        }
      }

      public typealias SuccessType = Status200

      /** Success */
      case status200(Status200)

      /** Bad Input */
      case status400

      /** Unauthorized */
      case status401

      /** Forbidden */
      case status403

      /** Not Found */
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
        case .status401: return 401
        case .status403: return 403
        case .status404: return 404
        }
      }

      public var successful: Bool {
        switch self {
        case .status200: return true
        case .status400: return false
        case .status401: return false
        case .status403: return false
        case .status404: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 200: self = try .status200(decoder.decode(Status200.self, from: data))
        case 400: self = .status400
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
