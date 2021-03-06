import Foundation
import Prch

#if false
  public extension Organizations {
    /** This resolves an event ID to the project slug and internal issue ID and internal event ID. */
    enum ResolveAnEventID {
      public static let service = Service<Response>(id: "Resolve an Event ID", tag: "Organizations", method: "GET", path: "/api/0/organizations/{organization_slug}/eventids/{event_id}/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["org: read"])])

      public struct Request: DeprecatedRequest<Response, CanaryAPI> {
        public struct Options {
          /** The slug of the organization the event ID should be looked up in. */
          public var organizationSlug: String

          /** The event ID to look up. */
          public var eventId: String

          public init(organizationSlug: String, eventId: String) {
            self.organizationSlug = organizationSlug
            self.eventId = eventId
          }
        }

        public var options: Options

        public init(options: Options) {
          self.options = options
        }

        /// convenience initialiser so an Option doesn't have to be created
        public init(organizationSlug: String, eventId: String) {
          let options = Options(organizationSlug: organizationSlug, eventId: eventId)
          self.init(options: options)
        }

        public var path: String {
          service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "event_id" + "}", with: "\(options.eventId)")
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
        /** This resolves an event ID to the project slug and internal issue ID and internal event ID. */
        public struct Status200: Model {
          public var event: Event

          public var eventId: String

          public var groupId: String

          public var organizationSlug: String

          public var projectSlug: String

          /** This resolves an event ID to the project slug and internal issue ID and internal event ID. */
          public struct Event: Model {
            public var meta: Meta

            public var context: Context

            public var contexts: [String: AnyCodable]

            public var dateCreated: String

            public var dateReceived: String

            public var dist: String?

            public var entries: [Entries]

            public var errors: [Errors]

            public var eventID: String

            public var fingerprints: [String]

            public var groupID: String

            public var id: String

            public var message: String

            public var metadata: Metadata

            public var packages: Packages

            public var platform: String

            public var sdk: [String: AnyCodable]?

            public var size: Int

            public var tags: [Tags]

            public var type: String

            public var user: User?

            public var title: String

            /** This resolves an event ID to the project slug and internal issue ID and internal event ID. */
            public struct Meta: Model {
              public var context: String?

              public var contexts: [String: AnyCodable]?

              public var entries: [String: AnyCodable]?

              public var message: String?

              public var packages: String?

              public var sdk: String?

              public var tags: [String: AnyCodable]?

              public var user: String?

              public init(context: String? = nil, contexts: [String: AnyCodable]? = nil, entries: [String: AnyCodable]? = nil, message: String? = nil, packages: String? = nil, sdk: String? = nil, tags: [String: AnyCodable]? = nil, user: String? = nil) {
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
                contexts = try container.decodeAnyIfPresent("contexts")
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
                try container.encodeAnyIfPresent(contexts, forKey: "contexts")
                try container.encodeAnyIfPresent(entries, forKey: "entries")
                try container.encodeIfPresent(message, forKey: "message")
                try container.encodeIfPresent(packages, forKey: "packages")
                try container.encodeIfPresent(sdk, forKey: "sdk")
                try container.encodeAnyIfPresent(tags, forKey: "tags")
                try container.encodeIfPresent(user, forKey: "user")
              }
            }

            /** This resolves an event ID to the project slug and internal issue ID and internal event ID. */
            public struct Context: Model {
              public var emptyList: [AnyCodable]?

              public var emptyMap: [String: AnyCodable]?

              public var length: Int?

              public var results: [Int]?

              public var session: Session?

              public var unauthorized: Bool?

              public var url: String?

              /** This resolves an event ID to the project slug and internal issue ID and internal event ID. */
              public struct Session: Model {
                public var foo: String?

                public init(foo: String? = nil) {
                  self.foo = foo
                }

                public init(from decoder: Decoder) throws {
                  let container = try decoder.container(keyedBy: StringCodingKey.self)

                  foo = try container.decodeIfPresent("foo")
                }

                public func encode(to encoder: Encoder) throws {
                  var container = encoder.container(keyedBy: StringCodingKey.self)

                  try container.encodeIfPresent(foo, forKey: "foo")
                }
              }

              public init(emptyList: [AnyCodable]? = nil, emptyMap: [String: AnyCodable]? = nil, length: Int? = nil, results: [Int]? = nil, session: Session? = nil, unauthorized: Bool? = nil, url: String? = nil) {
                self.emptyList = emptyList
                self.emptyMap = emptyMap
                self.length = length
                self.results = results
                self.session = session
                self.unauthorized = unauthorized
                self.url = url
              }

              public init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: StringCodingKey.self)

                emptyList = try container.decodeAnyIfPresent("emptyList")
                emptyMap = try container.decodeAnyIfPresent("emptyMap")
                length = try container.decodeIfPresent("length")
                results = try container.decodeArrayIfPresent("results")
                session = try container.decodeIfPresent("session")
                unauthorized = try container.decodeIfPresent("unauthorized")
                url = try container.decodeIfPresent("url")
              }

              public func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: StringCodingKey.self)

                try container.encodeAnyIfPresent(emptyList, forKey: "emptyList")
                try container.encodeAnyIfPresent(emptyMap, forKey: "emptyMap")
                try container.encodeIfPresent(length, forKey: "length")
                try container.encodeIfPresent(results, forKey: "results")
                try container.encodeIfPresent(session, forKey: "session")
                try container.encodeIfPresent(unauthorized, forKey: "unauthorized")
                try container.encodeIfPresent(url, forKey: "url")
              }
            }

            /** This resolves an event ID to the project slug and internal issue ID and internal event ID. */
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

            /** This resolves an event ID to the project slug and internal issue ID and internal event ID. */
            public struct Metadata: Model {
              public var title: String?

              public init(title: String? = nil) {
                self.title = title
              }

              public init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: StringCodingKey.self)

                title = try container.decodeIfPresent("title")
              }

              public func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: StringCodingKey.self)

                try container.encodeIfPresent(title, forKey: "title")
              }
            }

            /** This resolves an event ID to the project slug and internal issue ID and internal event ID. */
            public struct Packages: Model {
              public var myPackage: String?

              public init(myPackage: String? = nil) {
                self.myPackage = myPackage
              }

              public init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: StringCodingKey.self)

                myPackage = try container.decodeIfPresent("my.package")
              }

              public func encode(to encoder: Encoder) throws {
                var container = encoder.container(keyedBy: StringCodingKey.self)

                try container.encodeIfPresent(myPackage, forKey: "my.package")
              }
            }

            /** This resolves an event ID to the project slug and internal issue ID and internal event ID. */
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

            /** This resolves an event ID to the project slug and internal issue ID and internal event ID. */
            public struct User: Model {
              public var username: String?

              public var name: String?

              public var ipAddress: String?

              public var email: String?

              public var data: DataType?

              public var id: String

              /** This resolves an event ID to the project slug and internal issue ID and internal event ID. */
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

            public init(meta: Meta, context: Context, contexts: [String: AnyCodable], dateCreated: String, dateReceived: String, dist: String?, entries: [Entries], errors: [Errors], eventID: String, fingerprints: [String], groupID: String, id: String, message: String, metadata: Metadata, packages: Packages, platform: String, sdk: [String: AnyCodable]?, size: Int, tags: [Tags], type: String, user: User?, title: String) {
              self.meta = meta
              self.context = context
              self.contexts = contexts
              self.dateCreated = dateCreated
              self.dateReceived = dateReceived
              self.dist = dist
              self.entries = entries
              self.errors = errors
              self.eventID = eventID
              self.fingerprints = fingerprints
              self.groupID = groupID
              self.id = id
              self.message = message
              self.metadata = metadata
              self.packages = packages
              self.platform = platform
              self.sdk = sdk
              self.size = size
              self.tags = tags
              self.type = type
              self.user = user
              self.title = title
            }

            public init(from decoder: Decoder) throws {
              let container = try decoder.container(keyedBy: StringCodingKey.self)

              meta = try container.decode("_meta")
              context = try container.decode("context")
              contexts = try container.decodeAny("contexts")
              dateCreated = try container.decode("dateCreated")
              dateReceived = try container.decode("dateReceived")
              dist = try container.decodeIfPresent("dist")
              entries = try container.decodeArray("entries")
              errors = try container.decodeArray("errors")
              eventID = try container.decode("eventID")
              fingerprints = try container.decodeArray("fingerprints")
              groupID = try container.decode("groupID")
              id = try container.decode("id")
              message = try container.decode("message")
              metadata = try container.decode("metadata")
              packages = try container.decode("packages")
              platform = try container.decode("platform")
              sdk = try container.decodeAnyIfPresent("sdk")
              size = try container.decode("size")
              tags = try container.decodeArray("tags")
              type = try container.decode("type")
              user = try container.decodeIfPresent("user")
              title = try container.decode("title")
            }

            public func encode(to encoder: Encoder) throws {
              var container = encoder.container(keyedBy: StringCodingKey.self)

              try container.encode(meta, forKey: "_meta")
              try container.encode(context, forKey: "context")
              try container.encodeAny(contexts, forKey: "contexts")
              try container.encode(dateCreated, forKey: "dateCreated")
              try container.encode(dateReceived, forKey: "dateReceived")
              try container.encodeIfPresent(dist, forKey: "dist")
              try container.encode(entries, forKey: "entries")
              try container.encode(errors, forKey: "errors")
              try container.encode(eventID, forKey: "eventID")
              try container.encode(fingerprints, forKey: "fingerprints")
              try container.encode(groupID, forKey: "groupID")
              try container.encode(id, forKey: "id")
              try container.encode(message, forKey: "message")
              try container.encode(metadata, forKey: "metadata")
              try container.encode(packages, forKey: "packages")
              try container.encode(platform, forKey: "platform")
              try container.encodeAnyIfPresent(sdk, forKey: "sdk")
              try container.encode(size, forKey: "size")
              try container.encode(tags, forKey: "tags")
              try container.encode(type, forKey: "type")
              try container.encodeIfPresent(user, forKey: "user")
              try container.encode(title, forKey: "title")
            }
          }

          public init(event: Event, eventId: String, groupId: String, organizationSlug: String, projectSlug: String) {
            self.event = event
            self.eventId = eventId
            self.groupId = groupId
            self.organizationSlug = organizationSlug
            self.projectSlug = projectSlug
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            event = try container.decode("event")
            eventId = try container.decode("eventId")
            groupId = try container.decode("groupId")
            organizationSlug = try container.decode("organizationSlug")
            projectSlug = try container.decode("projectSlug")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encode(event, forKey: "event")
            try container.encode(eventId, forKey: "eventId")
            try container.encode(groupId, forKey: "groupId")
            try container.encode(organizationSlug, forKey: "organizationSlug")
            try container.encode(projectSlug, forKey: "projectSlug")
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
#endif
