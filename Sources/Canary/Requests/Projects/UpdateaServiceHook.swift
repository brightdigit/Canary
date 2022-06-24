import Foundation
import Prch

public extension Projects {
  /** Update a service hook. */
  enum UpdateaServiceHook {
    public static let service = Service<Response>(id: "Update a Service Hook", tag: "Projects", method: "PUT", path: "/api/0/projects/{organization_slug}/{project_slug}/hooks/{hook_id}/", hasBody: true, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:write"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        UpdateaServiceHook.service
      }

      /** Update a service hook. */
      public struct Body: Model {
        /** The URL for the webhook. */
        public var url: String

        /** The events to subscribe to. */
        public var events: [String]

        public init(url: String, events: [String]) {
          self.url = url
          self.events = events
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          url = try container.decode("url")
          events = try container.decodeArray("events")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(url, forKey: "url")
          try container.encode(events, forKey: "events")
        }
      }

      public struct Options {
        /** The slug of the organization the client keys belong to. */
        public var organizationSlug: String

        /** The slug of the project the client keys belong to. */
        public var projectSlug: String

        /** The GUID of the service hook. */
        public var hookId: String

        public init(organizationSlug: String, projectSlug: String, hookId: String) {
          self.organizationSlug = organizationSlug
          self.projectSlug = projectSlug
          self.hookId = hookId
        }
      }

      public var options: Options

      public var body: Body?

      public init(body: Body?, options: Options, encoder _: RequestEncoder? = nil) {
        self.body = body
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(organizationSlug: String, projectSlug: String, hookId: String, body: Body? = nil) {
        let options = Options(organizationSlug: organizationSlug, projectSlug: projectSlug, hookId: hookId)
        self.init(body: body, options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "project_slug" + "}", with: "\(options.projectSlug)").replacingOccurrences(of: "{" + "hook_id" + "}", with: "\(options.hookId)")
      }
    }

    public enum Response: DeprecatedResponse, CustomStringConvertible, CustomDebugStringConvertible {
      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      /** Update a service hook. */
      public struct Status200: Model {
        public var dateCreated: String

        public var events: [String]

        public var id: String

        public var secret: String

        public var status: String

        public var url: String

        public init(dateCreated: String, events: [String], id: String, secret: String, status: String, url: String) {
          self.dateCreated = dateCreated
          self.events = events
          self.id = id
          self.secret = secret
          self.status = status
          self.url = url
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          dateCreated = try container.decode("dateCreated")
          events = try container.decodeArray("events")
          id = try container.decode("id")
          secret = try container.decode("secret")
          status = try container.decode("status")
          url = try container.decode("url")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(dateCreated, forKey: "dateCreated")
          try container.encode(events, forKey: "events")
          try container.encode(id, forKey: "id")
          try container.encode(secret, forKey: "secret")
          try container.encode(status, forKey: "status")
          try container.encode(url, forKey: "url")
        }
      }

      public typealias SuccessType = Status200

      /** Success */
      case status200(Status200)

      /** Bad Input */
      case status400

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
        case .status400: return 400
        case .status403: return 403
        case .status404: return 404
        }
      }

      public var successful: Bool {
        switch self {
        case .status200: return true
        case .status400: return false
        case .status403: return false
        case .status404: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 200: self = try .status200(decoder.decode(Status200.self, from: data))
        case 400: self = .status400
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
