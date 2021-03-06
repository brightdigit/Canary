import Foundation
import Prch

public extension Events {
  struct Metadata: Codable, Equatable {
    public let type: String?
    public let value: String?
    public let title: String?
  }

  /** Return details on an individual issue. This returns the basic stats for the issue (title, last seen, first seen), some overall numbers (number of comments, user reports) as well as the summarized event data. */
  enum RetrieveAnIssue {
    public static let service = Service<Response>(id: "Retrieve an Issue", tag: "Events", method: "GET", path: "/api/0/issues/{issue_id}/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["event:read"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        RetrieveAnIssue.service
      }

      public struct Options {
        /** The ID of the issue to retrieve. */
        public var issueId: String

        public init(issueId: String) {
          self.issueId = issueId
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(issueId: String) {
        let options = Options(issueId: issueId)
        self.init(options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "issue_id" + "}", with: "\(options.issueId)")
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
      /** Return details on an individual issue. This returns the basic stats for the issue (title, last seen, first seen), some overall numbers (number of comments, user reports) as well as the summarized event data. */
      public struct Status200: Model {
        /** Return details on an individual issue. This returns the basic stats for the issue (title, last seen, first seen), some overall numbers (number of comments, user reports) as well as the summarized event data. */
        public enum Status: String, Codable, Equatable, CaseIterable {
          case resolved
          case unresolved
          case ignored
        }

        public var activity: [Activity]

        public var annotations: [String]

        public var assignedTo: [String: AnyCodable]?

        public var count: String

        public var culprit: String

        public var firstRelease: FirstRelease?

        public var firstSeen: String

        public var hasSeen: Bool

        public var id: String

        public var isBookmarked: Bool

        public var isPublic: Bool

        public var isSubscribed: Bool

        public var lastRelease: [String: AnyCodable]?

        public var lastSeen: String

        public var level: String

        public var logger: String?

        public var metadata: Metadata

        public var numComments: Int

        public var participants: [[String: AnyCodable]]

        public var permalink: String

        public var pluginActions: [[String]]

        public var pluginContexts: [String]

        public var pluginIssues: [[String: AnyCodable]]

        public var project: Project

        public var seenBy: [[String: AnyCodable]]

        public var shareId: String?

        public var shortId: String

        public var stats: Stats

        public var status: Status

        public var statusDetails: [String: AnyCodable]

        public var subscriptionDetails: [String: AnyCodable]?

        public var tags: [[String: AnyCodable]]

        public var title: String

        public var type: String

        public var userCount: Int

        public var userReportCount: Int

        /** Return details on an individual issue. This returns the basic stats for the issue (title, last seen, first seen), some overall numbers (number of comments, user reports) as well as the summarized event data. */
        public struct Activity: Model {
          public var data: [String: AnyCodable]?

          public var dateCreated: String?

          public var id: String?

          public var type: String?

          public var user: [String: AnyCodable]?

          public init(data: [String: AnyCodable]? = nil, dateCreated: String? = nil, id: String? = nil, type: String? = nil, user: [String: AnyCodable]? = nil) {
            self.data = data
            self.dateCreated = dateCreated
            self.id = id
            self.type = type
            self.user = user
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            data = try container.decodeAnyIfPresent("data")
            dateCreated = try container.decodeIfPresent("dateCreated")
            id = try container.decodeIfPresent("id")
            type = try container.decodeIfPresent("type")
            user = try container.decodeAnyIfPresent("user")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encodeAnyIfPresent(data, forKey: "data")
            try container.encodeIfPresent(dateCreated, forKey: "dateCreated")
            try container.encodeIfPresent(id, forKey: "id")
            try container.encodeIfPresent(type, forKey: "type")
            try container.encodeAnyIfPresent(user, forKey: "user")
          }
        }

        /** Return details on an individual issue. This returns the basic stats for the issue (title, last seen, first seen), some overall numbers (number of comments, user reports) as well as the summarized event data. */
        public struct FirstRelease: Model {
          public var authors: [String]?

          public var commitCount: Int?

          public var data: [String: AnyCodable]?

          public var dateCreated: String?

          public var dateReleased: String?

          public var deployCount: Int?

          public var firstEvent: String?

          public var lastCommit: String?

          public var lastDeploy: String?

          public var lastEvent: String?

          public var newGroups: Int?

          public var owner: String?

          public var projects: [Projects]?

          public var ref: String?

          public var shortVersion: String?

          public var url: String?

          public var version: String?

          /** Return details on an individual issue. This returns the basic stats for the issue (title, last seen, first seen), some overall numbers (number of comments, user reports) as well as the summarized event data. */
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

          public init(authors: [String]? = nil, commitCount: Int? = nil, data: [String: AnyCodable]? = nil, dateCreated: String? = nil, dateReleased: String? = nil, deployCount: Int? = nil, firstEvent: String? = nil, lastCommit: String? = nil, lastDeploy: String? = nil, lastEvent: String? = nil, newGroups: Int? = nil, owner: String? = nil, projects: [Projects]? = nil, ref: String? = nil, shortVersion: String? = nil, url: String? = nil, version: String? = nil) {
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
            self.url = url
            self.version = version
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            authors = try container.decodeArrayIfPresent("authors")
            commitCount = try container.decodeIfPresent("commitCount")
            data = try container.decodeAnyIfPresent("data")
            dateCreated = try container.decodeIfPresent("dateCreated")
            dateReleased = try container.decodeIfPresent("dateReleased")
            deployCount = try container.decodeIfPresent("deployCount")
            firstEvent = try container.decodeIfPresent("firstEvent")
            lastCommit = try container.decodeIfPresent("lastCommit")
            lastDeploy = try container.decodeIfPresent("lastDeploy")
            lastEvent = try container.decodeIfPresent("lastEvent")
            newGroups = try container.decodeIfPresent("newGroups")
            owner = try container.decodeIfPresent("owner")
            projects = try container.decodeArrayIfPresent("projects")
            ref = try container.decodeIfPresent("ref")
            shortVersion = try container.decodeIfPresent("shortVersion")
            url = try container.decodeIfPresent("url")
            version = try container.decodeIfPresent("version")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encodeIfPresent(authors, forKey: "authors")
            try container.encodeIfPresent(commitCount, forKey: "commitCount")
            try container.encodeAnyIfPresent(data, forKey: "data")
            try container.encodeIfPresent(dateCreated, forKey: "dateCreated")
            try container.encodeIfPresent(dateReleased, forKey: "dateReleased")
            try container.encodeIfPresent(deployCount, forKey: "deployCount")
            try container.encodeIfPresent(firstEvent, forKey: "firstEvent")
            try container.encodeIfPresent(lastCommit, forKey: "lastCommit")
            try container.encodeIfPresent(lastDeploy, forKey: "lastDeploy")
            try container.encodeIfPresent(lastEvent, forKey: "lastEvent")
            try container.encodeIfPresent(newGroups, forKey: "newGroups")
            try container.encodeIfPresent(owner, forKey: "owner")
            try container.encodeIfPresent(projects, forKey: "projects")
            try container.encodeIfPresent(ref, forKey: "ref")
            try container.encodeIfPresent(shortVersion, forKey: "shortVersion")
            try container.encodeIfPresent(url, forKey: "url")
            try container.encodeIfPresent(version, forKey: "version")
          }
        }

        /** Return details on an individual issue. This returns the basic stats for the issue (title, last seen, first seen), some overall numbers (number of comments, user reports) as well as the summarized event data. */
        public struct Project: Model {
          public var id: String?

          public var name: String?

          public var slug: String?

          public init(id: String? = nil, name: String? = nil, slug: String? = nil) {
            self.id = id
            self.name = name
            self.slug = slug
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            id = try container.decodeIfPresent("id")
            name = try container.decodeIfPresent("name")
            slug = try container.decodeIfPresent("slug")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encodeIfPresent(id, forKey: "id")
            try container.encodeIfPresent(name, forKey: "name")
            try container.encodeIfPresent(slug, forKey: "slug")
          }
        }

        /** Return details on an individual issue. This returns the basic stats for the issue (title, last seen, first seen), some overall numbers (number of comments, user reports) as well as the summarized event data. */
        public struct Stats: Model {
          public var _24h: [[Double]]?

          public var _30d: [[Double]]?

          public init(_24h: [[Double]]? = nil, _30d: [[Double]]? = nil) {
            self._24h = _24h
            self._30d = _30d
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            _24h = try container.decodeArrayIfPresent("24h")
            _30d = try container.decodeArrayIfPresent("30d")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encodeIfPresent(_24h, forKey: "24h")
            try container.encodeIfPresent(_30d, forKey: "30d")
          }
        }

        public init(activity: [Activity], annotations: [String], assignedTo: [String: AnyCodable]?, count: String, culprit: String, firstRelease: FirstRelease?, firstSeen: String, hasSeen: Bool, id: String, isBookmarked: Bool, isPublic: Bool, isSubscribed: Bool, lastRelease: [String: AnyCodable]?, lastSeen: String, level: String, logger: String?, metadata: Metadata, numComments: Int, participants: [[String: AnyCodable]], permalink: String, pluginActions: [[String]], pluginContexts: [String], pluginIssues: [[String: AnyCodable]], project: Project, seenBy: [[String: AnyCodable]], shareId: String?, shortId: String, stats: Stats, status: Status, statusDetails: [String: AnyCodable], subscriptionDetails: [String: AnyCodable]?, tags: [[String: AnyCodable]], title: String, type: String, userCount: Int, userReportCount: Int) {
          self.activity = activity
          self.annotations = annotations
          self.assignedTo = assignedTo
          self.count = count
          self.culprit = culprit
          self.firstRelease = firstRelease
          self.firstSeen = firstSeen
          self.hasSeen = hasSeen
          self.id = id
          self.isBookmarked = isBookmarked
          self.isPublic = isPublic
          self.isSubscribed = isSubscribed
          self.lastRelease = lastRelease
          self.lastSeen = lastSeen
          self.level = level
          self.logger = logger
          self.metadata = metadata
          self.numComments = numComments
          self.participants = participants
          self.permalink = permalink
          self.pluginActions = pluginActions
          self.pluginContexts = pluginContexts
          self.pluginIssues = pluginIssues
          self.project = project
          self.seenBy = seenBy
          self.shareId = shareId
          self.shortId = shortId
          self.stats = stats
          self.status = status
          self.statusDetails = statusDetails
          self.subscriptionDetails = subscriptionDetails
          self.tags = tags
          self.title = title
          self.type = type
          self.userCount = userCount
          self.userReportCount = userReportCount
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          activity = try container.decodeArray("activity")
          annotations = try container.decodeArray("annotations")
          assignedTo = try container.decodeAnyIfPresent("assignedTo")
          count = try container.decode("count")
          culprit = try container.decode("culprit")
          firstRelease = try container.decodeIfPresent("firstRelease")
          firstSeen = try container.decode("firstSeen")
          hasSeen = try container.decode("hasSeen")
          id = try container.decode("id")
          isBookmarked = try container.decode("isBookmarked")
          isPublic = try container.decode("isPublic")
          isSubscribed = try container.decode("isSubscribed")
          lastRelease = try container.decodeAnyIfPresent("lastRelease")
          lastSeen = try container.decode("lastSeen")
          level = try container.decode("level")
          logger = try container.decodeIfPresent("logger")
          metadata = try container.decode("metadata")
          numComments = try container.decode("numComments")
          participants = try container.decodeAny("participants")
          permalink = try container.decode("permalink")
          pluginActions = try container.decodeArray("pluginActions")
          pluginContexts = try container.decodeArray("pluginContexts")
          pluginIssues = try container.decodeAny("pluginIssues")
          project = try container.decode("project")
          seenBy = try container.decodeAny("seenBy")
          shareId = try container.decodeIfPresent("shareId")
          shortId = try container.decode("shortId")
          stats = try container.decode("stats")
          status = try container.decode("status")
          statusDetails = try container.decodeAny("statusDetails")
          subscriptionDetails = try container.decodeAnyIfPresent("subscriptionDetails")
          tags = try container.decodeAny("tags")
          title = try container.decode("title")
          type = try container.decode("type")
          userCount = try container.decode("userCount")
          userReportCount = try container.decode("userReportCount")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(activity, forKey: "activity")
          try container.encode(annotations, forKey: "annotations")
          try container.encodeAnyIfPresent(assignedTo, forKey: "assignedTo")
          try container.encode(count, forKey: "count")
          try container.encode(culprit, forKey: "culprit")
          try container.encodeIfPresent(firstRelease, forKey: "firstRelease")
          try container.encode(firstSeen, forKey: "firstSeen")
          try container.encode(hasSeen, forKey: "hasSeen")
          try container.encode(id, forKey: "id")
          try container.encode(isBookmarked, forKey: "isBookmarked")
          try container.encode(isPublic, forKey: "isPublic")
          try container.encode(isSubscribed, forKey: "isSubscribed")
          try container.encodeAnyIfPresent(lastRelease, forKey: "lastRelease")
          try container.encode(lastSeen, forKey: "lastSeen")
          try container.encode(level, forKey: "level")
          try container.encodeIfPresent(logger, forKey: "logger")
          try container.encode(metadata, forKey: "metadata")
          try container.encode(numComments, forKey: "numComments")
          try container.encodeAny(participants, forKey: "participants")
          try container.encode(permalink, forKey: "permalink")
          try container.encode(pluginActions, forKey: "pluginActions")
          try container.encode(pluginContexts, forKey: "pluginContexts")
          try container.encodeAny(pluginIssues, forKey: "pluginIssues")
          try container.encode(project, forKey: "project")
          try container.encodeAny(seenBy, forKey: "seenBy")
          try container.encodeIfPresent(shareId, forKey: "shareId")
          try container.encode(shortId, forKey: "shortId")
          try container.encode(stats, forKey: "stats")
          try container.encode(status, forKey: "status")
          try container.encodeAny(statusDetails, forKey: "statusDetails")
          try container.encodeAnyIfPresent(subscriptionDetails, forKey: "subscriptionDetails")
          try container.encodeAny(tags, forKey: "tags")
          try container.encode(title, forKey: "title")
          try container.encode(type, forKey: "type")
          try container.encode(userCount, forKey: "userCount")
          try container.encode(userReportCount, forKey: "userReportCount")
        }
      }

      public typealias SuccessType = Status200

      /** Success */
      case status200(Status200)

      /** Forbidden */
      case status403

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
        }
      }

      public var successful: Bool {
        switch self {
        case .status200: return true
        case .status403: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 200: self = try .status200(decoder.decode(Status200.self, from: data))
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
