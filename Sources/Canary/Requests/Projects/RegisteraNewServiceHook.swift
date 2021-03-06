import Foundation
import Prch

public extension Projects {
  /** Register a new service hook on a project.
   Events include:
   - event.alert: An alert is generated for an event (via rules).
   - event.created: A new event has been processed.
   This endpoint requires the 'servicehooks' feature to be enabled for your project. */
  enum RegisteraNewServiceHook {
    public static let service = Service<Response>(id: "Register a New Service Hook", tag: "Projects", method: "POST", path: "/api/0/projects/{organization_slug}/{project_slug}/hooks/", hasBody: true, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:write"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        RegisteraNewServiceHook.service
      }

      /** Register a new service hook on a project.
       Events include:
       - event.alert: An alert is generated for an event (via rules).
       - event.created: A new event has been processed.
       This endpoint requires the 'servicehooks' feature to be enabled for your project. */
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

        public init(organizationSlug: String, projectSlug: String) {
          self.organizationSlug = organizationSlug
          self.projectSlug = projectSlug
        }
      }

      public var options: Options

      public var body: Body

      public init(body: Body, options: Options, encoder _: RequestEncoder? = nil) {
        self.body = body
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(organizationSlug: String, projectSlug: String, body: Body) {
        let options = Options(organizationSlug: organizationSlug, projectSlug: projectSlug)
        self.init(body: body, options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "project_slug" + "}", with: "\(options.projectSlug)")
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
      /** Register a new service hook on a project.
       Events include:
       - event.alert: An alert is generated for an event (via rules).
       - event.created: A new event has been processed.
       This endpoint requires the 'servicehooks' feature to be enabled for your project. */
      public struct Status201: Model {
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

      public typealias SuccessType = Status201

      /** Success */
      case status201(Status201)

      /** You do not have that feature enabled */
      case status403

      /** The requested resource does not exist */
      case status404

      public var success: Status201? {
        switch self {
        case let .status201(response): return response
        default: return nil
        }
      }

      public var statusCode: Int {
        switch self {
        case .status201: return 201
        case .status403: return 403
        case .status404: return 404
        }
      }

      public var successful: Bool {
        switch self {
        case .status201: return true
        case .status403: return false
        case .status404: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 201: self = try .status201(decoder.decode(Status201.self, from: data))
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
