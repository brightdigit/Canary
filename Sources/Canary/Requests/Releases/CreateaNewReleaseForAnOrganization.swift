import Foundation
import Prch

public extension Releases {
  /** Create a new release for the given organization.  Releases are used by
   Sentry to improve its error reporting abilities by correlating
   first seen events with the release that might have introduced the
   problem.
   Releases are also necessary for source maps and other debug features
   that require manual upload for functioning well. */
  enum CreateaNewReleaseForAnOrganization {
    public static let service = Service<Response>(id: "Create a New Release for an Organization", tag: "Releases", method: "POST", path: "/api/0/organizations/{organization_slug}/releases/", hasBody: true, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:releases"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        CreateaNewReleaseForAnOrganization.service
      }

      /** Create a new release for the given organization.  Releases are used by
       Sentry to improve its error reporting abilities by correlating
       first seen events with the release that might have introduced the
       problem.
       Releases are also necessary for source maps and other debug features
       that require manual upload for functioning well. */
      public struct Body: Model {
        /** A version identifier for this release. Can be a version number, a commit hash, etc. */
        public var version: String

        /** A list of project slugs that are involved in this release. */
        public var projects: [String]

        /** An optional list of commit data to be associated with the release. Commits must include parameters `id` (the SHA of the commit), and can optionally include `repository`, `message`, `patch_set`, `author_name`, `author_email`, and `timestamp`. */
        public var commits: [Commits]?

        /** An optional date that indicates when the release went live. If not provided the current time is assumed. */
        public var dateReleased: Date?

        /** An optional commit reference. This is useful if a tagged version has been provided. */
        public var ref: String?

        /** An optional way to indicate the start and end commits for each repository included in a release. Head commits must include parameters `repository` and `commit` (the HEAD sha). They can optionally include `previousCommit` (the sha of the HEAD of the previous release), which should be specified if this is the first time you've sent commit data. `commit` may contain a range in the form of `previousCommit..commit`. */
        public var refs: [Refs]?

        /** A URL that points to the release. This can be the path to an online interface to the source code for instance */
        public var url: String?

        /** Create a new release for the given organization.  Releases are used by
         Sentry to improve its error reporting abilities by correlating
         first seen events with the release that might have introduced the
         problem.
         Releases are also necessary for source maps and other debug features
         that require manual upload for functioning well. */
        public struct Commits: Model {
          /** The email of the commit author. The commit author's email is required to enable the suggested assignee feature. */
          public var authorEmail: String?

          /** The name of the commit author. */
          public var authorName: String?

          /** The commit ID (the commit SHA). */
          public var id: String?

          /** The commit message. */
          public var message: String?

          /** A list of the files that have been changed in the commit. Specifying the patch_set is necessary to power suspect commits and suggested assignees. */
          public var patchSet: [PatchSet]?

          /** The full name of the repository the commit belongs to. If this field is not given Sentry will generate a name in the form: u'organization-<organization_id>' (i.e. if the organization id is 123, then the generated repository name will be u'organization-123). */
          public var repository: String?

          /** The commit timestamp is used to sort the commits given. If a timestamp is not included, the commits will remain sorted in the order given. */
          public var timestamp: Date?

          /** Create a new release for the given organization.  Releases are used by
           Sentry to improve its error reporting abilities by correlating
           first seen events with the release that might have introduced the
           problem.
           Releases are also necessary for source maps and other debug features
           that require manual upload for functioning well. */
          public struct PatchSet: Model {
            /** The type of change that happened in the commit. */
            public enum `Type`: String, Codable, Equatable, CaseIterable {
              case a = "A"
              case m = "M"
              case d = "D"
            }

            /** The path to the file. Both forward and backward slashes are supported. */
            public var path: String

            /** The type of change that happened in the commit. */
            public var type: `Type`

            public init(path: String, type: Type) {
              self.path = path
              self.type = type
            }

            public init(from decoder: Decoder) throws {
              let container = try decoder.container(keyedBy: StringCodingKey.self)

              path = try container.decode("path")
              type = try container.decode("type")
            }

            public func encode(to encoder: Encoder) throws {
              var container = encoder.container(keyedBy: StringCodingKey.self)

              try container.encode(path, forKey: "path")
              try container.encode(type, forKey: "type")
            }
          }

