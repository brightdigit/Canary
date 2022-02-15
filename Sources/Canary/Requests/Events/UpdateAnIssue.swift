import Foundation
import Prch

public extension Events {
  /** Updates an individual issue's attributes.  Only the attributes submitted are modified. */
  enum UpdateAnIssue {
    public static let service = APIService<Response>(id: "Update an Issue", tag: "Events", method: "PUT", path: "/api/0/issues/{issue_id}/", hasBody: true, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["event:write"])])

    public final class Request: APIRequest<Response, CanaryAPI> {
      /** Updates an individual issue's attributes.  Only the attributes submitted are modified. */
      public struct Body: Model {
        /** The actor id (or username) of the user or team that should be assigned to this issue. */
        public var assignedTo: String?

        /** In case this API call is invoked with a user context this allows changing of the flag that indicates if the user has seen the event. */
        public var hasSeen: Bool?

        /** In case this API call is invoked with a user context this allows changing of the bookmark flag. */
        public var isBookmarked: Bool?

        /** Sets the issue to public or private. */
        public var isPublic: Bool?

        public var isSubscribed: Bool?

        /** The new status for the issues. Valid values are `"resolved"`, `"resolvedInNextRelease"`, `"unresolved"`, and `"ignored"`. */
        public var status: String?

        public init(assignedTo: String? = nil, hasSeen: Bool? = nil, isBookmarked: Bool? = nil, isPublic: Bool? = nil, isSubscribed: Bool? = nil, status: String? = nil) {
          self.assignedTo = assignedTo
          self.hasSeen = hasSeen
          self.isBookmarked = isBookmarked
          self.isPublic = isPublic
          self.isSubscribed = isSubscribed
          self.status = status
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          assignedTo = try container.decodeIfPresent("assignedTo")
          hasSeen = try container.decodeIfPresent("hasSeen")
          isBookmarked = try container.decodeIfPresent("isBookmarked")
          isPublic = try container.decodeIfPresent("isPublic")
          isSubscribed = try container.decodeIfPresent("isSubscribed")
          status = try container.decodeIfPresent("status")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encodeIfPresent(assignedTo, forKey: "assignedTo")
          try container.encodeIfPresent(hasSeen, forKey: "hasSeen")
          try container.encodeIfPresent(isBookmarked, forKey: "isBookmarked")
          try container.encodeIfPresent(isPublic, forKey: "isPublic")
          try container.encodeIfPresent(isSubscribed, forKey: "isSubscribed")
          try container.encodeIfPresent(status, forKey: "status")
        }
      }

      public struct Options {
        /** The ID of the group to retrieve. */
        public var issueId: String

        public init(issueId: String) {
          self.issueId = issueId
        }
      }

      public var options: Options

      public var body: Body

      public init(body: Body, options: Options, encoder: RequestEncoder? = nil) {
        self.body = body
        self.options = options
        super.init(service: UpdateAnIssue.service) { defaultEncoder in
          try (encoder ?? defaultEncoder).encode(body)
        }
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(issueId: String, body: Body) {
        let options = Options(issueId: issueId)
        self.init(body: body, options: options)
      }

      override public var path: String {
        super.path.replacingOccurrences(of: "{" + "issue_id" + "}", with: "\(options.issueId)")
      }
    }

    public enum Response: APIResponseValue, CustomStringConvertible, CustomDebugStringConvertible {
      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      /** Updates an individual issue's attributes.  Only the attributes submitted are modified. */
      public struct Status200: Model {
        /** Updates an individual issue's attributes.  Only the attributes submitted are modified. */
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

        /** Updates an individual issue's attributes.  Only the attributes submitted are modified. */
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

        public init(lastSeen: String, numComments: Int, userCount: Int, culprit: String, title: String, id: String, assignedTo: [String: AnyCodable]?, logger: String?, type: String, annotations: [String], metadata: Metadata, status: Status, subscriptionDetails: [String: AnyCodable]?, isPublic: Bool, hasSeen: Bool, shortId: String, shareId: String?, firstSeen: String, count: String, permalink: String, level: String, isSubscribed: Bool, isBookmarked: Bool, project: Project, statusDetails: [String: AnyCodable]) {
          self.lastSeen = lastSeen
          self.numComments = numComments
          self.userCount = userCount
          self.culprit = culprit
          self.title = title
          self.id = id
          self.assignedTo = assignedTo
          self.logger = logger
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

      public typealias SuccessType = Status200

      /** Success */
      case status200(Status200)

      /** Forbidden */
      case status403

      /** The requested resource does not exist */
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
        default: throw APIClientError.unexpectedStatusCode(statusCode: statusCode, data: data)
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
