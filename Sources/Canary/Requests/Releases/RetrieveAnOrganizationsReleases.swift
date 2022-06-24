import Foundation
import Prch

public extension Releases {
  /** Return a release for a given organization. */
  enum RetrieveAnOrganizationsReleases {
    public static let service = Service<Response>(id: "Retrieve an Organization's Releases", tag: "Releases", method: "GET", path: "/api/0/organizations/{organization_slug}/releases/{version}/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:releases"])])

    public final class Request: DeprecatedRequest<Response, CanaryAPI> {
      public struct Options {
        /** The slug of the organization the release belongs to. */
        public var organizationSlug: String

        /** The version identifier of the release. */
        public var version: String

        public init(organizationSlug: String, version: String) {
          self.organizationSlug = organizationSlug
          self.version = version
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
        super.init(service: RetrieveAnOrganizationsReleases.service)
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(organizationSlug: String, version: String) {
        let options = Options(organizationSlug: organizationSlug, version: version)
        self.init(options: options)
      }

      override public var path: String {
        super.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "version" + "}", with: "\(options.version)")
      }
    }

    public enum Response: DeprecatedResponse, CustomStringConvertible, CustomDebugStringConvertible {
      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      /** Return a release for a given organization. */
      public struct Status200: Model {
        public var authors: [[String: AnyCodable]]

        public var commitCount: Int

        public var data: [String: AnyCodable]

        public var dateCreated: Date

        public var dateReleased: Date?

        public var deployCount: Int

        public var firstEvent: Date?

        public var lastCommit: [String: AnyCodable]?

        public var lastDeploy: [String: AnyCodable]?

        public var lastEvent: Date?

        public var newGroups: Int

        public var owner: [String: AnyCodable]?

        public var projects: [Projects]

        public var ref: String?

        public var shortVersion: String

        public var version: String

        public var url: String?

        /** Return a release for a given organization. */
        public struct Projects: Model {
          public var name: String?

          public var slug: String?

          public init(name: String? = nil, slug: String? = nil) {
            self.name = name
            self.slug = slug
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            name = try container.decodeIfPresent("name")
            slug = try container.decodeIfPresent("slug")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encodeIfPresent(name, forKey: "name")
            try container.encodeIfPresent(slug, forKey: "slug")
          }
        }

        public init(authors: [[String: AnyCodable]], commitCount: Int, data: [String: AnyCodable], dateCreated: Date, dateReleased: Date?, deployCount: Int, firstEvent: Date?, lastCommit: [String: AnyCodable]?, lastDeploy: [String: AnyCodable]?, lastEvent: Date?, newGroups: Int, owner: [String: AnyCodable]?, projects: [Projects], ref: String?, shortVersion: String, version: String, url: String?) {
          self.authors = authors
          self.commitCount = commitCount
          self.data = data
          self.dateCreated = dateCreated
          self.dateReleased = dateReleased
          self.deployCount = deployCount
          self.firstEvent = firstEvent
          self.lastCommit = lastCommit
          self.lastDeploy = lastDeploy
          self.lastEvent = lastEvent
          self.newGroups = newGroups
          self.owner = owner
          self.projects = projects
          self.ref = ref
          self.shortVersion = shortVersion
          self.version = version
          self.url = url
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          authors = try container.decodeAny("authors")
          commitCount = try container.decode("commitCount")
          data = try container.decodeAny("data")
          dateCreated = try container.decode("dateCreated")
          dateReleased = try container.decodeIfPresent("dateReleased")
          deployCount = try container.decode("deployCount")
          firstEvent = try container.decodeIfPresent("firstEvent")
          lastCommit = try container.decodeAnyIfPresent("lastCommit")
          lastDeploy = try container.decodeAnyIfPresent("lastDeploy")
          lastEvent = try container.decodeIfPresent("lastEvent")
          newGroups = try container.decode("newGroups")
          owner = try container.decodeAnyIfPresent("owner")
          projects = try container.decodeArray("projects")
          ref = try container.decodeIfPresent("ref")
          shortVersion = try container.decode("shortVersion")
          version = try container.decode("version")
          url = try container.decodeIfPresent("url")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encodeAny(authors, forKey: "authors")
          try container.encode(commitCount, forKey: "commitCount")
          try container.encodeAny(data, forKey: "data")
          try container.encode(dateCreated, forKey: "dateCreated")
          try container.encodeIfPresent(dateReleased, forKey: "dateReleased")
          try container.encode(deployCount, forKey: "deployCount")
          try container.encodeIfPresent(firstEvent, forKey: "firstEvent")
          try container.encodeAnyIfPresent(lastCommit, forKey: "lastCommit")
          try container.encodeAnyIfPresent(lastDeploy, forKey: "lastDeploy")
          try container.encodeIfPresent(lastEvent, forKey: "lastEvent")
          try container.encode(newGroups, forKey: "newGroups")
          try container.encodeAnyIfPresent(owner, forKey: "owner")
          try container.encode(projects, forKey: "projects")
          try container.encodeIfPresent(ref, forKey: "ref")
          try container.encode(shortVersion, forKey: "shortVersion")
          try container.encode(version, forKey: "version")
          try container.encodeIfPresent(url, forKey: "url")
        }
      }

      public typealias SuccessType = Status200

      /** Success */
      case status200(Status200)

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
