import Foundation
import Prch

public extension Projects {
  /** Return a service hook bound to a project. */
  enum RetrieveaServiceHook {
    public static let service = Service<Response>(id: "Retrieve a Service Hook", tag: "Projects", method: "GET", path: "/api/0/projects/{organization_slug}/{project_slug}/hooks/{hook_id}/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:read"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        RetrieveaServiceHook.service
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

      public init(options: Options) {
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(organizationSlug: String, projectSlug: String, hookId: String) {
        let options = Options(organizationSlug: organizationSlug, projectSlug: projectSlug, hookId: hookId)
        self.init(options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "project_slug" + "}", with: "\(options.projectSlug)").replacingOccurrences(of: "{" + "hook_id" + "}", with: "\(options.hookId)")
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
      /** Return a service hook bound to a project. */
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