          public init(authorEmail: String? = nil, authorName: String? = nil, id: String? = nil, message: String? = nil, patchSet: [PatchSet]? = nil, repository: String? = nil, timestamp: Date? = nil) {
            self.authorEmail = authorEmail
            self.authorName = authorName
            self.id = id
            self.message = message
            self.patchSet = patchSet
            self.repository = repository
            self.timestamp = timestamp
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            authorEmail = try container.decodeIfPresent("author_email")
            authorName = try container.decodeIfPresent("author_name")
            id = try container.decodeIfPresent("id")
            message = try container.decodeIfPresent("message")
            patchSet = try container.decodeArrayIfPresent("patch_set")
            repository = try container.decodeIfPresent("repository")
            timestamp = try container.decodeIfPresent("timestamp")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encodeIfPresent(authorEmail, forKey: "author_email")
            try container.encodeIfPresent(authorName, forKey: "author_name")
            try container.encodeIfPresent(id, forKey: "id")
            try container.encodeIfPresent(message, forKey: "message")
            try container.encodeIfPresent(patchSet, forKey: "patch_set")
            try container.encodeIfPresent(repository, forKey: "repository")
            try container.encodeIfPresent(timestamp, forKey: "timestamp")
          }
        }

        /** Create a new release for the given organization.  Releases are used by
         Sentry to improve its error reporting abilities by correlating
         first seen events with the release that might have introduced the
         problem.
         Releases are also necessary for source maps and other debug features
         that require manual upload for functioning well. */
        public struct Refs: Model {
          /** The current release's commit. */
          public var commit: String?

          /** The previous release's commit. */
          public var previousCommit: String?

          /** The full name of the repository the commit belongs to. */
          public var repository: String?

          public init(commit: String? = nil, previousCommit: String? = nil, repository: String? = nil) {
            self.commit = commit
            self.previousCommit = previousCommit
            self.repository = repository
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            commit = try container.decodeIfPresent("commit")
            previousCommit = try container.decodeIfPresent("previousCommit")
            repository = try container.decodeIfPresent("repository")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encodeIfPresent(commit, forKey: "commit")
            try container.encodeIfPresent(previousCommit, forKey: "previousCommit")
            try container.encodeIfPresent(repository, forKey: "repository")
          }
        }

        public init(version: String, projects: [String], commits: [Commits]? = nil, dateReleased: Date? = nil, ref: String? = nil, refs: [Refs]? = nil, url: String? = nil) {
          self.version = version
          self.projects = projects
          self.commits = commits
          self.dateReleased = dateReleased
          self.ref = ref
          self.refs = refs
          self.url = url
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          version = try container.decode("version")
          projects = try container.decodeArray("projects")
          commits = try container.decodeArrayIfPresent("commits")
          dateReleased = try container.decodeIfPresent("dateReleased")
          ref = try container.decodeIfPresent("ref")
          refs = try container.decodeArrayIfPresent("refs")
          url = try container.decodeIfPresent("url")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(version, forKey: "version")
          try container.encode(projects, forKey: "projects")
          try container.encodeIfPresent(commits, forKey: "commits")
          try container.encodeIfPresent(dateReleased, forKey: "dateReleased")
          try container.encodeIfPresent(ref, forKey: "ref")
          try container.encodeIfPresent(refs, forKey: "refs")
          try container.encodeIfPresent(url, forKey: "url")
        }
      }

      public struct Options {
        /** The slug of the organization. */
        public var organizationSlug: String

        public init(organizationSlug: String) {
          self.organizationSlug = organizationSlug
        }
      }

      public var options: Options

      public var body: Body?

      public init(body: Body?, options: Options, encoder _: RequestEncoder? = nil) {
        self.body = body
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(organizationSlug: String, body: Body? = nil) {
        let options = Options(organizationSlug: organizationSlug)
        self.init(body: body, options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)")
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
      /** Create a new release for the given organization.  Releases are used by
       Sentry to improve its error reporting abilities by correlating
       first seen events with the release that might have introduced the
       problem.
       Releases are also necessary for source maps and other debug features
       that require manual upload for functioning well. */
      public struct Status201: Model {
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

        /** Create a new release for the given organization.  Releases are used by
         Sentry to improve its error reporting abilities by correlating
         first seen events with the release that might have introduced the
         problem.
         Releases are also necessary for source maps and other debug features
         that require manual upload for functioning well. */
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

      public typealias SuccessType = Status201

      /** Success */
      case status201(Status201)

      /** Bad Input */
      case status400

      /** Forbidden */
      case status403

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
        }
      }

      public var successful: Bool {
        switch self {
        case .status201: return true
        case .status400: return false
        case .status403: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 201: self = try .status201(decoder.decode(Status201.self, from: data))
        case 400: self = .status400
        case 403: self = .status403
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
