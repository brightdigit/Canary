import Foundation
import Prch

public extension Events {
  /** Return a list of issues (groups) bound to a project.  All parameters are supplied as query string parameters.
    A default query of ``is:unresolved`` is applied. To return results with other statuses send an new query value (i.e. ``?query=`` for all results).
   The ``statsPeriod`` parameter can be used to select the timeline stats which should be present. Possible values are: ``""`` (disable),``"24h"``, ``"14d"`` */
  enum ListaProjectsIssues {
    public static let service = Service<Response>(id: "List a Project's Issues", tag: "Events", method: "GET", path: "/api/0/projects/{organization_slug}/{project_slug}/issues/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:read"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        ListaProjectsIssues.service
      }

      public struct Options {
        /** The slug of the organization the issues belong to. */
        public var organizationSlug: String

        /** The slug of the project the issues belong to. */
        public var projectSlug: String

        /** An optional stat period (can be one of `"24h"`, `"14d"`, and `""`). */
        public var statsPeriod: String?

        /** If this is set to true then short IDs are looked up by this function as well. This can cause the return value of the function to return an event issue of a different project which is why this is an opt-in. Set to 1 to enable. */
        public var shortIdLookup: Bool?

        /** An optional Sentry structured search query. If not provided an implied `"is:unresolved"` is assumed. */
        public var query: String?

        /** A pointer to the last object fetched and its' sort order; used to retrieve the next or previous results. */
        public var cursor: String?

