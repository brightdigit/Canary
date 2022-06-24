import Foundation
import Prch

public extension Organizations {
  /** Return a list of projects bound to a organization. */
  enum ListAnOrganizationsProjects {
    public static let service = Service<Response>(id: "List an Organization's Projects", tag: "Organizations", method: "GET", path: "/api/0/organizations/{organization_slug}/projects/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["org: read"])])

    public final class Request: DeprecatedRequest<Response, CanaryAPI> {
      public struct Options {
        /** The slug of the organization for which the projects should be listed. */
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
        super.init(service: ListAnOrganizationsProjects.service)
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(organizationSlug: String, cursor: String? = nil) {
        let options = Options(organizationSlug: organizationSlug, cursor: cursor)
        self.init(options: options)
      }

      override public var path: String {
        super.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(self.options.organizationSlug)")
      }

      override public var queryParameters: [String: Any] {
        var params: [String: Any] = [:]
        if let cursor = options.cursor {
          params["cursor"] = cursor
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
      /** Return a list of projects bound to a organization. */
      public struct Status200: Model {
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

        /** Return a list of projects bound to a organization. */
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
