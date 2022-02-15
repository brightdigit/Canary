import Foundation
import Prch

public extension Projects {
  /** Return a list of service hooks bound to a project. */
  enum ListaProjectsServiceHooks {
    public static let service = APIService<Response>(id: "List a Project's Service Hooks", tag: "Projects", method: "GET", path: "/api/0/projects/{organization_slug}/{project_slug}/hooks/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:read"])])

    public final class Request: APIRequest<Response, CanaryAPI> {
      public struct Options {
        /** The slug of the organization the client keys belong to. */
        public var organizationSlug: String

        /** The slug of the project the client keys belong to. */
        public var projectSlug: String

        /** A pointer to the last object fetched and its' sort order; used to retrieve the next or previous results. */
        public var cursor: String?

        public init(organizationSlug: String, projectSlug: String, cursor: String? = nil) {
          self.organizationSlug = organizationSlug
          self.projectSlug = projectSlug
          self.cursor = cursor
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
        super.init(service: ListaProjectsServiceHooks.service)
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(organizationSlug: String, projectSlug: String, cursor: String? = nil) {
        let options = Options(organizationSlug: organizationSlug, projectSlug: projectSlug, cursor: cursor)
        self.init(options: options)
      }

      override public var path: String {
        super.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(self.options.organizationSlug)").replacingOccurrences(of: "{" + "project_slug" + "}", with: "\(self.options.projectSlug)")
      }

      override public var queryParameters: [String: Any] {
        var params: [String: Any] = [:]
        if let cursor = options.cursor {
          params["cursor"] = cursor
        }
        return params
      }
    }

    public enum Response: APIResponseValue, CustomStringConvertible, CustomDebugStringConvertible {
      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      /** Return a list of service hooks bound to a project. */
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

      public typealias SuccessType = [Status200]

      /** Success */
      case status200([Status200])

      /** You do not have that feature enabled */
      case status403

      public var success: [Status200]? {
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
        case 200: self = try .status200(decoder.decode([Status200].self, from: data))
        case 403: self = .status403
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