        public init(organizationSlug: String, projectSlug: String, statsPeriod: String? = nil, shortIdLookup: Bool? = nil, query: String? = nil, cursor: String? = nil) {
          self.organizationSlug = organizationSlug
          self.projectSlug = projectSlug
          self.statsPeriod = statsPeriod
          self.shortIdLookup = shortIdLookup
          self.query = query
          self.cursor = cursor
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(organizationSlug: String, projectSlug: String, statsPeriod: String? = nil, shortIdLookup: Bool? = nil, query: String? = nil, cursor: String? = nil) {
        let options = Options(organizationSlug: organizationSlug, projectSlug: projectSlug, statsPeriod: statsPeriod, shortIdLookup: shortIdLookup, query: query, cursor: cursor)
        self.init(options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "project_slug" + "}", with: "\(options.projectSlug)")
      }

      public var queryParameters: [String: Any] {
        var params: [String: Any] = [:]
        if let statsPeriod = options.statsPeriod {
          params["statsPeriod"] = statsPeriod
        }
        if let shortIdLookup = options.shortIdLookup {
          params["shortIdLookup"] = shortIdLookup
        }
        if let query = options.query {
          params["query"] = query
        }
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
      /** Return a list of issues (groups) bound to a project.  All parameters are supplied as query string parameters.
        A default query of ``is:unresolved`` is applied. To return results with other statuses send an new query value (i.e. ``?query=`` for all results).
       The ``statsPeriod`` parameter can be used to select the timeline stats which should be present. Possible values are: ``""`` (disable),``"24h"``, ``"14d"`` */
      public struct Status200: Model {
        /** Return a list of issues (groups) bound to a project.  All parameters are supplied as query string parameters.
          A default query of ``is:unresolved`` is applied. To return results with other statuses send an new query value (i.e. ``?query=`` for all results).
         The ``statsPeriod`` parameter can be used to select the timeline stats which should be present. Possible values are: ``""`` (disable),``"24h"``, ``"14d"`` */
        public enum Status: String, Codable, Equatable, CaseIterable {
          case resolved
          case unresolved
          case ignored
        }

        public var lastSeen: String

        public var numComments: Int

        public var userCount: Int

        public var culprit: String

        public var title: String

        public var id: String

        public var assignedTo: [String: AnyCodable]?

        public var logger: String?

        public var stats: Stats

        public var type: String

        public var annotations: [String]

        public var metadata: Metadata

        public var status: Status

        public var subscriptionDetails: [String: AnyCodable]?

        public var isPublic: Bool

        public var hasSeen: Bool

        public var shortId: String

        public var shareId: String?

        public var firstSeen: String

        public var count: String

        public var permalink: String

        public var level: String

        public var isSubscribed: Bool

        public var isBookmarked: Bool

        public var project: Project

        public var statusDetails: [String: AnyCodable]

        /** Return a list of issues (groups) bound to a project.  All parameters are supplied as query string parameters.
          A default query of ``is:unresolved`` is applied. To return results with other statuses send an new query value (i.e. ``?query=`` for all results).
         The ``statsPeriod`` parameter can be used to select the timeline stats which should be present. Possible values are: ``""`` (disable),``"24h"``, ``"14d"`` */
        public struct Stats: Model {
          public var _24h: [[Double]]?

          public init(_24h: [[Double]]? = nil) {
            self._24h = _24h
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            _24h = try container.decodeArrayIfPresent("24h")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encodeIfPresent(_24h, forKey: "24h")
          }
        }

        /** Return a list of issues (groups) bound to a project.  All parameters are supplied as query string parameters.
          A default query of ``is:unresolved`` is applied. To return results with other statuses send an new query value (i.e. ``?query=`` for all results).
         The ``statsPeriod`` parameter can be used to select the timeline stats which should be present. Possible values are: ``""`` (disable),``"24h"``, ``"14d"`` */
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

        public init(lastSeen: String, numComments: Int, userCount: Int, culprit: String, title: String, id: String, assignedTo: [String: AnyCodable]?, logger: String?, stats: Stats, type: String, annotations: [String], metadata: Metadata, status: Status, subscriptionDetails: [String: AnyCodable]?, isPublic: Bool, hasSeen: Bool, shortId: String, shareId: String?, firstSeen: String, count: String, permalink: String, level: String, isSubscribed: Bool, isBookmarked: Bool, project: Project, statusDetails: [String: AnyCodable]) {
          self.lastSeen = lastSeen
          self.numComments = numComments
          self.userCount = userCount
          self.culprit = culprit
          self.title = title
          self.id = id
          self.assignedTo = assignedTo
          self.logger = logger
          self.stats = stats
          self.type = type
          self.annotations = annotations
          self.metadata = metadata
          self.status = status
          self.subscriptionDetails = subscriptionDetails
          self.isPublic = isPublic
          self.hasSeen = hasSeen
          self.shortId = shortId
          self.shareId = shareId
          self.firstSeen = firstSeen
          self.count = count
          self.permalink = permalink
          self.level = level
          self.isSubscribed = isSubscribed
          self.isBookmarked = isBookmarked
          self.project = project
          self.statusDetails = statusDetails
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          lastSeen = try container.decode("lastSeen")
          numComments = try container.decode("numComments")
          userCount = try container.decode("userCount")
          culprit = try container.decode("culprit")
          title = try container.decode("title")
          id = try container.decode("id")
          assignedTo = try container.decodeAnyIfPresent("assignedTo")
          logger = try container.decodeIfPresent("logger")
          stats = try container.decode("stats")
          type = try container.decode("type")
          annotations = try container.decodeArray("annotations")
          metadata = try container.decode("metadata")
          status = try container.decode("status")
          subscriptionDetails = try container.decodeAnyIfPresent("subscriptionDetails")
          isPublic = try container.decode("isPublic")
          hasSeen = try container.decode("hasSeen")
          shortId = try container.decode("shortId")
          shareId = try container.decodeIfPresent("shareId")
          firstSeen = try container.decode("firstSeen")
          count = try container.decode("count")
          permalink = try container.decode("permalink")
          level = try container.decode("level")
          isSubscribed = try container.decode("isSubscribed")
          isBookmarked = try container.decode("isBookmarked")
          project = try container.decode("project")
          statusDetails = try container.decodeAny("statusDetails")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(lastSeen, forKey: "lastSeen")
          try container.encode(numComments, forKey: "numComments")
          try container.encode(userCount, forKey: "userCount")
          try container.encode(culprit, forKey: "culprit")
          try container.encode(title, forKey: "title")
          try container.encode(id, forKey: "id")
          try container.encodeAnyIfPresent(assignedTo, forKey: "assignedTo")
          try container.encodeIfPresent(logger, forKey: "logger")
          try container.encode(stats, forKey: "stats")
          try container.encode(type, forKey: "type")
          try container.encode(annotations, forKey: "annotations")
          try container.encode(metadata, forKey: "metadata")
          try container.encode(status, forKey: "status")
          try container.encodeAnyIfPresent(subscriptionDetails, forKey: "subscriptionDetails")
          try container.encode(isPublic, forKey: "isPublic")
          try container.encode(hasSeen, forKey: "hasSeen")
          try container.encode(shortId, forKey: "shortId")
          try container.encodeIfPresent(shareId, forKey: "shareId")
          try container.encode(firstSeen, forKey: "firstSeen")
          try container.encode(count, forKey: "count")
          try container.encode(permalink, forKey: "permalink")
          try container.encode(level, forKey: "level")
          try container.encode(isSubscribed, forKey: "isSubscribed")
          try container.encode(isBookmarked, forKey: "isBookmarked")
          try container.encode(project, forKey: "project")
          try container.encodeAny(statusDetails, forKey: "statusDetails")
        }
      }

      public typealias SuccessType = [Status200]

      /** Success */
      case status200([Status200])

      /** Forbidden */
      case status403

      public var success: [Status200]? {
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
        case 200: self = try .status200(decoder.decode([Status200].self, from: data))
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
