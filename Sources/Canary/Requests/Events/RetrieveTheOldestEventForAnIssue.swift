import Foundation
import Prch

#if false
  public extension Events {
    /** Retrieves the details of the oldest event for an issue. */
    enum RetrieveTheOldestEventForAnIssue {
      public static let service = Service<Response>(id: "Retrieve the Oldest Event for an Issue", tag: "Events", method: "GET", path: "/api/0/issues/{issue_id}/events/oldest/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["event:read"])])

      public struct Request: DeprecatedRequest<Response, CanaryAPI> {
        public struct Options {
          /** The ID of the issue. */
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
          }
        }

        public var failure: FailureType? {
          successful ? nil : ()
        }

        public typealias FailureType = Void

        public typealias APIType = CanaryAPI
        /** Retrieves the details of the oldest event for an issue. */
        public struct Status200: Model {
          public var eventID: String

          public var dist: String?

          public var userReport: [String: AnyCodable]?

          public var previousEventID: String?

          public var message: String

          public var id: String

          public var size: Int

          public var errors: [Errors]

          public var platform: String

          public var nextEventID: String?

          public var type: String

          public var metadata: Metadata

          public var tags: [Tags]

          public var dateCreated: String

          public var dateReceived: String

          public var user: User?

          public var entries: [Entries]

          public var packages: [String: AnyCodable]

          public var sdk: Sdk

          public var meta: Meta

          public var contexts: [String: AnyCodable]

          public var fingerprints: [String]

          public var context: [String: AnyCodable]

          public var release: [String: AnyCodable]?

          public var groupID: String

          public var title: String

          /** Retrieves the details of the oldest event for an issue. */
          public struct Errors: Model {
            public var data: [String: AnyCodable]?

            public var message: String?

            public var type: String?

            public init(data: [String: AnyCodable]? = nil, message: String? = nil, type: String? = nil) {
              self.data = data
              self.message = message
              self.type = type
            }

            public init(from decoder: Decoder) throws {
              let container = try decoder.container(keyedBy: StringCodingKey.self)

              data = try container.decodeAnyIfPresent("data")
              message = try container.decodeIfPresent("message")
              type = try container.decodeIfPresent("type")
            }

            public func encode(to encoder: Encoder) throws {
              var container = encoder.container(keyedBy: StringCodingKey.self)

              try container.encodeAnyIfPresent(data, forKey: "data")
              try container.encodeIfPresent(message, forKey: "message")
              try container.encodeIfPresent(type, forKey: "type")
            }
          }

          /** Retrieves the details of the oldest event for an issue. */
          public struct Tags: Model {
            public var meta: String?

            public var key: String?

            public var value: String?

            public init(meta: String? = nil, key: String? = nil, value: String? = nil) {
              self.meta = meta
              self.key = key
              self.value = value
            }

            public init(from decoder: Decoder) throws {
              let container = try decoder.container(keyedBy: StringCodingKey.self)

              meta = try container.decodeIfPresent("_meta")
              key = try container.decodeIfPresent("key")
              value = try container.decodeIfPresent("value")
            }

            public func encode(to encoder: Encoder) throws {
              var container = encoder.container(keyedBy: StringCodingKey.self)

              try container.encodeIfPresent(meta, forKey: "_meta")
              try container.encodeIfPresent(key, forKey: "key")
              try container.encodeIfPresent(value, forKey: "value")
            }
          }

          /** Retrieves the details of the oldest event for an issue. */
          public struct User: Model {
            public var username: String?

            public var name: String?

            public var ipAddress: String?

            public var email: String?

            public var data: DataType?

            public var id: String

            /** Retrieves the details of the oldest event for an issue. */
            public struct DataType: Model {
              public var isStaff: Bool?

              public init(isStaff: Bool? = nil) {
                self.isStaff = isStaff
              }

              public init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: StringCodingKey.self)

                isStaff = try container.decodeIfPresent("isStaff")
              }

              public func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: StringCodingKey.self)

                try container.encodeIfPresent(isStaff, forKey: "isStaff")
              }
            }

            public init(username: String?, name: String?, ipAddress: String?, email: String?, data: DataType?, id: String) {
              self.username = username
              self.name = name
              self.ipAddress = ipAddress
              self.email = email
              self.data = data
              self.id = id
            }

            public init(from decoder: Decoder) throws {
              let container = try decoder.container(keyedBy: StringCodingKey.self)

              username = try container.decodeIfPresent("username")
              name = try container.decodeIfPresent("name")
              ipAddress = try container.decodeIfPresent("ip_address")
              email = try container.decodeIfPresent("email")
              data = try container.decodeIfPresent("data")
              id = try container.decode("id")
            }

            public func encode(to encoder: Encoder) throws {
              var container = encoder.container(keyedBy: StringCodingKey.self)

              try container.encodeIfPresent(username, forKey: "username")
              try container.encodeIfPresent(name, forKey: "name")
              try container.encodeIfPresent(ipAddress, forKey: "ip_address")
              try container.encodeIfPresent(email, forKey: "email")
              try container.encodeIfPresent(data, forKey: "data")
              try container.encode(id, forKey: "id")
            }
          }

          /** Retrieves the details of the oldest event for an issue. */
          public struct Sdk: Model {
            public var name: String?

            public var version: String?

            public init(name: String? = nil, version: String? = nil) {
              self.name = name
              self.version = version
            }

            public init(from decoder: Decoder) throws {
              let container = try decoder.container(keyedBy: StringCodingKey.self)

              name = try container.decodeIfPresent("name")
              version = try container.decodeIfPresent("version")
            }

            public func encode(to encoder: Encoder) throws {
              var container = encoder.container(keyedBy: StringCodingKey.self)

              try container.encodeIfPresent(name, forKey: "name")
              try container.encodeIfPresent(version, forKey: "version")
            }
          }

          /** Retrieves the details of the oldest event for an issue. */
          public struct Meta: Model {
            public var context: String?

            public var contexts: String?

            public var entries: [String: AnyCodable]?

            public var message: String?

            public var packages: String?

            public var sdk: String?

            public var tags: [String: AnyCodable]?

            public var user: String?

            public init(context: String? = nil, contexts: String? = nil, entries: [String: AnyCodable]? = nil, message: String? = nil, packages: String? = nil, sdk: String? = nil, tags: [String: AnyCodable]? = nil, user: String? = nil) {
              self.context = context
              self.contexts = contexts
              self.entries = entries
              self.message = message
              self.packages = packages
              self.sdk = sdk
              self.tags = tags
              self.user = user
            }

            public init(from decoder: Decoder) throws {
              let container = try decoder.container(keyedBy: StringCodingKey.self)

              context = try container.decodeIfPresent("context")
              contexts = try container.decodeIfPresent("contexts")
              entries = try container.decodeAnyIfPresent("entries")
              message = try container.decodeIfPresent("message")
              packages = try container.decodeIfPresent("packages")
              sdk = try container.decodeIfPresent("sdk")
              tags = try container.decodeAnyIfPresent("tags")
              user = try container.decodeIfPresent("user")
            }

            public func encode(to encoder: Encoder) throws {
              var container = encoder.container(keyedBy: StringCodingKey.self)

              try container.encodeIfPresent(context, forKey: "context")
              try container.encodeIfPresent(contexts, forKey: "contexts")
              try container.encodeAnyIfPresent(entries, forKey: "entries")
              try container.encodeIfPresent(message, forKey: "message")
              try container.encodeIfPresent(packages, forKey: "packages")
              try container.encodeIfPresent(sdk, forKey: "sdk")
              try container.encodeAnyIfPresent(tags, forKey: "tags")
              try container.encodeIfPresent(user, forKey: "user")
            }
          }

          public init(eventID: String, dist: String?, userReport: [String: AnyCodable]?, previousEventID: String?, message: String, id: String, size: Int, errors: [Errors], platform: String, nextEventID: String?, type: String, metadata: Metadata, tags: [Tags], dateCreated: String, dateReceived: String, user: User?, entries: [Entries], packages: [String: AnyCodable], sdk: Sdk, meta: Meta, contexts: [String: AnyCodable], fingerprints: [String], context: [String: AnyCodable], release: [String: AnyCodable]?, groupID: String, title: String) {
            self.eventID = eventID
            self.dist = dist
            self.userReport = userReport
            self.previousEventID = previousEventID
            self.message = message
            self.id = id
            self.size = size
            self.errors = errors
            self.platform = platform
            self.nextEventID = nextEventID
            self.type = type
            self.metadata = metadata
            self.tags = tags
            self.dateCreated = dateCreated
            self.dateReceived = dateReceived
            self.user = user
            self.entries = entries
            self.packages = packages
            self.sdk = sdk
            self.meta = meta
            self.contexts = contexts
            self.fingerprints = fingerprints
            self.context = context
            self.release = release
            self.groupID = groupID
            self.title = title
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            eventID = try container.decode("eventID")
            dist = try container.decodeIfPresent("dist")
            userReport = try container.decodeAnyIfPresent("userReport")
            previousEventID = try container.decodeIfPresent("previousEventID")
            message = try container.decode("message")
            id = try container.decode("id")
            size = try container.decode("size")
            errors = try container.decodeArray("errors")
            platform = try container.decode("platform")
            nextEventID = try container.decodeIfPresent("nextEventID")
            type = try container.decode("type")
            metadata = try container.decode("metadata")
            tags = try container.decodeArray("tags")
            dateCreated = try container.decode("dateCreated")
            dateReceived = try container.decode("dateReceived")
            user = try container.decodeIfPresent("user")
            entries = try container.decodeArray("entries")
            packages = try container.decodeAny("packages")
            sdk = try container.decode("sdk")
            meta = try container.decode("_meta")
            contexts = try container.decodeAny("contexts")
            fingerprints = try container.decodeArray("fingerprints")
            context = try container.decodeAny("context")
            release = try container.decodeAnyIfPresent("release")
            groupID = try container.decode("groupID")
            title = try container.decode("title")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encode(eventID, forKey: "eventID")
            try container.encodeIfPresent(dist, forKey: "dist")
            try container.encodeAnyIfPresent(userReport, forKey: "userReport")
            try container.encodeIfPresent(previousEventID, forKey: "previousEventID")
            try container.encode(message, forKey: "message")
            try container.encode(id, forKey: "id")
            try container.encode(size, forKey: "size")
            try container.encode(errors, forKey: "errors")
            try container.encode(platform, forKey: "platform")
            try container.encodeIfPresent(nextEventID, forKey: "nextEventID")
            try container.encode(type, forKey: "type")
            try container.encode(metadata, forKey: "metadata")
            try container.encode(tags, forKey: "tags")
            try container.encode(dateCreated, forKey: "dateCreated")
            try container.encode(dateReceived, forKey: "dateReceived")
            try container.encodeIfPresent(user, forKey: "user")
            try container.encode(entries, forKey: "entries")
            try container.encodeAny(packages, forKey: "packages")
            try container.encode(sdk, forKey: "sdk")
            try container.encode(meta, forKey: "_meta")
            try container.encodeAny(contexts, forKey: "contexts")
            try container.encode(fingerprints, forKey: "fingerprints")
            try container.encodeAny(context, forKey: "context")
            try container.encodeAnyIfPresent(release, forKey: "release")
            try container.encode(groupID, forKey: "groupID")
            try container.encode(title, forKey: "title")
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
#endif
