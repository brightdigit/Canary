import Foundation
import Prch

public extension Organizations {
  /** This resolves a short ID to the project slug and internal issue ID. */
  enum ResolveaShortID {
    public static let service = Service<Response>(id: "Resolve a Short ID", tag: "Organizations", method: "GET", path: "/api/0/organizations/{organization_slug}/shortids/{short_id}/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["org: read"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        ResolveaShortID.service
      }

      public struct Options {
        /** The slug of the organization the short ID should be looked up in. */
        public var organizationSlug: String

        /** The short ID to look up. */
        public var shortId: String

        public init(organizationSlug: String, shortId: String) {
          self.organizationSlug = organizationSlug
          self.shortId = shortId
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(organizationSlug: String, shortId: String) {
        let options = Options(organizationSlug: organizationSlug, shortId: shortId)
        self.init(options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "short_id" + "}", with: "\(options.shortId)")
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
      /** This resolves a short ID to the project slug and internal issue ID. */
      public struct Status200: Model {
        public var organizationSlug: String

        public var projectSlug: String

        public var shortId: String

        public var group: Group

        public var groupId: String

        /** This resolves a short ID to the project slug and internal issue ID. */
        public struct Group: Model {
          /** This resolves a short ID to the project slug and internal issue ID. */
          public enum Status: String, Codable, Equatable, CaseIterable {
            case resolved
            case unresolved
            case ignored
          }

          public var lastSeen: String

          public var numComments: Int

          public var userCount: Int

          public var culprit: String?

          public var title: String

          public var id: String

          public var assignedTo: AssignedTo?

          public var logger: String?

          public var type: String

          public var annotations: [String]

          public var metadata: Metadata

          public var status: Status

          public var subscriptionDetails: SubscriptionDetails?

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

          /** This resolves a short ID to the project slug and internal issue ID. */
          public struct AssignedTo: Model {
            public var id: String?

            public var name: String?

            public var type: String?

            public init(id: String? = nil, name: String? = nil, type: String? = nil) {
              self.id = id
              self.name = name
              self.type = type
            }

            public init(from decoder: Decoder) throws {
              let container = try decoder.container(keyedBy: StringCodingKey.self)

              id = try container.decodeIfPresent("id")
              name = try container.decodeIfPresent("name")
              type = try container.decodeIfPresent("type")
            }

            public func encode(to encoder: Encoder) throws {
              var container = encoder.container(keyedBy: StringCodingKey.self)

              try container.encodeIfPresent(id, forKey: "id")
              try container.encodeIfPresent(name, forKey: "name")
              try container.encodeIfPresent(type, forKey: "type")
            }
          }

          /** This resolves a short ID to the project slug and internal issue ID. */
          public struct Metadata: Model {
            public var filename: String?

            public var function: String?

            public var title: String?

            public var type: String?

            public var value: String?

            public init(filename: String? = nil, function: String? = nil, title: String? = nil, type: String? = nil, value: String? = nil) {
              self.filename = filename
              self.function = function
              self.title = title
              self.type = type
              self.value = value
            }

            public init(from decoder: Decoder) throws {
              let container = try decoder.container(keyedBy: StringCodingKey.self)

              filename = try container.decodeIfPresent("filename")
              function = try container.decodeIfPresent("function")
              title = try container.decodeIfPresent("title")
              type = try container.decodeIfPresent("type")
              value = try container.decodeIfPresent("value")
            }

            public func encode(to encoder: Encoder) throws {
              var container = encoder.container(keyedBy: StringCodingKey.self)

              try container.encodeIfPresent(filename, forKey: "filename")
              try container.encodeIfPresent(function, forKey: "function")
              try container.encodeIfPresent(title, forKey: "title")
              try container.encodeIfPresent(type, forKey: "type")
              try container.encodeIfPresent(value, forKey: "value")
            }
          }

          /** This resolves a short ID to the project slug and internal issue ID. */
          public struct SubscriptionDetails: Model {
            public var reason: String?

            public init(reason: String? = nil) {
              self.reason = reason
            }

            public init(from decoder: Decoder) throws {
              let container = try decoder.container(keyedBy: StringCodingKey.self)

              reason = try container.decodeIfPresent("reason")
            }

            public func encode(to encoder: Encoder) throws {
              var container = encoder.container(keyedBy: StringCodingKey.self)

              try container.encodeIfPresent(reason, forKey: "reason")
            }
          }

          /** This resolves a short ID to the project slug and internal issue ID. */
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

          public init(lastSeen: String, numComments: Int, userCount: Int, culprit: String?, title: String, id: String, assignedTo: AssignedTo?, logger: String?, type: String, annotations: [String], metadata: Metadata, status: Status, subscriptionDetails: SubscriptionDetails?, isPublic: Bool, hasSeen: Bool, shortId: String, shareId: String?, firstSeen: String, count: String, permalink: String, level: String, isSubscribed: Bool, isBookmarked: Bool, project: Project, statusDetails: [String: AnyCodable]) {
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
            culprit = try container.decodeIfPresent("culprit")
            title = try container.decode("title")
            id = try container.decode("id")
            assignedTo = try container.decodeIfPresent("assignedTo")
            logger = try container.decodeIfPresent("logger")
            type = try container.decode("type")
            annotations = try container.decodeArray("annotations")
            metadata = try container.decode("metadata")
            status = try container.decode("status")
            subscriptionDetails = try container.decodeIfPresent("subscriptionDetails")
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
            try container.encodeIfPresent(culprit, forKey: "culprit")
            try container.encode(title, forKey: "title")
            try container.encode(id, forKey: "id")
            try container.encodeIfPresent(assignedTo, forKey: "assignedTo")
            try container.encodeIfPresent(logger, forKey: "logger")
            try container.encode(type, forKey: "type")
            try container.encode(annotations, forKey: "annotations")
            try container.encode(metadata, forKey: "metadata")
            try container.encode(status, forKey: "status")
            try container.encodeIfPresent(subscriptionDetails, forKey: "subscriptionDetails")
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

        public init(organizationSlug: String, projectSlug: String, shortId: String, group: Group, groupId: String) {
          self.organizationSlug = organizationSlug
          self.projectSlug = projectSlug
          self.shortId = shortId
          self.group = group
          self.groupId = groupId
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          organizationSlug = try container.decode("organizationSlug")
          projectSlug = try container.decode("projectSlug")
          shortId = try container.decode("shortId")
          group = try container.decode("group")
          groupId = try container.decode("groupId")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(organizationSlug, forKey: "organizationSlug")
          try container.encode(projectSlug, forKey: "projectSlug")
          try container.encode(shortId, forKey: "shortId")
          try container.encode(group, forKey: "group")
          try container.encode(groupId, forKey: "groupId")
        }
      }

      public typealias SuccessType = Status200

      /** Success */
      case status200(Status200)

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
        case 200: self = try .status200(decoder.decode(Status200.self, from: data))
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
