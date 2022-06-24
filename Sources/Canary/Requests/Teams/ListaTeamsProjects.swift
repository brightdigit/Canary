import Foundation
import Prch

public extension Teams {
  /** Return a list of projects bound to a team. */
  enum ListaTeamsProjects {
    public static let service = Service<Response>(id: "List a Team's Projects", tag: "Teams", method: "GET", path: "/api/0/teams/{organization_slug}/{team_slug}/projects/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:read"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        ListaTeamsProjects.service
      }

      public struct Options {
        /** The slug of the organization the team belongs to. */
        public var organizationSlug: String

        /** The slug of the team to get. */
        public var teamSlug: String

        /** A pointer to the last object fetched and its' sort order; used to retrieve the next or previous results. */
        public var cursor: String?

        public init(organizationSlug: String, teamSlug: String, cursor: String? = nil) {
          self.organizationSlug = organizationSlug
          self.teamSlug = teamSlug
          self.cursor = cursor
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(organizationSlug: String, teamSlug: String, cursor: String? = nil) {
        let options = Options(organizationSlug: organizationSlug, teamSlug: teamSlug, cursor: cursor)
        self.init(options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "team_slug" + "}", with: "\(options.teamSlug)")
      }

      public var queryParameters: [String: Any] {
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
      /** Return a list of projects bound to a team. */
      public struct Status200: Model {
        public var dateCreated: Date

        public var features: [String]

        public var firstEvent: String?

        public var hasAccess: Bool

        public var id: String

        public var isBookmarked: Bool

        public var isMember: Bool

        public var name: String

        public var platform: String?

        public var slug: String

        public var team: Team

        public var teams: [Teams]

        public var latestDeploys: String?

        /** Return a list of projects bound to a team. */
        public struct Team: Model {
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

        /** Return a list of projects bound to a team. */
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

        public init(dateCreated: Date, features: [String], firstEvent: String?, hasAccess: Bool, id: String, isBookmarked: Bool, isMember: Bool, name: String, platform: String?, slug: String, team: Team, teams: [Teams], latestDeploys: String?) {
          self.dateCreated = dateCreated
          self.features = features
          self.firstEvent = firstEvent
          self.hasAccess = hasAccess
          self.id = id
          self.isBookmarked = isBookmarked
          self.isMember = isMember
          self.name = name
          self.platform = platform
          self.slug = slug
          self.team = team
          self.teams = teams
          self.latestDeploys = latestDeploys
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          dateCreated = try container.decode("dateCreated")
          features = try container.decodeArray("features")
          firstEvent = try container.decodeIfPresent("firstEvent")
          hasAccess = try container.decode("hasAccess")
          id = try container.decode("id")
          isBookmarked = try container.decode("isBookmarked")
          isMember = try container.decode("isMember")
          name = try container.decode("name")
          platform = try container.decodeIfPresent("platform")
          slug = try container.decode("slug")
          team = try container.decode("team")
          teams = try container.decodeArray("teams")
          latestDeploys = try container.decodeIfPresent("latestDeploys")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(dateCreated, forKey: "dateCreated")
          try container.encode(features, forKey: "features")
          try container.encodeIfPresent(firstEvent, forKey: "firstEvent")
          try container.encode(hasAccess, forKey: "hasAccess")
          try container.encode(id, forKey: "id")
          try container.encode(isBookmarked, forKey: "isBookmarked")
          try container.encode(isMember, forKey: "isMember")
          try container.encode(name, forKey: "name")
          try container.encodeIfPresent(platform, forKey: "platform")
          try container.encode(slug, forKey: "slug")
          try container.encode(team, forKey: "team")
          try container.encode(teams, forKey: "teams")
          try container.encodeIfPresent(latestDeploys, forKey: "latestDeploys")
        }
      }

      public typealias SuccessType = [Status200]

      /** Success */
      case status200([Status200])

      /** Forbidden */
      case status403

      /** Team not found */
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
        case 200: self = try .status200(decoder.decode([Status200].self, from: data))
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
